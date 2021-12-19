import 'package:flutter/material.dart';
import 'package:flutter_sutoritera/data/story.dart';
import 'package:flutter_sutoritera/data/story_dao.dart';
import 'package:flutter_sutoritera/models/app_state_manager.dart';
import 'package:provider/provider.dart';
import '../data/user_dao.dart';

class CreateStoryScreen extends StatefulWidget {
  CreateStoryScreen({Key? key}) : super(key: key);

  @override
  _CreateStoryScreenState createState() => _CreateStoryScreenState();
}

class _CreateStoryScreenState extends State<CreateStoryScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  String? email;

  @override
  void initState() {
    super.initState();
  }

  // Username controller
  @override
  Widget build(BuildContext context) {
    final userDao = Provider.of<UserDao>(context, listen: false);
    final storyDao = Provider.of<StoryDao>(context, listen: false);
    email = userDao.email();
    return Center(
        child: Form(
      key: _formKey,
      child: Column(
        children: [
          Row(
            children: [
              const SizedBox(height: 80),
              Expanded(
                // Create the field for the email address.
                child: TextFormField(
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    hintText: 'Title',
                  ),
                  autofocus: false,
                  // Use an email address keyboard type.
                  keyboardType: TextInputType.text,
                  // Set the editing controller.
                  controller: _titleController,
                  // Define a validator to check for empty strings. You can use regular expressions or any other type of validation if you like.
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Title Required';
                    }
                    return null;
                  },
                ),
              ),
            ],
          ),
          Row(
            children: [
              const SizedBox(height: 80),
              Expanded(
                // Create the field for the email address.
                child: TextFormField(
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    hintText: 'Description',
                  ),
                  autofocus: false,
                  // Use an email address keyboard type.
                  keyboardType: TextInputType.text,
                  // Set the editing controller.
                  controller: _descriptionController,
                  // Define a validator to check for empty strings. You can use regular expressions or any other type of validation if you like.
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Description Required';
                    }
                    return null;
                  },
                ),
              ),
            ],
          ),
          ElevatedButton(
            onPressed: () => _createNewStory(storyDao),
            child: const Text('Create Story'),
          ),
        ],
      ),
    ));
  }

  void _createNewStory(StoryDao storyDao) {
    final story = Story(
        title: _titleController.text,
        description: _descriptionController.text,
        createdDate: DateTime.now(),
        // TODO: add email
        creatorName: email!);
    storyDao.saveStory(story);
    _titleController.clear();
    _descriptionController.clear();
    setState(() {});
    Provider.of<AppStateManager>(context, listen: false).goToTab(0);
  }
}
