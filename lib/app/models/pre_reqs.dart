import 'dart:convert';

import 'package:equatable/equatable.dart';

class PreReqs extends Equatable {
  const PreReqs({
    required this.id,
    required this.title,
    required this.credits,
  });

  factory PreReqs.fromJson(String source) =>
      PreReqs.fromMap(json.decode(source));

  factory PreReqs.fromMap(Map<String, dynamic> map) {
    return PreReqs(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      credits: map['credits']?.toInt() ?? 0,
    );
  }

  final int credits;
  final String id;
  final String title;

  @override
  List<Object> get props => [id, title, credits];

  @override
  String toString() => 'PreReqs(id: $id, title: $title, credits: ${credits.toString()})';

  PreReqs copyWith({
    String? id,
    String? title,
    int? credits,
  }) {
    return PreReqs(
      id: id ?? this.id,
      title: title ?? this.title,
      credits: credits ?? this.credits,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'title': title});
    result.addAll({'credits': credits});

    return result;
  }

  String toJson() => json.encode(toMap());
}
