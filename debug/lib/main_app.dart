import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'screens/registration_screen.dart';
import 'screens/manager_dashboard_screen.dart';
import 'screens/client_dashboard_screen.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Donald GUI',
      debugShowCheckedModeBanner: false,
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegistrationScreen(),
        '/manager': (context) => const ManagerDashboardScreen(userName: 'מנהל'),
        '/client': (context) => const ClientDashboardScreen(userName: 'לקוח'),
      },
    );
  }
}
