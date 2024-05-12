///https://www.youtube.com/watch?v=-zNC2hWftho&list=RDCMUC8NpGP0AOQ0kX9ZRcohiPeQ&index=10
///Future chaining...to other future
void main() async {
  print('lenght1');
  final lenght1 = await calculateLenght(await getFullName());
  print(lenght1);


  //* here the program get back the Future<Null> and continues normally and only when the futures
  //* chained resolve the program will execute the code at then() close.
  //* here I'm not awaiting for the future as lenght2 will get the future instance but not the value
  //* and will continue synchronously UNTIL calculateLenght() will get resolved to a value, and then
  //* // 4: lenght2 will be set to the value and //5 will be printed.
  //* to sum up, wiht this approach i.e. without awaiting and using the Future api, I'm able to let
  //* the app to run synchronously while awaiting for the futures to resolve.
  //! lenght2 is var because the values it will accept will be of different types during
  //! the resolution of the futures i.e. first, at //1 it will receive a Future<Null> but later on, at //4 it will
  //! receive an int
  //* output:
  //* Instance of 'Future<Null>'
  //* continuing with the main thread while the future is resolved
  //* 8
  print('lenght2');
  var lenght2;
  lenght2 = getFullName().then((fullname) => calculateLenght(fullname)).then((lenght) {//1
    lenght2 = lenght;//4
    print(lenght);//5
  });
  print(lenght2);//2
  print('continuing with the main thread while the future is resolved');//3

  //* Here the code runs as if it was fully synchrounous all the way to resolve the futures (due to await),
  //* in other words, the program get back the Future<Null> and continues normally and only when the futures
  //* chained resolve the program will execute the code at then() close.
  //* at //1, all the futures are resolved before continuing the synchronous rest of the program
  //* i.e. //4 and //5, worth notice that length3 at //4 has a type of null instead of Future<Null>
  //* as in the previous example.
  //* output:
  //* 8
  //* null
  //* continuing with the main thread while the future is resolved
  print('lenght3');
  var lenght3;
  lenght3 = await getFullName().then((fullname) => calculateLenght(fullname)).then((lenght) {//1
    lenght3 = lenght;//2
    print(lenght);//3
  });
  print(lenght3);//4
  print('continuing with the main thread while the future is resolved');//5

  //* Here lenght4 is of type int because its awaiting for the result.
  print('lenght4');
  int lenght4;
  lenght4 = await getFullName().then((fullname) => calculateLenght(fullname));
  print(lenght4);
  print('continuing with the main thread while the future is resolved');//5
}

Future<int> calculateLenght(String s) => Future.delayed(const Duration(seconds: 1), () => s.length);

Future<String> getFullName() => Future.delayed(const Duration(seconds: 1), () => 'john Doe');
