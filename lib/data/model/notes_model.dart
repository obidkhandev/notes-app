class NotesModel {
  final int? id;
  final String name;
  final String createdDate;
  final int noteColor;
  final String descriptions;

  NotesModel({
     this.id, // Updated constructor
    required this.name,
    required this.createdDate,
    required this.noteColor,
    required this.descriptions,
  });

  // Convert NotesModel instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id, // Include id in JSON
      'name': name,
      "descriptions":descriptions,
      'createdDate': createdDate,
      'noteColor': noteColor,
    };
  }

  // Create a NotesModel instance from JSON
  factory NotesModel.fromJson(Map<String, dynamic> json) {
    return NotesModel(
      id: json['id'],
      descriptions:json["descriptions"],
      name: json['name'],
      createdDate: json['createdDate'],
      noteColor: json['noteColor'],
    );
  }
  NotesModel copyWith({
    int? id,
    String? name,
    String? createdDate,
    int? noteColor,
    String? descriptions,
  }) {
    return NotesModel(
      id: id ?? this.id,
      name: name ?? this.name,
      createdDate: createdDate ?? this.createdDate,
      noteColor: noteColor ?? this.noteColor,
      descriptions: descriptions ?? this.descriptions,
    );
  }
}
