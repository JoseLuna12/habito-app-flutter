import 'package:flutter/material.dart';

import 'package:habito/features/authentication/screens/password_recovery.dart';
import 'package:habito/features/authentication/screens/sign_up.dart';
import 'package:habito/features/authentication/services/user_local.dart';
import 'package:habito/features/authentication/widgets/login_actions.dart';
import 'package:habito/common/navigation/navigation.dart';
import 'package:habito/constants/app_colors.dart';
import 'package:habito/constants/app_measurements.dart';

import 'package:habito/themes/defaults.dart';
import 'package:habito/features/timeline/screens/home.dart';

class SignIn extends StatelessWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future<bool> isUserLogged() async {
      final user = await getCurrentUser();
      if (user != null) {
        if (context.mounted) {
          navigateNoAnimReplacementsTo(
            context: context,
            to: const HomeScreen(),
          );
        }
        return true;
      } else {
        return false;
      }
      // return user;
    }

    return FutureBuilder<bool>(
        future: isUserLogged(),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.data == true) {
            // if(snapshot.data.jwToken){
            //   return
            // }
            return const Placeholder();
          } else {
            return const SiginInContent();
          }
        });
  }
}

class SiginInContent extends StatelessWidget {
  const SiginInContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    double keyboard = MediaQuery.of(context).viewInsets.bottom;

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
            const LoginActions(),
            Center(
              child: TextButton(
                onPressed: () {
                  navigateTo(context: context, to: const PasswordRecovery());
                },
                child: const Text(
                  "Forgot my password",
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),
            const Spacer(),
            Visibility(
              visible: keyboard == 0,
              child: Padding(
                padding: const EdgeInsets.only(
                  bottom: HabiMeasurements.paddingBottomLast,
                ),
                child: Center(
                  child: TextButton(
                    onPressed: () {
                      navigateTo(context: context, to: const SignUp());
                    },
                    child: const Text(
                      "Create Account",
                      style: TextStyle(
                        fontSize: 17,
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
