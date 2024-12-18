import 'package:flutter/material.dart';
import 'package:myapp/home.dart';
import 'package:myapp/messages_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final TextEditingController userName = TextEditingController();
  final TextEditingController email = TextEditingController();

  final TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: userName,
              decoration: InputDecoration(
                  hintText: 'نام کاربری ',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(30))),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: email,
              decoration: InputDecoration(
                  hintText: 'ایمیل',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(30))),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: password,
              decoration: InputDecoration(
                  hintText: 'رمزعبور',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(30))),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton(
                  onPressed: () async {
                    try {
                      final AuthResponse res = await supabase.auth.signUp(
                        email: email.text,
                        password: password.text,
                        data: {'username': userName.text},
                      );

                      final Session? session = res.session;
                      final User? user = res.user;
                      // if (session != null && user != null) {
                      //   return showDialog(
                      //     context: context,
                      //     builder: (BuildContext context) {
                      //       return AlertDialog(
                      //           title: Text('${user.appMetadata['username']}خوش آمدید'));
                      //     },
                      //   );
                      // } else {
                      //   return showDialog(
                      //     builder: (BuildContext context) {
                      //       return AlertDialog(title: const Text('ثبت نام با موفقیت انجام نشد '));
                      //     },
                      //     context: context,
                      //   );
                      // }
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const Home(),
                      ));
                    } catch (e) {
                      if (e is PostgrestException) {
                        print('Database error: ${e.message}');
                      } else if (e is AuthException) {
                        print('Auth error: ${e.message}');
                      } else {
                        print('Unknown error: $e');
                      }
                    }
                  },
                  child: const Text('ثبت')),
            ),
          ),
        ],
      ),
    );
  }
}
