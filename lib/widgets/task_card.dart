// ignore_for_file: non_constant_identifier_names, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_manager/model/task_model.dart';
import 'package:task_manager/utililites/app_colors.dart';
import 'package:task_manager/utililites/app_style.dart';

class TaskCard extends StatefulWidget {
  final TaskModel task;
  final OnTaskDelete;
  final OnTaskDone;

  const TaskCard({
    super.key,
    required this.task,
    required this.OnTaskDelete,
    required this.OnTaskDone,
  });

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      elevation: 5,
      color: Colors.white,
      child: SizedBox(
        height: 70.h,
        child: Center(
          child: ListTile(
            onTap: () {
              widget.OnTaskDone(widget.task);
            },
            leading: Icon(
              widget.task.isDone
                  ? Icons.check_box
                  : Icons.check_box_outline_blank,
              color: AppColors.primaryColor,
            ),
            title: Text(
              widget.task.task,
              style: AppStyle.instance.appTextTaskStyle(
                  18,
                  AppColors.textColor,
                  FontWeight.w600,
                  widget.task.isDone
                      ? TextDecoration.lineThrough
                      : TextDecoration.none),
            ),
            trailing: Container(
              height: 35.h,
              width: 35.w,
              decoration: BoxDecoration(
                color: AppColors.redColor,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Center(
                child: IconButton(
                  onPressed: widget.OnTaskDelete,
                  icon: Icon(
                    Icons.delete,
                    size: 20,
                    color: AppColors.scaffoldColor,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
