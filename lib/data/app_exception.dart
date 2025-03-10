
class AppException implements Exception{

  final _message;
  final _prefix;

  AppException([this._message,this._prefix]);

  @override
  String toString(){
    return '$_message$_prefix';
  }
}

class InternetException extends AppException{
  InternetException([String? message]) : super(message,'No Internet');
}

class RequestTimeOut extends AppException{
  RequestTimeOut([String? message]) : super(message,'Request Time Out');
}


class ServerException extends AppException{
  ServerException ([String? message]) : super(message,'Internal Server Error');
}

class InvalidUrlException extends AppException{
  InvalidUrlException ([String? message]) : super(message,'Internal Url');
}

class FetchDataException extends AppException{
  FetchDataException ([String? message]) : super(message,'Fetching Data Error');
}

class UserAlreadyExistsException extends AppException{
  UserAlreadyExistsException ([String? message]) : super(message,'user with this email already exists');
}

class EmailOrPasswordIncorrect extends AppException{
  EmailOrPasswordIncorrect ([String? message]) : super(message,'Email Or is Incorrect ');
}