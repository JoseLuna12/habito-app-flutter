import 'package:flutter/material.dart';
import 'package:habito/common/providers/user_provider.dart';
import 'package:habito/constants/app_colors.dart';
import 'package:habito/constants/app_measurements.dart';
import 'package:habito/themes/defaults.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future<void> logOut() async {
      await context.read<UserProvider>().clearUserData();
    }

    return Scaffold(
      appBar: const HomeAppBar(),
      body: ElevatedButton(
        onPressed: logOut,
        child: const Text("Exit"),
      ),
    );
  }
}

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  AppBar build(BuildContext context) {
    // final user = await context.watch<UserProvider>().user;

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
                  text: context.watch<UserProvider>().user ?? "",
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
