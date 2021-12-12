//!WIDGET TO SHOW TITLE OF EACH PAGE
import 'package:flutter/material.dart';

class OtherPagesTitle extends StatefulWidget {
  final String pageTitle;
  final Color titleColour;
  const OtherPagesTitle({
    Key? key,
    required this.pageTitle,
    required this.titleColour,
  }) : super(key: key);

  @override
  State<OtherPagesTitle> createState() => _PageTitleState();
}

class _PageTitleState extends State<OtherPagesTitle> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).brightness == Brightness.light
          ? Colors.white
          : Colors.black,
      title: Text(widget.pageTitle,
          style: Theme.of(context).textTheme.bodyText2!.copyWith(
                fontSize: 28,
                color: widget.titleColour,
                fontWeight: FontWeight.w600,
              )),
    );
  }
}
