import 'package:flutter/material.dart';
import 'package:flutter_sutoritera/data/story.dart';
import 'package:flutter_sutoritera/data/story_dao.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

class StoriesScreen extends StatefulWidget {
  StoriesScreen({Key? key}) : super(key: key);

  @override
  _StoriesScreenState createState() => _StoriesScreenState();
}

class _StoriesScreenState extends State<StoriesScreen> {
  final ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    final storyDao = Provider.of<StoryDao>(context, listen: false);
    return Column(
      children: [_getMessageList(storyDao)],
    );
  }

  Widget _getMessageList(StoryDao storyDao) {
    return Expanded(
      // Create a StreamBuilder widget.
      child: StreamBuilder<QuerySnapshot>(
        // Use your storyDao to get a stream of messages.
        stream: storyDao.getStoriesStream(),
        // Use a builder that contains your snapshot.
        builder: (context, snapshot) {
          // If you don’t have any data yet, use a LinearProgressIndicator.
          if (!snapshot.hasData) {
            return const Center(child: LinearProgressIndicator());
          }

          // Call _buildList() with your snapshot data.
          return _buildList(context, snapshot.data!.docs);
        },
      ),
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot snapshot) {
    // Create a new message from the given snapshot.
    final story = Story.fromSnapshot(snapshot);
    // Pass the message info to the MessageWidget.
    return Column(
      children: [
        Text(story.creatorName),
        Text(story.title),
      ],
    );
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot>? snapshot) {
    return ListView.builder(
        itemCount: snapshot!.length,
        itemBuilder: (BuildContext listContext, index) {
          return _buildListItem(listContext, snapshot[index]);
        },
        // Return a ListView with our _scrollController and some physics.
        controller: _scrollController,
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.only(top: 20.0));
  }
}
