import 'dart:async';
import 'package:evently_c17_fri/core/firebase_functions.dart';
import 'package:evently_c17_fri/models/task_model.dart';
import 'package:flutter/material.dart';

class HomePageProvider extends ChangeNotifier {
  List<String> categories = [
    "All",
    "eating",
    "sport",
    "exhibition",
    "bookclub",
    "birthday",
    "gaming",
    "workshop",
    "meeting",
    "holiday",
  ];

  List<TaskModel> tasks = [];
  bool isLoading = false;
  String errorMessage = "";
  int selectedCategoryIndex = 0;
  StreamSubscription? streamSubscription;

  changeCategory(int index) {
    selectedCategoryIndex = index;
    getStreamTasks();
    notifyListeners();
  }

  @override
  dispose() {
    streamSubscription!.cancel();
    super.dispose();
  }

  getStreamTasks() {
    if (streamSubscription != null) streamSubscription!.cancel();
    streamSubscription =
        FirebaseFunctions.getStreamTasks(
          category: selectedCategoryIndex == 0
              ? null
              : categories[selectedCategoryIndex],
        ).listen((event) {
          tasks = event.docs.map((e) => e.data()).toList();
          notifyListeners();
        });
  }

  getTasks() async {
    isLoading = true;
    errorMessage = "";

    try {
    } catch (e) {
      errorMessage = e.toString();
      print("Error : ${e.toString()}");
    }

    isLoading = false;
    notifyListeners();
  }
}
