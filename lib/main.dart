import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'data/user_dao.dart';
import 'home_page/homepage.dart';
import 'login_page.dart';
import 'splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<UserDao>(
          lazy: false,
          create: (_) => UserDao(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Hitch Hiking',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        // 1
        home: Consumer<UserDao>(
          // 2
          builder: (context, userDao, child) {
            // 3
            if (userDao.isLoggedIn()) {
              return HomePage();
            } else {
              return const LoginPage();
            }
          },
        ),
      ),
    );
  }
}
