import 'package:flutter/material.dart';
import 'package:habito/common/providers/user_provider.dart';
import 'package:habito/constants/app_colors.dart';
import 'package:habito/constants/app_measurements.dart';
import 'package:habito/features/authentication/widgets/error_input_label.dart';

import 'package:habito/themes/defaults.dart';
import 'package:provider/provider.dart';

class SoftSignIn extends StatefulWidget {
  const SoftSignIn({Key? key}) : super(key: key);

  @override
  State<SoftSignIn> createState() => _SoftSignInState();
}

class _SoftSignInState extends State<SoftSignIn> {
  String errorLabel = "";

  final nameController = TextEditingController();

  void updateErrorLabel(String text) {
    setState(() {
      errorLabel = text;
    });
  }

  @override
  Widget build(BuildContext context) {
    Future<void> saveUserLocally() async {
      if (nameController.text.isEmpty) {
        updateErrorLabel("Field cannot be empty!");
        return;
      }

      if (nameController.text.length < 3) {
        updateErrorLabel("Name should have at least 3 characters!");

        return;
      }

      await context.read<UserProvider>().setUser(nameController.text);
    }

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: HabiMeasurements.paddingHorizontal,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              text: TextSpan(
                text: "Habito",
                style: Theme.of(context).textTheme.displayLarge?.copyWith(
                      fontSize: 60,
                      fontFamily: HabiThemeDefaults.fontFamily,
                    ),
                children: const [
                  TextSpan(
                    text: ".",
                    style: TextStyle(
                      color: HabiColor.orange,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            TextField(
              controller: nameController,
              onChanged: (_) => updateErrorLabel(""),
              textCapitalization: TextCapitalization.words,
              keyboardType: TextInputType.name,
              onSubmitted: (_) => saveUserLocally(),
              decoration: const InputDecoration(hintText: "Your name"),
              // enabled: !_loading,
            ),
            ErrorInputLabel(show: true, text: errorLabel),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: HabiMeasurements.paddingHorizontalXl,
                vertical: HabiMeasurements.paddingBottomLast,
              ),
              child: Center(
                child: ElevatedButton(
                  onPressed: () => saveUserLocally(),
                  child: const Text("Continue"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
