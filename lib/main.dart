import 'package:ecommerce/app/auth_widget.dart';
import 'package:ecommerce/app/pages/auth/sign_in_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'app/pages/admin_home.dart';
import 'app/providers.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
        primary: Colors.orange,
        seedColor: Colors.orange,
      )),
      home: AuthWidget(
        adminSignedInBuilder: (context) => AdminHome(),
        signedInBuilder: (context) => Scaffold(
          body: Center(
              child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text("Signed In in"),
              ElevatedButton(
                  onPressed: () {
                    ref.read(firebaseAuthProvider).signOut();
                  },
                  child: const Text("Sign out"))
            ],
          )),
        ),
        nonSignedInBuilder: (_) => const SignInPage(),
      ),
    );
  }
}
