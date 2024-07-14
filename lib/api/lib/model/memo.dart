//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class Memo {
  String? id;
  String? title;
  String? content;
  List<String>? tags;
  DateTime? createdAt;
  DateTime? updatedAt;

  Memo({
    this.id,
    this.title,
    this.content,
    this.tags,
    this.createdAt,
    this.updatedAt,
  });

  factory Memo.fromJson(Map<String, dynamic> json) {
    return Memo(
      id: json['ID']?.toString(),
      title: json['title'],
      content: json['content'],
      tags: (json['tags'] as List<dynamic>?)?.map((e) => e.toString()).toList() ?? [],
      createdAt: json['CreatedAt'] != null ? DateTime.parse(json['CreatedAt']) : null,
      updatedAt: json['UpdatedAt'] != null ? DateTime.parse(json['UpdatedAt']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ID': id,
      'title': title,
      'content': content,
      'tags': tags,
      'CreatedAt': createdAt?.toIso8601String(),
      'UpdatedAt': updatedAt?.toIso8601String(),
    };
  }
}
