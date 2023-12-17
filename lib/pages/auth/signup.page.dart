import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopify_app/providers/app_auth.provider.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  @override
  void initState() {
    Provider.of<AppAuthProvider>(context, listen: false).init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Consumer<AppAuthProvider>(
            builder: (ctx, appAuthProvider, _) {
              return Form(
                key: appAuthProvider.formKey,
                child: SingleChildScrollView(
                  child: SafeArea(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 100,
                          width: 100,
                          color: Colors.red,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text('SignUp'),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          controller: appAuthProvider.emailController,
                          validator: (value) {
                            if (value == null || value == '') {
                              return 'email is required';
                            }
                            if (!EmailValidator.validate(value)) {
                              return 'Enter Valid Email';
                            } else {
                              if (!value.split('@').last.contains('gmail')) {
                                return 'Enter Valid Gmail';
                              }
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            label: const Text('Email'),
                            suffixIcon: const Icon(Icons.mail),
                            // fillColor: Colors.red,
                            isDense: true,
                            filled: true,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15)),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          obscureText: appAuthProvider.obscureText,
                          controller: appAuthProvider.passwordController,
                          validator: (value) {
                            if (value == null || value == '') {
                              return 'password is required';
                            }
                            if (value.length < 8) {
                              return 'Password length must be 8';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            label: const Text('Password'),
                            suffixIcon: InkWell(
                              onTap: () {
                                appAuthProvider.toggleObscure();
                              },
                              child: appAuthProvider.obscureText
                                  ? const Icon(Icons.visibility_off)
                                  : const Icon(Icons.visibility),
                            ),

                            // fillColor: Colors.red,
                            isDense: true,
                            filled: true,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15)),
                          ),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            await appAuthProvider.signUp(context);
                          },
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(300, 60),
                          ),
                          child: const Text('Signup'),
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
