import 'dart:async';
import 'package:evently_c17_fri/core/firebase_functions.dart';
import 'package:evently_c17_fri/models/task_model.dart';
import 'package:flutter/material.dart';

class FavouritePageProvider extends ChangeNotifier {
  bool isLoading = false;
  String errorMessage = "";
  List<TaskModel> tasks = [];
  StreamSubscription? streamSubscription;

  getFavoriteTasks() {
    if (streamSubscription != null) streamSubscription!.cancel();
    streamSubscription = FirebaseFunctions.getFavoriteTasks().listen((event) {
      tasks = event.docs.map((e) => e.data()).toList();
      notifyListeners();
    });
  }
}
