import 'package:flutter/material.dart';
import 'dashboard_page.dart';
import 'pages/pyq_page.dart';
import 'pages/notes_page.dart';
import 'pages/faculty_review_page.dart';
import 'pages/plan_sync_page.dart';
import 'pages/lost_found_page.dart';
import 'pages/ride_sharing_page.dart';
import 'pages/profile_page.dart';
import 'pages/settings_page.dart';
import 'pages/edit_profile_page.dart';

void main() {
  runApp(const KIITA2ZApp());
}

class KIITA2ZApp extends StatelessWidget {
  const KIITA2ZApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'KIITA2Z',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const DashboardPage(),
      routes: {
        '/pyq': (context) => PYQPage(),
        '/notes': (context) => NotesPage(),
        '/facultyReview': (context) => const FacultyReviewPage(),
        '/planSync': (context) => const PlanSyncPage(),
        '/lostFound': (context) => const LostFoundPage(),
        '/rideSharing': (context) => const RideSharingPage(),
        '/profile': (context) => ProfilePage(),
        '/settings': (context) => const SettingsPage(),
        '/editProfile': (context) => const EditProfilePage(),
      },
    );
  }
}
