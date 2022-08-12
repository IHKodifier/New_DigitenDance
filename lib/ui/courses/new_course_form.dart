import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_typeahead_web/flutter_typeahead.dart';
import 'package:logger/logger.dart';
import 'package:new_digitendance/app/contants.dart';
import 'package:new_digitendance/app/models/session.dart';
import 'package:new_digitendance/ui/courses/pre_reqs_wiget.dart';
import 'package:new_digitendance/ui/courses/pre_reqs_state.dart';
import 'package:new_digitendance/ui/shared/spacers.dart';

import '../../app/models/course.dart';
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
  Course? newState;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // SearchApi searchService = SearchApi();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    courseTitleController.text = '';
    courseIdController.text = '';
    courseCreditController.text = '';
  }

  void onCourseSaved() {
    ref.read(preReqsEditingProvider).selectedPreReqs;

    //prep a new course object
    Course newState = Course(
        id: courseIdController.text,
        title: courseTitleController.text,
        credits: int.parse(courseCreditController.text),
        preReqs: ref.read(preReqsEditingProvider).selectedPreReqs?.toList(),
        sessions: [
          Session.initial(),
          Session.initial(),
          Session.initial(),
        ],
        docRef: ref
            .read(dbApiProvider)
            .documentReferenceFromStringPath('institutions/Not_INItialized'));
    var _docRef = ref.read(dbApiProvider).dbCourse.getDocRefForNewCourse(ref);
    newState.docRef = _docRef;

    ref
        .read(dbApiProvider)
        .dbCourse
        .addNewCourse(course: newState, ref: ref)
        .then(
      (value) {
        ScaffoldMessenger.maybeOf(context)?.showSnackBar(
          SnackBar(
            content: Text(
                'New Course with Course ID  ${newState.title} ]] has been Successsfully Saved'),
          ),
        );
      },
    );

    
  }

  void onSavePrssed() {
    newState = Course.initial();

    if (!_formKey.currentState!.validate()) {
      return;
    } else {
      _formKey.currentState?.save();
      newState = newState?.copyWith(
          preReqs: ref.read(preReqsEditingProvider).selectedPreReqs?.toList());
      newState = newState?.copyWith(sessions: [Session.initial()]);
      ref
          .read(dbApiProvider)
          .dbCourse
          .addNewCourse(course: newState!, ref: ref);
    }
  }

  void onResetPressed() {}

  void onCancelPressed() {}

  Widget _buildButtonBar() {
    return SizedBox(
      height: 80,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            flex: 8,
            child: TextButton(
                onPressed: onCancelPressed,
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
                onPressed: onResetPressed,
                child: const Text(
                  'RESET',
                  style: TextStyle(fontSize: 24),
                )),
          ),
          const Spacer(flex: 1),
          Expanded(
            flex: 8,
            child: ElevatedButton.icon(
                onPressed: onSavePrssed,
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

  Widget _courseTitleField() {
    return TextFormField(
      controller: courseTitleController,
      decoration: const InputDecoration(
        icon: Icon(Icons.title),
        hintText: 'Exact Title of The Course',
        labelText: 'Course Tiltle * ',
      ),
      onSaved: (String? value) {
        // newSate = newSate?.copyWith(courseId: value);
        newState?.title = value!;
        // This optional block of code can be used to run
        // code when the user saves the form.
        // newState
      },
      validator: (String? value) {
        return (value != null && value.contains('@'))
            ? 'Do not use the @ char.'
            : null;
      },
    );
  }

  Widget _coureseCreditsField() {
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
        newState?.credits = int.parse(value!);
        // newSate = newSate?.copyWith(credits: int.parse(value!));
      },
      validator: (String? value) {
        return (value != null && value.contains('@'))
            ? 'Do not use the @ char.'
            : null;
      },
    );
  }

  Widget _courseIdField() {
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
        newState?.id = value!;
        // newSate = newSate!.copyWith(courseId: value);
      },
      validator: (String? value) {
        return (value != null && value.contains('@'))
            ? 'Do not use the @ char.'
            : null;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var preLoadedState = ref.read(currentCourseProvider);

    // _key = _formKey;

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
                    _courseIdField(),
                    // CourseIdField(
                    //   courseIdController: courseIdController,
                    //   formKey: _formKey,
                    // ),
                    const SpacerVertical(30),

                    ///[courseTitle FormField]
                    _courseTitleField(),
                    // CourseTitleField(
                    //   courseTitleController: courseTitleController,
                    //   formKey: _formKey,
                    // ),
                    const SpacerVertical(30),

                    ///[courseCredits] Form Field
                    _coureseCreditsField(),
                    // CourseCreditsFormField(
                    //   courseCreditController: courseCreditController,
                    //   formKey: _formKey,
                    // ),
                    const SpacerVertical(30),

                    const SpacerVertical(30),
                    const PreReqsWidget(),

                    ///widget below is not required in New course form
                    // FacultySelectionCard(),

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
