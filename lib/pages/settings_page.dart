import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        children: const [
          ListTile(
            leading: Icon(Icons.account_circle),
            title: Text("Account"),
          ),
          ListTile(
            leading: Icon(Icons.notifications),
            title: Text("Notifications"),
          ),
          ListTile(
            leading: Icon(Icons.color_lens),
            title: Text("Theme"),
          ),
          ListTile(
            leading: Icon(Icons.security),
            title: Text("Privacy & Security"),
          ),
        ],
      ),
    );
  }
}
