// ignore_for_file: sort_constructors_first, lines_longer_than_80_chars

class TodoModel {
  TodoModel({
    required this.content,
    required this.isCompleted,
    this.documentId,
  });

  final String content;
  final String? documentId;
  final bool isCompleted;

  TodoModel copyWith({
    String? content,
    bool? isCompleted,
  }) {
    return TodoModel(
      documentId: documentId,
      content: content ?? this.content,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'content': content,
      'isCompleted': isCompleted,
    };
  }

  factory TodoModel.fromMap(Map<String, dynamic> map) {
    return TodoModel(
      documentId: map['\$id'] as String,
      content: map['content'] as String,
      isCompleted: map['isCompleted'] as bool? ?? false,
    );
  }

  @override
  String toString() =>
      'TodoModel(content: $content, isCompleted: $isCompleted, documentId: $documentId)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TodoModel &&
        other.content == content &&
        other.isCompleted == isCompleted &&
        other.documentId == documentId;
  }

  @override
  int get hashCode =>
      content.hashCode ^ isCompleted.hashCode ^ documentId.hashCode;
}
