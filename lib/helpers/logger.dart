import 'package:logger/logger.dart';

/// Retuns a logger.
Logger logger(String name) {
  return Logger(printer: _LogPrinter(name));
}

class _LogPrinter extends LogPrinter {
  final String _name;
  _LogPrinter(this._name);

  @override
  List<String> log(LogEvent event) {
    final AnsiColor color = PrettyPrinter.levelColors[event.level];
    final String emoji = PrettyPrinter.levelEmojis[event.level];
    return [color('$emoji$_name: ${event.message}')];
  }
}
