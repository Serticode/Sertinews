//!WIDGET TO SHOW TITLE OF EACH PAGE
import 'package:flutter/material.dart';

class PageTitle extends StatelessWidget {
  final String pageTitle;
  final Color titleColour;
  final IconData pageIcon;
  const PageTitle(
      {Key? key,
      required this.pageTitle,
      required this.titleColour,
      required this.pageIcon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 10.0,
        horizontal: 10.0,
      ),
      height: MediaQuery.of(context).size.height / 16,
      width: MediaQuery.of(context).size.width / 2,
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: titleColour.withOpacity(0.2),
        borderRadius: BorderRadius.circular(40.0),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            pageIcon,
            size: 32.0,
            color: titleColour,
          ),
          const SizedBox(
            width: 10.0,
          ),
          Text(pageTitle,
              style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w500,
              ).copyWith(
                color: titleColour,
              )),
        ],
      ),
    );
  }
}
