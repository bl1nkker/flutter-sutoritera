import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_sutoritera/models/app_state_manager.dart';
import 'package:flutter_sutoritera/navigation/sutoritera_pages.dart';
import 'package:provider/provider.dart';
import '../data/user_dao.dart';

class LoginScreen extends StatefulWidget {
  static MaterialPage page() {
    return MaterialPage(
      name: SutoriteraPages.loginPath,
      key: ValueKey(SutoriteraPages.loginPath),
      child: const LoginScreen(),
    );
  }

  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Create a text controller for the email field.
  final _emailController = TextEditingController();
  // Create a text controller for the password field.
  final _passwordController = TextEditingController();
  // Create a key needed for a form.
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // Dispose of the editing controllers.
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Use Provider to get an instance of the UserDao.
    final userDao = Provider.of<UserDao>(context, listen: false);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        // Create the Form with the global key.
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Row(
                children: [
                  const SizedBox(height: 80),
                  Expanded(
                    // Create the field for the email address.
                    child: TextFormField(
                      decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                        hintText: 'Email Address',
                      ),
                      autofocus: false,
                      // Use an email address keyboard type.
                      keyboardType: TextInputType.emailAddress,
                      // Turn off auto-correction and capitalization.
                      textCapitalization: TextCapitalization.none,
                      autocorrect: false,
                      // Set the editing controller.
                      controller: _emailController,
                      // Define a validator to check for empty strings. You can use regular expressions or any other type of validation if you like.
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Email Required';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  const SizedBox(height: 20),
                  Expanded(
                    child: TextFormField(
                      decoration: const InputDecoration(
                          border: UnderlineInputBorder(), hintText: 'Password'),
                      autofocus: false,
                      obscureText: true,
                      keyboardType: TextInputType.visiblePassword,
                      textCapitalization: TextCapitalization.none,
                      autocorrect: false,
                      controller: _passwordController,
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Password Required';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Row(
                children: [
                  const SizedBox(height: 20),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        // Set the first button to call the login() method.
                        userDao.login(
                            _emailController.text, _passwordController.text,
                            () {
                          Provider.of<AppStateManager>(context, listen: false)
                              .login(_emailController.text,
                                  _passwordController.text);
                        });
                      },
                      child: const Text('Login'),
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  const SizedBox(height: 20),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        // Set the second button to call the signup() method.
                        userDao.signup(
                            _emailController.text, _passwordController.text,
                            () {
                          Provider.of<AppStateManager>(context, listen: false)
                              .login(_emailController.text,
                                  _passwordController.text);
                        });
                      },
                      child: const Text('Sign Up'),
                    ),
                  ),
                  const SizedBox(height: 60),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
