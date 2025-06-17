import 'package:flutter/material.dart';

class PYQPage extends StatefulWidget {
  const PYQPage({Key? key}) : super(key: key);

  @override
  State<PYQPage> createState() => _PYQPageState();
}

class _PYQPageState extends State<PYQPage> {
  final List<String> academicYears = ['2021-22', '2022-23', '2023-24'];
  final List<String> subjects = [
    'Data Structures',
    'Computer Networks',
    'Operating Systems',
    'DBMS',
    'Mathematics',
    'OOPs'
  ];

  String? selectedYear;
  String searchQuery = '';
  List<String> filteredSubjects = [];

  @override
  void initState() {
    super.initState();
    filteredSubjects = subjects;
  }

  void _filterSubjects(String query) {
    setState(() {
      searchQuery = query;
      filteredSubjects = subjects
          .where((subject) =>
              subject.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  void _viewPYQ(String subject) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Viewing $subject PYQ')),
    );
    // TODO: Load and display PDF
  }

  void _downloadPYQ(String subject) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Downloading $subject PYQ')),
    );
    // TODO: Implement file download logic
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PYQ & Solutions'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: 'Select Academic Year',
                border: OutlineInputBorder(),
              ),
              value: selectedYear,
              items: academicYears
                  .map((year) => DropdownMenuItem(
                        value: year,
                        child: Text(year),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  selectedYear = value;
                });
              },
            ),
            const SizedBox(height: 16),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Search Subject',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: _filterSubjects,
            ),
            const SizedBox(height: 16),
            Expanded(
              child: selectedYear == null
                  ? const Center(
                      child: Text(
                        'Please select an academic year to view PYQs.',
                        style: TextStyle(color: Colors.grey),
                      ),
                    )
                  : ListView.builder(
                      itemCount: filteredSubjects.length,
                      itemBuilder: (context, index) {
                        final subject = filteredSubjects[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          child: ListTile(
                            title: Text(subject),
                            subtitle: Text('PYQ for $selectedYear'),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.visibility),
                                  tooltip: 'View',
                                  onPressed: () => _viewPYQ(subject),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.download),
                                  tooltip: 'Download',
                                  onPressed: () => _downloadPYQ(subject),
                                ),
                              ],
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
