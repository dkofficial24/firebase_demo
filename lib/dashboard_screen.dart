import 'package:firebase_demo/dashboard_message_model.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen(this.dashboardMessage, {super.key});

  final DashboardMessage dashboardMessage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Old Dashboard'),),
      backgroundColor: getColor(dashboardMessage.bgColor),
      body: Center(
        child: Text(dashboardMessage.text),
      ),
    );
  }

  Color getColor(String color) {
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
}
