/*This class handle possible api exceptions*/
class ApiException implements Exception {
  final String? _message;
  final String? _prefix;

  ApiException([this._message, this._prefix]);

  String toString() {
    return _message??"";
  }
}

class FetchDataException extends ApiException {
  FetchDataException([String? message])
      : super(message, "Error during communication");
}

class BadRequestException extends ApiException {
  BadRequestException([String? message]) : super(message, "Invalid request");
}

class UnauthorisedException extends ApiException {
  UnauthorisedException([message]) : super(message, "Unauthorised:");
}

class InvalidInputException extends ApiException {
  InvalidInputException([String? message]) : super(message, "Invalid Input:");
}

class ServerException extends ApiException {
  ServerException([String? message]) : super(message, "Internal Server Error");
}
