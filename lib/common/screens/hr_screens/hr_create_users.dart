import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:glassmorphism_ui/glassmorphism_ui.dart';
import 'package:multi_select_flutter/chip_display/multi_select_chip_display.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:timesheet/common/controllers/hr_controllers/get_users_dept_controller.dart';
import 'package:timesheet/common/controllers/hr_controllers/hr_create_user_controller.dart';
import 'package:timesheet/common/controllers/hr_controllers/hr_users_controller.dart';
import 'package:timesheet/common/models/hr_models/hr_users_model.dart';
import 'package:timesheet/utils/toast_notify.dart';

class HRCreateUsers extends StatefulWidget {
  HRCreateUsers({
    super.key,
    required this.title,
  });

  final String title;

  @override
  State<HRCreateUsers> createState() => _HRCreateUsersState();
}

class _HRCreateUsersState extends State<HRCreateUsers> {
  final CreateUserController uuc = CreateUserController();

  final TextEditingController firstNameController = TextEditingController();

  final TextEditingController lastNameController = TextEditingController();

  final TextEditingController emailController = TextEditingController();
  //
  final TextEditingController employeeIdController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final TextEditingController confirmPassController = TextEditingController();

  final TextEditingController mobileNoController = TextEditingController();

  final TextEditingController isManagerController = TextEditingController();
  final TextEditingController reportingManagerIdController =
      TextEditingController();
  dynamic isManager;
  dynamic reportingManagerId;

  // final AllDepartmentList adl = AllDepartmentList();  now only need depts by userId not all depts

  final UsersDepartmentController udc = UsersDepartmentController();

  final CreateUserController cuc = CreateUserController();

  final HRUsersController hruc = HRUsersController();
  List<HRAllUsersListModel> hrUserListObj = [];
  List<dynamic> _selectedDepartmentIds = [];
  List<dynamic> deptNames = [];
  getData() async {
    // await adl.getAllDepartments();
    hrUserListObj = HRUsersController.managersList;
    // deptNames = AllDepartmentList.verifiedDepartmentList;
    setState(() {});
  }

