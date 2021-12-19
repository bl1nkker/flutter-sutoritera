import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_sutoritera/data/user_dao.dart';
import 'package:flutter_sutoritera/models/app_state_manager.dart';
import 'package:flutter_sutoritera/navigation/app_router.dart';
import 'package:provider/provider.dart';
import '../data/story_dao.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const Sutoritera());
}

class Sutoritera extends StatefulWidget {
  const Sutoritera({Key? key}) : super(key: key);

  @override
  State<Sutoritera> createState() => _SutoriteraState();
}

class _SutoriteraState extends State<Sutoritera> {
  final _profileManager = UserDao();

  final _appStateManager = AppStateManager();

  late AppRouter _appRouter;

  @override
  void initState() {
    _appRouter = AppRouter(
      appStateManager: _appStateManager,
      profileManager: _profileManager,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Provider
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => _appStateManager,
        ),
        ChangeNotifierProvider<UserDao>(
          lazy: false,
          create: (_) => UserDao(),
        ),
        Provider<StoryDao>(
          lazy: false,
          create: (_) => StoryDao(),
        ),
      ],
      child: Consumer<UserDao>(
        builder: (context, profileManager, child) {
          // ThemeData theme;
          // if (profileManager.darkMode) {
          //   theme = FooderlichTheme.dark();
          // } else {
          //   theme = FooderlichTheme.light();
          // }

          return MaterialApp(
            // theme: theme,
            title: 'Sutoritera',
            home: Router(
              routerDelegate: _appRouter,
              // Here, you set the router widget’s BackButtonDispatcher, which
              //listens to the platform pop route notifications. When the user
              //taps the Android system Back button, it triggers the router
              //delegate’s onPopPage callback.
              backButtonDispatcher: RootBackButtonDispatcher(),
            ),
          );
        },
      ),
    );
  }
}
