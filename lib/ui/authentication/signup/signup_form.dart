import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:new_digitendance/app/apis/dbapi.dart';
import 'package:new_digitendance/ui/authentication/auth_state.dart';

import '../../../app/models/institution.dart';
import '../../../app/utilities.dart';

class SignupForm extends ConsumerStatefulWidget {
  const SignupForm({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginFormState();
}

class _LoginFormState extends ConsumerState<SignupForm> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController institutionController = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  String _email = '';
  bool concealPassword = true;
  String _password = '';
  late Institution _institution;
  late AuthStateNotifier notifier;
  late AuthState state;
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    notifier = ref.read(authStateNotifierProvider.notifier);
    state = ref.watch(authStateNotifierProvider);
    return Container(
      child: Center(
        child: SingleChildScrollView(
          child: Form(
            key: _formkey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Text(
                    'SIGN UP',
                    style: Theme.of(context).textTheme.headline3?.copyWith(
                          color: Theme.of(context).primaryColor,
                        ),
                  ),
                ),
                _institutionTextField(),
                const SizedBox(
                  height: 20,
                ),
                _emailTextField(),
                const SizedBox(
                  height: 20,
                ),
                _passwordTextField(),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    buildSignupButton(),
                  ],
                ),

                // buildForgotPassword(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> onSignUp() async {
    var result =
        await FirebaseFirestore.instance.collection('institutions').get();
    Utils.log(result.docs[0].data().toString());

    // _formkey.currentState?.validate();
    // _formkey.currentState?.save();

    // Utils.log('CREATING INSTITUTION ${_institution.toString()}');
    // notifier.setBusy();
    // var result =  notifier
    //     .signUpWithEmailPassword(
    //         email: _email,
    //         password: _password,
    //         institution: _institution,
    //         login_serviceProvider: LoginProviderType.EmailPassword)
    //     .then((value) {

    // notifier.setIdle();
    // Utils.log(value.runtimeType.toString());
    //     });
  }

  buildSignupButton() {
    return SizedBox(
      // width: 300,
      height: 50,
      child: notifier.isNotBusy
          ? Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: ElevatedButton.icon(
                  onPressed: onSignUp,
                  icon: const FaIcon(FontAwesomeIcons.key),
                  label: const Text(
                    'Sign Up',
                    style: TextStyle(fontSize: 22),
                  )),
            )
          : const Center(child: CircularProgressIndicator.adaptive()),
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
            _email = value!;
          },
          validator: (value) {
            return null;
          },
          decoration: const InputDecoration(
            labelText: "Email",
            hintText: "Enter your email",
            // If  you are using latest version of flutter then lable text and hint text shown like this
            // if you r using flutter less then 1.20.* then maybe this is not working properly
            floatingLabelBehavior: FloatingLabelBehavior.always,
            suffixIcon: Tooltip(
              message:
                  'This email will be the UserId for the  \n ADMIN ROLE of the institution.\n  you can set up accounts for faculty and students later',
              child: Icon(Icons.question_mark),
              // height: 160,
              textStyle: TextStyle(fontSize: 20),
            ),
          ),
        ));
  }

  _institutionTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: TextFormField(
        keyboardType: TextInputType.emailAddress,
        controller: institutionController,
        onSaved: (newValue) {
          _institution = Institution(
              title: newValue!,
              id: 'not set',
              docRef: DbApi().dbAppUser.db.collection('institutions').doc());
        },
        // validator: (value) {},
        decoration: const InputDecoration(
          labelText: "Institution Name",
          hintText: "Name of your school or college",
          // If  you are using latest version of flutter then lable text and hint text shown like this
          // if you r using flutter less then 1.20.* then maybe this is not working properly
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: Tooltip(
            message:
                'The name of the organization for which this App \nwill maintain data.....can be changed later',
            child: Icon(Icons.question_mark),
            // height: 160,
            textStyle: TextStyle(fontSize: 20),
          ),
        ),
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
          _password = value!;
        },
        // validator: (value) {},
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
}
