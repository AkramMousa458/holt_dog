import 'package:flutter/material.dart';

class ResultsScreen extends StatelessWidget {
  const ResultsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> results = [
      {
        'dog_name': 'Buddy',
        'predicted_mood': 'Happy',
        'predicted_disease': 'None',
        'disease_confidence': '96',
      },
      {
        'dog_name': 'Max',
        'predicted_mood': 'Calm',
        'predicted_disease': 'Mild Dermatitis',
        'disease_confidence': '88',
      },
      {
        'dog_name': 'Bella',
        'predicted_mood': 'Anxious',
        'predicted_disease': 'Fungal Infection',
        'disease_confidence': '91',
      },
    ];

    return Scaffold(
      appBar: AppBar(title: const Text("Analysis Results")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView.separated(
          itemCount: results.length + 1,
          separatorBuilder: (_, __) => const SizedBox(height: 14),
          itemBuilder: (context, index) {
            if (index == 0) {
              return const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "AI Predictions:",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  Divider(),
                  SizedBox(height: 8),
                ],
              );
            }

            final result = results[index - 1];
            return _buildResultItemCard(result);
          },
        ),
      ),
    );
  }

  Widget _buildResultItemCard(Map<String, String> result) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        child: Column(
          children: [
            ListTile(
              leading:
                  const Icon(Icons.pets, color: Colors.deepOrange, size: 30),
              title: const Text(
                'Dog Name',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                result['dog_name'] ?? '-',
                style: const TextStyle(fontSize: 18, color: Colors.black87),
              ),
            ),
            _buildResultCard(
                "Dog Mood", result['predicted_mood'] ?? '-', Icons.mood),
            _buildResultCard(
              "Skin Condition",
              result['predicted_disease'] ?? '-',
              Icons.health_and_safety,
            ),
            _buildResultCard(
              "Confidence",
              "${result['disease_confidence'] ?? '-'}%",
              Icons.check_circle_outline,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResultCard(String title, String value, IconData icon) {
    return ListTile(
      leading: Icon(icon, color: Colors.orange, size: 30),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(
        value,
        style: const TextStyle(fontSize: 18, color: Colors.black87),
      ),
    );
  }
}
