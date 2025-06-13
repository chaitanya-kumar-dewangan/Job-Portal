import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
// import '../../colors/color.dart';
// import '../../home/screen/home_screen.dart';
import '../screens/phone_auth_page.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<AuthState>(
      stream: Supabase.instance.client.auth.onAuthStateChange,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: Center(child: CircularProgressIndicator(color: Colors.red.shade900)),
          );
        }
        final session = snapshot.hasData ? snapshot.data!.session : null;
        if (session != null) {
          final userId = session.user.id ?? ""; // userId from Sup abase
          return HomePage();
        } else {
          return PhoneAuthPage();
        }
      },
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
