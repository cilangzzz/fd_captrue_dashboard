import 'package:flutter/material.dart';

class RadiuoButton extends StatefulWidget {
  const RadiuoButton(
      {super.key,
      required this.label,
      required this.index,
      required this.currentIndex,
      required this.onPressed});
  final String label;
  final int index;
  final int currentIndex;
  final Function() onPressed;

  @override
  State<RadiuoButton> createState() => _RadiuoButtonState();
}

class _RadiuoButtonState extends State<RadiuoButton> {
  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: widget.onPressed,
      style: OutlinedButton.styleFrom(
        side: BorderSide(
            color: Theme.of(context).primaryColor, // 边框颜色
            width: 2.0, // 边框宽度
            style: BorderStyle.none),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        backgroundColor: (widget.index == widget.currentIndex)
            ? Theme.of(context).primaryColorLight
            : null, // 设置背景颜色
      ),
      child: Text(
        widget.label,
        style: TextStyle(
          color: (widget.index == widget.currentIndex)
              ? Colors.white
              : Theme.of(context).primaryColor,
        ),
      ),
    );
  }
}
