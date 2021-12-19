import 'package:cloud_firestore/cloud_firestore.dart';
import 'story.dart';

class StoryDao {
  // Gets an instance of FirebaseFirestore and then gets the root of the messages collection by calling collection().
  final CollectionReference collection =
      FirebaseFirestore.instance.collection('stories');

  void saveStory(Story story) {
    collection.add(story.toJson());
  }

  // This returns a stream of data at the root level
  Stream<QuerySnapshot> getStoriesStream() {
    return collection.snapshots();
  }
}
