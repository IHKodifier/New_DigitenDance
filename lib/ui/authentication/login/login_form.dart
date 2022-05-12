import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:new_digitendance/app/contants.dart';
import 'package:new_digitendance/ui/authentication/signup/signup_page.dart';
import 'package:new_digitendance/ui/home/admin/admin_homepage.dart';

import '../state/auth_state.dart';

class LoginForm extends ConsumerStatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginFormState();
}

class _LoginFormState extends ConsumerState<LoginForm> {
  bool concealPassword = true;
  String email = '';
  TextEditingController emailController = TextEditingController();
  String password = '';
  TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  buildLoginButton(WidgetRef ref) {
    // final authState = ref.watch(authStateProvider);
    final notifier = ref.read(authenticationNotifierProvider.notifier);
    return Expanded(
      child: Container(
        // width: 300,
        height: 50,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: ElevatedButton(
              // icon: FaIcon(FontAwesomeIcons.key, size: 40),
              onPressed: () async {
                notifier.setBusyTo = true;
                var loginSuccess = await notifier.login(
                    loginProvider: LoginProviderType.EmailPassword,
                    email: emailController.text,
                    password: passwordController.text);
                notifier.setBusyTo = false;
                Navigator.of(context).pop();
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_)=>AdminAppHomePage()));
              },
              child: const Text(
                'Login',
                style: TextStyle(fontSize: 22),
              )),
        ),
      ),
    );
  }

  buildSignUpButton(WidgetRef ref) {
    // final authState = ref.watch(authStateProvider);
    // final notifier = ref.read(authStateProvider.notifier);
    return Expanded(
      child: Container(
        // width: 300,
        height: 50,
        child: Padding(
          padding: const EdgeInsets.all(0),
          child: TextButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (_) => const SignupPage()));
              },
              child: const Text(
                'SIGN UP',
                style: TextStyle(fontSize: 22),
              )),
        ),
      ),
    );
  }

  _emailTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: TextFormField(
        keyboardType: TextInputType.emailAddress,
        controller: emailController,
        // onSaved: (newValue) => email = newValue,
        onSaved: (value) {
          email = value!;
        },
        validator: (value) {},
        decoration: const InputDecoration(
            labelText: "Email",
            hintText: "Enter your email",
            // If  you are using latest version of flutter then lable text and hint text shown like this
            // if you r using flutter less then 1.20.* then maybe this is not working properly
            floatingLabelBehavior: FloatingLabelBehavior.always,
            suffixIcon: Icon(Icons.email)),
      ),
    );
  }

  _passwordTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: TextFormField(
        keyboardType: TextInputType.emailAddress,
        controller: passwordController,
        obscureText: concealPassword,
        onSaved: (value) {
          password = value!;
        },
        validator: (value) {},
        decoration: InputDecoration(
          labelText: "Password",
          hintText: "Passwords are case SENSITIVE",

          // If  you are using latest version of flutter then lable text and hint text shown like this
          // if you r using flutter less then 1.20.* then maybe this is not working properly
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: IconButton(
            splashColor: Theme.of(context).primaryColor.withOpacity(0.3),
            onPressed: () {
              setState(() {
                concealPassword = !concealPassword;
              });
            },
            icon: concealPassword
                ? const Icon(Icons.visibility)
                : const Icon(Icons.visibility_off),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final notifier = ref.read(authenticationNotifierProvider.notifier);
    return Material(
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Text(
                  'LOGIN',
                  style: Theme.of(context).textTheme.headline3,
                ),
              ),
              _emailTextField(),
              SizedBox(
                height: 20,
              ),
              _passwordTextField(),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  buildLoginButton(ref),
                  buildSignUpButton(ref),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
