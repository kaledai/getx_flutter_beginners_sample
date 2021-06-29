import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_state_management/src/controller/reactive_state_controller.dart';
import 'package:getx_state_management/src/services/api_service.dart';

class ExamplePage extends StatefulWidget {
  ExamplePage({Key? key}) : super(key: key);

  @override
  _ExamplePageState createState() => _ExamplePageState();
}

class _ExamplePageState extends State<ExamplePage> {
  final _counterState = Get.put(ReactiveStateController());

  final _apiService = Get.put(ApiService());

  bool isFetched = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GetX - Dependencies Management'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextButton(
              onPressed: () {
                _apiService.getApiData();
                setState(() {
                  isFetched = true;
                });
              },
              child: Text('Fetch API Data'),
            ),
            isFetched != true
                ? const SizedBox.shrink()
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Person',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text('name: ${_apiService.person!.name}'),
                      Text('age: ${_apiService.person!.age}'),
                      Text('gender: ${_apiService.person!.gender}'),
                      Text('address: ${_apiService.person!.address}'),
                    ],
                  ),
            const SizedBox(height: 28),
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    _counterState.decrement();
                  },
                  icon: Icon(Icons.remove),
                ),
                Obx(
                  () => Text(
                    '${_counterState.count}',
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    _counterState.increment();
                  },
                  icon: Icon(Icons.add),
                ),
                IconButton(
                  onPressed: () {
                    _counterState.reset();
                  },
                  icon: Icon(Icons.refresh),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
