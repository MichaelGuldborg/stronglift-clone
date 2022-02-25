import 'package:flutter/material.dart';
import 'package:lifter/pages/history/HistoryPage.dart';
import 'package:lifter/pages/home/home_bottom_navigation.dart';
import 'package:lifter/pages/home/home_landing_page.dart';
import 'package:lifter/services/analytics.dart';
import 'package:lifter/services/firebase/firebase_auth_functions.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    FirebaseAuthFunctions.updateDeviceToken();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 56),
            child: IndexedStack(
              index: currentIndex,
              children: <Widget>[
                HomeLandingPage(),
                HistoryPage(),
                Container(),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: HomeBottomNavigation(
              currentIndex: currentIndex,
              onChange: (index) {
                Analytics.trackEvent('click_home_$index');
                setState(() => currentIndex = index);
              },
            ),
          ),
        ],
      ),
    );
  }
}
