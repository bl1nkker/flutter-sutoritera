import 'package:flutter/material.dart';
import 'package:flutter_sutoritera/models/app_state_manager.dart';
import 'package:flutter_sutoritera/navigation/sutoritera_pages.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  static MaterialPage page() {
    return MaterialPage(
      name: SutoriteraPages.splashPath,
      key: ValueKey(SutoriteraPages.splashPath),
      child: const SplashScreen(),
    );
  }

  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<AppStateManager>(context, listen: false).initializeApp();
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [const Icon(Icons.store_mall_directory)],
        ),
      ),
    );
  }
}
