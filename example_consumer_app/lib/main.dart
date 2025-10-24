import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// Import kimapp packages
import 'package:kimapp/kimapp.dart';
import 'package:kimapp_utils/kimapp_utils.dart';
import 'package:kimapp_supabase_helper/kimapp_supabase_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Supabase (you'll need to configure these values)
  await Supabase.initialize(
    url: 'YOUR_SUPABASE_URL',
    anonKey: 'YOUR_SUPABASE_ANON_KEY',
  );

  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kimapp Packages Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kimapp Packages Example'),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Successfully using kimapp packages!',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            Text(
              '• kimapp core package ✓',
              style: TextStyle(color: Colors.green),
            ),
            Text(
              '• kimapp_utils package ✓',
              style: TextStyle(color: Colors.green),
            ),
            Text(
              '• kimapp_supabase_helper package ✓',
              style: TextStyle(color: Colors.green),
            ),
          ],
        ),
      ),
    );
  }
}