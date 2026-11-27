/*import 'package:flutter/material.dart';

import 'features/lobby/home_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const AbsurdApp());
}

class AbsurdApp extends StatelessWidget {
  const AbsurdApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Absurd APP',
      home: HomeScreen(),
    );
  }
}
*/
import 'package:flutter/material.dart';

import 'core/theme/app_theme.dart';
import 'features/lobby/data/mock_lobby_controller.dart';
import 'features/lobby/home_screen.dart';

void main() {
  runApp(const AbsurdApp());
}

class AbsurdApp extends StatefulWidget {
  const AbsurdApp({super.key});

  @override
  State<AbsurdApp> createState() => _AbsurdAppState();
}

class _AbsurdAppState extends State<AbsurdApp> {
  final MockLobbyController _lobbyController = MockLobbyController();

  @override
  void dispose() {
    _lobbyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Absurd APP',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: HomeScreen(controller: _lobbyController),
    );
  }
}
