import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:new_digitendance/app/models/faculty.dart';
import 'package:new_digitendance/app/states/admin_state.dart';
import 'package:new_digitendance/ui/shared/spacers.dart';

import '../../authentication/login/login_form.dart';

final newFacultyProvider = StateNotifierProvider<FacultyNotifier,Faculty>((ref) {
  return FacultyNotifier(Faculty.initial());
});

class FacultyNotifier  extends StateNotifier<Faculty>{
  FacultyNotifier(super.state);
  void setUserId({required String userId}){
    state=state.copyWith(userId: userId);
  }
  void setPhone({required String value}){
    state=state.copyWith(phone: value);
  }
  
}


class NewFacultyForm extends ConsumerStatefulWidget {
  const NewFacultyForm({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _NewFacultyFormState();
}

class _NewFacultyFormState extends ConsumerState<NewFacultyForm> {
  late TextEditingController bioController;
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
    bioController.dispose();
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
    bioController = TextEditingController();
    var _formKey = GlobalKey<FormState>();
  }



    var state  ;
  @override
  Widget build(BuildContext context) {
    state= ref.watch(newFacultyProvider);
    return LayoutBuilder(
      builder: (context, constraints) => SizedBox(
        width: constraints.maxWidth * .45,
        child: Dialog(
            elevation: 10,
            insetPadding: const EdgeInsets.all(48),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const _FormHeader(),
                  const Divider(thickness: 1),
                  UserIdTextFormField(controller: userIdController),
                  SpacerVertical(24),
                  IconButton(
                    icon: const Icon(
                      Icons.add_a_photo_outlined,
                      size: 120,
                    ),
                    onPressed: () {},
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const PrefixMenu(),
                      SpacerHorizontal(24),
                      FirstNameTextFormField(controller: firstNameController),
                      SpacerHorizontal(12),
                      LastNameTextFormField(controller: lastNameController),
                    ],
                  ),
                  const SpacerVertical(24),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Job Title',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      SpacerHorizontal(36),
                      JobTitleMenu(),
                    ],
                  ),
                  const SpacerVertical(24),
                  PhoneTextFormField( phoneController),
                  const SpacerVertical(24),

                  // const SpacerVertical(24),
                  BioTextFormField(controller: bioController),
                  //ButtonBar
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Flexible(
                            // flex: 3,
                            child: Container(
                          width: double.infinity,
                          child: OnHoverButton(
                            child: ElevatedButton(
                                onPressed: createNewFaculty, child: const Text('Save')),
                          ),
                        )),
                        Flexible(
                            // flex: 2,
                            child: Container(
                          width: double.infinity,
                          child: OnHoverButton(
                            child: TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text('Cancel')),
                          ),
                        )),
                      ],
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }

  void createNewFaculty() {
    //TODO  savr the form
    log.i('save button was clicked phone = ${state.phone}');
  }
}

class JobTitleMenu extends ConsumerStatefulWidget {
  const JobTitleMenu({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _JobTitleMenuState();
}

class _JobTitleMenuState extends ConsumerState<JobTitleMenu> {
  String selectedJobTitle = 'Please Select';
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

class PhoneTextFormField extends ConsumerStatefulWidget {
  const PhoneTextFormField(this.controller, {super.key});
  final TextEditingController controller;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PhoneTextFormFieldState();
}

class _PhoneTextFormFieldState extends ConsumerState<PhoneTextFormField> {

  @override
  Widget build(BuildContext context) {
    final state= ref.watch(newFacultyProvider);
    return ConstrainedBox(
      constraints: BoxConstraints(
        minWidth: 200,
        maxWidth: 350,
      ),
      child: Padding(
        padding:
            const EdgeInsets.only(top: 12, left: 32.0, right: 32, bottom: 12),
        child: TextFormField(
          controller: widget.controller,
          decoration: InputDecoration(
            labelText: ' phone ',
            hintText: '+923XX XXXX XXX',
            hintStyle: Theme.of(context).textTheme.labelLarge?.copyWith(
                fontStyle: FontStyle.italic,
                color: Theme.of(context).colorScheme.primary),
            // If  you are using latest version of flutter then lable text and hint text shown like this
            // if you r using flutter less then 1.20.* then maybe this is not working properly
            floatingLabelBehavior: FloatingLabelBehavior.auto,
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
       onSaved: (value){
        if (state!=null) {
          ref.read(newFacultyProvider.notifier).setPhone(value: value!);
        }
       },
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
    return ConstrainedBox(
      constraints: BoxConstraints(
        minWidth: 150,
        maxWidth: 350,
      ),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: ' First Name',
          hintText: 'First  name of the new Faculty member',
          hintStyle: Theme.of(context).textTheme.labelLarge?.copyWith(
              fontStyle: FontStyle.italic,
              color: Theme.of(context).colorScheme.primary),

          // If  you are using latest version of flutter then lable text and hint text shown like this
          // if you r using flutter less then 1.20.* then maybe this is not working properly
          floatingLabelBehavior: FloatingLabelBehavior.auto,
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
    return ConstrainedBox(
      constraints: BoxConstraints(
        minWidth: 150,
        maxWidth: 350,
      ),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: ' Last Name',
          hintText: 'Last name of the new Faculty member',
          hintStyle: Theme.of(context).textTheme.labelLarge?.copyWith(
              fontStyle: FontStyle.italic,
              color: Theme.of(context).colorScheme.primary),

          // If  you are using latest version of flutter then lable text and hint text shown like this
          // if you r using flutter less then 1.20.* then maybe this is not working properly
          floatingLabelBehavior: FloatingLabelBehavior.auto,
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
    return ConstrainedBox(
      constraints: BoxConstraints(
        minWidth: 150,
        maxWidth: 350,
      ),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: 'user Id',
          hintText: 'User Id for the new faculty',
          hintStyle: Theme.of(context).textTheme.labelLarge?.copyWith(
              fontStyle: FontStyle.italic,
              color: Theme.of(context).colorScheme.primary),

          // If  you are using latest version of flutter then lable text and hint text shown like this
          // if you r using flutter less then 1.20.* then maybe this is not working properly
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          suffixIcon: Tooltip(
            message: '''This is the user Id of the faculty you create
               this will be the UserId for that  faculty member  to login to the system
               ''',
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

class BioTextFormField extends StatelessWidget {
  const BioTextFormField({
    super.key,
    required this.controller,
  });

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        minWidth: 250,
        maxWidth: 550,
      ),
      child: TextFormField(
        controller: controller,
        maxLines: null,
        decoration: InputDecoration(
          labelText: 'Short bio ',
          hintText: 'Enter short bio of the new faculty',
          hintStyle: Theme.of(context).textTheme.labelLarge?.copyWith(
              fontStyle: FontStyle.italic,
              color: Theme.of(context).colorScheme.primary),

          // If  you are using latest version of flutter then lable text and hint text shown like this
          // if you r using flutter less then 1.20.* then maybe this is not working properly
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          suffixIcon: Tooltip(
            message: '''This is the user Id of the faculty you create
               this will be the UserId for that  faculty member  to login to the system
               ''',
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
