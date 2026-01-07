import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tryde_partner/core/constants/color_constants.dart';
import 'package:tryde_partner/dummy_api_data/food/model/meal_model.dart';
import 'package:tryde_partner/dummy_api_data/food/provider/food_provider.dart';
import 'package:tryde_partner/features/customer/food/cart_screen.dart';

class RestaurantScreen extends StatefulWidget {
  final Meal selectedMeal; // Passed from dashboard tap

  const RestaurantScreen({
    super.key,
    required this.selectedMeal,
  });

  @override
  State<RestaurantScreen> createState() => _RestaurantScreenState();
}

class _RestaurantScreenState extends State<RestaurantScreen> {
  bool isVegSelected = false; // Initially unchecked
  bool isNonVegSelected = false; // Initially unchecked
  Map<String, int> cart = {}; // Dynamic cart: meal name -> quantity

  void _addToCart(Meal meal) {
    setState(() {
      cart[meal.strMeal] = (cart[meal.strMeal] ?? 0) + 1;
    });
  }

  int get totalItems => cart.values.fold(0, (sum, count) => sum + count);

  @override
  void initState() {
    super.initState();
    // Load meals for menu (reuse Indian area for dummy restaurant menu)
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<MealProvider>(context, listen: false);
      if (provider.meals.isEmpty) {
        provider.loadMealsByArea('Indian');
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
          'Haldiram\'s Restaurant • 15-20',
          style: TextStyle(fontWeight: FontWeight.w600, color: AppColors.textPrimary),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, size: 20, color: AppColors.textPrimary),
            onPressed: () {
              // Handle search
            },
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(height: 1, color: AppColors.grey300),
        ),
        elevation: 0,
        backgroundColor: AppColors.white,
      ),
      body: Consumer<MealProvider>(
        builder: (context, provider, child) {
          if (provider.isLoadingMeals && provider.meals.isEmpty) {
            return const Center(child: CircularProgressIndicator(color: AppColors.foodPrimary));
          }
          if (provider.errorMeals != null) {
            return Center(child: Text('Error: ${provider.errorMeals}', style: TextStyle(color: AppColors.error)));
          }
          final meals = provider.meals; // Use loaded meals as dummy dishes
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Restaurant Ad Block (Enhanced to match screenshot)
                _buildRestaurantAdBlock(context),
                const SizedBox(height: 16),

                // Veg/NonVeg Filters and Bolt
                _buildFiltersAndBolt(context),
                const SizedBox(height: 16),

                // Top Picks Section (Now Horizontal Scroll)
                _buildTopPicks(context, meals),
                const SizedBox(height: 16),

                // Suggestions by Top Foodies Section (Now Horizontal Scroll)
                _buildSuggestionsSection(context, meals),
                const SizedBox(height: 16),

                // Additional sections if needed (e.g., Combos, Recommended) - based on screenshots
                _buildCombosSection(context, meals.skip(8).take(2).toList()),
                const SizedBox(height: 16),

                _buildRecommendedSection(context, meals.skip(10).take(4).toList()),
                const SizedBox(height: 16),

                _build99StoreSection(context, meals.skip(14).take(2).toList()),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: _buildCartSummary(context),
    );
  }

  // Enhanced: Restaurant Ad Block (Promotional Card like Swiggy)
  Widget _buildRestaurantAdBlock(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ONLY ON TRYDE with underline and Pure Veg badge
          Row(
            children: [
              Expanded(
                child: Text(
                  'ONLY ON TRYDE',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                    decoration: TextDecoration.underline,
                    decorationThickness: 2,
                    decorationColor: AppColors.foodPrimary,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.success,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.eco_outlined, size: 14, color: Colors.white),
                    const SizedBox(width: 4),
                    Text(
                      'Pure Veg',
                      style: TextStyle(fontSize: 12, color: Colors.white, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Restaurant Name
          Text(
            'Haldiram\'s Restaurant',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
          ),
          const SizedBox(height: 8),
          // Delivery info
          Text(
            '15-20 mins | Vijay Nagar',
            style: TextStyle(fontSize: 14, color: AppColors.textLight),
          ),
          const SizedBox(height: 4),
          // Ratings
          Row(
            children: [
              Icon(Icons.star, size: 16, color: Colors.amber),
              const SizedBox(width: 4),
              Text('4.6', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
              const SizedBox(width: 8),
              Text('6.3k ratings', style: TextStyle(fontSize: 14, color: AppColors.textLight)),
            ],
          ),
          const SizedBox(height: 12),
          // Discount Badge
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(4),
                decoration: const BoxDecoration(
                  color: Colors.orange,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.star, size: 12, color: Colors.white),
              ),
              const SizedBox(width: 8),
              Text(
                '50% off up to 2/5',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.textPrimary),
              ),
              const Spacer(),
              Text(
                'USE TRYNEW',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Filters and Bolt
  Widget _buildFiltersAndBolt(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          // Veg Filter
          GestureDetector(
            onTap: () {
              setState(() {
                isVegSelected = !isVegSelected;
                if (isVegSelected) isNonVegSelected = false;
              });
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: isVegSelected ? AppColors.success.withOpacity(0.1) : Colors.transparent,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: isVegSelected ? AppColors.success : AppColors.grey300),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.circle_outlined, size: 16, color: AppColors.success),
                  const SizedBox(width: 4),
                  const Text('Veg', style: TextStyle(fontSize: 14, color: AppColors.textPrimary)),
                ],
              ),
            ),
          ),
          const SizedBox(width: 8),
          // Non-Veg Filter
          GestureDetector(
            onTap: () {
              setState(() {
                isNonVegSelected = !isNonVegSelected;
                if (isNonVegSelected) isVegSelected = false;
              });
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: isNonVegSelected ? AppColors.error.withOpacity(0.1) : Colors.transparent,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: isNonVegSelected ? AppColors.error : AppColors.grey300),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.square_outlined, size: 16, color: AppColors.error),
                  const SizedBox(width: 4),
                  const Text('Non Veg', style: TextStyle(fontSize: 14, color: AppColors.textPrimary)),
                ],
              ),
            ),
          ),
          const Spacer(),
          // Bolt
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: AppColors.warning.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.bolt, size: 16, color: AppColors.warning),
                const SizedBox(width: 4),
                const Text('Food in 10 mins', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.warning)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Top Picks Section (Horizontal Scroll)
  Widget _buildTopPicks(BuildContext context, List<Meal> meals) {
    if (meals.isEmpty) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Top Picks', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
          const SizedBox(height: 12),
          SizedBox(
            height: 200, // Fixed height for horizontal scroll
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: meals.length,
              itemBuilder: (context, index) {
                final meal = meals[index];
                final isBestseller = index == 1; // Dummy for second item
                final quantity = cart[meal.strMeal] ?? 0;
                return Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: GestureDetector(
                    onTap: () {},
                    child: Container(
                      width: 160, // Fixed width for each card
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        image: DecorationImage(
                          image: NetworkImage(meal.strMealThumb),
                          fit: BoxFit.cover,
                          onError: (exception, stackTrace) => null,
                        ),
                      ),
                      child: Stack(
                        children: [
                          if (isBestseller)
                            Positioned(
                              top: 8,
                              right: 8,
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(Icons.verified, size: 12, color: AppColors.success),
                                    const SizedBox(width: 2),
                                    const Text('Bestseller', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
                                  ],
                                ),
                              ),
                            ),
                          Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [Colors.black54, Colors.transparent],
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter,
                                ),
                                borderRadius: const BorderRadius.vertical(bottom: Radius.circular(12)),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    meal.strMeal,
                                    style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    '\u{20B9}${index == 0 ? '439' : '214'}', // Dummy prices
                                    style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 12,
                            right: 12,
                            child: quantity > 0
                                ? Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: AppColors.success,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Text(
                                      '$quantity',
                                      style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600),
                                    ),
                                  )
                                : ElevatedButton(
                                    onPressed: () => _addToCart(meal),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.white,
                                      foregroundColor: AppColors.foodPrimary,
                                      minimumSize: const Size(60, 32),
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                                    ),
                                    child: const Text('ADD', style: TextStyle(fontWeight: FontWeight.w600)),
                                  ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // Suggestions by Top Foodies Section (Horizontal Scroll)
  Widget _buildSuggestionsSection(BuildContext context, List<Meal> meals) {
    if (meals.isEmpty) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Suggestions by Top Foodies', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
          const SizedBox(height: 12),
          SizedBox(
            height: 160, // Fixed height for horizontal scroll
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: meals.length + 1, // +1 for MENU button
              itemBuilder: (context, index) {
                if (index == meals.length) {
                  // MENU Button
                  return Padding(
                    padding: const EdgeInsets.only(right: 16, left: 12),
                    child: GestureDetector(
                      onTap: () {
                        // Handle menu navigation
                      },
                      child: Container(
                        width: 60,
                        decoration: BoxDecoration(
                          color: AppColors.grey200,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(Icons.menu_book, color: AppColors.textLight),
                      ),
                    ),
                  );
                }
                final meal = meals[index];
                final quantity = cart[meal.strMeal] ?? 0;
                return Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: GestureDetector(
                    onTap: () {},
                    child: Container(
                      width: 120,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        image: DecorationImage(
                          image: NetworkImage(meal.strMealThumb),
                          fit: BoxFit.cover,
                          onError: (exception, stackTrace) => null,
                        ),
                      ),
                      child: Stack(
                        children: [
                          Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [Colors.black54, Colors.transparent],
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter,
                                ),
                                borderRadius: const BorderRadius.vertical(bottom: Radius.circular(12)),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    meal.strMeal,
                                    style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 8,
                            right: 8,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                quantity > 0
                                    ? Container(
                                        padding: const EdgeInsets.all(4),
                                        decoration: BoxDecoration(
                                          color: AppColors.success,
                                          shape: BoxShape.circle,
                                        ),
                                        child: Text(
                                          '$quantity',
                                          style: const TextStyle(color: Colors.white, fontSize: 12),
                                        ),
                                      )
                                    : ElevatedButton(
                                        onPressed: () => _addToCart(meal),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.white,
                                          foregroundColor: AppColors.foodPrimary,
                                          minimumSize: const Size(40, 24),
                                          padding: EdgeInsets.zero,
                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                                        ),
                                        child: const Text('ADD', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600)),
                                      ),
                                const SizedBox(width: 4),
                                Container(
                                  padding: const EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                    color: AppColors.foodPrimary.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: const Icon(Icons.more_horiz, size: 14, color: AppColors.foodPrimary),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // Combos Section (From screenshot)
  Widget _buildCombosSection(BuildContext context, List<Meal> meals) {
    if (meals.isEmpty) return const SizedBox.shrink();
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Combos for Abhishek (5) NEW', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
          const SizedBox(height: 12),
          ...meals.map((meal) => _buildComboCard(context, meal)).toList(),
        ],
      ),
    );
  }

  Widget _buildComboCard(BuildContext context, Meal meal) {
    final quantity = cart[meal.strMeal] ?? 0;
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.grey300),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              meal.strMealThumb,
              height: 80,
              width: 80,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                height: 80,
                width: 80,
                color: AppColors.grey200,
                child: const Icon(Icons.restaurant, color: AppColors.grey400),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(meal.strMeal, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                const SizedBox(height: 4),
                const Text('₹432', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.foodPrimary)),
                const SizedBox(height: 4),
                const Text('More details', style: TextStyle(fontSize: 12, color: AppColors.textLight)),
              ],
            ),
          ),
          quantity > 0
              ? Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.success,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    '$quantity',
                    style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                )
              : ElevatedButton(
                  onPressed: () => _addToCart(meal),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.foodPrimary,
                    foregroundColor: Colors.white,
                    minimumSize: const Size(60, 32),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                  ),
                  child: const Text('ADD'),
                ),
        ],
      ),
    );
  }

  // Recommended Section (Grid)
  Widget _buildRecommendedSection(BuildContext context, List<Meal> meals) {
    if (meals.isEmpty) return const SizedBox.shrink();
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Recommended (20)', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
          const SizedBox(height: 12),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.8,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
            ),
            itemCount: meals.length,
            itemBuilder: (context, index) {
              final meal = meals[index];
              final quantity = cart[meal.strMeal] ?? 0;
              return Column(
                children: [
                  Expanded(
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(
                            meal.strMealThumb,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) => Container(
                              color: AppColors.grey200,
                              child: const Icon(Icons.restaurant_menu, color: AppColors.grey400),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 8,
                          right: 8,
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                            child: quantity > 0
                                ? Text(
                                    '$quantity',
                                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.success),
                                  )
                                : const Icon(Icons.add, size: 16, color: AppColors.grey600),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(meal.strMeal, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600), maxLines: 1, overflow: TextOverflow.ellipsis),
                  Text('₹154', style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.foodPrimary)),
                  ElevatedButton(
                    onPressed: () => _addToCart(meal),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.foodPrimary,
                      foregroundColor: Colors.white,
                      minimumSize: const Size(double.infinity, 32),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                    ),
                    child: Text(quantity > 0 ? 'Added ($quantity)' : 'ADD'),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  // 99 Store Section
  Widget _build99StoreSection(BuildContext context, List<Meal> meals) {
    if (meals.isEmpty) return const SizedBox.shrink();
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('₹99 store', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
          const SizedBox(height: 12),
          SizedBox(
            height: 200,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: meals.length,
              itemBuilder: (context, index) {
                final meal = meals[index];
                final quantity = cart[meal.strMeal] ?? 0;
                return Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: Container(
                    width: 140,
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 8)],
                    ),
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                          child: Image.network(
                            meal.strMealThumb,
                            height: 100,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) => Container(
                              height: 100,
                              color: AppColors.grey200,
                              child: const Icon(Icons.restaurant_menu),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: Column(
                            children: [
                              Text(meal.strMeal, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600), maxLines: 1, overflow: TextOverflow.ellipsis),
                              const Text('₹99', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.green)),
                              ElevatedButton(
                                onPressed: () => _addToCart(meal),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green,
                                  foregroundColor: Colors.white,
                                  minimumSize: const Size(double.infinity, 28),
                                ),
                                child: Text(quantity > 0 ? 'Added ($quantity)' : 'ADD'),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // Cart Summary (Bottom) - Now Dynamic
  Widget _buildCartSummary(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 60,
      color: AppColors.white,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.success.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.shopping_cart, color: AppColors.success),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              totalItems > 0 ? '$totalItems items added' : 'No items added',
              style: const TextStyle(fontWeight: FontWeight.w600, color: AppColors.textPrimary),
            ),
          ),
          GestureDetector(
            onTap: () {
                    // Navigate to Cart Screen
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CartScreen(cart: {},)),
                    );
                  },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: totalItems > 0 ? AppColors.success : AppColors.grey300,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                'View Cart >',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: totalItems > 0 ? Colors.white : AppColors.textLight,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}