import 'package:flutter/material.dart';

/// The default scroll physics.
AlwaysScrollableScrollPhysics scrollPhysics =
    const AlwaysScrollableScrollPhysics(
  parent: BouncingScrollPhysics(),
);
