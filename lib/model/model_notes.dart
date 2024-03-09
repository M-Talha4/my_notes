class NotesModel {
  final int? id;
  final String title;
  final String? extra;
  final String date;
  final String description;

  NotesModel(
      {required this.id,
      required this.title,
      this.extra,
      required this.date,
      required this.description});

  NotesModel.fromMap(Map<String, dynamic> res)
      : id = res['id'],
        title = res['title'],
        extra = res['extra'],
        date = res['date'],
        description = res['description'];

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'title': title,
      'extra': extra,
      'date': date,
      'description': description,
    };
  }
}
