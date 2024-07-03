import 'dart:convert';

class DashboardMessage {
  String dashboardType;
  String text;
  String bgColor;

  DashboardMessage({
    required this.dashboardType,
    required this.text,
    required this.bgColor,
  });

  // Factory constructor to create a DashboardMessage from JSON
  factory DashboardMessage.fromJson(Map<String, dynamic> json) {
    return DashboardMessage(
      dashboardType: json['dashboard_type'],
      text: json['text'],
      bgColor: json['bgColor'],
    );
  }

  // Method to convert a DashboardMessage to JSON
  Map<String, dynamic> toJson() {
    return {
      'dashboard_type': dashboardType,
      'text': text,
      'bgColor': bgColor,
    };
  }

  // Static method to create a DashboardMessage from a JSON string
  static DashboardMessage fromJsonString(String jsonString) {
    return DashboardMessage.fromJson(json.decode(jsonString));
  }

  // Method to convert a DashboardMessage to a JSON string
  String toJsonString() {
    return json.encode(toJson());
  }
}

