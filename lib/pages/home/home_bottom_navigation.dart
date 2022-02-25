import 'package:flutter/material.dart';
import 'package:lifter/constants/theme_colors.dart';

class HomeBottomNavigation extends StatelessWidget {
  final int currentIndex;
  final Function(int index) onChange;

  const HomeBottomNavigation({
    Key? key,
    required this.currentIndex,
    required this.onChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            color: ThemeColors.shadowGrey,
            offset: Offset(0, 0),
            blurRadius: 32,
          ),
        ],
      ),
      child: BottomNavigationBar(
        currentIndex: currentIndex,
        backgroundColor: Colors.white,
        onTap: onChange,
        showUnselectedLabels: false,
        selectedItemColor: ThemeColors.primary,
        elevation: 0,
        items: const [
          BottomNavigationBarItem(
            label: 'Home',
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            label: 'History',
            icon: Icon(Icons.calendar_today),
          ),
          BottomNavigationBarItem(
            label: 'Settings',
            icon: Icon(Icons.settings),
          ),
        ],
      ),
    );

    return Container(
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(
            color: ThemeColors.shadowGrey,
            offset: Offset(0, 0),
            blurRadius: 32,
          ),
        ],
      ),
      child: ClipRRect(
        // borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
        child: Container(
          color: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: List.generate(3, (i) {
              final isActive = i == currentIndex;
              return Expanded(
                child: GestureDetector(
                  onTap: () => onChange(i),
                  child: Container(
                    height: 50,
                    alignment: Alignment.center,
                    color: Colors.transparent, // enforce click size
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Icon(
                          [Icons.home, Icons.chat, Icons.person][i],
                          color: isActive ? ThemeColors.black : ThemeColors.shadowGrey,
                        ),
                        Visibility(
                          visible: [false, false, false][i],
                          child: Container(
                            alignment: Alignment.topCenter,
                            padding: EdgeInsets.only(top: 8, left: 24),
                            child: Container(
                              width: 7,
                              height: 7,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
