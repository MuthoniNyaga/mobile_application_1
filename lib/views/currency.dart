import 'package:flutter/material.dart';
import 'package:flutter_application_1/controllers/currencycontroler.dart';
import 'package:get/get.dart';

class Currency extends StatelessWidget {
  const Currency({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CurrencyController());

    return Scaffold(
      appBar: AppBar(title: const Text('Currency Converter')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: controller.kesController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'KES'),
            ),
            TextField(
              controller: controller.usdController,
              readOnly: true,
              decoration: const InputDecoration(labelText: 'USD'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: controller.convert,
              child: const Text('Convert'),
            ),
            const SizedBox(height: 16),
            Obx(() => Text('Rate: 1 USD = ${controller.rate.value} KES')),
          ],
        ),
      ),
    );
  }
}