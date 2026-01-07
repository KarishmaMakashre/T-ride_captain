// porter_submit_order_screen.dart (Fixed bottom overflow issue)

import 'package:flutter/material.dart';
import 'package:tryde_partner/core/constants/color_constants.dart';

class PorterSubmitOrderScreen extends StatelessWidget {
  const PorterSubmitOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text("Submit Order", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
      ),
      // Wrap body in SafeArea + SingleChildScrollView to prevent overflow
      body: SafeArea(
        child: Column(
          children: [
            // Main scrollable content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Success Message
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.porterPrimaryLight.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Text(
                        "There are few free couriers now. As soon as\nSomeone is free, we will immediately arrive.",
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // What's in it
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.porterPrimary,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text("What's in it: Cloth", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                          SizedBox(height: 4),
                          Text("Up to 1kg, 2-Wheeler", style: TextStyle(color: Colors.white70)),
                          SizedBox(height: 4),
                          Text("Payment in cash", style: TextStyle(color: Colors.white70)),
                          SizedBox(height: 4),
                          Text("What's in it: Cloth", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),

                    const SizedBox(height: 30),

                    // From & To Addresses
                    const Text("From", style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    _buildAddressCard(
                      number: "1",
                      address: "177, Extension, Gulmohar Extension, Telephone Nagar, Indore, Madhya Pradesh 452018, India",
                      phone: "+91 8888888888",
                      name: "Renuka Agrawal",
                    ),

                    const SizedBox(height: 20),

                    const Text("To", style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    _buildAddressCard(
                      number: "2",
                      address: "301, Vijay Nagar Square, near Vedanta Hospital, Ratna Lok Colony, Indore, Madhya Pradesh 452010, India",
                      phone: "+91 8888888888",
                      name: "Renuka Agrawal",
                      note: "Payment at this address",
                    ),

                    const SizedBox(height: 20), // Extra space before bottom
                  ],
                ),
              ),
            ),

            // Fixed Bottom Bar (outside scroll view)
            Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: AppColors.white,
                boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, -2))],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      const Text("₹ 45", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                      const Spacer(),
                      ElevatedButton(
                        onPressed: () {
                          // Final submit logic
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.porterPrimary,
                          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                        ),
                        child: const Text("Create order", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Pressing “Create order”, I approve Terms of use of the product and Privacy Policy",
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAddressCard({
    required String number,
    required String address,
    required String phone,
    required String name,
    String? note,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.grey300),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 18,
            backgroundColor: AppColors.porterPrimary,
            child: Text(number, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(address, style: const TextStyle(fontSize: 14)),
                const SizedBox(height: 4),
                Text("$name • $phone", style: const TextStyle(color: Colors.grey, fontSize: 13)),
                if (note != null) ...[
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.grey100,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(note, style: const TextStyle(fontSize: 12)),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}