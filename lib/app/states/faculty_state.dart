import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:new_digitendance/app/models/faculty.dart';
import 'package:new_digitendance/app/states/admin_state.dart';
import 'package:new_digitendance/app/states/institution_state.dart';

import '../utilities/transformer.dart';

final facultyListProvider = StreamProvider<List<Faculty>>((ref) {
final stream =
ref.read(institutionNotifierProvider).asData!.value
.docRef!
.collection('faculty')
.snapshots().transform(streamTransformer(Faculty.fromMap));
return stream;





   
});