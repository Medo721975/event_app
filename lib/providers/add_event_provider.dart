import 'package:evently_c17_fri/core/firebase_functions.dart';
import 'package:evently_c17_fri/models/task_model.dart';
import 'package:flutter/material.dart';

class AddEventProvider extends ChangeNotifier {
  int selectedCategoryIndex = 0;
  DateTime selectedDate = DateTime.now();

  changeDate(DateTime date) {
    selectedDate = date;
    notifyListeners();
  }

  changeCategory(int index) {
    selectedCategoryIndex = index;
    notifyListeners();
  }

  addEvent(TaskModel taskModel) async {
    await FirebaseFunctions.createTask(taskModel);
    notifyListeners();
  }
}
