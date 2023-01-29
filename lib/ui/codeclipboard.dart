import 'package:cloud_firestore_platform_interface/src/timestamp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:new_digitendance/app/utilities/date_time_extention.dart';
import 'package:new_digitendance/ui/shared/spacers.dart';

import '../../app/models/faculty.dart';
import '../../app/models/session.dart';
import '../../app/states/course_editing_state.dart';
import '../../app/states/faculty_state.dart';
import '../../app/states/session_state.dart';

class NewSessionForm extends ConsumerStatefulWidget {
  const NewSessionForm({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _NewSessionFormState();
}

class _NewSessionFormState extends ConsumerState<NewSessionForm> {
  String? endDateString = 'Select Date & Time ';
  //  facultyList=[];
  Faculty? facultySelected = Faculty(userId: '');

  late final TextEditingController idController;
  final Logger logger = Logger(printer: PrettyPrinter());
  Session? newSession;
  SessionNotifier? newSessionNotifier;
  DateTime? regEndDate;
  TimeOfDay? regEndTime;
  DateTime? regStartDate;
  DateTime? sessionEndDate;
  DateTime? sessionStartDate;
  late final TextEditingController titleController;
  List<bool> tutoringDays = [false, false, false, false, false];

  late final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    idController = TextEditingController();
    titleController = TextEditingController();
  }

  Widget buildSessionStart(BuildContext context) {
    return Container(
      child: Card(
        elevation: 3,
        margin: const EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              ' starts on ',
              style: Theme.of(context)
                  .textTheme
                  .titleSmall
                  ?.copyWith(fontWeight: FontWeight.w400, fontSize: 16),
            ),
            const SpacerVertical(8),
            InkWell(
              child: sessionStartDate != null
                  ? Text(
                      sessionStartDate != null
                          ? DateFormat.yMMMEd('en-US').format(sessionStartDate!)
                          : 'Select Date',
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge
                          ?.copyWith(color: Theme.of(context).primaryColor),
                    )
                  : const Icon(Icons.calendar_today_outlined),
              onTap: () => _pickSessionStartDat(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSessionEnd(BuildContext context) {
    //  endDate==null?

    return Card(
      elevation: 3,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            ' Ends on ',
            style: Theme.of(context)
                .textTheme
                .titleSmall
                ?.copyWith(fontWeight: FontWeight.w400, fontSize: 16),
          ),
          const SpacerVertical(8),
          InkWell(
            child: sessionEndDate != null
                ? Text(DateFormat.yMMMEd('en-US').format(sessionEndDate!),
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(color: Theme.of(context).primaryColor))
                : const Icon(Icons.calendar_today_rounded),
            onTap: () => _pickSessionEndDate(context),
          ),
        ],
      ),
    );
  }

  buildWeekdayChoices() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text('Tutoring Calendar'),
        ),
        Wrap(
          spacing: 16,
          children: [
            ChoiceChip(
              padding: const EdgeInsets.all(4),
              selectedColor:
                  Theme.of(context).colorScheme.secondary.withOpacity(.7),
              pressElevation: 15,
              label: const Text('M'),
              selected: tutoringDays[0],
              onSelected: (value) {
                tutoringDays[0] = value;
                setState(() {});
              },
            ),
            ChoiceChip(
              padding: const EdgeInsets.all(8),
              selectedColor:
                  Theme.of(context).colorScheme.secondary.withOpacity(.7),
              pressElevation: 15,
              label: const Text('T'),
              selected: tutoringDays[1],
              onSelected: (value) {
                tutoringDays[1] = value;
                setState(() {});
              },
            ),
            ChoiceChip(
              padding: const EdgeInsets.all(8),
              selectedColor:
                  Theme.of(context).colorScheme.secondary.withOpacity(.7),
              pressElevation: 15,
              label: const Text('W'),
              selected: tutoringDays[2],
              onSelected: (value) {
                tutoringDays[2] = value;
                setState(() {});
              },
            ),
            ChoiceChip(
              padding: const EdgeInsets.all(8),
              selectedColor:
                  Theme.of(context).colorScheme.secondary.withOpacity(.7),
              pressElevation: 15,
              label: const Text('T'),
              selected: tutoringDays[3],
              onSelected: (value) {
                tutoringDays[3] = value;
                logger.i(tutoringDays.toString());
                setState(() {});
              },
            ),
            ChoiceChip(
              padding: const EdgeInsets.all(8),
              selectedColor:
                  Theme.of(context).colorScheme.secondary.withOpacity(.7),
              pressElevation: 15,
              label: const Text('F'),
              selected: tutoringDays[4],
              onSelected: (value) {
                tutoringDays[4] = value;
                setState(() {});
              },
            ),
          ],
        ),
      ],
    );
  }

  onCreateSession() {
    newSession = Session();
    final notifier = ref.read(newSessionNotifierProvider.notifier);
    logger.i('we have clicked Save session button ');

    // if (_formKey.currentState!.validate()) {
    //   _formKey.currentState!.save();
    //   // newSession?.parentCourseId = ref.read(currentCourseProvider).courseId!;
    //   newSession!.registrationStartDate = regStartDate as Timestamp?;
    //   newSession!.registrationEndDate = Timestamp.fromDate(
    //     DateTime(regEndDate!.year).join(date: regEndDate!, time: regEndTime!),
    //   );
    //   newSession!.faculty = ref.read(newSessionProvider).faculty;

    //   notifier.setSession(newSession!);
    //   var notif = ref.read(courseEditingProvider.notifier);
    //   notif.state.sessions!.add(newSession!);
    //   logger.i(
    //       'New Session Added \n printing from Provider ${ref.read(newSessionProvider).toString()}');
    //   // ref.read(newSessionProvider)=

    //   Navigator.pop(context);

    //   // )
    // } else {}
  }

  _pickSessionStartDat(BuildContext context) async {
    final newDate = await showDatePicker(
      context: context,
      initialDate: regStartDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (newDate != null) {
      setState(() {
        sessionStartDate = newDate;
      });
    } else {
      return null;
    }
  }

  _pickSessionEndDate(BuildContext context) async {
    final newDate = await showDatePicker(
      context: context,
      initialDate: sessionStartDate ?? DateTime.now(),
      firstDate: sessionStartDate ?? regEndDate!.add(const Duration(days: 1)),
      lastDate: DateTime(2100),
    );
    if (newDate != null) {
      setState(() {
        sessionEndDate = newDate;
      });
    } else {
      return;
    }
  }

  _pickRegistrationEndDate(BuildContext context) async {
    final newDate = await showDatePicker(
      context: context,
      initialDate: regEndDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    // TimeOfDay
    final now = TimeOfDay.now();
    final selectectedTime = await showTimePicker(
      context: context,
      initialTime: regEndTime ?? now,
    );
    setState(() {
      regEndDate = newDate;
      if (regEndDate == null) {
        endDateString = null;
      } else {
        endDateString = DateFormat.yMMMEd('en-US').format(regEndDate!);
      }
      regEndTime = selectectedTime;

      String temp = regEndTime!.format(context);
      endDateString = endDateString! + ' --  ' + temp;
    });
  }

  _pickRegistrationStartDate(BuildContext context) async {
    final newDate = await showDatePicker(
      context: context,
      initialDate:
          sessionStartDate?.subtract(Duration(days: 18)) ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: sessionStartDate!.subtract(const Duration(days: 18)),
    );
    setState(() {
      regStartDate = newDate;
    });
  }

  @override
  Widget build(BuildContext context) {
    var facultyList = ref.watch(facultyListProvider).value;
    var selectedFacultyTile = Card(
      child: facultySelected!.userId != ''
      ?Column(
        children: [
          facultySelected!.userId != ''
              ? Text(facultySelected!.userId)
              : Container(),
          Row(
            children: [
              Text(facultySelected!.prefix),
              facultySelected!.userId == ''
                  ? Container()
                  : Text(facultySelected!.firstName!),
              facultySelected!.userId == ''
                  ? Container()
                  : Text(facultySelected!.lastName!),
            ],
          ),
        ],
      ):Container(),
    );
    var formTitle = Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text('Create new Session',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: Theme.of(context).primaryColor,
              )),
    );
    var sessionIdField = Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 8.0,
      ),
      child: TextFormField(
        decoration: const InputDecoration(
          hintText: 'Please enter a Session Id',
          label: Text('session Id'),
        ),
        controller: idController,
        onSaved: (newValue) {
          logger.i('Saving Session Id');
          newSession!.id = newValue;
        },
      ),
    );
    var sessioTitleField = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: TextFormField(
        decoration: const InputDecoration(
          hintText: 'Please enter a Session Title',
          label: Text('session Title'),
        ),
        controller: titleController,
        onSaved: (newValue) {
          logger.i('Saving Session Title');
          if (newSession != null) {
            newSession!.title = newValue;
          }
        },
      ),
    );
    var textInputCard = Column(
      children: [
        sessionIdField,
        sessioTitleField,
        const SpacerVertical(16),
      ],
    );
    var buildRegEnd = Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            ' Ends on  ',
            style: Theme.of(context)
                .textTheme
                .titleSmall
                ?.copyWith(fontWeight: FontWeight.w400, fontSize: 16),
          ),
          const SpacerVertical(8),
          InkWell(
            child: regStartDate != null
                ? Text(endDateString!,
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(color: Theme.of(context).primaryColor))
                : const Icon(Icons.calendar_today_rounded),
            onTap: () => _pickRegistrationEndDate(context),
          ),
        ],
      ),
    );
    var buildRegStart = Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            ' starts on ',
            style: Theme.of(context)
                .textTheme
                .titleSmall
                ?.copyWith(fontWeight: FontWeight.w400, fontSize: 16),
          ),
          // const SizedBox(width: 20),
          const SpacerVertical(8),
          InkWell(
            child: regStartDate != null
                ? Text(
                    regStartDate != null
                        ? DateFormat.yMMMEd('en-US').format(regStartDate!)
                        : 'Select Date',
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(color: Theme.of(context).primaryColor),
                  )
                : const Icon(Icons.calendar_today_outlined),
            onTap: () => _pickRegistrationStartDate(context),
          ),
        ],
      ),
    );
    var registrationDatesCard = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Registration ',
            style: Theme.of(context)
                .textTheme
                .headlineSmall
                ?.copyWith(color: Theme.of(context).primaryColor),
          ),
        ),
        // const SpacerVertical(4),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(child: buildRegStart),
            Expanded(child: buildRegEnd),
            // const SpacerVertical(8),
          ],
        ),
        const SpacerVertical(16),
        // buildFacultySelectionCard(context),
      ],
    );
    var sessionCalendarCard = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Session Calendar ',
            style: Theme.of(context)
                .textTheme
                .headlineSmall
                ?.copyWith(color: Theme.of(context).primaryColor),
          ),
        ),
        // const SpacerVertical(4),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            buildSessionStart(context),
            Flexible(child: Container()),
            buildSessionEnd(context),
            // const SpacerVertical(4),
          ],
        ),
        const SpacerVertical(8),
        buildWeekdayChoices(),
        const SpacerVertical(8),
      ],
    );
    var buttonBar = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Spacer(
          flex: 2,
        ),
        TextButton(
            onPressed: (() => Navigator.pop(context)),
            // icon: const Icon(Icons.cancel),
            child: const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Cancel',
                style: TextStyle(fontSize: 20),
              ),
            )),
        const Spacer(flex: 1),
        ElevatedButton.icon(
            onPressed: onCreateSession,
            icon: const Icon(
              Icons.save,
            ),
            label: const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'SAVE ',
                style: TextStyle(fontSize: 20),
              ),
            )),
        const Spacer(
          flex: 2,
        ),
      ],
    );
    var facultySelectionCard = Container(
      child: Card(
        child: InkWell(
          child: Tooltip(
              child: facultySelected?.userId == ''
                  ? Text(
                      'click to select faculty',
                    )
                  : selectedFacultyTile,
              message: 'click to select faculty'),
          onTap: () => showDialog(
              context: context,
              builder: ((context) => SimpleDialog(
                    title: Text('Select Faculty'),
                    children: facultyList
                        ?.map((e) => SimpleDialogOption(
                              child: Text(e.userId),
                              onPressed: () {
                                logger.i('you selected ${e.userId}');
                                facultySelected=e;
                                Navigator.of(context).pop();
                              },
                            ))
                        .toList(),

                  )
                  ),
                  ),
        ),
      ),
    );

    Widget form = Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              formTitle,
              textInputCard,
              sessionCalendarCard,
              facultySelectionCard,
              registrationDatesCard,
              SpacerVertical(16),
              buttonBar,
            ],
          ),
        ),
      ),
    );

    // final facultyList = ref.read(facultyListProvider);
    newSessionNotifier = ref.read(newSessionNotifierProvider.notifier);
    newSession = ref.watch(newSessionNotifierProvider);
    // facultySelected = newSession?.faculty;
    final size = MediaQuery.of(context).size;
    return Center(child: form);
  }
}
