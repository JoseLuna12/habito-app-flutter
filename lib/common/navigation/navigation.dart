import 'package:flutter/material.dart';

void navigateNoAnimReplacementsTo({
  required BuildContext context,
  required Widget to,
}) {
  Navigator.of(context).pushReplacement(
    PageRouteBuilder(
      maintainState: false,
      pageBuilder: (context, animation, secondaryAnim) => to,
      transitionsBuilder: (context, animation, secondaryAnimation, child) =>
          child,
    ),
  );
}

void navigateWithAnimReplacementsTo({
  required BuildContext context,
  required Widget to,
}) {
  Navigator.of(context)
      .pushReplacement(MaterialPageRoute(builder: (context) => to));
}

void navigateTo({
  required BuildContext context,
  required Widget to,
}) {
  Navigator.of(context).push(MaterialPageRoute(builder: (context) => to));
}

void navigatePop({
  required BuildContext context,
}) {
  Navigator.of(context).pop();
}
