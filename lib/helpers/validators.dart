import 'package:habitflow/resources/strings.dart';

/// Validates a posetive integer.
String validatePosInt(String value) {
  if (value.isEmpty || int.tryParse(value) == null) {
    return validInteger;
  } else if (int.parse(value) <= 0) {
    return positiveInteger;
  }
  return null;
}

/// Validates a string.
String validateStr(String value) {
  if (value.isEmpty) {
    return validName;
  }
  return null;
}
