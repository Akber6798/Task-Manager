// ignore_for_file: use_build_context_synchronously, iterable_contains_unrelated_type

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manager/model/task_model.dart';
import 'package:task_manager/services/db_services.dart';
import 'package:task_manager/utililites/app_colors.dart';
import 'package:task_manager/utililites/app_style.dart';
import 'package:task_manager/utililites/utilities.dart';
import 'package:task_manager/widgets/button.dart';
import 'package:task_manager/widgets/custom_drawer.dart';
import 'package:task_manager/widgets/task_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final taskController = TextEditingController();
  final searchController = TextEditingController();
  List<TaskModel> allTaskList = [];
  String? userName;

  //for filter the task as per new one
  Future<List<TaskModel>> getTaskListAsPerNewTask() async {
    allTaskList = await DataBaseServices.instance.getTasks();
    searchTaskFilter(searchController.text);
    allTaskList.sort((first, second) => second.id.compareTo(first.id));
    return allTaskList;
  }

  //for search
  void searchTaskFilter(String enteredKeyword) {
    List<TaskModel> results = [];

    if (enteredKeyword.isEmpty) {
      results = allTaskList;
    } else {
      results = allTaskList
          .where((element) =>
              element.task.toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
    }
    setState(() {
      allTaskList = results;
    });
  }

  // to get username
  Future<String?> getUsername() async {
    SharedPreferences prefference = await SharedPreferences.getInstance();
    String? user = prefference.getString('name');
    userName = user;
    return userName;
  }

  // to detect the change of the checkbox
  void checkBoxChanged(TaskModel model) {
    setState(() {
      model.isDone = !model.isDone;
    });
  }

  @override
  void initState() {
    super.initState();
    getUsername();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Utilities.instance.showAppAppDialogue(context, "Are you sure to Exit",
            () async {
          SystemNavigator.pop();
        });
        return Future.value(false);
      },
      child: Scaffold(
        drawer: CustomDrawer(
          name: userName.toString(),
        ),
        appBar: AppBar(
          title: Text(
            "Task Manager",
            style: AppStyle.instance
                .appTextStyle(22, AppColors.textColor, FontWeight.bold),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showAddTaskDialogue();
          },
          backgroundColor: AppColors.primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Icon(
            Icons.add,
            size: 35.sp,
          ),
        ),
        body: FutureBuilder<List<TaskModel>>(
          future: getTaskListAsPerNewTask(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text(
                  snapshot.error.toString(),
                ),
              );
            } else if (snapshot.hasData) {
              if (snapshot.data!.isEmpty) {
                return Center(
                  child: SizedBox(
                    height: 500.h,
                    width: double.infinity,
                    child: Column(
                      children: [
                        Lottie.asset('assets/animations/100757-not-found.json',
                            height: 320.h, width: 320.w),
                        Text(
                          'Hi $userName, nothing in here yet...\nClick the add button to get started',
                          style: AppStyle.instance.appTextStyle(
                              18, AppColors.textColor, FontWeight.w400),
                        )
                      ],
                    ),
                  ),
                );
              } else {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.w),
                  child: ListView(
                    children: [
                      SizedBox(height: 10.h),
                      Text(
                        "Hi ${userName.toString()}",
                        style: AppStyle.instance.appTextStyle(
                            20, AppColors.textColor, FontWeight.w500),
                      ),
                      SizedBox(height: 15.h),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: TextFormField(
                          onChanged: (value) => searchTaskFilter(value),
                          controller: searchController,
                          cursorColor: AppColors.primaryColor,
                          decoration: const InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                              hintText: "Search",
                              prefixIcon: Icon(
                                Icons.search,
                              )),
                        ),
                      ),
                      SizedBox(height: 15.h),
                      Text(
                        "All Tasks",
                        style: AppStyle.instance.appTextStyle(
                            18, AppColors.textColor, FontWeight.w400),
                      ),
                      SizedBox(height: 10.h),
                      ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: ((context, index) {
                            var singleTask = snapshot.data![index];
                            return TaskCard(
                                task: singleTask,
                                OnTaskDelete: () {
                                  setState(() {
                                    DataBaseServices.instance
                                        .deleteTask(singleTask.id);
                                  });
                                  Utilities.instance
                                      .showMessage("Task deleted");
                                },
                                OnTaskDone: checkBoxChanged);
                          }),
                          separatorBuilder: ((context, index) =>
                              SizedBox(height: 10.h)),
                          itemCount: snapshot.data!.length)
                    ],
                  ),
                );
              }
            } else {
              return Center(
                child: CircularProgressIndicator(
                  color: AppColors.primaryColor,
                ),
              );
            }
          },
        ),
      ),
    );
  }

  //show dialogue for add task

  void showAddTaskDialogue() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: ((context) {
        return AlertDialog(
          backgroundColor: AppColors.scaffoldColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          title: Text(
            'Add Task',
            style: AppStyle.instance
                .appTextStyle(22, AppColors.textColor, FontWeight.bold),
          ),
          content: TextFormField(
            cursorColor: AppColors.primaryColor,
            controller: taskController,
            maxLength: 25,
            decoration: const InputDecoration(counterText: ""),
          ),
          actions: [
            Button(
                buttonName: "Cancel",
                onPressed: () {
                  Navigator.pop(context);
                  taskController.clear();
                }),
            Button(
                buttonName: "Add",
                onPressed: () {
                  addTaskFunction();
                })
          ],
        );
      }),
    ).whenComplete(
      () {
        setState(() {});
      },
    );
  }

  //add task to data base

  Future<void> addTaskFunction() async {
    if (taskController.text.isEmpty) {
      Utilities.instance.showMessage('Enter the Task');
    } else {
      await DataBaseServices.instance.addTask(TaskModel(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          task: taskController.text));
      Utilities.instance.showMessage('Task Added');
      Navigator.pop(context);
      taskController.clear();
    }
  }

  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
    taskController.dispose();
  }
}
