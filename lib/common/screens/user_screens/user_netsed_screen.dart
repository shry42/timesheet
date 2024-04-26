import 'package:flutter/material.dart';
import 'package:glassmorphism_ui/glassmorphism_ui.dart';
import 'package:timesheet/common/controllers/hr_controllers/get_my_users_team_nested_list_controller.dart';
import 'package:timesheet/utils/widgets/hr_cards/hr_users_card.dart';

class NestedUsersManagerScreen extends StatefulWidget {
  const NestedUsersManagerScreen({super.key, required this.title, this.userId});

  final String title;
  final int? userId;

  @override
  State<NestedUsersManagerScreen> createState() =>
      _NestedUsersManagerScreenState();
}

class _NestedUsersManagerScreenState extends State<NestedUsersManagerScreen> {
  final MyNetstedTeamListController mntlc = MyNetstedTeamListController();

  List<dynamic>? dataList;
  List? searchDataList;
  List? mainDataList;
  final double height = 100;
  final double width = 400;

  @override
  void initState() {
    dataList; //Initialize as empty or else data will not be displayed until tapped on searchbar
    mntlc;
    WidgetsBinding.instance?.addPostFrameCallback((_) async {
      await mntlc.getMyTeamList(widget.userId!.toInt()).then((value) {
        setState(() {
          dataList = value;
          mainDataList = value;
        });
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 213, 231, 214),
      body: Column(children: [
        const SizedBox(height: 40),
        GlassContainer(
          height: 50,
          width: double.infinity,
          blur: 10,
          color: Colors.white.withOpacity(0.1),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.blue.withOpacity(0.8),
              const Color.fromARGB(255, 242, 236, 236).withOpacity(0.9),
            ],
          ),
          //--code to remove border
          border: const Border.fromBorderSide(BorderSide.none),
          shadowStrength: 10,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(16),
          shadowColor: Colors.white.withOpacity(0.24),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  widget.title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Spacer(),
              ],
            ),
          ),
        ),

        //

        // const SizedBox(height: 10),
        Expanded(
          child: Column(
            children: [
              Builder(builder: (
                BuildContext context,
              ) {
                if (dataList == null || dataList!.isEmpty) {
                  return const Center(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 120),
                      Text('No records found')
                    ],
                  ));
                } else {
                  return Expanded(
                    child: ListView.builder(
                        itemCount: dataList!.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () async {
                              // String firstName =
                              //     dataList![index].firstName;
                              // String lastName =
                              //     dataList![index].lastName;
                              // String email = dataList![index].email;
                              // String mobileNo =
                              //     dataList![index].mobileNo;
                              // int isManager =
                              //     dataList![index].isManager;
                              // int id = dataList![index].id;
                              // int reportingManagerId =
                              //     dataList![index].reportingManager;
                              // String reportingManagerWithName =
                              //     dataList![index]
                              //         .reportingManagerWithName;
                              // if (AppController.role == 'hrManager') {
                              //   Get.to(HRUpdateUserScreen(
                              //     title: 'Update User',
                              //     id: id,
                              //     firstName: firstName,
                              //     lastName: lastName,
                              //     email: email,
                              //     mobileNo: mobileNo,
                              //     isManager: isManager.toString(),
                              //     reportingManagerId:
                              //         reportingManagerId,
                              //     reportingManagerWithName:
                              //         reportingManagerWithName,
                              //   ));
                              // }
                            },
                            child: HRUsersCard(
                              ht: height,
                              wd: width,
                              duration: 200,
                              name:
                                  ' ${dataList![index].firstName} ${dataList![index].lastName}',
                              email: dataList![index].email,
                              // mobile: dataList![index].mobileNo,
                              // reportingManager: dataList![index]
                              //     .reportingManagerWithName,
                              isManager: dataList![index].isManager == 0
                                  ? 'no'
                                  : 'yes',
                            ),
                          );
                        }),
                  );
                }
              })
            ],
          ),
        ),
        //
      ]),
    );
  }
}
