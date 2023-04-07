import 'dart:convert';

class Todo {
  Todo({
    required this.content,
    this.isComplete = false,
    required this.id,
    this.createdAt,
    this.updatedAt,
    this.permissions = const [],
  });

  String content;
  bool isComplete;
  String id;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<String> permissions;

  factory Todo.fromJson(String str) => Todo.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Todo.fromMap(Map<String, dynamic> json) => Todo(
        content: json["content"],
        isComplete: json["isComplete"] ?? false,
        id: json["\u0024id"],
        createdAt: DateTime.parse(json["\u0024createdAt"]),
        updatedAt: DateTime.parse(json["\u0024updatedAt"]),
        permissions: List<String>.from(json["\u0024permissions"].map((x) => x)),
      );

  Map<String, dynamic> toMap() {
    final map = {
      "content": content,
      "isComplete": isComplete,
    };

    return map;
  }
}
