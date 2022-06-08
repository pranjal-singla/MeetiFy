import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:untitled/resources/auth_methods.dart';
import 'package:untitled/screens/home_screen.dart';
import 'package:untitled/screens/login_screen.dart';
import 'package:untitled/screens/video_call_screen.dart';
import 'package:untitled/utils/colors.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Zoom Clone',
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: backgroundColor,
        ),
        routes: {
          LoginScreen.id: (context) => const LoginScreen(),
          HomeScreen.id: (context) => const HomeScreen(),
          VideoCallScreen.id: (context) => const VideoCallScreen(),
        },
        home: SplashScreen(
            seconds: 5,
            navigateAfterSeconds: StreamBuilder(
              stream: AuthMethods().authChanges,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (snapshot.hasData) {
                  return const HomeScreen();
                }
                return const LoginScreen();
              },
            ),
            image: Image.asset(
              'assets/images/meetiFY.png',
              alignment: Alignment.center,
            ),
            photoSize: 100.0,
            backgroundColor: backgroundColor,
            loaderColor: Colors.white));
  }
}
