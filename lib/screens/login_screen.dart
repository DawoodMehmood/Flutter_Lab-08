import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool obscurePass = true;
  bool rememberMe = false;

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Image.asset(
                'assets/logo.png',
                width: 200,
                height: 200,
              ),
            ),
            Form(
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 25),
                    width: _size.width * 0.8,
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter email address';
                        }
                        if (!RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(value)) {
                          return 'Please enter a valid email address';
                        }
                      },
                      controller: emailController,
                      decoration: const InputDecoration(
                          hintText: 'Email', prefixIcon: Icon(Icons.email)),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 25),
                    width: _size.width * 0.8,
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter password';
                        }
                        if (value.length < 8) {
                          return 'Please enter minimum 8 characters';
                        }
                        const pattern =
                            r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
                        final regExp = RegExp(pattern);
                        if (!regExp.hasMatch(value)) {
                          return 'Please enter valid password with at least one uppercase Alphabet, one special character and one number.';
                        }
                      },
                      obscureText: obscurePass,
                      controller: passwordController,
                      decoration: InputDecoration(
                          hintText: 'Password',
                          prefixIcon: Icon(Icons.lock),
                          suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                obscurePass = !obscurePass;
                              });
                            },
                            child: obscurePass
                                ? Icon(Icons.visibility)
                                : Icon(Icons.visibility_off),
                          )),
                    ),
                  ),
                ],
              ),
              key: _formKey,
            ),
            Container(
              margin: const EdgeInsets.only(top: 25, left: 25, right: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Checkbox(
                          value: rememberMe,
                          onChanged: (value) {
                            setState(() {
                              rememberMe = value!;
                            });
                          }),
                      const Text('Remember Me')
                    ],
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Forgot Password',
                      style: TextStyle(color: Colors.blue),
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 50),
              width: _size.width * 0.75,
              child: ElevatedButton(
                onPressed: () {
                  if (!_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Please enter valid credentials!'),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  } else {
                    Navigator.pushNamed(context, '/catalog');
                  }
                },
                child: const Text('Login'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
