import 'package:flutter/material.dart';
import 'package:habito/features/authentication/models/user_model.dart';
import 'package:habito/features/authentication/screens/sign_in.dart';
import 'package:habito/features/authentication/services/user_local.dart';
import 'package:habito/common/navigation/navigation.dart';
import 'package:habito/constants/app_colors.dart';
import 'package:habito/constants/app_measurements.dart';
import 'package:habito/themes/defaults.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future<User> getUser() async {
      final user = await getCurrentUser();
      if (user == null) {
        if (context.mounted) {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const SignIn()));
        }
        throw ErrorDescription("User is not logged");
      }
      return user;
    }

    return FutureBuilder<User>(
      future: getUser(),
      builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
        if (snapshot.hasData) {
          return HomeContent(user: snapshot.data!);
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}

// ignore: must_be_immutable
class HomeContent extends StatelessWidget {
  User user;
  HomeContent({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    Future<void> logOut() async {
      await clearUser();
      if (context.mounted) {
        navigateNoAnimReplacementsTo(context: context, to: const SignIn());
      }
    }

    return Scaffold(
      appBar: HomeAppBar(user: user),
      body: ElevatedButton(
        onPressed: logOut,
        child: const Text("Exit"),
      ),
    );
  }
}

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({
    super.key,
    required this.user,
  });

  final User user;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  AppBar build(BuildContext context) {
    return AppBar(
      leadingWidth: double.infinity,
      leading: Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: const EdgeInsets.only(left: HabiMeasurements.paddingLeft),
          child: RichText(
            text: TextSpan(
              text: "Hi, ",
              style: Theme.of(context).textTheme.displayLarge?.copyWith(
                    fontSize: 26,
                    fontFamily: HabiThemeDefaults.fontFamily,
                    color: Theme.of(context).brightness == Brightness.light
                        ? HabiColor.orange
                        : HabiColor.white,
                  ),
              children: [
                TextSpan(
                  text: user.name,
                  style: Theme.of(context).textTheme.displayLarge?.copyWith(
                        fontSize: 26,
                        fontFamily: HabiThemeDefaults.fontFamily,
                        color: Theme.of(context).brightness == Brightness.light
                            ? HabiColor.orange
                            : HabiColor.white,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
          ),
        ),
      ),
      actions: const [
        Padding(
          padding: EdgeInsets.only(right: HabiMeasurements.paddingRight),
          child: CircleAvatar(
            backgroundColor: HabiColor.orange,
          ),
        )
      ],
    );
  }
}
