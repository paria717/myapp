import 'package:flutter/material.dart';
import 'package:myapp/auth_page.dart';
import 'package:myapp/home.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://xjpkmrbpdgrpgrxqvpff.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InhqcGttcmJwZGdycGdyeHF2cGZmIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzI2MDg0NDcsImV4cCI6MjA0ODE4NDQ0N30.yBUdxBcxwjUD5GhqWApqGs8iaNw-R3EPNGfsz1BI-34',
  );
  
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 238, 19, 92)),
          useMaterial3: true,
        ),
        home: AuthPage());
  }
}
