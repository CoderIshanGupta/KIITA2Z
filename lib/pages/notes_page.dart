import 'package:flutter/material.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({Key? key}) : super(key: key);

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  final List<String> academicYears = ['1st Year', '2nd Year', '3rd Year', '4th Year'];
  final List<String> allSubjects = [
    'Data Structures',
    'Computer Networks',
    'Operating Systems',
    'DBMS',
    'Mathematics',
    'OOPs',
    'AI & ML',
    'CN Lab'
  ];

  String? selectedYear;
  String searchQuery = '';
  List<String> filteredSubjects = [];

  @override
  void initState() {
    super.initState();
    filteredSubjects = allSubjects;
  }

  void _filterSubjects(String query) {
    setState(() {
      searchQuery = query;
      filteredSubjects = allSubjects
          .where((subject) =>
              subject.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  void _viewNote(String subject) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Viewing notes for $subject')),
    );
    // TODO: Add file viewer or open PDF/PPT
  }

  void _downloadNote(String subject) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Downloading notes for $subject')),
    );
    // TODO: Add file download functionality
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes'),
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
              items: academicYears.map((year) {
                return DropdownMenuItem(
                  value: year,
                  child: Text(year),
                );
              }).toList(),
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
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: _filterSubjects,
            ),
            const SizedBox(height: 16),
            Expanded(
              child: selectedYear == null
                  ? const Center(
                      child: Text(
                        'Please select an academic year to view notes.',
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
                            subtitle: Text('Notes for $selectedYear'),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.visibility),
                                  tooltip: 'View',
                                  onPressed: () => _viewNote(subject),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.download),
                                  tooltip: 'Download',
                                  onPressed: () => _downloadNote(subject),
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
