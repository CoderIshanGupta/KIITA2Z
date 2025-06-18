import 'package:flutter/material.dart';

class RidePost {
  final String destination;
  final String pickupLocation;
  final String dateTime;
  final int seatsAvailable;
  final String contact;

  RidePost({
    required this.destination,
    required this.pickupLocation,
    required this.dateTime,
    required this.seatsAvailable,
    required this.contact,
  });
}

class RideSharingPage extends StatefulWidget {
  const RideSharingPage({Key? key}) : super(key: key);

  @override
  State<RideSharingPage> createState() => _RideSharingPageState();
}

class _RideSharingPageState extends State<RideSharingPage> {
  final List<RidePost> rides = [
    RidePost(
      destination: 'Puri',
      pickupLocation: 'Main Gate, KIIT',
      dateTime: '2025-06-11 07:00 AM',
      seatsAvailable: 2,
      contact: '+91 9876543210',
    ),
    RidePost(
      destination: 'Bhubaneswar Airport',
      pickupLocation: 'Campus 6',
      dateTime: '2025-06-11 10:00 AM',
      seatsAvailable: 1,
      contact: '+91 9123456780',
    ),
  ];

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _destinationController = TextEditingController();
  final TextEditingController _pickupController = TextEditingController();
  final TextEditingController _dateTimeController = TextEditingController();
  final TextEditingController _seatsController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();

  String searchQuery = '';
  List<RidePost> filteredRides = [];

  @override
  void initState() {
    super.initState();
    filteredRides = rides;
  }

  void _searchRides(String query) {
    setState(() {
      searchQuery = query;
      filteredRides = rides
          .where((ride) =>
              ride.destination.toLowerCase().contains(query.toLowerCase()) ||
              ride.pickupLocation.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  void _submitRidePost() {
    if (_formKey.currentState!.validate()) {
      final newRide = RidePost(
        destination: _destinationController.text.trim(),
        pickupLocation: _pickupController.text.trim(),
        dateTime: _dateTimeController.text.trim(),
        seatsAvailable: int.parse(_seatsController.text.trim()),
        contact: _contactController.text.trim(),
      );

      setState(() {
        rides.insert(0, newRide);
        filteredRides = List.from(rides);
      });

      _destinationController.clear();
      _pickupController.clear();
      _dateTimeController.clear();
      _seatsController.clear();
      _contactController.clear();

      Navigator.of(context).pop();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Ride posted successfully")),
      );
    }
  }

  void _showPostRideDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Post a Ride'),
        content: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                _buildTextField(_destinationController, 'Destination'),
                const SizedBox(height: 10),
                _buildTextField(_pickupController, 'Pickup Location'),
                const SizedBox(height: 10),
                _buildTextField(_dateTimeController, 'Date & Time'),
                const SizedBox(height: 10),
                _buildTextField(_seatsController, 'Seats Available',
                    isNumber: true),
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
            onPressed: _submitRidePost,
            child: const Text('Post'),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label,
      {bool isNumber = false}) {
    return TextFormField(
      controller: controller,
      validator: (val) => val == null || val.isEmpty ? 'Required' : null,
      keyboardType: isNumber ? TextInputType.number : TextInputType.text,
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
        title: const Text('Ride Sharing'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_circle),
            tooltip: 'Post a Ride',
            onPressed: _showPostRideDialog,
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: const InputDecoration(
                labelText: 'Search by Destination or Pickup',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: _searchRides,
            ),
          ),
          Expanded(
            child: filteredRides.isEmpty
                ? const Center(child: Text('No rides found.'))
                : ListView.builder(
                    itemCount: filteredRides.length,
                    itemBuilder: (context, index) {
                      final ride = filteredRides[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        child: ListTile(
                          title: Text(ride.destination),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Pickup: ${ride.pickupLocation}'),
                              Text('Date & Time: ${ride.dateTime}'),
                              Text('Seats Available: ${ride.seatsAvailable}'),
                              Text('Contact: ${ride.contact}'),
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
