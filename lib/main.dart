import 'package:flutter/material.dart';
import 'package:habito/common/database/shared_preferences.dart';
import 'package:habito/common/date/week.dart';
import 'package:habito/common/providers/app_state_provider.dart';
import 'package:habito/common/providers/task_provider.dart';
import 'package:habito/common/providers/user_provider.dart';
import 'package:habito/common/providers/week_provider.dart';
import 'package:habito/common/widgets/loading_placeholder.dart';
import 'package:habito/constants/app_colors.dart';
import 'package:habito/features/authentication/screens/soft_authentication.dart';
import 'package:habito/features/routines/screens/home.dart';
import 'package:habito/themes/classic.dart';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HabitoSharedPreferences pref = HabitoSharedPreferences(
    sharedPreferences: await SharedPreferences.getInstance(),
  );
  HabiWeek weekData = HabiWeek();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => UserProvider(preferences: pref),
        ),
        ChangeNotifierProvider(
          create: (context) => TaskProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => AppStateProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => WeekProvider(weeksValues: weekData),
        )
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // @override
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Habito',
        theme: HabiTheme.lightTheme,
        darkTheme: HabiTheme.darkTheme,
        themeMode: ThemeMode.system,
        home: StreamBuilder<UserLoadingStatus>(
          stream: Provider.of<UserProvider>(context).userStatus,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              if (!Provider.of<UserProvider>(context).isAppInitialized) {
                Provider.of<UserProvider>(context, listen: false).initApp();
              }
              return const LoadingPlaceholder();
            }
            if (snapshot.data == UserLoadingStatus.loading) {
              return const LoadingPlaceholder();
            }
            if (snapshot.data == UserLoadingStatus.unauthenticated) {
              return const SoftSignIn();
            }
            if (snapshot.data == UserLoadingStatus.authenticated) {
              return const HomeScreen();
            }

            if (snapshot.data == UserLoadingStatus.error) {
              return const Placeholder();
            }

            return const LoadingPlaceholder();
          },
        ));
  }
}

//  FutureBuilder<String?>(
//         future: context.read<UserProvider>().initUser(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.done) {
//             if (context.watch<UserProvider>().user == null) {
//               return const SoftSignIn();
//             }
//             return HomeScreen();
//           }

//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const LoadingPlaceholder();
//           }

//           if (snapshot.hasError) {
//             return const Placeholder();
//           }

//           return const LoadingPlaceholder();
//         },
//       ),

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 130,
        leading: const Center(
          child: Text(
            "Hola peter",
            style: TextStyle(fontSize: 26),
          ),
        ),
        actions: const [
          CircleAvatar(
            backgroundColor: HabiColor.orange,
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
                child: ListView(
              children: const [
                ListTile(
                  title: Text("this is a test"),
                ),
                ListTile(
                  title: Text("this is a test"),
                ),
                ListTile(
                  title: Text("this is a test"),
                ),
                ListTile(
                  title: Text("this is a test"),
                ),
                ListTile(
                  title: Text("this is a test"),
                ),
              ],
            )),
            const TextField(
              decoration: InputDecoration(hintText: "email"),
            ),
            TextButton(onPressed: () {}, child: const Text("this is test")),
            ElevatedButton(
              onPressed: () {},
              child: const Text("data"),
            )
          ],
        ),
      ),
    );
  }
}
