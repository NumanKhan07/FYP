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
      color: Colors.green.shade100,
      elevation: 2,
      child: ListTile(
        leading: const Icon(Icons.camera_alt, size: 40, color: Colors.green),
        title: const Text('Start Detection'),
        subtitle: const Text('Scan a tomato leaf for disease detection.'),
        trailing: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const DetectionScreen()),
            );
          },
          child: const Text('Go'),
        ),
      ),
    );
  }

  Widget _buildHistorySection() {
    return Card(
      elevation: 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          ListTile(
            leading: Icon(Icons.history, color: Colors.deepOrange),
            title: Text('Detection History'),
          ),
          Divider(),
          ListTile(
            title: Text('05 May 2025'),
            subtitle: Text('Result: Late Blight'),
          ),
          ListTile(
            title: Text('02 May 2025'),
            subtitle: Text('Result: Healthy'),
          ),
        ],
      ),
    );
  }

  Widget _buildTipsSection() {
    return Card(
      elevation: 2,
      child: ListTile(
        leading: const Icon(Icons.lightbulb, color: Colors.amber),
        title: const Text('Crop Tip of the Day'),
        subtitle: const Text('Avoid overhead irrigation during humid days to reduce blight spread.'),
      ),
    );
  }
}
