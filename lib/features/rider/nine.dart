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

  final List<String> tags = [
    "Polite",
    "On time",
    "Good location",
    "Late",
    "Wrong pickup",
  ];

  final Set<String> selectedTags = {};

  @override
  void dispose() {
    feedbackCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
          /// 🖼️ BACKGROUND IMAGE
          Positioned.fill(
            child: Image.asset(
              'assets/images/topHeaderImage.png',
              fit: BoxFit.cover,
            ),
          ),

          /// 🔲 OVERLAY (optional but recommended)
          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(0.10),
            ),
          ),
          /// 🧱 MAIN UI
          SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        /// 🔙 Back + Title
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () => Navigator.pop(context),
                              child: const Icon(Icons.arrow_back, color: Colors.black,),
                            ),
                            const SizedBox(width: 12),
                            const Text(
                              "Rate Passenger",
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                              ),
                            )
                          ],
                        ),

                        const SizedBox(height: 24),

                        /// 👤 Passenger Card
                        Container(
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Row(
                            children: const [
                              CircleAvatar(
                                radius: 26,
                                backgroundImage: NetworkImage(
                                  "https://randomuser.me/api/portraits/men/32.jpg",
                                ),
                              ),
                              SizedBox(width: 14),
                              Text(
                                "Rahul Sharma",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 24),

                        /// ⭐ Question
                        const Text(
                          "How was your passenger?",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),

                        const SizedBox(height: 16),

                        /// ⭐ Rating Stars
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(5, (i) {
                            return IconButton(
                              icon: Icon(
                                Icons.star,
                                size: 36,
                                color: i < rating
                                    ? Colors.orange
                                    : Colors.grey.shade300,
                              ),
                              onPressed: () =>
                                  setState(() => rating = i + 1),
                            );
                          }),
                        ),

                        const Center(
                          child: Text(
                            "Excellent experience",
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),

                        const SizedBox(height: 20),

                        /// 🏷 Feedback Chips
                        Wrap(
                          spacing: 10,
                          runSpacing: 10,
                          children: tags.map((tag) {
                            final selected =
                            selectedTags.contains(tag);
                            return ChoiceChip(
                              label: Text(tag),
                              selected: selected,
                              onSelected: (_) {
                                setState(() {
                                  selected
                                      ? selectedTags.remove(tag)
                                      : selectedTags.add(tag);
                                });
                              },
                              selectedColor:
                              Colors.green.withOpacity(.15),
                              labelStyle: TextStyle(
                                color: selected
                                    ? Colors.green
                                    : Colors.black,
                              ),
                              side: BorderSide(
                                color: selected
                                    ? Colors.green
                                    : Colors.grey.shade300,
                              ),
                              backgroundColor: Colors.white,
                            );
                          }).toList(),
                        ),

                        const SizedBox(height: 24),

                        /// ✍ Feedback Field
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                                color: Colors.grey.shade300),
                          ),
                          child: TextField(
                            controller: feedbackCtrl,
                            maxLines: 5,
                            decoration: const InputDecoration(
                              hintText:
                              "Additional feedback (optional)",
                              border: InputBorder.none,
                            ),
                          ),
                        ),

                        const SizedBox(height: 20),

                        /// 🖼 Image
                        ClipRRect(
                          borderRadius: BorderRadius.circular(14),
                          child: Image.network(
                            "https://images.unsplash.com/photo-1520975916090-3105956dac38",
                            height: w * 0.45,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),

                        const SizedBox(height: 80),
                      ],
                    ),
                  ),
                ),

                /// ✅ FIXED BOTTOM BUTTON
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                            const EarningsUpdatedScreen(),
                          ),
                        );
                      },
                      child: const Text(
                        "Submit Rating",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
