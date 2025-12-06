import 'package:flutter/material.dart';
import 'package:ai_bible_companion/services/service_provider.dart';
import 'package:ai_bible_companion/services/connectivity_service.dart';

class ConnectivityStatusPage extends StatefulWidget {
  const ConnectivityStatusPage({Key? key}) : super(key: key);

  @override
  State<ConnectivityStatusPage> createState() => _ConnectivityStatusPageState();
}

class _ConnectivityStatusPageState extends State<ConnectivityStatusPage> {
  late ConnectivityService _connectivityService;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _connectivityService = ServiceProvider.of(context)!.connectivityService;
    _connectivityService.addListener(_onConnectivityChanged);
  }

  @override
  void dispose() {
    _connectivityService.removeListener(_onConnectivityChanged);
    super.dispose();
  }

  void _onConnectivityChanged() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final isConnected = _connectivityService.isConnected;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              isConnected ? Icons.wifi : Icons.wifi_off,
              size: 100,
              color: isConnected ? Colors.green : Colors.red,
            ),
            const SizedBox(height: 24.0),
            Text(
              isConnected ? 'Connected' : 'Disconnected',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 48.0),
            ElevatedButton(
              onPressed: () {
                _connectivityService.toggleConnection();
              },
              child: const Text('Toggle Connection'),
            ),
          ],
        ),
      ),
    );
  }
}
