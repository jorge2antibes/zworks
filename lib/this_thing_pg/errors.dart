class NullXFileError extends Error {}

class NotImplementedError extends Error {
  String? message = 'This functionality is not implemented yet';

  NotImplementedError({this.message});
}

class NoLocalImgsError extends Error {
  String? message = 'This Thing: localImgs set is empty';

  NoLocalImgsError({this.message});
}
