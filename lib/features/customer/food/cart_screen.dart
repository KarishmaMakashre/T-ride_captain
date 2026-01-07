// cart_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tryde_partner/core/constants/color_constants.dart';
import 'package:tryde_partner/dummy_api_data/food/model/meal_model.dart';
import 'package:tryde_partner/dummy_api_data/food/provider/food_provider.dart';

class CartScreen extends StatefulWidget {
  final Map<String, int> cart; // Passed from RestaurantScreen

  const CartScreen({
    super.key,
    required this.cart,
  });

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  String selectedDeliveryType = 'Standard'; // Default
  final Map<String, double> deliveryFees = {
    'Express': 29.0,
    'Standard': 19.0,
    'Eco Saver': 0.0,
  };
  final Map<String, Map<String, dynamic>> deliveryTypes = {
    'Express': {'time': '25-30 mins', 'desc': 'Fastest delivery, directly to you!'},
    'Standard': {'time': '30-35 mins', 'desc': 'Minimal order grouping'},
    'Eco Saver': {'time': '35-45 mins', 'desc': 'Lesser CO2 by order grouping'},
  };

  // Dummy total calculation
  double get subtotal => widget.cart.entries.fold(0.0, (sum, entry) {
    final meal = Provider.of<MealProvider>(context, listen: false).meals.firstWhere(
      (m) => m.strMeal == entry.key,
      orElse: () => Meal(strMeal: entry.key, strMealThumb: '', idMeal: ''),
    );
    return sum + (entry.value * 300.0); // Dummy price per item
  });

  double get deliveryFee => deliveryFees[selectedDeliveryType] ?? 19.0;
  double get total => subtotal + deliveryFee;
  double get savings => 10.0; // Dummy savings

  void _updateQuantity(String mealName, int change) {
    setState(() {
      if ((widget.cart[mealName] ?? 0) + change <= 0) {
        widget.cart.remove(mealName);
      } else {
        widget.cart[mealName] = (widget.cart[mealName] ?? 0) + change;
      }
      if (widget.cart.isEmpty) {
        Navigator.pop(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 18, color: AppColors.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Olio - The Wood Fired Pizzeria',
          style: TextStyle(fontWeight: FontWeight.w600, color: AppColors.textPrimary),
        ),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              // Handle menu options
            },
            itemBuilder: (context) => [
              const PopupMenuItem(value: 'Edit', child: Text('Edit')),
              const PopupMenuItem(value: 'Share', child: Text('Share')),
            ],
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(height: 1, color: AppColors.grey300),
        ),
        elevation: 0,
        backgroundColor: AppColors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Address Selector
            _buildAddressSelector(context),
            const SizedBox(height: 8),

            // Savings Banner
            _buildSavingsBanner(context),
            const SizedBox(height: 16),

            // Delivery Type Section
            _buildDeliveryTypeSection(context),
            const SizedBox(height: 16),

            // Cart Items
            if (widget.cart.isNotEmpty) ...[
              ...widget.cart.entries.map((entry) => _buildCartItem(context, entry.key, entry.value)).toList(),
              const SizedBox(height: 16),
            ],

            // Add One Subscription
            _buildAddOneSubscription(context),
            const SizedBox(height: 16),

            // Complete Your Meal
            _buildCompleteYourMeal(context),
            const SizedBox(height: 16),

            // Savings Corner
            _buildSavingsCorner(context),
            const SizedBox(height: 16),

            // Cancellation Policy
            _buildCancellationPolicy(context),
            const SizedBox(height: 24),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomBar(context),
    );
  }

