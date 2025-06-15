import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 24),
            const CircleAvatar(
              radius: 60,
              backgroundImage: AssetImage('assets/profile.jpg'), // Replace with NetworkImage if needed
            ),
            const SizedBox(height: 16),
            const Text(
              'John Doe',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            const Text(
              'john.doe@example.com',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 24),
            _buildInfoTile(Icons.school, 'Branch', 'CSE'),
            _buildInfoTile(Icons.calendar_today, 'Year', '3rd Year'),
            _buildInfoTile(Icons.phone, 'Phone', '+91 9876543210'),
            _buildInfoTile(Icons.location_on, 'Hostel', 'Boys Hostel 3'),
            const Divider(height: 40),
            ListTile(
              leading: const Icon(Icons.edit),
              title: const Text('Edit Profile'),
              onTap: () {
                Navigator.pushNamed(context, '/editProfile');
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () {
                // TODO: Implement logout
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Logged out')),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoTile(IconData icon, String label, String value) {
    return ListTile(
      leading: Icon(icon, color: Colors.blue),
      title: Text(label),
      subtitle: Text(value),
    );
  }
}
