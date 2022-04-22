import 'dart:convert';

class AddData {
  String title;
  String description;
  String id;
  DateTime date;
  AddData({
    this.title,
    this.description,
    this.id,
    this.date,
  });

  AddData copyWith({
    String title,
    String description,
    String id,
    DateTime date,
  }) {
    return AddData(
      title: title ?? this.title,
      description: description ?? this.description,
      id: id ?? this.id,
      date: date ?? this.date,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'date': date.millisecondsSinceEpoch,
    };
  }

  factory AddData.fromMap(Map<String, dynamic> map) {
    return AddData(
      title: map['title'],
      description: map['description'],
      id: map['\$id'],
      date: DateTime.fromMillisecondsSinceEpoch(map['date']),
    );
  }

  String toJson() => json.encode(toMap());

  factory AddData.fromJson(String source) =>
      AddData.fromMap(json.decode(source));

  @override
  String toString() {
    return 'AddData(title: $title, description: $description, id: $id, date: $date)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AddData &&
        other.title == title &&
        other.description == description &&
        other.id == id &&
        other.date == date;
  }

  @override
  int get hashCode {
    return title.hashCode ^ description.hashCode ^ id.hashCode ^ date.hashCode;
  }
}
