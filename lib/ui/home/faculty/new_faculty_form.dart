import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:new_digitendance/ui/shared/spacers.dart';

import '../../authentication/login/login_form.dart';

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
    return LayoutBuilder(builder: (context,constraints)=>
      Container(
        width: constraints.maxWidth*.45,
        child: Dialog(
            elevation: 10,
            insetPadding: const EdgeInsets.all(32),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const _FormHeader(),
                  const Divider(thickness: 1),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Placeholder(fallbackHeight: 180,
                      fallbackWidth: 180,
                      child: IconButton(icon: Icon(Icons.add_a_photo_outlined,size: 120,), onPressed: () {  },),),
                      Column(
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              PrefixMenu(),
                              LayoutBuilder(builder: (context,constraints){
                                double parentWidth = constraints.maxWidth;
                                return SizedBox(width: parentWidth-16,
                                height: 50,
                                child: FirstNameTextFormField(controller: firstNameController),);
                              }),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  SpacerVertical(12),
                  Placeholder(fallbackHeight: 80,),
                  SpacerVertical(12),
                  Placeholder(fallbackHeight: 80,),
                  SpacerVertical(12),
                  Placeholder(fallbackHeight: 80,),
                  SpacerVertical(12),
          
              
          
                  //ButtonBar
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Flexible(
                          flex: 3,
                          child: Container(
                            width: double.infinity,
                            child: OnHoverButton(
                              child: ElevatedButton(
                                  onPressed: () {}, child: Text('Save')),
                            ),
                          )),
                      Flexible(
                          flex: 2,
                          child: Container(
                            width: double.infinity,
                            child: OnHoverButton(
                              child: TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text('Cancel')),
                            ),
                          )),
                    ],
                  ),
          
                  // ),
                ],
              ),
            )),
      ),
    );
  }
}

class JobTitleMenu extends ConsumerStatefulWidget {
  const JobTitleMenu({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _JobTitleMenuState();
}

class _JobTitleMenuState extends ConsumerState<JobTitleMenu> {
  List<String> titles = [
    'Please Select',
    'Professor',
    'Assistant Professor',
    'Associate Professor',
    'Lecturer',
    'Lab Scientist',
    'Lab Technician',
    'Teaching Assistant'
  ];
  String selectedJobTitle = 'Please Select';

  @override
  Widget build(BuildContext context) {
    return Container(
      child: DropdownButton<String>(
        value: selectedJobTitle,
        items: titles
            .map(
              (e) => DropdownMenuItem(
                child: Text(e),
                value: e,
              ),
            )
            .toList(),
        onChanged: (value) {
          setState(() {
            selectedJobTitle = value!;
          });
        },
      ),
    );
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
    // final maxwidth = MediaQuery.of(context).size.width;
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
    return Container(
      // width: 200,
      child: TextFormField(
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
      ),
    );
  }
}
