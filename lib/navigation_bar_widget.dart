import 'package:exstudio/account/account_widget.dart';
import 'package:exstudio/flutter_flow/flutter_flow_theme.dart';
import 'package:exstudio/flutter_flow/nav/nav.dart';
import 'package:exstudio/home/home_widget.dart';
import 'package:exstudio/shedule/shedule_widget.dart';
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
      'Shedule': SheduleWidget(),
      'Home': HomeWidget(),
      'Account': AccountWidget(),
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
            unselectedItemColor: FlutterFlowTheme.of(context).primaryColor,
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
            items: [
              BottomNavigationBarItem(
                icon: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.schedule,
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
                      Icons.add,
                      size: 32,
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
                      Icons.person_outline,
                      size: 28,
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
