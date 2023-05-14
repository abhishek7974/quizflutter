import 'package:fintech_assignment/controller/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: true);

    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
              ),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
              ),
              obscureText: true,
            ),
            SizedBox(height: 16.0),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      if (_emailController.text != '' &&
                          _passwordController.text != '') {
                        authProvider.login(_emailController.text,
                            _passwordController.text, context);
                        authProvider.serchId(_emailController.text);
                      }
                    },
                    child: Container(
                      margin: EdgeInsets.all(20),
                      color: Colors.blue,
                      padding:
                          EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                      child: Center(
                          child: Text(
                        "Login",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      if (_emailController.text != '' &&
                          _passwordController.text != '') {
                        authProvider.signUp(_emailController.text,
                            _passwordController.text, context);
                      }
                    },
                    child: Container(
                      margin: EdgeInsets.all(20),
                      color: Colors.blue,
                      padding:
                          EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                      child: Center(
                          child: Text(
                        "Sign up",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
