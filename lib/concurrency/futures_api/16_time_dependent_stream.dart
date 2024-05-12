import 'dart:async';

///Streans
///
/// future => | ........... 1s ......... X |
/// stream => | ........... 1s ......... X ..... 500ms ..... X ........ 700ms....... XXX ..... and so on |
///
/// https://www.youtube.com/watch?v=-zNC2hWftho&list=RDCMUC8NpGP0AOQ0kX9ZRcohiPeQ&index=10
/// Stream transformer that errors out if the given stream does not produce a value in
/// a given timeout
void main() async {
  try {
    await for (final name in namesGenerator().withTimeoutBetweenEvents(
      duration: const Duration(seconds: 3),
    )) {
      print('name: $name');
    }
  } on TimeoutBetweenEventsException catch (e) {
    print('TimeBetweenEventsException: $e');
    print('stackTrace: ${e.stackTrace}');//* stackTrace is a property that I will define in the exception itself
  } on GeneralErrorException catch (e) {
    print('GeneralException: $e');
    print('stackTrace: ${e.stackTrace}');//* stackTrace is a property that I will define in the exception itself
  }
}

class TimeoutBetweenEvent<T> extends StreamTransformerBase<T, T> {
  final Duration duration;

  const TimeoutBetweenEvent({required this.duration});

  @override
  Stream<T> bind(Stream<T> stream) {
    StreamController<T>? controller;
    StreamSubscription<T>? subscription;
    Timer? timer;

    //* I can set the listeners in the constructor as follows:
    controller = StreamController<T>(
      onListen: () {
        print('onListen() as parameter');
        subscription = stream.listen(
          (data) {
            print('stream.listen() ondata as parameter: $data');
            timer?.cancel(); //cancels every time it receives data
            timer = Timer.periodic(duration, (timer) {
              controller?.addError(
                TimeoutBetweenEventsException(message: 'No event received for duration of $duration'),
              );
            });
            controller?.add(data);
          },
          onDone: () {
            print('stream.listen() onDone as parameter');
            controller?.close();
          },
          onError: (err) {
            print('stream.listen() onError as parameter: $err');
            controller?.addError(GeneralErrorException(message: 'General error', err: err));
          },
        );
      },
      onCancel: () {
        print('StreamController() constructor: onCancel() as parameter');
        subscription?.cancel();
        timer?.cancel();
      },
      onResume: () {
        print('StreamController() constructor: onResume() as parameter');
      },
      onPause: () {
        print('StreamController() constructor: onPause() as parameter');
      },
    );

    //* And/Or initialize or override them in the controller
    //* object as they are accessible as fields/properties
    // controller.onCancel = () {
    //   print('onCancel as property');
    //   subscription?.cancel();
    //   timer?.cancel();
    // };
    // controller.onListen = () {
    //   print('onListen as property');
    // };
    controller.onPause = () {
      print('onPause as property');
    };
    controller.onResume = () {
      print('onResume as property');
    };

    return controller.stream;
  }
}

class TimeoutBetweenEventsException implements Exception {
  final String message;
  final stackTrace = StackTrace.current;

  TimeoutBetweenEventsException({required this.message});
}

class GeneralErrorException implements Exception {
  final String message;
  final Exception err;
  final stackTrace = StackTrace.current;

  GeneralErrorException({required this.message, required this.err});
}

extension<T> on Stream<T> {
  Stream<T> withTimeoutBetweenEvents({required Duration duration}) => transform(
        TimeoutBetweenEvent(duration: duration),
      );
}

Stream<String> namesGenerator() async* {
  yield 'name1';
  await Future.delayed(const Duration(seconds: 2));
  yield 'name2';
  await Future.delayed(const Duration(seconds: 3));
  yield 'name3';
}
