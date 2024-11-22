sealed class CustomException {
  final String message;
  final StackTrace? stack;

  CustomException(this.message, [this.stack]);
}

class BadDataException extends CustomException {
  BadDataException(super.message, [super.stack]);
}

class InternetException extends CustomException {
  InternetException(super.message, [super.stack]);
}

class UnknownException extends CustomException {
  UnknownException(super.message, [super.stack]);
}

class PluginException extends CustomException {
  PluginException(super.message, [super.stack]);
}