  getDeptNames() async {
    deptNames = await udc.getAllDepartments(reportingManagerId);
    setState(() {});
  }

// Future<void> getDeptNames() async {
//   final List<DepartmentModel> deptList = await udc.getAllDepartments();
//   final List<DepartmentModel> filteredDeptList = deptList.where((dept) {
//     final List<int> managerIds = hrUserListObj
//         .firstWhere((user) => user.id == reportingManagerId)
//         .departmentIds;
//     return managerIds.contains(dept.id);
//   }).toList();
//   setState(() {
//     deptNames = filteredDeptList;
//   });
// }

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    getData();
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
        child: Form(
          key: _formKey,
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
                child: TextFormField(
                  // controller: emailController,
                  controller: firstNameController,
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
                    labelText: 'First Name',
                    // hintText: 'username',
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.deny(
                        RegExp(r'\s')), // no spaces allowed
                  ],
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter a first name";
                    } else if (!RegExp(r'^[a-zA-Z]+$').hasMatch(value)) {
                      return "First name can only contain letters";
                    }
                    // Check if the input is a valid email address ending with '@gegadyne.com'
                    var re = RegExp(
                        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@gegadyne\.com$');
                    if (!re.hasMatch(value)) {
                      return "Email must end with '@gegadyne.com'";
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                child: TextFormField(
                  controller: lastNameController,
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
                    labelText: 'Last Name',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter a name";
                    } else if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
                      return "Name can only contain alphabets and spaces";
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                child: TextFormField(
                  controller: emailController,
                  // initialValue: widget.email,
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
                    labelText: 'Email address',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter an email";
                    } else if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                      return "Please enter a valid email";
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                child: TextFormField(
                  controller: employeeIdController,
                  // initialValue: widget.email,
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
                    labelText: 'Employee Id',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter employee id";
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                child: TextFormField(
                    controller: passwordController,
                    // initialValue: widget.lastName,
                    onChanged: (value) {
                      // AppController.setemailId(emailController.text);
                      // c.userName.value = emailController.text;
                    },
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 8),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      labelText: 'Password',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter password";
                      }
                    }),
              ),
              Padding(
                //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                child: TextFormField(
                  controller: confirmPassController,
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
                    labelText: 'Confirm Password',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please re enter password";
                    }
                  },
                ),
              ),
              Padding(
                //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                child: TextFormField(
                  controller: mobileNoController,
                  // initialValue: widget.mobileNo,
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
                    labelText: 'MobileNumber',
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly, // allow only digits
                    LengthLimitingTextInputFormatter(
                        10), // limit to 10 characters
                  ],
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a phone number';
                    } else if (value.length != 10) {
                      return 'Please enter a valid 10-digit phone number';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                child: DropdownButtonFormField<int>(
                  validator: (value) {
                    if (value == null) {
                      return 'Please select a reporting manager';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    labelText: 'Reporting Manager',
                  ),
                  // value: widget.reportingManagerId,
                  items: hrUserListObj
                      .map((user) => DropdownMenuItem<int>(
                            value: user.id,
                            child: Text('${user.firstName} ${user.lastName}'),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      reportingManagerId = value!;
                      _selectedDepartmentIds.clear();
                    });
                    getDeptNames();
                  },
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                child: DropdownButtonFormField<int>(
                  validator: (value) {
                    if (value == null) {
                      return 'Please select a managerial level';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    labelText: 'Is a Manager?',
                  ),
                  // value: widget.isManager.toString(),
                  onChanged: (value) {
                    setState(() {
                      isManager = value!;
                    });
                  },
                  items: const [
                    DropdownMenuItem(
                      value: 1,
                      child: Text('Yes'),
                    ),
                    DropdownMenuItem(
                      value: 0,
                      child: Text('No'),
                    ),
                  ],
                ),
              ),
              // const SizedBox(height: 35),
              ...[
                // const SizedBox(height: 17),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: MultiSelectDialogField<String>(
                      // validator: (value) {
                      //   if (value == null || value.isEmpty) {
                      //     return 'Please select at least one department';
                      //   }
                      //   return null;
                      // },
                      searchable: true,
                      items: deptNames
                          .map(
                            (dept) => MultiSelectItem<String>(
                                // dept.id,
                                dept.id.toString(),
                                dept.deptName),
                          )
                          .toList(),
                      initialValue: [],
                      onConfirm: (values) {
                        setState(() {
                          _selectedDepartmentIds = values;
                        });
                      },
                      title: const Text('Select Departments'),
                      buttonText: const Text('Select Departments'),
                      chipDisplay: MultiSelectChipDisplay<String>(
                        onTap: (item) {
                          setState(() {
                            _selectedDepartmentIds.remove(item);
                          });
                        },
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      buttonIcon: const Icon(Icons.arrow_drop_down_outlined),
                    ),
                  ),
                ),
                // Display selected departments
                if (_selectedDepartmentIds != null &&
                    _selectedDepartmentIds.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Wrap(
                      spacing: 8,
                      children: _selectedDepartmentIds.map((deptId) {
                        final dept = deptNames
                            .firstWhere((dept) => dept.id == int.parse(deptId));
                        return Chip(
                          label: Text(dept.deptName),
                          onDeleted: () {
                            setState(() {
                              _selectedDepartmentIds.remove(deptId);
                            });
                          },
                        );
                      }).toList(),
                    ),
                  ),
              ],
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
                      if (_formKey.currentState!.validate()) {
                        if (_selectedDepartmentIds.isEmpty) {
                          toast('Please select at least one department');
                        } else {
                          await cuc.createUser(
                            firstNameController.text,
                            lastNameController.text,
                            emailController.text,
                            employeeIdController.text,
                            passwordController.text,
                            confirmPassController.text,
                            mobileNoController.text,
                            reportingManagerId,
                            isManager,
                            _selectedDepartmentIds,
                          );
                        }
                      }
                    },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: Text(
                            'Submit',
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
      ),

      // backgroundColor: Colors.transparent,
    );
  }
}
