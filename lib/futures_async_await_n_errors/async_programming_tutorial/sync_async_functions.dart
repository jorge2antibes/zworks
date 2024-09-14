/// Quick review
/// A Future<T> instance produces a value of type T.
/// If a future doesn't produce a usable value, then the future's type is Future<void>.
/// A future can be in one of two states: uncompleted or completed.
/// When you call a function that returns a future, the function queues up work to be done and returns an uncompleted future.
/// When a future's operation finishes, the future completes with a value or with an error.
/// Key terms:
/// Future: the Dart Future class.
/// future: an instance of the Dart Future class.
///
/// Asynchronous programming: futures, async, await
/// https://dart.dev/libraries/async/async-await
