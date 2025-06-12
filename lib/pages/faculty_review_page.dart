import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Faculty {
  final String name;
  final String designation;
  final String department;
  final List<String> subjects;
  final String email;
  final String phone;
  final String? linkedIn;

  Faculty({
    required this.name,
    required this.designation,
    required this.department,
    required this.subjects,
    required this.email,
    required this.phone,
    this.linkedIn,
  });
}

class FacultyReviewPage extends StatefulWidget {
  const FacultyReviewPage({Key? key}) : super(key: key);

  @override
  State<FacultyReviewPage> createState() => _FacultyReviewPageState();
}

class _FacultyReviewPageState extends State<FacultyReviewPage> {
  final List<Faculty> allFaculty = [
    Faculty(
      name: 'Dr. Priya Sharma',
      designation: 'Associate Professor',
      department: 'CSE',
      subjects: ['Data Structures', 'Algorithms'],
      email: 'priya.sharma@kiit.ac.in',
      phone: '+91 9876543210',
      linkedIn: 'https://linkedin.com/in/priyasharma',
    ),
    Faculty(
      name: 'Mr. Anil Kumar',
      designation: 'Assistant Professor',
      department: 'IT',
      subjects: ['Operating Systems', 'DBMS'],
      email: 'anil.kumar@kiit.ac.in',
      phone: '+91 9123456780',
      linkedIn: null,
    ),
    // Add more mock faculty here...
  ];

  String searchQuery = '';
  List<Faculty> filteredFaculty = [];

  @override
  void initState() {
    super.initState();
    filteredFaculty = allFaculty;
  }

  void _searchFaculty(String query) {
    setState(() {
      searchQuery = query;
      filteredFaculty = allFaculty
          .where((f) =>
              f.name.toLowerCase().contains(query.toLowerCase()) ||
              f.subjects.any((s) => s.toLowerCase().contains(query.toLowerCase())))
          .toList();
    });
  }

  void _launchLinkedIn(String? url) async {
    if (url != null && await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Invalid or missing LinkedIn URL")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Faculty Reviews'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(
                labelText: 'Search Faculty or Subject',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: _searchFaculty,
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: filteredFaculty.length,
                itemBuilder: (context, index) {
                  final faculty = filteredFaculty[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      title: Text(faculty.name),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('${faculty.designation}, ${faculty.department}'),
                          const SizedBox(height: 4),
                          Text('Subjects: ${faculty.subjects.join(', ')}'),
                          Text('Email: ${faculty.email}'),
                          Text('Phone: ${faculty.phone}'),
                        ],
                      ),
                      isThreeLine: true,
                      trailing: IconButton(
                        icon: const Icon(Icons.launch),
                        tooltip: 'LinkedIn Profile',
                        onPressed: () => _launchLinkedIn(faculty.linkedIn),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
