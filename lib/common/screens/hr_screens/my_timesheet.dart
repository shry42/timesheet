import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glassmorphism_ui/glassmorphism_ui.dart';
import 'package:intl/intl.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:timesheet/common/controllers/app_controller.dart';
import 'package:timesheet/common/controllers/hr_controllers/hr_attributes_controller.dart';
import 'package:timesheet/common/screens/hr_screens/create_timesheet.dart';
import 'package:timesheet/common/screens/hr_screens/hr_update_attributes.dart';
import 'package:timesheet/utils/widgets/hr_cards/hr_attributes_card.dart';

class MyTimesheetScreen extends StatefulWidget {
  const MyTimesheetScreen({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyTimesheetScreen> createState() => _MyTimesheetScreenState();
}

final HRAttributesController hac = HRAttributesController();

class _MyTimesheetScreenState extends State<MyTimesheetScreen> {
  DateTime? selectedDate;

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
                if (AppController.role == 'hrManager')
                  Shimmer(
                    duration: const Duration(seconds: 2),
                    interval: const Duration(milliseconds: 20),
                    color: Colors.white,
                    colorOpacity: 1,
                    enabled: true,
                    direction: const ShimmerDirection.fromLTRB(),
                    child: GestureDetector(
                      onTap: () {
                        _selectDate(context, selectedDate ?? DateTime.now());
                      },
                      child: Container(
                        height: 30,
                        width: 100,
                        decoration: BoxDecoration(
                            border: Border.all(),
                            color: Colors.white70,
                            borderRadius: BorderRadius.circular(6)),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Center(
                              child: Text(
                                'Create Timesheet',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 12),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                const SizedBox(width: 10),
              ],
            ),
          ),
        ),
        const SizedBox(height: 10),
        Expanded(
          child: FutureBuilder(
            future: hac.attributes(),
            builder: (BuildContext ctx, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 50),
                      CircularProgressIndicator(),
                      SizedBox(height: 10),
                      Text('Loading attributes...'),
                    ],
                  ),
                );
              } else if (snapshot.hasError) {
                return const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 100),
                      Icon(Icons.error, color: Colors.red),
                      SizedBox(height: 60),
                      Text(
                          '    Error loading attributes\nPlease try again by logging out'),
                    ],
                  ),
                );
              } else if (snapshot.data == null || snapshot.data.isEmpty) {
                return const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 65),
                      Text('No attributes to show\ncreate attributes first!'),
                    ],
                  ),
                );
              } else {
                return Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        // reverse: true,
                        itemCount: snapshot.data.length,
                        itemBuilder: (ctx, index) => GestureDetector(
                          onTap: () async {
                            String attributeName = snapshot.data[index].name;
                            String description =
                                snapshot.data[index].description;
                            int attributeId = snapshot.data[index].id;

                            if (AppController.role == 'hrManager') {
                              Get.to(HRUpdateAttribute(
                                description: description,
                                attributeName: attributeName,
                                attributeId: attributeId,
                                title: 'Update Attribute',
                              ));
                            }
                          },
                          child: HRAttributesCard(
                            ht: 130,
                            wd: 400,
                            duration: 400,
                            // id: snapshot.data![index].id.toString(),
                            name: snapshot.data![index].name.toString(),
                            createdAt: snapshot.data![index].createdAt
                                .toString()
                                .split("T")[0],
                            description:
                                snapshot.data![index].description.toString(),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }
            },
          ),
        ),
      ]),
    );
  }

  Future<void> _selectDate(BuildContext context, DateTime selectedDate) async {
    DateTime initialDate = DateTime.now();

    // If today is not Monday, find the next Monday
    if (selectedDate.weekday != 1) {
      int daysUntilNextMonday = (1 - selectedDate.weekday + 7) % 7;
      selectedDate = selectedDate.add(Duration(days: daysUntilNextMonday));
    }

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
      selectableDayPredicate: (DateTime date) {
        // Allow only Mondays to be selected
        return date.weekday == 1;
      },
    );

    if (picked != null) {
      // Create a new DateTime object with the same date as picked but time set to 00:00:00
      DateTime trimmedDate = DateTime(picked.year, picked.month, picked.day);

      // Format the date to '2024-04-01' format
      String formattedDate = DateFormat('yyyy-MM-dd').format(trimmedDate);

      // Get the next 5 dates in sequence
      List<DateTime> nextDates = getNextNDates(picked, 6);

      // Format each date to '2024-04-01' format
      List<String> formattedNextDates = nextDates.map((date) {
        return DateFormat('yyyy-MM-dd').format(date);
      }).toList();

      // Navigate to the next screen, passing the picked date and the next 5 dates
      Get.to(CreateTimesheetScreen(
        title: 'Fill Timesheet',
        date1: formattedDate,
        date2: formattedNextDates[1],
        date3: formattedNextDates[2],
        date4: formattedNextDates[3],
        date5: formattedNextDates[4],
        date6: formattedNextDates[5],
      ));
    }
  }

  List<DateTime> getNextNDates(DateTime date, int n) {
    return List.generate(n, (i) => date.add(Duration(days: i)));
  }
}
