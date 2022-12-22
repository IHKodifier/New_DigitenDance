import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';

StreamTransformer<QuerySnapshot<Map<String, dynamic>>, List<T>>
    streamTransformer<T>(
  T Function(Map<String, dynamic> jsonMap) fromJson,
) =>
        StreamTransformer<QuerySnapshot<Map<String, dynamic>>,
            List<T>>.fromHandlers(
          handleData: (
            QuerySnapshot<Map<String, dynamic>> data,
            EventSink<List<T>> sink,
          ) {
            sink.add(data.docs.map((e) => fromJson(e .data())).toList());

            // final snaps = data.docs.map((doc) => doc.data()).toList();
            // final sessions = snaps.map((json) => fromJson(json)).toList();
            // data.docs[0].

            // sink.add(sessions);
          },
        );
