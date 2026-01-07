import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:go_router/go_router.dart';

class RideFeedbackScreen extends StatefulWidget {
  const RideFeedbackScreen({super.key});

  @override
  State<RideFeedbackScreen> createState() => _RideFeedbackScreenState();
}

class _RideFeedbackScreenState extends State<RideFeedbackScreen> {
  double _rating = 5.0;
  final TextEditingController _feedbackController = TextEditingController();
  final List<String> _quickFeedbacks = [
    "Great driver!",
    "On time",
    "Clean vehicle",
    "Safe ride",
    "Friendly"
  ];
  List<String> _selectedFeedbacks = [];

  @override
  void dispose() {
    _feedbackController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Rate Your Ride"),
        automaticallyImplyLeading: false,
        actions: [
          TextButton(
            onPressed: () => context.go('/home'),
            child: const Text("Skip", style: TextStyle(color: Colors.grey)),
          ),
        ],
      ),
      body: SingleChildScrollView(  // ← यही मुख्य fix है
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/images/rider_image.jpg'),
            ),
            const SizedBox(height: 16),
            const Text("Akash Raghu", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const Text("Hero Passion Pro • MP13 DR 3986", style: TextStyle(color: Colors.grey)),

            const SizedBox(height: 32),

            const Text("How was your ride?", style: TextStyle(fontSize: 20)),
            const SizedBox(height: 16),

            RatingBar.builder(
              initialRating: 5,
              minRating: 1,
              direction: Axis.horizontal,
              itemCount: 5,
              itemSize: 50,
              itemBuilder: (context, _) => const Icon(Icons.star, color: Colors.amber),
              onRatingUpdate: (rating) => setState(() => _rating = rating),
            ),

            const SizedBox(height: 32),

            // Quick Feedback Chips
            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: _quickFeedbacks.map((feedback) {
                final isSelected = _selectedFeedbacks.contains(feedback);
                return FilterChip(
                  label: Text(feedback),
                  selected: isSelected,
                  onSelected: (selected) {
                    setState(() {
                      if (selected) {
                        _selectedFeedbacks.add(feedback);
                      } else {
                        _selectedFeedbacks.remove(feedback);
                      }
                    });
                  },
                );
              }).toList(),
            ),

            const SizedBox(height: 24),

            TextField(
              controller: _feedbackController,
              maxLines: 4,
              decoration: const InputDecoration(
                hintText: "Share more details (optional)",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 40),  // Submit button के लिए space

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: Colors.green,
                ),
                onPressed: () {
                  debugPrint("Rating: $_rating, Feedback: ${_feedbackController.text}, Quick: $_selectedFeedbacks");
                  context.go('/home');
                },
                child: const Text("Submit Feedback", style: TextStyle(fontSize: 18, color: Colors.white)),
              ),
            ),

            const SizedBox(height: 20),  // Bottom safe space
          ],
        ),
      ),
    );
  }
}