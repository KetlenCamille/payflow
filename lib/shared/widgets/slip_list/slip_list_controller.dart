import 'package:flutter/material.dart';
import 'package:payflow/shared/models/slip_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SlipListController {
  final slipsNotifier = ValueNotifier<List<SlipModel>>(<SlipModel>[]);
  List<SlipModel> get slips => slipsNotifier.value;
  set slips(List<SlipModel> value) => slipsNotifier.value = value;

  SlipListController(){
    getSlips();
  }

  Future<void> getSlips() async {
    try {
      final instance = await SharedPreferences.getInstance();
      final response = instance.getStringList("slips") ?? <String> [];
      slips = response.map((e) => SlipModel.fromJson(e)).toList();
    } catch (e) {
      slips = <SlipModel> [];
    }
  }
}