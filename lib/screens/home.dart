import 'package:flutter/material.dart';
import 'package:flutter_sutoritera/data/user_dao.dart';
import 'package:flutter_sutoritera/models/app_state_manager.dart';
import 'package:flutter_sutoritera/navigation/sutoritera_pages.dart';
import 'package:flutter_sutoritera/screens/create_story_screen.dart';
import 'package:flutter_sutoritera/screens/profile_screen.dart';
import 'package:flutter_sutoritera/screens/stories_screen.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  static MaterialPage page(int currentTab) {
    return MaterialPage(
      name: SutoriteraPages.home,
      key: ValueKey(SutoriteraPages.home),
      child: Home(
        currentTab: currentTab,
      ),
    );
  }

  const Home({
    Key? key,
    required this.currentTab,
  }) : super(key: key);

  final int currentTab;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  static List<Widget> pages = <Widget>[StoriesScreen(), CreateStoryScreen()];

  @override
  Widget build(BuildContext context) {
    return Consumer<AppStateManager>(
      builder: (context, appStateManager, child) {
        return Scaffold(
          appBar: AppBar(
            actions: [
              InkWell(
                onTap: () {
                  Provider.of<AppStateManager>(context, listen: false)
                      .changeTheme();
                },
                child: Text('Change theme'),
              )
            ],
            title: Text(
              'Sutoritera App',
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          body: IndexedStack(index: widget.currentTab, children: pages),
          bottomNavigationBar: BottomNavigationBar(
            selectedItemColor:
                Theme.of(context).textSelectionTheme.selectionColor,
            currentIndex: widget.currentTab,
            onTap: (index) {
              Provider.of<AppStateManager>(context, listen: false)
                  .goToTab(index);
            },
            items: <BottomNavigationBarItem>[
              const BottomNavigationBarItem(
                icon: Icon(Icons.explore),
                label: 'Explore',
              ),
              const BottomNavigationBarItem(
                icon: Icon(Icons.add_a_photo_outlined),
                label: 'Create',
              )
            ],
          ),
        );
      },
    );
  }
}
