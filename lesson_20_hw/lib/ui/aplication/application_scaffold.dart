import 'package:cocktail_app/ui/aplication/adaptive_app_bar.dart';
import 'package:cocktail_app/ui/aplication/adaptive_navigation_bar.dart';
import 'package:cocktail_app/ui/aplication/application_drawer.dart';
import 'package:flutter/material.dart';

class ApplicationScaffold extends StatelessWidget {
  final Widget child;

  ApplicationScaffold({@required this.child});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AdaptiveAppBar(),
      drawer: ApplicationDrawer(),
      body: child,
      bottomNavigationBar: ApplicationNavigationBar(),
    );
  }
}
