import 'package:flutter/material.dart';

class SizeReportingWidget extends StatefulWidget {
  final Widget child;
  final Function(Size) onSizeChanged;
  const SizeReportingWidget({super.key,required this.child,required this.onSizeChanged});

  @override
  State<SizeReportingWidget> createState() => _SizeReportingWidgetState();
}

class _SizeReportingWidgetState extends State<SizeReportingWidget> {
  late GlobalKey _key;

  @override
  void initState() {
    super.initState();
    _key = GlobalKey();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      final RenderBox renderBox = _key.currentContext?.findRenderObject() as RenderBox;
      final size = renderBox.size;
      widget.onSizeChanged(size);
    });

    return Container(
      key: _key,
      child: widget.child,
    );
  }
}