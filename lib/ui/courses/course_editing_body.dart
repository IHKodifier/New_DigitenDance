import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:new_digitendance/app/models/session.dart';
import 'package:new_digitendance/ui/authentication/login/login_form.dart';
import 'package:new_digitendance/ui/courses/pre_reqs_wiget.dart';
import 'package:new_digitendance/ui/courses/session_card.dart';
import 'package:new_digitendance/ui/courses/session_state.dart';
import 'package:new_digitendance/ui/home/admin/state/admin_state.dart';
import 'package:new_digitendance/ui/shared/shimmers.dart';

import '../../app/models/course.dart';
import '../shared/spacers.dart';

class CourseEditingBodyWidget extends ConsumerStatefulWidget {
  const CourseEditingBodyWidget({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CourseEditingBodyWidgetState();
}

class _CourseEditingBodyWidgetState
    extends ConsumerState<CourseEditingBodyWidget> {
  TextEditingController courseCreditController = TextEditingController();
  TextEditingController courseIdController = TextEditingController();
  TextEditingController courseTitleController = TextEditingController();
  TextEditingController facultyController = TextEditingController();
  late Course newState;
  late Course preLoadedState;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    preLoadedState = ref.read(currentCourseProvider);
    courseTitleController.text = preLoadedState.title;
    courseIdController.text = preLoadedState.id;
    courseCreditController.text = preLoadedState.credits.toString();
  }

  void onResetPressed() {}

  void onCancelPressed() {}

  void onSavePrssed() {}

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
        newState.id = value!;
        // newSate = newSate!.copyWith(courseId: value);
      },
      validator: (String? value) {
        return (value != null && value.contains('@'))
            ? 'Do not use the @ char.'
            : null;
      },
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
        newState.title = value!;
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

  Widget _buildButtonBar() {
    return SizedBox(
      height: 80,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            flex: 8,
            child: OnHoverButton(
              child: TextButton(
                  onPressed: onCancelPressed,
                  // icon: const Icon(Icons.cancel),
                  child: const Text(
                    'Cancel',
                    style: TextStyle(fontSize: 24),
                  )),
            ),
          ),
          const Spacer(flex: 1),
          Expanded(
            flex: 8,
            child: OnHoverButton(
              child: TextButton(
                  onPressed: onResetPressed,
                  child: const Text(
                    'RESET',
                    style: TextStyle(fontSize: 24),
                  )),
            ),
          ),
          const Spacer(flex: 1),
          Expanded(
            flex: 8,
            child: OnHoverButton(
              child: ElevatedButton.icon(
                  onPressed: onSavePrssed,
                  icon: const Icon(Icons.save),
                  label: const Text(
                    'Save',
                    style: TextStyle(fontSize: 24),
                  )),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final preLoadedState = ref.read(currentCourseProvider);
    return SingleChildScrollView(
      child: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * .75,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.always,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _courseIdField(),
                      const SpacerVertical(15),

                      ///[courseTitle FormField]
                      _courseTitleField(),
                      const SpacerVertical(15),

                      ///[courseCredits] Form Field
                      _coureseCreditsField(),
                      const SpacerVertical(15),
                      const SpacerVertical(15),
                      const PreReqsWidget(
                        mode: PreReqsWidgetMode.Editable,
                      ),
                      const SizedBox(
                        height: 20,
                        width: 50,
                      ),
                      SessionEditingCard(),
                      _buildButtonBar(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SessionEditingCard extends ConsumerWidget {
  late BuildContext localContext;
   SessionEditingCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
     localContext = context;
    return ref
        .watch(sessionStreamProvider)
        .when(data: whenData, error: whenError, loading: whenLoading);
  }

  Widget whenData(
    List<Session> data,
  ) {
    return Container(
      width: 500,
      height: 600,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(60),
          color: Colors.white,
          border: Border.all(
            color: Theme.of(localContext).primaryColor,
            width: 3,
          )),
      child: Wrap(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: FloatingActionButton(
              child: Icon(
                Icons.add,
                size: 45,
              ),
              onPressed: () {},
            ),
          ),
          ...data
              .map((e) => SessionTile(
                    state: e,
                  ))
              .toList(),
        ],
      ),
    );
  }

  Widget whenLoading() {
    return ShimmerCard();
  }

  Widget whenError(Object error, StackTrace? stackTrace) {
    return Text(error.toString() + stackTrace.toString());
  }
}
