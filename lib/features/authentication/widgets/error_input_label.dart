import 'package:flutter/material.dart';
import 'package:habito/constants/app_colors.dart';

//ignore: must_be_immutable
class ErrorInputLabel extends StatelessWidget {
  final bool show;
  final String text;

  const ErrorInputLabel({Key? key, required this.show, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> allErrors = text.split(',');
    List<Widget> errorsText = List.generate(allErrors.length, (index) {
      return Text(
        allErrors[index],
        style: TextStyle(
          color: Theme.of(context).brightness == Brightness.light
              ? HabiColor.dangerLight
              : HabiColor.dangerDark,
          // color:  HabiColor.dangerDark,
          fontSize: 14,
        ),
      );
    });

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: SizedBox(
        height: 25 * errorsText.length.toDouble(),
        child: Visibility(
          visible: show,
          child: Column(
            children: errorsText,
          ),
        ),
      ),
    );
  }
}
