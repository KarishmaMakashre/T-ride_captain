import 'package:flutter/material.dart';
import 'package:tryde_partner/features/rider/ten.dart';

class RatePassengerScreen extends StatefulWidget {
  const RatePassengerScreen({super.key});

  @override
  State<RatePassengerScreen> createState() => _RatePassengerScreenState();
}

class _RatePassengerScreenState extends State<RatePassengerScreen> {
  int rating = 5;
  final TextEditingController feedbackCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Rate Passenger")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text(
              "How was your passenger?",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (i) {
                return IconButton(
                  icon: Icon(
                    Icons.star,
                    size: 36,
                    color: i < rating ? Colors.orange : Colors.grey,
                  ),
                  onPressed: () => setState(() => rating = i + 1),
                );
              }),
            ),

            TextField(
              controller: feedbackCtrl,
              maxLines: 3,
              decoration: const InputDecoration(
                hintText: "Optional feedback",
                border: OutlineInputBorder(),
              ),
            ),

            const Spacer(),

            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const EarningsUpdatedScreen(),
                  ),
                );
              },
              child: const Text("Submit Rating"),
            ),
          ],
        ),
      ),
    );
  }
}
