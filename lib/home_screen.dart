import 'dart:convert';

import 'package:firebase_demo/dashboard_message_model.dart';
import 'package:firebase_demo/dashboard_screen.dart';
import 'package:firebase_demo/new_dashboard_screen.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final remoteConfig = FirebaseRemoteConfig.instance;

  @override
  void initState() {
    setupRemoteConfig();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: getColor(),
        body: Column(
          children: [
            Text(
              'Hello',
              style: TextStyle(fontSize: getTextSize()),
            ),
            SizedBox(
              height: 16,
            ),
            ElevatedButton(
                onPressed: () {
                  String jsonStr = remoteConfig.getString('dashboard_key');
                  bool paymentFeatureFlag = remoteConfig.getBool('payment_flag');
                  final map = jsonDecode(jsonStr);
                  DashboardMessage dashboardMsg =
                      DashboardMessage.fromJson(map);
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    if (dashboardMsg.dashboardType == 'old') {
                      return DashboardScreen(dashboardMsg);
                    } else {
                      return NewDashboardScreen(dashboardMsg,paymentFeatureFlag);
                    }
                  }));
                },
                child: Text('Dashboard'))
          ],
        ),
      ),
    );
  }

  Color getColor() {
    String color = remoteConfig.getString('bg_color');
    if (color == 'red') {
      return Colors.red;
    } else if (color == 'yellow') {
      return Colors.yellow;
    } else if (color == 'green') {
      return Colors.green;
    } else {
      return Colors.white;
    }
  }

  double getTextSize() {
    return remoteConfig.getDouble('text_size');
  }

  Future setupRemoteConfig() async {
    try {
      await remoteConfig.setConfigSettings(RemoteConfigSettings(
        fetchTimeout: const Duration(minutes: 1),
        minimumFetchInterval: const Duration(seconds: 5),
      ));
      await remoteConfig.setDefaults( {
        "bg_color": 'red',
        "text_size": 16,
        "payment_flag":false,
        "dashboard_key": jsonEncode({
          "dashboard_type": "old",
          "text": "Hey",
          "bgColor": "red"
        })
      });
      remoteConfig.fetchAndActivate();
      remoteConfig.onConfigUpdated.listen((event) async {
        print('-------------Fetching Values-------------');
        await remoteConfig.activate();
        if (mounted) {
          setState(() {});
        }
        // Use the new config values here.
      });
    } catch (e) {
      print('Errorrr $e');
    }
  }
}
