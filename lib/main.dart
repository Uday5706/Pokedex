import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pokepedia/screens/home_screen.dart';
import 'package:pokepedia/screens/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); //This ensures Flutter’s binding is set up before running any async/native code (like Firebase).
  await Firebase.initializeApp(); //This initializes Firebase in your app.
  runApp(Pokedex());
}

class Pokedex extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner:
          false, // to remove the trial app sign on top right
      theme: ThemeData(
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: {
            TargetPlatform.android:
                CupertinoPageTransitionsBuilder(), // iOS-style side transition
            TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          },
        ),
        textTheme: GoogleFonts.poppinsTextTheme(),
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: Colors.blue, // blinking cursor color
          selectionColor: Colors.blueAccent.shade100, // highlight color
          selectionHandleColor:
              Colors.blueAccent, // <--- this changes the blob color
        ), // Apply Poppins globally
      ),
      home: FirebaseAuth.instance.currentUser != null
          ? const HomeScreen()
          : const LoginScreen(),
    );
  }
}
