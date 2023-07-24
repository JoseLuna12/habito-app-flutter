import 'package:flutter/material.dart';
import 'package:habito/authentication/widgets/signup_actions.dart';
import 'package:habito/constants/app_icons.dart';
import 'package:habito/constants/app_measurements.dart';

class SignUp extends StatelessWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Icon(HabiIcons.iconBack),
        ),
        title: const Text("Create account"),
      ),
      body: const Padding(
        padding: EdgeInsets.symmetric(
          horizontal: HabiMeasurements.paddingHorizontal,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 30),
            Text("User Data"),
            SizedBox(height: 25),
            Expanded(child: SignupActions()),
          ],
        ),
      ),
    );
  }
}
