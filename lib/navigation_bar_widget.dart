import 'dart:io';
import 'package:exstudio/favorites/favorites_widget.dart';
import 'package:exstudio/flutter_flow/flutter_flow_theme.dart';
import 'package:exstudio/flutter_flow/nav/nav.dart';
import 'package:exstudio/home/home_widget.dart';
import 'package:exstudio/profile/profile_widget.dart';
import 'package:flutter/material.dart';

class NavBarWidget extends StatefulWidget {
  const NavBarWidget({
    Key? key,
    required this.initialPage,
    this.params,
  }) : super(key: key);

  final String initialPage;
  final FFParameters? params;

  @override
  State<NavBarWidget> createState() => _NavBarPageState();
}

class _NavBarPageState extends State<NavBarWidget> {
  late Map<String, Widget> _tabs;
  late String _currentPageName;

  @override
  void initState() {
    super.initState();

    _tabs = {
      'Home': HomeWidget(),
      'Profile': ProfileWidget(),
      'Favorites': FavoritesWidget(),
    };

    _currentPageName = widget.initialPage;
  }

  @override
  Widget build(BuildContext context) {
    final currentIndex = _tabs.keys.toList().indexOf(_currentPageName);

    return Scaffold(
      body: _tabs[_currentPageName],
      extendBody: true,
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        child: Theme(
          data: ThemeData(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
          ),
          child: BottomNavigationBar(
            backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
            selectedFontSize: 0,
            unselectedFontSize: 0,
            selectedItemColor:
                FlutterFlowTheme.of(context).selectedBottomItemColor,
            type: BottomNavigationBarType.fixed,
            unselectedItemColor: Colors.white60,
            currentIndex: currentIndex,
            showUnselectedLabels: false,
            showSelectedLabels: false,
            onTap: (index) {
              if (index != 3) {
                setState(() {
                  _currentPageName = _tabs.keys.toList()[index];
                });
              }
            },
            items: const [
              BottomNavigationBarItem(
                icon: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.person_outline,
                      size: 26,
                    ),
                  ],
                ),
                label: "",
              ),
              BottomNavigationBarItem(
                icon: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.search,
                      size: 26,
                    ),
                  ],
                ),
                label: "",
              ),
              BottomNavigationBarItem(
                icon: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.favorite_border_outlined,
                      size: 26,
                    ),
                  ],
                ),
                label: "",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
