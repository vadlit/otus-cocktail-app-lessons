import 'package:flutter/widgets.dart';

class DetailsSubtitle extends StatelessWidget {
  final String caption;

  const DetailsSubtitle(
      this.caption, {
        Key key,
      }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 10, 0, 8),
      child: Text(
        caption,
        style: TextStyle(
            color: Color.fromARGB(255, 234, 234, 234),
            fontSize: 14,
            fontWeight: FontWeight.w400),
      ),
    );
  }
}