import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_typeahead_web/flutter_typeahead.dart';
import 'package:logger/logger.dart';
import 'package:new_digitendance/app/contants.dart';
import 'package:new_digitendance/ui/courses/faculty_selection_card.dart';
import 'package:new_digitendance/ui/courses/pre_reqs.dart';
import 'package:new_digitendance/ui/shared/spacers.dart';

import '../../app/models/course.dart';
import '../../app/models/faculty.dart';
import '../home/admin/state/admin_state.dart';

class NewCourseForm extends ConsumerStatefulWidget {
  const NewCourseForm({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _NewCourseFormState();
}

class _NewCourseFormState extends ConsumerState<NewCourseForm> {
  /// text editing controllers
  TextEditingController courseCreditController = TextEditingController();

  TextEditingController courseIdController = TextEditingController();
  TextEditingController courseTitleController = TextEditingController();
  TextEditingController facultyController = TextEditingController();
  var log = Logger();
  Course? preLoadedState;

  // SearchApi searchService = SearchApi();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    courseTitleController.text = '';
    courseIdController.text = '';
    courseCreditController.text = '';
    // courseCreditController.text =
    //     preLoadedState?.credits == 0 ? '' : preLoadedState!.credits.toString();
  }

  facultySuggestionSelected(Faculty? faculty) {
    log.i('${faculty.toString()} has been selected from search');
    // course.
  }

  void onCourseSaved() {
    Course newState = Course(
        courseTitle: courseIdController.text,
        courseId: courseTitleController.text,
        credits: int.parse(courseCreditController.text),
        preReqs: const [],
        sessions: const [],
        docRef: ref
            .read(dbApiProvider)
            .documentReferenceFromPath('institutions/Not_INItialized'));
    var _docRef = ref
        .read(dbApiProvider)
        .dbCourse
        .getDocRefForNewCourse(ref as ProviderRef);
    newState.docRef = _docRef;

    ref
        .read(dbApiProvider)
        .dbCourse
        .addNewCourse(course: newState, ref: ref as ProviderRef);

    // addNewCourse(course).then((value) => ScaffoldMessenger.maybeOf(context)!
    //     .showSnackBar(SnackBar(
    //         content: Text(
    //             'New Course with Course ID  ${course.courseId} ]] has been Successsfully Saved'))));
  }

  void onSave() {}

  void onReset() {}

  void onCancel() {}

  Widget _buildButtonBar() {
    return SizedBox(
      height: 80,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            flex: 8,
            child: TextButton(
                onPressed: onCancel,
                // icon: const Icon(Icons.cancel),
                child: const Text(
                  'Cancel',
                  style: TextStyle(fontSize: 24),
                )),
          ),
          const Spacer(flex: 1),
          Expanded(
            flex: 8,
            child: TextButton(
                onPressed: onReset,
                child: const Text(
                  'RESET',
                  style: TextStyle(fontSize: 24),
                )),
          ),
          const Spacer(flex: 1),
          Expanded(
            flex: 8,
            child: ElevatedButton.icon(
                onPressed: onSave,
                icon: const Icon(Icons.save),
                label: const Text(
                  'Save',
                  style: TextStyle(fontSize: 24),
                )),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var preLoadedState = ref.read(currentCourseProvider);
    
    var _formKey = GlobalKey<_NewCourseFormState>();

    return Center(
      child: SizedBox(
        width: MediaQuery.of(context).size.width * .75,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.always,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ///[CourseId] text form field
                    CourseIdField(courseIdController: courseIdController),
                    const SpacerVertical(30),

                    ///[courseTitle FormField]
                    CourseTitleField(
                      courseTitleController: courseTitleController,
                    ),
                    const SpacerVertical(30),

                    ///[courseCredits] Form Field
                    CourseCreditsFormField(
                      courseCreditController: courseCreditController,
                    ),
                    const SpacerVertical(30),

                    ///[facutyId] Form Field
                    // TypeAheadField<Faculty?>(
                    //   // minCharsForSuggestions: 3,
                    //   // controller: facultyController,
                    //   // suggestionsCallback: suggestionsCallback,
                    //   // itemBuilder: (context, faculty) =>
                    //   //     FacultySearchListTile(faculty: faculty!),
                    //   onSuggestionSelected: facultySuggestionSelected,
                    //   textFieldConfiguration: TextFieldConfiguration(
                    //     autofocus: true,
                    //     style:
                    //         DefaultTextStyle.of(context).style.copyWith(fontSize: 18),
                    //     textCapitalization: TextCapitalization.sentences,
                    //     decoration: const InputDecoration(
                    //       icon: Icon(Icons.book),
                    //       hintText: 'Faculty email',
                    //       labelText: 'Faculty *',
                    //     ),
                    //   ),
                    //   // onSaved: (String? value) {
                    //   //   // This optional block of code can be used to run
                    //   //   // code when the user saves the form.
                    //   // },
                    //   // validator: (String? value) {
                    //   //   return (value != null && value.contains('@'))
                    //   //       ? 'Do not use the @ char.'
                    //   //       : null;
                    //   // },
                    // ),

                    const SpacerVertical(30),
                    const PreReqsWidget(),
                    FacultySelectionCard(),

                    const SizedBox(
                      height: 20,
                    ),

                    _buildButtonBar(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CourseCreditsFormField extends StatelessWidget {
  const CourseCreditsFormField({
    Key? key,
    required this.courseCreditController,
  }) : super(key: key);

  final TextEditingController courseCreditController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: courseCreditController,
      decoration: const InputDecoration(
        icon: Icon(Icons.money),
        hintText: 'Number of Credits',
        labelText: 'Credits *',
      ),
      onSaved: (String? value) {
        // This optional block of code can be used to run
        // code when the user saves the form.
      },
      validator: (String? value) {
        return (value != null && value.contains('@'))
            ? 'Do not use the @ char.'
            : null;
      },
    );
  }
}

class CourseTitleField extends StatelessWidget {
  const CourseTitleField({
    Key? key,
    required this.courseTitleController,
  }) : super(key: key);

  final TextEditingController courseTitleController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: courseTitleController,
      decoration: const InputDecoration(
        icon: Icon(Icons.title),
        hintText: 'Exact Title of The Course',
        labelText: 'Course Tiltle * ',
      ),
      onSaved: (String? value) {
        // This optional block of code can be used to run
        // code when the user saves the form.
      },
      validator: (String? value) {
        return (value != null && value.contains('@'))
            ? 'Do not use the @ char.'
            : null;
      },
    );
  }
}

class CourseIdField extends StatelessWidget {
  const CourseIdField({
    Key? key,
    required this.courseIdController,
  }) : super(key: key);

  final TextEditingController courseIdController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: courseIdController,
      decoration: const InputDecoration(
        icon: Icon(Icons.person),
        hintText: 'Unique ID of this course',
        labelText: 'Course Id *',
      ),
      onSaved: (String? value) {
        // This optional block of code can be used to run
        // code when the user saves the form.
      },
      validator: (String? value) {
        return (value != null && value.contains('@'))
            ? 'Do not use the @ char.'
            : null;
      },
    );
  }
}
