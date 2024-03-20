import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:timesheet/common/bottom_navigations/bottom_nav_controller.dart';

class BottomNavHR extends StatefulWidget {
  final int initialIndex;

  const BottomNavHR({Key? key, this.initialIndex = 0}) : super(key: key);

  @override
  State<BottomNavHR> createState() => _BottomNavHRState();
}

class _BottomNavHRState extends State<BottomNavHR> {
  BottomNavigationController bnc = BottomNavigationController();

  int _page = 0;
  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  List pages = [];

  @override
  void initState() {
    bnc.selectedIndex.value = widget.initialIndex;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: const Color.fromARGB(255, 213, 231, 214),
        bottomNavigationBar: CurvedNavigationBar(
          key: _bottomNavigationKey,
          index: bnc
              .selectedIndex.value, // Set the initial index to 1 (2nd position)
          backgroundColor: const Color.fromARGB(0, 246, 245, 245),
          height: 60,
          buttonBackgroundColor: const Color.fromARGB(255, 101, 194, 104),
          color: const Color.fromARGB(255, 100, 219, 104),
          animationDuration: const Duration(milliseconds: 200),
          items: const <Widget>[
            Icon(Icons.description, size: 26, color: Colors.white),
            Icon(Icons.person_pin_rounded, size: 26, color: Colors.white),
            // Icon(Icons.person_add_alt_1_rounded, size: 26, color: Colors.white),
            Icon(Icons.house, size: 26, color: Colors.white),
            Icon(Icons.person, size: 26, color: Colors.white),
          ],
          onTap: (index) {
            if (bnc.selectedIndex.value != index) {
              bnc.selectedIndex.value = index;
            }
          },
        ),
        body: pages[bnc.selectedIndex.value],
      ),
    );
  }
}
