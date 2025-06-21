import 'package:flutter/material.dart';
import 'package:kiita2z/services/local_storage_service.dart';

class PlanSyncPage extends StatefulWidget {
  const PlanSyncPage({Key? key}) : super(key: key);

  @override
  State<PlanSyncPage> createState() => _PlanSyncPageState();
}

class _PlanSyncPageState extends State<PlanSyncPage> {
  final List<String> years = ['2023-24', '2024-25', '2025-26'];
  final List<String> semesters = ['1st', '2nd', '3rd', '4th', '5th', '6th', '7th', '8th'];
  final List<String> branches = ['CSE', 'IT', 'CSSE', 'CSSC'];

  String? selectedYear;
  String? selectedSemester;
  String? selectedBranch;
  String? selectedSection;

  List<String> sectionList = [];

  @override
  void initState() {
    super.initState();
    _loadSavedPreferences();
  }

  Future<void> _loadSavedPreferences() async {
    final prefs = await LocalStorageService.getPlanSyncPrefs();
    setState(() {
      selectedYear = prefs['year'];
      selectedSemester = prefs['semester'];
      selectedBranch = prefs['branch'];
      selectedSection = prefs['section'];
      _updateSections();
    });
  }

  void _updateSections() {
    if (selectedBranch == null) {
      sectionList = [];
    } else {
      int count = 1;
      switch (selectedBranch) {
        case 'CSE':
          count = 50;
          break;
        case 'IT':
          count = 5;
          break;
        case 'CSSE':
          count = 3;
          break;
        case 'CSSC':
          count = 3;
          break;
      }
      sectionList = List.generate(count, (i) => '${selectedBranch!}-${i + 1}');
    }
  }

  Future<void> _savePreferences() async {
    if (selectedYear != null &&
        selectedSemester != null &&
        selectedBranch != null &&
        selectedSection != null) {
      await LocalStorageService.savePlanSyncPrefs({
        'year': selectedYear!,
        'semester': selectedSemester!,
        'branch': selectedBranch!,
        'section': selectedSection!,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Preferences saved successfully")),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill all fields")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    _updateSections(); // Keep section list synced

    return Scaffold(
      appBar: AppBar(title: const Text('Plan Sync')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildDropdown('Select Academic Year', years, selectedYear, (value) {
              setState(() => selectedYear = value);
            }),
            _buildDropdown('Select Semester', semesters, selectedSemester, (value) {
              setState(() => selectedSemester = value);
            }),
            _buildDropdown('Select Branch', branches, selectedBranch, (value) {
              setState(() {
                selectedBranch = value;
                selectedSection = null;
              });
            }),
            _buildDropdown('Select Section', sectionList, selectedSection, (value) {
              setState(() => selectedSection = value);
            }),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              icon: const Icon(Icons.save),
              label: const Text("Save Preferences"),
              onPressed: _savePreferences,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdown(
    String hint,
    List<String> items,
    String? selectedValue,
    Function(String?) onChanged,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: DropdownButtonFormField<String>(
        value: selectedValue,
        decoration: InputDecoration(
          labelText: hint,
          border: const OutlineInputBorder(),
        ),
        items: items.map((item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Text(item),
          );
        }).toList(),
        onChanged: onChanged,
      ),
    );
  }
}