  // Address Selector
  Widget _buildAddressSelector(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Icon(Icons.home, color: AppColors.textPrimary),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Home | Flt, Ratna Lok Colony, Indore, ...', style: TextStyle(fontWeight: FontWeight.w500)),
                Text('Change address', style: TextStyle(fontSize: 12, color: AppColors.textLight)),
              ],
            ),
          ),
          Icon(Icons.arrow_forward_ios, size: 16, color: AppColors.grey400),
        ],
      ),
    );
  }

  // Savings Banner
  Widget _buildSavingsBanner(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.success.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(Icons.savings, color: AppColors.success, size: 20),
          const SizedBox(width: 8),
          Expanded(child: Text('₹10 saved! Including delivery fee savings', style: TextStyle(fontWeight: FontWeight.w600))),
        ],
      ),
    );
  }

  // Delivery Type Section
  Widget _buildDeliveryTypeSection(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Text('Delivery Type', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
              Spacer(),
              Text('Tip', style: TextStyle(fontSize: 14, color: AppColors.textLight)),
              SizedBox(width: 8),
              Text('Instructions', style: TextStyle(fontSize: 14, color: AppColors.textLight)),
            ],
          ),
          const SizedBox(height: 16),
          ...deliveryTypes.keys.map((type) => RadioListTile<String>(
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(type),
                    Text(deliveryTypes[type]!['desc'], style: const TextStyle(fontSize: 12, color: AppColors.textLight)),
                  ],
                ),
                subtitle: Text(deliveryTypes[type]!['time']),
                secondary: Text('₹${deliveryFees[type]}'),
                value: type,
                groupValue: selectedDeliveryType,
                onChanged: (value) {
                  setState(() {
                    selectedDeliveryType = value!;
                  });
                },
                activeColor: type == 'Express' ? Colors.blue : type == 'Standard' ? Colors.orange : Colors.green,
              )),
        ],
      ),
    );
  }

  // Cart Item
  Widget _buildCartItem(BuildContext context, String mealName, int quantity) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.grey300),
      ),
      child: Row(
        children: [
          // Image placeholder
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: AppColors.grey200,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.restaurant, color: AppColors.grey400),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(mealName, style: const TextStyle(fontWeight: FontWeight.w600)),
                const Text('8 inch (Regular)', style: TextStyle(fontSize: 12, color: AppColors.textLight)),
                const SizedBox(height: 4),
                Row(
                  children: [
                    IconButton(
                      onPressed: () => _updateQuantity(mealName, -1),
                      icon: const Icon(Icons.remove, size: 16),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(minWidth: 24, minHeight: 24),
                    ),
                    Text('$quantity', style: const TextStyle(fontWeight: FontWeight.w600)),
                    IconButton(
                      onPressed: () => _updateQuantity(mealName, 1),
                      icon: const Icon(Icons.add, size: 16),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(minWidth: 24, minHeight: 24),
                    ),
                    const Spacer(),
                    Text('₹${quantity * 300}', style: const TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Add One Subscription
  Widget _buildAddOneSubscription(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.pink.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Add one at ₹1', style: TextStyle(fontWeight: FontWeight.w600)),
                const Text('Save ₹31 now & get 3 months of free deliveries >'),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {
              // Handle add subscription
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.foodPrimary,
              foregroundColor: Colors.white,
              minimumSize: const Size(80, 40),
            ),
            child: const Text('Add ₹1'),
          ),
        ],
      ),
    );
  }

  // Complete Your Meal
  Widget _buildCompleteYourMeal(BuildContext context) {
    final addOns = ['Signat - Garlic.. ₹245', 'Italia - Cheese.. ₹239', 'Peri-Peri Garlic.. ₹245', 'Popeye .. ₹245'];
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('COMPLETE YOUR MEAL', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
          const SizedBox(height: 12),
          Row(
            children: List.generate(4, (index) => Expanded(
              child: Column(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.pink.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.add, color: Colors.pink),
                  ),
                  const SizedBox(height: 8),
                  Text(addOns[index], style: const TextStyle(fontSize: 12), textAlign: TextAlign.center),
                ],
              ),
            )),
          ),
        ],
      ),
    );
  }

  // Savings Corner
  Widget _buildSavingsCorner(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('SAVINGS CORNER', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
          const SizedBox(height: 12),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.orange.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.local_offer, color: Colors.orange, size: 20),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Save ₹10 on this order + extra ₹30 on next order'),
                    const Text('View all coupons >', style: TextStyle(fontSize: 12, color: AppColors.textLight)),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  // Apply coupon
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(60, 32),
                ),
                child: const Text('Apply'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Cancellation Policy
  Widget _buildCancellationPolicy(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.grey100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Cancellation policy:', style: TextStyle(fontWeight: FontWeight.w600)),
          SizedBox(height: 8),
          Text('Please double-check your order and address details.'),
          Text('Orders are non-refundable once placed.'),
        ],
      ),
    );
  }

  // Bottom Bar
  Widget _buildBottomBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.success.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                const Icon(Icons.description, color: AppColors.success),
                const SizedBox(width: 8),
                Expanded(child: Text('To Pay ₹${total.toStringAsFixed(0)}')),
                const SizedBox(width: 8),
                Text('₹$savings saved on the total!', style: const TextStyle(color: AppColors.success)),
                const Icon(Icons.arrow_forward_ios, size: 12),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    // View detailed bill
                  },
                  child: const Text('View Detailed Bill'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                flex: 2,
                child: ElevatedButton(
                  onPressed: () {
                    // Proceed to pay
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Proceeding to payment...')),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.success,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  child: const Text('Proceed to Pay'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}