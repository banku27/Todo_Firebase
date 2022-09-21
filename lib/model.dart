class Note {
  String title;
  String content;
  String id;
  Note({
    required this.title,
    required this.content,
    required this.id,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'content': content,
    };
  }

  factory Note.fromMap(Map<String, dynamic> map, String id) {
    return Note(
      title: map['title'] ?? '',
      content: map['content'] ?? '',
      id: id,
    );
  }
}
