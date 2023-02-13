import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:new_digitendance/ui/shared/spacers.dart';

class NewFacultyForm extends ConsumerStatefulWidget {
  const NewFacultyForm({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _NewFacultyFormState();
}

class _NewFacultyFormState extends ConsumerState<NewFacultyForm> {
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController phoneController;
  late TextEditingController userIdController;

  @override
  void dispose() {
    // TODO: implement dispose
    userIdController.dispose();
    firstNameController.dispose();
    phoneController.dispose();
    lastNameController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userIdController = TextEditingController();
    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
    phoneController = TextEditingController();
    var _formKey = GlobalKey<FormState>();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
        elevation: 10,
        insetPadding: const EdgeInsets.all(32),
        child: Container(
            width: MediaQuery.of(context).size.width * .45,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const _FormHeader(),
                  const Divider(thickness: 1),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        //     const PrefixMenu(),
                        //     UserIdTextFormField(controller: userIdController),
                        //   ],
                        // ),
                        // const Divider(thickness: 0.5),
                        // const SpacerVertical(8),
                        // FirstNameTextFormField(controller: firstNameController),
                        // const Divider(thickness: 0.5),
                        // const SpacerVertical(8),
                        // LastNameTextFormField(controller: lastNameController),
                        // const Divider(thickness: 0.5),
                        // const SpacerVertical(8),
                        // PhoneTextFormField(controller: phoneController),
                        // const Divider(thickness: 0.5),
                        // const SpacerVertical(8),
                        Container(
                          height: 150,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Icon(
                                Icons.person,
                                size: 100,
                              ),
                              Container(
                                height: 250,
                                width: 100,
                                child: Text('text boxes go here.'),
                              ),
                            ],
                          ),
                        ),
                      ]),
                  // ),
                ],
              ),
            )));
  }
}

class PrefixMenu extends ConsumerStatefulWidget {
  const PrefixMenu({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PrefixMenuState();
}

class _PrefixMenuState extends ConsumerState<PrefixMenu> {
  List<String> prefixes = [
    'Mr',
    'Ms',
    'Mrs',
    'Dr',
  ];
  String selectedPrefix = 'Mr';

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: selectedPrefix,
      items: prefixes
          .map((e) => DropdownMenuItem(
                child: Text(e),
                value: e,
              ))
          .toList(),
      onChanged: (value) {
        setState(() {
          selectedPrefix = value!;
        });
      },
    );
  }
}

class _FormHeader extends StatelessWidget {
  const _FormHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      'Create New Faculty',
      style: Theme.of(context).textTheme.headlineMedium,
    );
  }
}

class PhoneTextFormField extends StatelessWidget {
  const PhoneTextFormField({
    super.key,
    required this.controller,
  });

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: ' phone ',
        hintText: '+923XX XXXX XXX',
        hintStyle: Theme.of(context).textTheme.labelSmall?.copyWith(
            fontStyle: FontStyle.italic,
            color: Theme.of(context).colorScheme.primary),
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Tooltip(
          message: '''This is the First Name of the faculty you create
             will be the UserId for the  faculty to login
             ADMIN ROLE of the institution.appears evety where in the system''',

          child: const Icon(Icons.phone_android_sharp),
          // height: 160,
          textStyle: Theme.of(context)
              .textTheme
              .titleMedium!
              .copyWith(color: Theme.of(context).colorScheme.onPrimary),
        ),
      ),
    );
  }
}

class FirstNameTextFormField extends StatelessWidget {
  const FirstNameTextFormField({
    super.key,
    required this.controller,
  });

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: ' First Name',
        hintText: 'First  name of the new Faculty member',
        hintStyle: Theme.of(context).textTheme.labelSmall?.copyWith(
            fontStyle: FontStyle.italic,
            color: Theme.of(context).colorScheme.primary),

        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Tooltip(
          message: '''This is the First Name of the faculty you create
             will be the UserId for the  faculty to login
             ADMIN ROLE of the institution.appears evety where in the system''',
          child: const Icon(Icons.person),
          // height: 160,
          textStyle: Theme.of(context)
              .textTheme
              .titleMedium!
              .copyWith(color: Theme.of(context).colorScheme.onPrimary),
        ),
      ),
    );
  }
}

class LastNameTextFormField extends StatelessWidget {
  const LastNameTextFormField({
    super.key,
    required this.controller,
  });

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: ' Last Name',
        hintText: 'Last name of the new Faculty member',
        hintStyle: Theme.of(context).textTheme.labelSmall?.copyWith(
            fontStyle: FontStyle.italic,
            color: Theme.of(context).colorScheme.primary),

        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Tooltip(
          message: '''This is the Last Name of the faculty you create
             will be the UserId for the  faculty to login
             ADMIN ROLE of the institution.appears evety where in the system''',
          child: const Icon(Icons.person),
          // height: 160,
          textStyle: Theme.of(context)
              .textTheme
              .titleMedium!
              .copyWith(color: Theme.of(context).colorScheme.onPrimary),
        ),
      ),
    );
  }
}

class UserIdTextFormField extends StatelessWidget {
  const UserIdTextFormField({
    super.key,
    required this.controller,
  });

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: 'user Id',
        hintText: 'User Id for the new faculty',
        hintStyle: Theme.of(context).textTheme.labelSmall?.copyWith(
            fontStyle: FontStyle.italic,
            color: Theme.of(context).colorScheme.primary),

        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Tooltip(
          message: '''This is the user Id of the faculty you create
             will be the UserId for the  faculty to login
             ADMIN ROLE of the institution.appears evety where in the system''',
          child: const Icon(Icons.person),
          // height: 160,
          textStyle: Theme.of(context)
              .textTheme
              .titleMedium!
              .copyWith(color: Theme.of(context).colorScheme.onPrimary),
        ),
      ),
    );
  }
}
