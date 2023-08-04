import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:habito/common/providers/app_state_provider.dart';
import 'package:habito/common/providers/user_provider.dart';
import 'package:habito/constants/app_colors.dart';
import 'package:habito/constants/app_measurements.dart';
import 'package:habito/themes/defaults.dart';
import 'package:provider/provider.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  AppBar build(BuildContext context) {
    final user = context.read<UserProvider>().softGetCurrentUser();

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
                  text: user,
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
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: HabiMeasurements.paddingRight),
          child: Visibility(
            visible: !context.watch<AppStateProvider>().isKeyboardOpen,
            replacement: TextButton(
              onPressed: () {
                context.read<AppStateProvider>().closeKeyboard();
              },
              child: const Text("Close"),
            ),
            child: const CircleAvatar(
              backgroundColor: HabiColor.orange,
            ),
          ),
        )
      ],
    );
  }
}
