import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CurrencyController extends GetxController {
  final kesController = TextEditingController();
  final usdController = TextEditingController();
  final rate = 130.0.obs;

  void convert() {
    final kes = double.tryParse(kesController.text) ?? 0.0;
    usdController.text = (kes / rate.value).toStringAsFixed(2);
  }

  @override
  void onClose() {
    kesController.dispose();
    usdController.dispose();
    super.onClose();
  }
}