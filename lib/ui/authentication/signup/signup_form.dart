import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:logger/logger.dart';
import 'package:new_digitendance/app/apis/dbapi.dart';
import 'package:new_digitendance/app/contants.dart';
import 'package:new_digitendance/ui/authentication/startup/state/startup_state.dart';
import 'package:new_digitendance/ui/home/admin/admin_homepage.dart';

import '../../../app/models/institution.dart';
import '../../../app/utilities.dart';
import '../state/auth_state.dart';
import '../state/authentication_notifier.dart';
import '../state/institution_state.dart';

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
  late AuthenticationNotifier authStateNotifier;
  late AuthenticationState authState;
  var log = Logger(printer: PrettyPrinter());
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    authStateNotifier = ref.read(authenticationNotifierProvider.notifier);
    authState = ref.watch(authenticationNotifierProvider);

    // return ?
    // builSignUpForm(context):Materialpa;
    if (authState.authenticatedUser == null) {
      return builSignUpForm(context);
    } else {
      return AdminAppHomePage();
    }
  }

  Center builSignUpForm(BuildContext context) {
    return Center(
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
                children: [
                  Expanded(child: buildSignupButton()),
                ],
              ),

              // buildForgotPassword(),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> onSignUp() async {
    _formkey.currentState?.validate();
    _formkey.currentState?.save();

    log.i('CREATING INSTITUTION ${_institution.toString()}');
    authStateNotifier.setBusyTo = true;
    var signedupUser = await authStateNotifier
        .signUpUser(
            email: _email,
            password: _password,
            institution: _institution,
            loginProviderType: LoginProviderType.EmailPassword)
        .then((value) {
      log.i(value.toString());
      authStateNotifier.setAuthenticatedUser(appUser: value);
      ref
          .read(institutionNotifierProvider.notifier)
          .setInstitution(_institution);
      // final adminNotifier =ref.read(adminStateNotifierProvider.notifier);
      // adminNotifier.
      Navigator.of(context).pop();
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => AdminAppHomePage()));
    });

    authStateNotifier.setBusyTo = false;
    // ref.read(authenticationNotifierProvider.notifier).up
  }

  buildSignupButton() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 128),
      child: SizedBox(
        // width: 300,
        height: 50,
        child: authStateNotifier.isNotBusy
            ? Container(
                margin: const EdgeInsets.symmetric(horizontal: 28),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: ElevatedButton.icon(
                      onPressed: onSignUp,
                      icon: const FaIcon(FontAwesomeIcons.key),
                      label: const Text(
                        'Sign Up',
                        style: TextStyle(fontSize: 22),
                      )),
                ),
              )
            : const Center(child: CircularProgressIndicator.adaptive()),
      ),
    );
  }

  _emailTextField() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 64),
      child: Padding(
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
          )),
    );
  }

  _institutionTextField() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 64),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: TextFormField(
          keyboardType: TextInputType.emailAddress,
          controller: institutionController,
          onSaved: (newValue) {
            _institution = Institution(
                title: newValue!,
                id: 'not set',
                address: 'not set',
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
      ),
    );
  }

  _passwordTextField() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 64),
      child: Padding(
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
      ),
    );
  }
}
