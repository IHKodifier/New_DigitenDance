// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:cloud_firestore_platform_interface/src/timestamp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:new_digitendance/app/states/session_state.dart';

import '../../app/models/session.dart';
import '../shared/spacers.dart';

class NewSessionFormBody extends ConsumerStatefulWidget {
  const NewSessionFormBody({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _NewSessionFormBodyState();
}

class _NewSessionFormBodyState extends ConsumerState<NewSessionFormBody> {
  late final TextEditingController idController;
  final Logger logger = Logger(printer: PrettyPrinter());
  late   SessionNotifier sessionNotifier;
  late   Session state ;
  late final TextEditingController titleController;
  String endDateString='';

  final _formKey=GlobalKey<FormState>();

@override
void initState() {
  super.initState();
  idController= TextEditingController();
  titleController= TextEditingController();
  
}

  @override
  // TODO: implement ref
  WidgetRef get ref => super.ref;

  Padding formTitle(BuildContext context) => Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text('Create New Session',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: Theme.of(context).primaryColor,
              )),
          );

  textInputPanel(BuildContext context) =>Column(children: [
    Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 8.0,
      ),
      child: TextFormField(
        decoration: const InputDecoration(
          hintText: 'Please enter the id for session',
          label: Text('session Id'),
        ),
        controller: idController,
        onSaved: (newValue) {
          logger.i('Saving Session Id');
          // newSession!.id = newValue;
        },
      ),
    ),
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: TextFormField(
        decoration: const InputDecoration(
          hintText: 'Please enter a Session Title',
          label: Text('session Title'),
        ),
        controller: titleController,
        onSaved: (newValue) {
          logger.i('Saving Session Title');
          // if (newSession != null) {
          //   newSession!.title = newValue;
          // }
        },
      ),
    ),
  ],);

  sessionDatesPanel(BuildContext context) =>Column(
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
        // buildWeekdayChoices(),
        const SpacerVertical(8),
      ],
    );

      buildSessionStart(BuildContext context) =>Container(
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
              child: state.sessionStartDate != null
                  ? Text(
                      state.sessionStartDate != null
                          ? DateFormat.yMMMEd('en-US').format(state.sessionStartDate!)
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

  buildSessionEnd(BuildContext context) { return Card(
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
            child: state.sessionEndDate != null
                ? Text(DateFormat.yMMMEd('en-US').format(state.sessionEndDate!),
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(color: Theme.of(context).primaryColor))
                : const Icon(Icons.calendar_today_rounded),
            onTap: () => _pickSessionEndDate(context),
          ),
        ],
      ),
    );}

  sessionDaysPanel(BuildContext context) {
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
              selected: state.tutoringDays![0],
              onSelected: (value) {
                state.tutoringDays![0] = value;
                setState(() {});
              },
            ),
            ChoiceChip(
              padding: const EdgeInsets.all(8),
              selectedColor:
                  Theme.of(context).colorScheme.secondary.withOpacity(.7),
              pressElevation: 15,
              label: const Text('T'),
              selected: state.tutoringDays![1],
              onSelected: (value) {
                state.tutoringDays![1] = value;
                setState(() {});
              },
            ),
            ChoiceChip(
              padding: const EdgeInsets.all(8),
              selectedColor:
                  Theme.of(context).colorScheme.secondary.withOpacity(.7),
              pressElevation: 15,
              label: const Text('W'),
              selected: state.tutoringDays![2],
              onSelected: (value) {
                state.tutoringDays![2] = value;
                setState(() {});
              },
            ),
            ChoiceChip(
              padding: const EdgeInsets.all(8),
              selectedColor:
                  Theme.of(context).colorScheme.secondary.withOpacity(.7),
              pressElevation: 15,
              label: const Text('T'),
              selected: state.tutoringDays![3],
              onSelected: (value) {
                state.tutoringDays![3] = value;
                logger.i(state.tutoringDays.toString());
                setState(() {});
              },
            ),
            ChoiceChip(
              padding: const EdgeInsets.all(8),
              selectedColor:
                  Theme.of(context).colorScheme.secondary.withOpacity(.7),
              pressElevation: 15,
              label: const Text('F'),
              selected: state.tutoringDays![4],
              onSelected: (value) {
                state.tutoringDays![4] = value;
                setState(() {});
              },
            ),
          ],
        ),
      ],
    );
  }

  _pickSessionStartDat(BuildContext context)async {
    final newDate = await showDatePicker(
      context: context,
      initialDate: state.registrationStartDate==null? DateTime.now():state.registrationStartDate as DateTime,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (newDate != null) {
      setState(() {
        state.sessionStartDate = newDate;
      });
    } else {
      return null;
    }
  }

      _pickSessionEndDate(BuildContext context) async {
    final newDate = await showDatePicker(
      context: context,
      initialDate: state.sessionStartDate ?? DateTime.now(),
      firstDate: state.sessionStartDate ?? (state.registrationEndDate! as DateTime).add(const Duration(days: 1)),
      lastDate: DateTime(2100),
    );
    if (newDate != null) {
      setState(() {
        state.sessionEndDate = newDate;
      });
    } else {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    sessionNotifier= ref.read(newSessionNotifierProvider.notifier);
    state=ref.watch(newSessionNotifierProvider);

    return Container(
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              formTitle(context), 
              textInputPanel(context),
              sessionDatesPanel(context),
              sessionDaysPanel(context),
              registrationDatesPanel(context),


            ],
          ),
        ),
      ),
    );
    
  }
  
  registrationDatesPanel(BuildContext context) {
    return Column(
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
            Expanded(child: buildRegStart()),
            Expanded(child: buildRegEnd()),
            // const SpacerVertical(8),
          ],
        ),
        const SpacerVertical(16),
        // buildFacultySelectionCard(context),
      ],
    );
  }
  
  buildRegStart() =>Container(
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
            child: state.registrationStartDate != null
                ? Text(
                    state.registrationStartDate != null
                        ? DateFormat.yMMMEd('en-US').format(state.registrationStartDate! as DateTime)
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
    
      _pickRegistrationStartDate(BuildContext context) async {
    final newDate = await showDatePicker(
      context: context,
      initialDate:
          state.sessionStartDate?.subtract(Duration(days: 18)) ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: state.sessionStartDate!.subtract(const Duration(days: 18)),
    );
    setState(() {
      DateTime dateTime= newDate!;

      state.registrationStartDate = newDate;
    });
  }
  
  buildRegEnd() =>Container(
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
            child: state.registrationEndDate != null
                ? Text(endDateString,
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
    
      _pickRegistrationEndDate(BuildContext context) async {
    final newDate = await showDatePicker(
      context: context,
      initialDate: state.registrationEndDate!=null?state.registrationEndDate as DateTime: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    // TimeOfDay
    final now = TimeOfDay.now();
    final selectectedTime = await showTimePicker(
      context: context,
      initialTime:  now,
    );
    setState(() {
      state.registrationEndDate = newDate as Timestamp?;
      if (state.registrationEndDate == null) {
        endDateString = '';
      } else {
        endDateString = DateFormat.yMMMEd('en-US').format(state.registrationEndDate as DateTime);
      }
      state.registrationEndDate = selectectedTime as Timestamp;

      String temp = (state.registrationEndDate!as TimeOfDay) .format(context);
      endDateString = endDateString! + ' --  ' + temp;
    });
  }
}