import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Attendance extends Equatable {
  final DateTime date;
  final AttendanceStatus status;
  final Timestamp? datePosted;

  Attendance(this.date, this.status,
  this.datePosted);
  
  @override
  // TODO: implement props
  List<Object?> get props => [date,status];
  
}


enum AttendanceStatus
{  present,
   absent,
   sanctionedLeave,
   notDueYet
 

}