import 'package:flutter/material.dart';
import 'detection_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dashboard')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildWeatherCard(),
            const SizedBox(height: 16),
            _buildDetectCard(context),
            const SizedBox(height: 16),
            _buildHistorySection(),
            const SizedBox(height: 16),
            _buildTipsSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildWeatherCard() {
    return Card(
      elevation: 3,
      child: ListTile(
        leading: const Icon(Icons.cloud, size: 40, color: Colors.blue),
        title: const Text('Current Weather'),
        subtitle: const Text('Temp: 26°C, Humidity: 70%\nRain: Likely today'),
        trailing: IconButton(
          icon: const Icon(Icons.refresh),
          onPressed: () {
            // Future: add weather API
          },
        ),
      ),
    );
  }

  Widget _buildDetectCard(BuildContext context) {
    return Card(

