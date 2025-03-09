import 'package:flutter/material.dart';
import 'bottom.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'providers/auth_provider.dart';
import 'screens/auth/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyBaQqSbDQT1bWx2LAwgP79Nl9ZX1A4id60",
      appId: "1:320978960474:android:5b9f3df9718782800ed863",
      messagingSenderId: "320978960474",
      projectId: "ems-v1-8c580",
      storageBucket: "ems-v1-8c580.firebasestorage.app",
      // For Android, authDomain is not required. Firebase Auth will work without it.
      // When you get the authDomain, you can add it here:
      // authDomain: "your-project-id.firebaseapp.com",
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AuthProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: const Color(0xFF18181B),
          primaryColor: Colors.green,
        ),
        home: const LoginScreen(),
      ),
    );
  }
}

class PackageTrackerScreen extends StatelessWidget {
  const PackageTrackerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const CircleAvatar(
                          radius: 20,
                          backgroundImage:
                              NetworkImage('https://placeholder.com/40x40'),
                        ),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Stive Kote',
                              style: TextStyle(fontWeight: FontWeight.w500),
                            ),
                            Text(
                              '12 Jan 2024',
                              style: TextStyle(
                                color: Colors.grey[400],
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          '872',
                          style: TextStyle(
                            color: Colors.green[500],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'Coins',
                          style: TextStyle(color: Colors.grey[400]),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Search Bar
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[900],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: TextField(
                    style: TextStyle(
                        color: Colors.white), // Ensures text color is visible
                    decoration: InputDecoration(
                      hintText: 'Track Your Package',
                      hintStyle:
                          TextStyle(color: Colors.grey[400]), // Style hint text
                      prefixIcon: Icon(Icons.search, color: Colors.grey[400]),
                      suffixIcon: Icon(Icons.settings, color: Colors.grey[400]),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 14.0), // Adjust vertical alignment
                    ),
                  ),
                ),
              ),

              // Discount Card
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.green[600],
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Discount',
                            style: TextStyle(fontSize: 18),
                          ),
                          SizedBox(height: 4),
                          Text(
                            '20% OFF',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                              width: 60, height: 60, color: Colors.green[700]),
                          const SizedBox(width: 8),
                          Container(
                              width: 60, height: 60, color: Colors.green[700]),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              // Navigation Icons
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    {'label': 'Price', 'icon': Icons.attach_money},
                    {'label': 'Point', 'icon': Icons.location_on_outlined},
                    {'label': 'News', 'icon': Icons.article},
                    {'label': 'Info', 'icon': Icons.info},
                  ]
                      .map((item) => Column(
                            children: [
                              Container(
                                width: 48,
                                height: 48,
                                decoration: BoxDecoration(
                                  color: Colors.grey[800],
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(item['icon'] as IconData,
                                    color: Colors.grey[400]),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                item['label'].toString(),
                                style: TextStyle(
                                    color: Colors.grey[400], fontSize: 12),
                              ),
                            ],
                          ))
                      .toList(),
                ),
              ),

              // Recent Shipping
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Recent Shipping',
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                          GestureDetector(
                            onTap: () {
                              // Add your navigation or action here
                              debugPrint("See all clicked!");
                            },
                            child: Text(
                              'See all',
                              style: TextStyle(
                                  color: Colors.green[500], fontSize: 14),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Expanded(
                        child: ListView(
                          children: [
                            _buildShipmentItem(
                                'AX25H1J6', 'On the way', Colors.orange),
                            _buildShipmentItem(
                                'A153KOJ2', 'Completed', Colors.green),
                            _buildShipmentItem(
                                'A153KOJ2', 'Completed', Colors.green),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),

        // bottom navigation bar

        bottomNavigationBar: const BottomNavigation());
  }

  Widget _buildShipmentItem(String id, String status, Color statusColor) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[850],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.grey[800],
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.local_shipping, color: Colors.green[500]),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'ID NUMBER',
                  style: TextStyle(color: Colors.grey[400], fontSize: 12),
                ),
                const SizedBox(height: 2),
                Text(id, style: const TextStyle(fontWeight: FontWeight.w500)),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              border: Border.all(color: statusColor),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text(
              status,
              style: TextStyle(color: statusColor, fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }
}
