import 'package:flutter/material.dart';

/// AppBar which elevates when scrolled.
class ElevatingAppBar extends StatefulWidget implements PreferredSizeWidget {
  /// Widget to display as title.
  final Widget title;

  /// Scroll controller.
  final ScrollController scrollController;

  /// Target elevation.
  final double elevation;

  /// Constructs.
  const ElevatingAppBar({
    @required this.title,
    @required this.scrollController,
    this.elevation = 4,
  });

  @override
  _ElevatingAppBarState createState() => _ElevatingAppBarState();

  @override
  Size get preferredSize => AppBar().preferredSize;
}

class _ElevatingAppBarState extends State<ElevatingAppBar> {
  double _elevation = 0;

  void _scrollListener() {
    final double newElevation =
        widget.scrollController.offset > 1 ? widget.elevation : 0;
    if (_elevation != newElevation) {
      setState(() {
        _elevation = newElevation;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    widget.scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    super.dispose();
    widget.scrollController?.removeListener(_scrollListener);
    widget.scrollController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: widget.title,
      elevation: _elevation,
    );
  }
}
