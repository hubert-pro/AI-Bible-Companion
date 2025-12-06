import 'package:flutter/material.dart';
import 'package:ai_bible_companion/services/service_provider.dart';
import 'package:ai_bible_companion/services/theme_service.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late ThemeService _themeService;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _themeService = ServiceProvider.of(context)!.themeService;
    _themeService.addListener(_onThemeChanged);
  }

  @override
  void dispose() {
    _themeService.removeListener(_onThemeChanged);
    super.dispose();
  }

  void _onThemeChanged() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            ListTile(
              title: const Text('Dark Mode'),
              trailing: Switch(
                value: _themeService.themeMode == ThemeMode.dark,
                onChanged: (value) {
                  _themeService.toggleTheme();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
