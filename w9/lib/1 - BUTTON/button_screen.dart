import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ButtonStatus {
  final String name;
  final bool selected;
  ButtonStatus({required this.name, required this.selected});
}

Future<ButtonStatus> fetchButtonStatus() async {
  final url = Uri.parse(
    "https://nora-database-default-rtdb.asia-southeast1.firebasedatabase.app/users.json",
  );

  final response = await http.get(url);

  if (response.statusCode != 200) {
    throw Exception("Failed to fetch button status");
  }

  final json = jsonDecode(response.body);

  return ButtonStatus(name: json["name"], selected: json["selected"]);
}

class ButtonScreen extends StatefulWidget {
  const ButtonScreen({super.key});

  @override
  State<ButtonScreen> createState() => _ButtonScreenState();
}

class _ButtonScreenState extends State<ButtonScreen> {
  String? name;
  bool selected = false;
  bool loading = true;
  String? error;

  @override
  void initState() {
    super.initState();
    _fetchButtonData();
  }

  void _fetchButtonData() async {
    setState(() => loading = true);

    try {
      ButtonStatus status = await fetchButtonStatus();
      setState(() {
        name = status.name;
        selected = status.selected;
        loading = false;
      });
    } catch (e) {
      setState(() {
        error = "Something went wrong!";
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    if (error != null) {
      return Scaffold(body: Center(child: Text("Error!")));
    }

    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () => setState(() => selected =! selected),
          style: ElevatedButton.styleFrom(
            backgroundColor: selected ? Colors.blue : Colors.white
          ),
          child: Text(name?? ""),
        ),
      ),
    );
  }
}
