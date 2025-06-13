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




class RoleSelectionScreen extends StatefulWidget {
  const RoleSelectionScreen({super.key});

  @override
  State<RoleSelectionScreen> createState() => _RoleSelectionScreenState();
}

class _RoleSelectionScreenState extends State<RoleSelectionScreen> {
  String? selectedRole;

  void _navigateToNextScreen() {
    if (selectedRole == 'company') {
      Navigator.push(context, MaterialPageRoute(builder: (_) => const CompanyScreen()));
    } else if (selectedRole == 'employee') {
      Navigator.push(context, MaterialPageRoute(builder: (_) => const EmployeeScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Choose your role\nbelow 👇",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 30),
              RoleOption(
                title: "I am a Company",
                image: 'assets/role_icon/company.jpg', // Replace with your illustration
                selected: selectedRole == 'company',
                onTap: () => setState(() => selectedRole = 'company'),
              ),
              const SizedBox(height: 16),
              const Center(child: Text("or", style: TextStyle(fontSize: 16))),
              const SizedBox(height: 16),
              RoleOption(
                title: "I am an Employee",
                image: 'assets/role_icon/individual.jpg', // Replace with your illustration
                selected: selectedRole == 'employee',
                onTap: () => setState(() => selectedRole = 'employee'),
              ),
              const Spacer(),
              if (selectedRole != null)
                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red.shade900,
                      minimumSize: const Size(double.infinity, 55),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    onPressed: _navigateToNextScreen,
                    child: const Text("Get started", style: TextStyle(fontSize: 18, color: Colors.white)),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class RoleOption extends StatelessWidget {
  final String title;
  final String image;
  final bool selected;
  final VoidCallback onTap;

  const RoleOption({
    super.key,
    required this.title,
    required this.image,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: selected ? Colors.red.shade100 : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: selected ? Colors.red.shade900 : Colors.grey.shade300,
            width: selected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Image.asset(image, height: 60, width: 60),
            const SizedBox(width: 20),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
            ),
            Icon(selected ? Icons.check_circle : Icons.circle_outlined,
                color: selected ? Colors.red.shade900 : Colors.grey),
          ],
        ),
      ),
    );
  }
}

class CompanyScreen extends StatefulWidget {
  const CompanyScreen({super.key});

  @override
  State<CompanyScreen> createState() => _CompanyScreenState();
}

class _CompanyScreenState extends State<CompanyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Company Login")),
      body: const Center(child: Text("This is the Company Login screen")),
    );
  }
}


class EmployeeScreen extends StatefulWidget {
  const EmployeeScreen({super.key});

  @override
  State<EmployeeScreen> createState() => _EmployeeScreenState();
}

class _EmployeeScreenState extends State<EmployeeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Employee Login")),
      body: const Center(child: Text("This is the Employee Login screen")),
    );
  }
}

