import 'package:flutter_neumorphic/flutter_neumorphic.dart';

/// Better redirection with navigator.
void redirect(BuildContext context, String name, Widget widget) {
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) => widget,
      settings: RouteSettings(name: name),
    ),
  );
}
