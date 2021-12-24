import 'package:flutter/material.dart';
import 'package:flutter_sutoritera/data/story.dart';
import 'package:intl/intl.dart';

class StoryCard extends StatelessWidget {
  final Story story;
  const StoryCard({Key? key, required this.story}) : super(key: key);
  final String timeFormatToShow = 'dd.MM.yyyy';

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(story.title, style: TextStyle()),
            Text(story.description),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(story.creatorName),
                Text(DateFormat(timeFormatToShow)
                    .format(story.createdDate)
                    .toString())
              ],
            )
          ],
        ),
      ),
    );
  }
}
