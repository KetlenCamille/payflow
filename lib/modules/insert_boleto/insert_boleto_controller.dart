import 'package:flutter/material.dart';
import 'package:payflow/shared/models/slip_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InsertBoletoController{
  final formKey = GlobalKey<FormState>();
  SlipModel model = SlipModel();
  
  String? validateName(String? value) => 
    value?.isEmpty ?? true ? "Name can't be empty" : null;
  String? validateDueDate(String? value) => 
    value?.isEmpty ?? true ? "Due date can't be empty" : null;
  String? validateValue(double value) => 
    value == 0 ? "Enter a value greater than R\$ 0,00" : null;
  String? validateSlipCode(String? value) => 
    value?.isEmpty ?? true ? "Slip code can't be empty" : null;

  Future<void> createSlip() async {
    final form = formKey.currentState;
    if(form!.validate()){
      return await saveSlip();
    }
  }

  Future<void> saveSlip() async{
      final instance = await SharedPreferences.getInstance();
      final slips = instance.getStringList("slips") ?? <String>[];
      slips.add(model.toJson());
      await instance.setStringList("slips", slips);
      return;
  }

  void onChange({String? name, String? dueDate, double? value, String? barcode}){
    model = model.copyWith(
      name: name, 
      dueDate: dueDate, 
      value: value, 
      barcode: barcode
    );
  }
}