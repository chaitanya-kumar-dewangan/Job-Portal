// import 'package:ask/onboarding/screens/onboarding_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:provider/provider.dart';
// import 'onboarding/services/onboarding_provider.dart';
//
// void main() {
//   WidgetsFlutterBinding.ensureInitialized();
//   // ✅ Set transparent status bar
//   SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
//     statusBarColor: Colors.transparent, // Transparent status bar
//     statusBarIconBrightness: Brightness.dark, // Or Brightness.light based on background
//   ));
//
//   runApp(
//     MultiProvider(
//       providers: [
//         ChangeNotifierProvider(create: (_) => OnboardingProvider()),
//       ],
//       child: const MyApp(),
//     ),
//   );
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Career App',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//       ),
//       home: OnboardingScreen(), // Make sure this screen uses `extendBodyBehindAppBar: true`
//     );
//   }
// }
//


import 'package:ask/utils/credentials.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'authentication/services/auth_gate.dart';
import 'onboarding/screens/onboarding_screen.dart';
import 'onboarding/services/onboarding_provider.dart';

void main() async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  try {
    await Supabase.initialize(
      anonKey: SupabaseCredential.APIKEY,
      url: SupabaseCredential.APIURL,
    );
  } catch (e) {
    print('Failed to initialize Supabase: $e');
    // Handle the error appropriately, e.g., show a user-friendly message or fallback
  }
  FlutterNativeSplash.remove();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => OnboardingProvider()),

      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final session = Supabase.instance.client.auth.currentSession;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Aarna Food Court',
      home: session != null ? AuthGate() : OnboardingScreen(),
      // home: Scrreen(),
    );
  }
}
