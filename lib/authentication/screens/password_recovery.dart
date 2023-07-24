import 'package:flutter/material.dart';
import 'package:habito/constants/app_icons.dart';
import 'package:habito/constants/app_measurements.dart';

class PasswordRecovery extends StatelessWidget {
  const PasswordRecovery({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Icon(HabiIcons.iconBack),
        ),
        title: const Text("Password Recovery"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: HabiMeasurements.paddingHorizontal,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30),
            const Text("Enter your email"),
            const SizedBox(height: 30),
            const TextField(
              // controller: _nameController,
              // onChanged: (_) => resetBadCredentials('name'),
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(hintText: "Email"),
              // enabled: !_loading,
            ),
            const SizedBox(height: 30),
            ElevatedButton(
                onPressed: () {}, child: const Text("Restore password"))
          ],
        ),
      ),
    );
  }
}
