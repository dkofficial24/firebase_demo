import 'package:firebase_demo/dashboard_message_model.dart';
import 'package:flutter/material.dart';

class NewDashboardScreen extends StatelessWidget {
  const NewDashboardScreen(this.dashboardMessage, this.paymentFeatureFlag,
      {super.key});

  final DashboardMessage dashboardMessage;
  final bool paymentFeatureFlag;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Dashboard'),
      ),
      backgroundColor: getColor(dashboardMessage.bgColor),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(dashboardMessage.text),
          ),
          if (paymentFeatureFlag)
            ElevatedButton(onPressed: () {}, child: Text('Pay Now'))
        ],
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
