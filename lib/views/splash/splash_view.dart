import 'package:flutter/material.dart';
import 'package:pokemon/routes/routes.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();

    // Simulates loading time in splash before going to main feed
    Future<void>.delayed(const Duration(seconds: 2), () {
      Navigator.of(context).popAndPushNamed(Routes.feed);
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'Pokemon',
          style: TextStyle(fontSize: 32),
        ),
      ),
    );
  }
}
