import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glassmorphism_ui/glassmorphism_ui.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:timesheet/common/controllers/hr_controllers/hr_create_project_controller.dart';
import 'package:timesheet/common/controllers/hr_controllers/my_departments_controller.dart';

class HRCreateProject extends StatefulWidget {
  HRCreateProject({
    super.key,
    required this.title,
  });

  final String title;

  @override
  State<HRCreateProject> createState() => _HRCreateProjectState();
}

class _HRCreateProjectState extends State<HRCreateProject> {
  final TextEditingController name = TextEditingController();
  final TextEditingController description = TextEditingController();
  final TextEditingController code = TextEditingController();
  //  TextEditingController selectedStartDate = TextEditingController();
  //  TextEditingController selectedEndDate = TextEditingController();
  // final TextEditingController departmentId = TextEditingController();
  int? departmentId;
  late DateTime _date;

  //

  // final AllDepartmentList adl = AllDepartmentList()  ;   don't need all departemnet list
  final MyDepartmentsController adl =
      MyDepartmentsController(); // only need mydepartement list said by manish
  List<dynamic> deptNames = [];
  getData() async {
    await adl.getMyDepartments();
    // deptNames = AllDepartmentList.verifiedDepartmentList;
    deptNames = MyDepartmentsController.myDeptList;
    setState(() {});
  }

  final CreateProjectController cpc = Get.put(CreateProjectController());

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    getData();
    _date = DateTime.now();
    // Initialize the controllers with the provided values
    // firstNameController.text = widget.firstName;
    // lastNameController.text = widget.lastName;
    // emailController.text = widget.email;
    // mobileNoController.text = widget.mobileNo;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 213, 231, 214),
      body: SingleChildScrollView(
        child: Column(children: [
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
                  const SizedBox(width: 10),
                ],
              ),
            ),
          ),
          const SizedBox(height: 30),
          Column(children: [
            Padding(
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
              child: TextFormField(
                // controller: emailController,
                controller: name,
                // initialValue: widget.firstName,
                onChanged: (value) {
                  // AppController.setemailId(emailController.text);
                  // c.userName.value = emailController.text;
                },
                decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  labelText: 'Project Name',
                  // hintText: 'username',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter Projet name";
                  }
                  return null;
                },
              ),
            ),
            Padding(
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
              child: TextFormField(
                controller: description,
                // initialValue: widget.lastName,
                onChanged: (value) {
                  // AppController.setemailId(emailController.text);
                  // c.userName.value = emailController.text;
                },
                decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  labelText: 'Description',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter description";
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
              child: TextFormField(
                controller: code,
                decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  labelText: 'Code',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter code";
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
              child: TextFormField(
                decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
                  labelText: 'startDate',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                // initialValue: "select date",
                // // _date.toLocal().toString().split(' ')[0],
                initialValue:
                    cpc.selectedStartDate.value.split(' ')[0] ?? 'select date',
                readOnly: true,
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: _date,
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2101),
                  );

                  if (pickedDate != null && pickedDate != _date) {
                    setState(() {
                      _date = pickedDate;
                      cpc.selectedStartDate.value = pickedDate.toString();
                    });
                  }
                },
                validator: (value) {
                  if (value == null) {
                    return 'Please select startDate';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
              child: TextFormField(
                decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
                  labelText: 'endDate',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                // initialValue: "select date",
                // // _date.toLocal().toString().split(' ')[0],
                initialValue:
                    cpc.selectedEndDate.value.split(' ')[0] ?? 'select date',
                readOnly: true,
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: _date,
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2101),
                  );

                  if (pickedDate != null && pickedDate != _date) {
                    setState(() {
                      _date = pickedDate;
                      cpc.selectedEndDate.value = pickedDate.toString();
                    });
                  }
                },
                validator: (value) {
                  if (value == null) {
                    return 'Please select endDate';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
              child: DropdownButtonFormField<int>(
                decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  labelText: 'Select department',
                ),
                // value: widget.reportingManagerId,
                items: deptNames
                    .map((dept) => DropdownMenuItem<int>(
                          value: dept.id,
                          child: Text('${dept.deptName}'),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    departmentId = value!;
                  });
                },
              ),
            ),
            const SizedBox(height: 20),
            Shimmer(
              duration: const Duration(seconds: 2),
              // This is NOT the default value. Default value: Duration(seconds: 0)
              interval: const Duration(seconds: 1),
              // This is the default value
              color: Colors.white,
              // This is the default value
              colorOpacity: 1,
              // This is the default value
              enabled: true,
              // This is the default value
              direction: const ShimmerDirection.fromLTRB(),
              child: Container(
                height: 42,
                width: 160,
                decoration: BoxDecoration(
                    color: Colors.greenAccent,
                    borderRadius: BorderRadius.circular(30)),
                child: ElevatedButton(
                  onPressed: () async {
                    // if (_formKey.currentState!.validate()) {
                    await cpc.createProject(
                        name.text,
                        description.text,
                        code.text,
                        cpc.selectedStartDate.value,
                        cpc.selectedEndDate.value,
                        departmentId as int);
                    // }
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Text(
                          'Create',
                          style: TextStyle(color: Colors.black, fontSize: 25),
                        ),
                      ),
                      Icon(
                        Icons.energy_savings_leaf,
                        color: Color.fromARGB(255, 78, 225, 83),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ]),
          const SizedBox(
            height: 30,
          ),
        ]),
      ),

      // backgroundColor: Colors.transparent,
    );
  }
}
