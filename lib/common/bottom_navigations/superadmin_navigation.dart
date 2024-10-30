import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:timesheet/common/bottom_navigations/bottom_nav_controller.dart';
import 'package:timesheet/common/controllers/app_controller.dart';
import 'package:timesheet/common/screens/hr_screens/hr_create_view_attributes.dart';
import 'package:timesheet/common/screens/hr_screens/hr_create_view_projects.dart';
import 'package:timesheet/common/screens/hr_screens/hr_create_view_tasks.dart';
import 'package:timesheet/common/screens/hr_screens/hr_departments.dart';
import 'package:timesheet/common/screens/hr_screens/hr_myteam.dart';
import 'package:timesheet/common/screens/hr_screens/hr_profile_settings.dart';
import 'package:timesheet/common/screens/hr_screens/hr_users_list.dart';

class BottomNavSuperAdmin extends StatefulWidget {
  final int initialIndex;

  const BottomNavSuperAdmin({Key? key, this.initialIndex = 0})
      : super(key: key);

  @override
  State<BottomNavSuperAdmin> createState() => _BottomNavSuperAdminState();
}

class _BottomNavSuperAdminState extends State<BottomNavSuperAdmin> {
  BottomNavigationController bnc = BottomNavigationController();

  int _page = 0;
  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  List pages = [
    const UsersHRScreen(title: 'Users List'),
    const HRMyProjects(title: 'All Projects'),
    const DepartmentsHRScreen(title: 'Departments'),
    const HRMyTasks(title: 'Tasks List'),
    const HRMyAttributes(title: 'Attributes List'),
    const MyTeamScreen(title: 'Verify Team\'s Timesheet'),
    const HRSettingsScreen(title: 'Profile'),
  ];

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
            Icon(Icons.book, size: 26, color: Colors.white),
            Icon(Icons.list_alt_outlined, size: 26, color: Colors.white),
            Icon(Icons.task_outlined, size: 26, color: Colors.white),
            Icon(Icons.attractions, size: 26, color: Colors.white),
            Icon(Icons.desktop_mac_rounded, size: 26, color: Colors.white),
            Icon(Icons.person, size: 26, color: Colors.white),
          ],
          onTap: (index) {
            if (bnc.selectedIndex.value != index) {
              bnc.selectedIndex.value = index;
            }
            if (bnc.selectedIndex.value == 5) {
              AppController.setVerification(1);
            }
          },
        ),
        body: pages[bnc.selectedIndex.value],
      ),
    );
  }
}
