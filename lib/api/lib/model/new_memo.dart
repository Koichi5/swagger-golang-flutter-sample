//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class NewMemo {
  /// Returns a new [NewMemo] instance.
  NewMemo({
    required this.title,
    required this.content,
  });

  String title;

  String content;

  @override
  bool operator ==(Object other) => identical(this, other) || other is NewMemo &&
    other.title == title &&
    other.content == content;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (title.hashCode) +
    (content.hashCode);

  @override
  String toString() => 'NewMemo[title=$title, content=$content]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'title'] = this.title;
      json[r'content'] = this.content;
    return json;
  }

  /// Returns a new [NewMemo] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static NewMemo? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "NewMemo[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "NewMemo[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return NewMemo(
        title: mapValueOfType<String>(json, r'title')!,
        content: mapValueOfType<String>(json, r'content')!,
      );
    }
    return null;
  }

  static List<NewMemo> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <NewMemo>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = NewMemo.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, NewMemo> mapFromJson(dynamic json) {
    final map = <String, NewMemo>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = NewMemo.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of NewMemo-objects as value to a dart map
  static Map<String, List<NewMemo>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<NewMemo>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = NewMemo.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'title',
    'content',
  };
}

