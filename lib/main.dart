import 'dart:async';
import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/ringing_screen.dart';
import 'services/database_service.dart';

import 'package:alarm/alarm.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseService.initialize();
  await Alarm.init();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  StreamSubscription<dynamic>? ringSubscription;
  bool isRingingScreenPushed = false;

  @override
  void initState() {
    super.initState();
    // Alarm.ringStream is deprecated, using Alarm.ringing instead
    // Note: since Alarm.ringing returns an AlarmSet, we just listen to it
    // and if there's any active alarm, we push the screen.
    ringSubscription = Alarm.ringing.listen((alarmSet) {
      if (alarmSet.alarms.isNotEmpty && !isRingingScreenPushed) {
        isRingingScreenPushed = true;
        _navigateToRingingScreen();
      } else if (alarmSet.alarms.isEmpty) {
        isRingingScreenPushed = false;
      }
    });
  }

  void _navigateToRingingScreen() {
    if (navigatorKey.currentState == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _navigateToRingingScreen();
      });
      return;
    }
    navigatorKey.currentState?.push(
      MaterialPageRoute(builder: (context) => const RingingScreen()),
    );
  }

  @override
  void dispose() {
    ringSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      title: 'QR Alarm',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
        colorScheme: const ColorScheme.dark(
          primary: Colors.orange,
          secondary: Colors.orangeAccent,
          surface: Color(0xFF1C1C1E),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}
