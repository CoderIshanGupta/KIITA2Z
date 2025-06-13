import 'package:flutter/material.dart';
import 'dart:math';

class LostItem {
  final String title;
  final String description;
  final String location;
  final String date;
  final String contact;

  LostItem({
    required this.title,
    required this.description,
    required this.location,
    required this.date,
    required this.contact,
  });
}

class LostFoundPage extends StatefulWidget {
  const LostFoundPage({Key? key}) : super(key: key);

  @override
  State<LostFoundPage> createState() => _LostFoundPageState();
}

class _LostFoundPageState extends State<LostFoundPage> {
  final List<LostItem> reportedItems = [
    LostItem(
      title: 'Black Wallet',
      description: 'Found near CSE Block. Contains some cards.',
      location: 'CSE Block',
      date: '2025-06-08',
      contact: '+91 9876543210',
    ),
    LostItem(
      title: 'Red Water Bottle',
      description: 'Found on the 3rd floor of Admin Block.',
      location: 'Admin Block',
      date: '2025-06-09',
      contact: '+91 9123456780',
    ),
  ];

  final _formKey = GlobalKey<FormState>();
  String searchQuery = '';
  List<LostItem> filteredItems = [];

  // Form fields
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredItems = reportedItems;
  }

  void _searchItems(String query) {
    setState(() {
      searchQuery = query;
      filteredItems = reportedItems
          .where((item) =>
              item.title.toLowerCase().contains(query.toLowerCase()) ||
              item.description.toLowerCase().contains(query.toLowerCase()) ||
              item.location.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  void _submitLostItem() {
    if (_formKey.currentState!.validate()) {
      final newItem = LostItem(
        title: _titleController.text.trim(),
        description: _descController.text.trim(),
        location: _locationController.text.trim(),
        date: DateTime.now().toString().split(' ').first,
        contact: _contactController.text.trim(),
      );

      setState(() {
        reportedItems.insert(0, newItem);
        filteredItems = List.from(reportedItems);
      });

      Navigator.of(context).pop();

      _titleController.clear();
      _descController.clear();
      _locationController.clear();
      _contactController.clear();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Item reported successfully")),
      );
    }
  }

  void _showReportDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Report Found Item'),
        content: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                _buildTextField(_titleController, 'Title'),
                const SizedBox(height: 10),
                _buildTextField(_descController, 'Description'),
                const SizedBox(height: 10),
                _buildTextField(_locationController, 'Location'),
                const SizedBox(height: 10),
                _buildTextField(_contactController, 'Contact Info'),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: _submitLostItem,
            child: const Text('Submit'),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label) {
    return TextFormField(
      controller: controller,
      validator: (val) => val == null || val.isEmpty ? 'Required' : null,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lost & Found'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            tooltip: 'Report Found Item',
            onPressed: _showReportDialog,
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: const InputDecoration(
                labelText: 'Search Lost Items',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: _searchItems,
            ),
          ),
          Expanded(
            child: filteredItems.isEmpty
                ? const Center(child: Text('No matching items found.'))
                : ListView.builder(
                    itemCount: filteredItems.length,
                    itemBuilder: (context, index) {
                      final item = filteredItems[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        child: ListTile(
                          title: Text(item.title),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(item.description),
                              Text('Location: ${item.location}'),
                              Text('Date: ${item.date}'),
                              Text('Contact: ${item.contact}'),
                            ],
                          ),
                          isThreeLine: true,
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
