import 'package:cloud_firestore/cloud_firestore.dart';

class Story {
  final String title;
  final String description;
  final DateTime createdDate;
  final String creatorName;

  DocumentReference? reference;

  Story(
      {required this.title,
      required this.description,
      required this.createdDate,
      required this.creatorName,
      this.reference});

  // JSON converters

  // The first definition will help you transform the JSON you receive from the Cloud Firestore, into a Story
  factory Story.fromJson(Map<dynamic, dynamic> json) => Story(
      title: json['title'] as String,
      description: json['description'] as String,
      createdDate: DateTime.parse(json['createdDate'] as String),
      creatorName: json['creatorName'] as String);

  // The second will do the opposite — transform the Story into JSON, for saving
  Map<String, dynamic> toJson() => <String, dynamic>{
        'createdDate': createdDate.toString(),
        'title': title,
        'description': description,
        'creatorName': creatorName,
      };

  // This takes a Firestore snapshot and converts it to a story.
  factory Story.fromSnapshot(DocumentSnapshot snapshot) {
    final story = Story.fromJson(snapshot.data() as Map<String, dynamic>);
    story.reference = snapshot.reference;
    return story;
  }
}
