import 'package:flutter_neumorphic/flutter_neumorphic.dart';

/// The default scroll physics.
AlwaysScrollableScrollPhysics scrollPhysics =
    const AlwaysScrollableScrollPhysics(
  parent: BouncingScrollPhysics(),
);
