import 'package:flutter/material.dart';
import 'package:habito/features/authentication/widgets/error_input_label.dart';
import 'package:habito/features/authentication/widgets/signup_actions.dart';
import 'package:habito/common/navigation/navigation.dart';
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
            navigatePop(context: context);
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
            Expanded(
              child: SignupActions(),
            ),
          ],
        ),
      ),
    );
  }
}
