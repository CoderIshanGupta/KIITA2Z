import 'package:flutter/material.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _selectedIndex = 3; // Home is center, index 3

  final List<_NavItem> _navItems = [
    _NavItem('PYQ', Icons.book, '/pyq'),
    _NavItem('Notes', Icons.note, '/notes'),
    _NavItem('Faculty', Icons.reviews, '/facultyReview'),
    _NavItem('Home', Icons.home, '/dashboard'),
    _NavItem('Plan Sync', Icons.schedule, '/planSync'),
    _NavItem('Lost & Found', Icons.search, '/lostFound'),
    _NavItem('Ride Share', Icons.directions_car, '/rideSharing'),
  ];

  void _onNavTap(int index) {
    setState(() {
      _selectedIndex = index;
    });

    // Don't navigate again if already on Home
    if (_navItems[index].route != '/dashboard') {
      Navigator.pushNamed(context, _navItems[index].route);
    }
  }

  void _logout() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Logged out')),
    );
    // TODO: Implement logout logic
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_navItems[_selectedIndex].label),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: _logout,
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              accountName: const Text("John Doe"),
              accountEmail: const Text("john.doe@example.com"),
              currentAccountPicture: const CircleAvatar(
                backgroundImage: AssetImage('assets/profile.jpg'),
              ),
              decoration: const BoxDecoration(color: Colors.blue),
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text("Profile"),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/profile');
              },
            ),
            const Divider(),
            ..._navItems.where((item) => item.label != 'Home').map((item) {
              return ListTile(
                leading: Icon(item.icon),
                title: Text(item.label),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, item.route);
                },
              );
            }).toList(),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text("Settings"),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/settings');
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text("Logout"),
              onTap: () {
                Navigator.pop(context);
                _logout();
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Text(
          'Welcome to KIITA2Z!',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onNavTap,
        type: BottomNavigationBarType.fixed,
        items: [
          _navItemToBar(_navItems[0]),
          _navItemToBar(_navItems[1]),
          _navItemToBar(_navItems[2]),
          _navItemToBar(_navItems[3]), // HOME (center)
          _navItemToBar(_navItems[4]),
          _navItemToBar(_navItems[5]),
          _navItemToBar(_navItems[6]),
        ],
      ),
    );
  }

  BottomNavigationBarItem _navItemToBar(_NavItem item) {
    return BottomNavigationBarItem(
      icon: Icon(item.icon),
      label: item.label,
    );
  }
}

class _NavItem {
  final String label;
  final IconData icon;
  final String route;

  _NavItem(this.label, this.icon, this.route);
}
