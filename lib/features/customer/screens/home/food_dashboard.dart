
// // food_dashboard.dart
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:tryde_partner/core/constants/color_constants.dart';
// import 'package:tryde_partner/dummy_api_data/food/model/meal_model.dart';
// import 'package:tryde_partner/dummy_api_data/food/provider/food_provider.dart';


// class FoodDashboard extends StatefulWidget {
//   const FoodDashboard({super.key});

//   @override
//   State<FoodDashboard> createState() => _FoodDashboardState();
// }

// class _FoodDashboardState extends State<FoodDashboard> {
//   @override
//   void initState() {
//     super.initState();
//     // Auto-load Indian meals for the dashboard (as per Swiggy-like Indian foods)
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       final provider = Provider.of<MealProvider>(context, listen: false);
//       if (provider.meals.isEmpty) {
//         provider.loadMealsByArea('Indian');
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Consumer<MealProvider>(
//       builder: (context, provider, child) {
//         if (provider.isLoadingMeals && provider.meals.isEmpty) {
//           return const Center(child: CircularProgressIndicator());
//         }
//         if (provider.errorMeals != null) {
//           return Center(child: Text('Error: ${provider.errorMeals}'));
//         }
//         final meals = provider.meals; // Use API-loaded Indian meals
//         return SingleChildScrollView(
//           padding: const EdgeInsets.all(16),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Top Offers Banner (Static, as API is recipes, not brands; kept placeholders)
//               _buildOffersBanner(context),
//               const SizedBox(height: 16),

//               // Use ₹15 Free Cash Banner (Static)
//               _buildFreeCashBanner(context),
//               const SizedBox(height: 20),

//               // What's on your mind? Horizontal Carousel (Using first 5 API meals)
//               _buildWhatsOnYourMind(context, meals.take(5).toList()),
//               const SizedBox(height: 20),

//               // ₹99 Store Section (Using next 3 API meals)
//               _build99StoreSection(context, meals.skip(5).take(3).toList()),
//               const SizedBox(height: 20),

//               // More on Swiggy Icons (Static)
//               _buildMoreOnSwiggy(context),
//               const SizedBox(height: 20),

//               // Top Restaurants List (Static, as no restaurant API; placeholders)
//               _buildTopRestaurants(context),
//               const SizedBox(height: 20),

//               // Bottom Filter/Sort Bar (Static)
//               _buildFilterSortBar(context),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   // Top Offers Banner (Horizontal scrollable cards for KFC, etc. - Static placeholders)
//   Widget _buildOffersBanner(BuildContext context) {
//     final theme = Theme.of(context);
//     final List<Map<String, dynamic>> offers = [
//       {
//         'image': 'https://www.themealdb.com/images/media/meals/kcv6hj1598733479.jpg',
//         'title': 'KFC',
//         'subtitle': 'Burgers',
//         'price': '₹69',
//         'rating': 4.0,
//         'time': '15-20 min',
//         'distance': '4.5 km',
//       },
//       {
//         'image': 'https://www.themealdb.com/images/media/meals/kcv6hj1598733479.jpg',
//         'title': 'Theobroma',
//         'subtitle': 'Bakery',
//         'price': '₹99',
//         'rating': 4.5,
//         'time': '10-15 min',
//         'distance': '4.4 km',
//       },
//       {
//         'image': 'https://www.themealdb.com/images/media/meals/kcv6hj1598733479.jpg',
//         'title': 'Behrouz Biryani',
//         'subtitle': 'Biryani',
//         'price': '₹199',
//         'rating': 4.4,
//         'time': '20-25 min',
//         'distance': '4.2 km',
//       },
//       {
//         'image': 'https://www.themealdb.com/images/media/meals/kcv6hj1598733479.jpg',
//         'title': 'Behrouz Biryani',
//         'subtitle': 'Biryani',
//         'price': '₹199',
//         'rating': 4.4,
//         'time': '20-25 min',
//         'distance': '4.2 km',
//       },
//       {
//         'image': 'https://www.themealdb.com/images/media/meals/kcv6hj1598733479.jpg',
//         'title': 'Behrouz Biryani',
//         'subtitle': 'Biryani',
//         'price': '₹199',
//         'rating': 4.4,
//         'time': '20-25 min',
//         'distance': '4.2 km',
//       },
//     ];

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             const Text('Min ₹100 off', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
//             const Text('Fast Delivery', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.green)),
//           ],
//         ),
//         const SizedBox(height: 12),
//         SizedBox(
//           height: 200,
//           child: ListView.builder(
//             scrollDirection: Axis.horizontal,
//             itemCount: offers.length,
//             itemBuilder: (context, index) {
//               final offer = offers[index];
//               return Padding(
//                 padding: const EdgeInsets.only(right: 12),
//                 child: _buildOfferCard(context, offer),
//               );
//             },
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildOfferCard(BuildContext context, Map<String, dynamic> offer) {
//     final theme = Theme.of(context);
//     return Container(
//       width: 150,
//       decoration: BoxDecoration(
//         color: theme.colorScheme.surface,
//         borderRadius: BorderRadius.circular(12),
//         boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 8)],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           ClipRRect(
//             borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
//             child: Image.network(
//               offer['image'],
//               height: 80,
//               width: double.infinity,
//               fit: BoxFit.cover,
//               errorBuilder: (context, error, stackTrace) => Container(
//                 height: 80,
//                 color: Colors.grey[300],
//                 child: const Icon(Icons.image_not_supported, color: Colors.grey),
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(offer['title'], style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
//                 Text(offer['subtitle'], style: TextStyle(fontSize: 12, color: theme.colorScheme.onSurfaceVariant)),
//                 const SizedBox(height: 4),
//                 Text('${offer['price']} AD', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
//                 Row(
//                   children: [
//                     _buildStarRating(offer['rating']),
//                     const SizedBox(width: 4),
//                     Text(offer['time'], style: TextStyle(fontSize: 12, color: theme.colorScheme.onSurfaceVariant)),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   // Free Cash Banner (Static)
//   Widget _buildFreeCashBanner(BuildContext context) {
//     final theme = Theme.of(context);
//     return Container(
//       width: double.infinity,
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//           colors: [AppColors.foodPrimary.withOpacity(0.1), Colors.transparent],
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//         ),
//         borderRadius: BorderRadius.circular(16),
//         border: Border.all(color: AppColors.foodPrimary.withOpacity(0.2)),
//       ),
//       child: Row(
//         children: [
//           Container(
//             padding: const EdgeInsets.all(8),
//             decoration: BoxDecoration(
//               color: Colors.amber[100],
//               shape: BoxShape.circle,
//             ),
//             child: const Icon(Icons.monetization_on, color: Colors.amber, size: 24),
//           ),
//           const SizedBox(width: 12),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'Use your ₹15 free cash on your order!',
//                   style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: theme.colorScheme.onBackground),
//                 ),
//                 Text(
//                   'Expires in 13:10:58',
//                   style: TextStyle(fontSize: 12, color: theme.colorScheme.onSurfaceVariant),
//                 ),
//               ],
//             ),
//           ),
//           const Icon(Icons.arrow_forward_ios, size: 16, color: AppColors.foodPrimary),
//         ],
//       ),
//     );
//   }

//   // What's on your mind? Carousel (Dynamic with API meals)
//   Widget _buildWhatsOnYourMind(BuildContext context, List<Meal> meals) {
//     final theme = Theme.of(context);
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text('What\'s on your mind?', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: theme.colorScheme.onBackground)),
//         const SizedBox(height: 12),
//         SizedBox(
//           height: 120,
//           child: ListView.builder(
//             scrollDirection: Axis.horizontal,
//             itemCount: meals.length,
//             itemBuilder: (context, index) {
//               final meal = meals[index];
//               return Padding(
//                 padding: const EdgeInsets.only(right: 12),
//                 child: GestureDetector(
//                   onTap: () {
//                     // Navigate to meal details using idMeal
//                     // e.g., Navigator.pushNamed(context, '/meal-detail', arguments: meal.idMeal);
//                   },
//                   child: Column(
//                     children: [
//                       ClipRRect(
//                         borderRadius: BorderRadius.circular(12),
//                         child: Image.network(
//                           meal.strMealThumb,
//                           height: 100,
//                           width: 100,
//                           fit: BoxFit.cover,
//                           errorBuilder: (context, error, stackTrace) => Container(
//                             height: 100,
//                             width: 100,
//                             decoration: BoxDecoration(
//                               color: Colors.grey[300],
//                               borderRadius: BorderRadius.circular(12),
//                             ),
//                             child: const Icon(Icons.restaurant, size: 40, color: Colors.grey),
//                           ),
//                         ),
//                       ),
//                       const SizedBox(height: 8),
//                       Expanded(
//                         child: Text(
//                           meal.strMeal,
//                           textAlign: TextAlign.center,
//                           style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: theme.colorScheme.onBackground),
//                           maxLines: 2,
//                           overflow: TextOverflow.ellipsis,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               );
//             },
//           ),
//         ),
//       ],
//     );
//   }

//   // ₹99 Store Section (Dynamic with API meals)
//   Widget _build99StoreSection(BuildContext context, List<Meal> meals) {
//     final theme = Theme.of(context);
//     if (meals.isEmpty) {
//       return const SizedBox.shrink(); // No data, hide section
//     }

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             const Text('₹99 store', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
//             Row(
//               children: [
//                 Container(
//                   padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//                   decoration: BoxDecoration(
//                     color: Colors.green.withOpacity(0.1),
//                     borderRadius: BorderRadius.circular(20),
//                   ),
//                   child: Row(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       Icon(Icons.check_circle, size: 16, color: Colors.green),
//                       const SizedBox(width: 4),
//                       const Text('Meals at ₹99 + Free delivery', style: TextStyle(fontSize: 12, color: Colors.green)),
//                     ],
//                   ),
//                 ),
//                 const SizedBox(width: 8),
//                 const Icon(Icons.arrow_forward_ios, size: 16),
//               ],
//             ),
//           ],
//         ),
//         const SizedBox(height: 12),
//         SizedBox(
//           height: 250,
//           child: ListView.builder(
//             scrollDirection: Axis.horizontal,
//             itemCount: meals.length,
//             itemBuilder: (context, index) {
//               final meal = meals[index];
//               return Padding(
//                 padding: const EdgeInsets.only(right: 12),
//                 child: GestureDetector(
//                   onTap: () {
//                     // Navigate to meal details
//                   },
//                   child: Container(
//                     width: 150,
//                     decoration: BoxDecoration(
//                       color: theme.colorScheme.surface,
//                       borderRadius: BorderRadius.circular(12),
//                       boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 8)],
//                     ),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Stack(
//                           children: [
//                             ClipRRect(
//                               borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
//                               child: Image.network(
//                                 meal.strMealThumb,
//                                 height: 120,
//                                 width: double.infinity,
//                                 fit: BoxFit.cover,
//                                 errorBuilder: (context, error, stackTrace) => Container(
//                                   height: 120,
//                                   color: Colors.grey[300],
//                                   child: const Icon(Icons.restaurant_menu, color: Colors.grey),
//                                 ),
//                               ),
//                             ),
//                             Positioned(
//                               top: 4,
//                               right: 4,
//                               child: Container(
//                                 padding: const EdgeInsets.all(4),
//                                 decoration: const BoxDecoration(
//                                   color: Colors.white,
//                                   shape: BoxShape.circle,
//                                 ),
//                                 child: const Icon(Icons.add, size: 16, color: Colors.grey),
//                               ),
//                             ),
//                           ],
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.all(8),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 meal.strMeal,
//                                 style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
//                                 maxLines: 1,
//                                 overflow: TextOverflow.ellipsis,
//                               ),
//                               const Text('₹99', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.green)), // Static price for demo
//                               Row(
//                                 children: [
//                                   _buildStarRating(4.0), // Static rating for demo
//                                   const SizedBox(width: 4),
//                                   const Text('(100+)', style: TextStyle(fontSize: 12, color: Colors.grey)),
//                                 ],
//                               ),
//                               const Text('Quick Bite Store', style: TextStyle(fontSize: 12, color: Colors.grey)), // Static store
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               );
//             },
//           ),
//         ),
//       ],
//     );
//   }

//   // More on Swiggy Icons (Static)
//   Widget _buildMoreOnSwiggy(BuildContext context) {
//     final theme = Theme.of(context);
//     final List<Map<String, dynamic>> moreItems = [
//       {'icon': Icons.currency_rupee, 'title': '99 STORE\nMEALS AT ₹99'},
//       {'icon': Icons.local_offer, 'title': 'OFFER\nZONE'},
//       {'icon': Icons.flash_on, 'title': 'BOLT\nFOOD IN 10MINS'},
//       {'icon': Icons.train, 'title': 'FOOD ON\nTRAIN'},
//     ];

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text('More on Swiggy', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: theme.colorScheme.onBackground)),
//         const SizedBox(height: 12),
//         SizedBox(
//           height: 80,
//           child: ListView.builder(
//             scrollDirection: Axis.horizontal,
//             itemCount: moreItems.length,
//             itemBuilder: (context, index) {
//               final item = moreItems[index];
//               return Padding(
//                 padding: const EdgeInsets.only(right: 12),
//                 child: GestureDetector(
//                   onTap: () {}, // Navigate
//                   child: Container(
//                     width: 80,
//                     decoration: BoxDecoration(
//                       color: AppColors.foodPrimary.withOpacity(0.1),
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Icon(item['icon'], size: 32, color: AppColors.foodPrimary),
//                         const SizedBox(height: 8),
//                         Text(
//                           item['title'],
//                           textAlign: TextAlign.center,
//                           style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: theme.colorScheme.onBackground),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               );
//             },
//           ),
//         ),
//       ],
//     );
//   }

//   // Top Restaurants List (Static placeholders)
//   Widget _buildTopRestaurants(BuildContext context) {
//     final theme = Theme.of(context);
//     final List<Map<String, dynamic>> restaurants = [
//       {
//         'image': 'https://www.themealdb.com/images/media/meals/kcv6hj1598733479.jpg',
//         'title': 'Haldiram\'s',
//         'rating': 4.4,
//         'reviews': '(6.3k+)',
//         'time': '',
//         'cuisines': 'North Indian, Chaat, Chine...',
//         'distance': 'Vijay Nagar, 1.1 km',
//         'offer': null
//       },
//       {
//         'image': 'https://www.themealdb.com/images/media/meals/kcv6hj1598733479.jpg',
//         'title': 'Apna Sweets',
//         'rating': 4.4,
//         'reviews': '(64k+)',
//         'time': '10-15 mins',
//         'cuisines': 'North Indian, Sweets, Thali...',
//         'distance': 'Vijay Nagar, 0.7 km',
//         'offer': null,
//       },
//       {
//         'image': 'https://www.themealdb.com/images/media/meals/kcv6hj1598733479.jpg',
//         'title': 'Haldiram\'s Sweets a...',
//         'rating': 4.7,
//         'reviews': '(528)',
//         'time': '5-10 mins',
//         'cuisines': 'Sweets, Desserts, Indian Sn...',
//         'distance': 'Vijay Nagar, 1.1 km',
//         'offer': null,
//       },
//       {
//         'image': 'https://www.themealdb.com/images/media/meals/kcv6hj1598733479.jpg',
//         'title': 'Kesar Shree',
//         'rating': 4.2,
//         'reviews': '(11)',
//         'time': '10-15 mins',
//         'cuisines': 'Fast Food',
//         'distance': 'Vijay Nagar, 1.2 km',
//         'offer': null,
//       },
//     ];

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Text('Top 1540 restaurants to explore', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: theme.colorScheme.onBackground)),
//             Row(
//               children: [
//                 Icon(Icons.bolt, color: Colors.orange, size: 20),
//                 const SizedBox(width: 4),
//                 Text('Bolt', style: TextStyle(color: Colors.orange, fontWeight: FontWeight.w600)),
//               ],
//             ),
//           ],
//         ),
//         const SizedBox(height: 12),
//         ListView.separated(
//           shrinkWrap: true,
//           physics: const NeverScrollableScrollPhysics(),
//           itemCount: restaurants.length,
//           separatorBuilder: (context, index) => const SizedBox(height: 12),
//           itemBuilder: (context, index) {
//             final res = restaurants[index];
//             return GestureDetector(
//               onTap: () {}, // Navigate to restaurant
//               child: Container(
//                 padding: const EdgeInsets.all(8),
//                 decoration: BoxDecoration(
//                   color: theme.colorScheme.surface,
//                   borderRadius: BorderRadius.circular(12),
//                   border: Border.all(color: theme.colorScheme.outline.withOpacity(0.1)),
//                 ),
//                 child: Row(
//                   children: [
//                     ClipRRect(
//                       borderRadius: BorderRadius.circular(8),
//                       child: Image.network(
//                         res['image'],
//                         height: 80,
//                         width: 120,
//                         fit: BoxFit.cover,
//                         errorBuilder: (context, error, stackTrace) => Container(
//                           height: 80,
//                           width: 120,
//                           color: Colors.grey[300],
//                           child: const Icon(Icons.restaurant, color: Colors.grey),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(width: 12),
//                     Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Expanded(
//                                 child: Text(
//                                   res['title'],
//                                   style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: theme.colorScheme.onBackground),
//                                 ),
//                               ),
//                               if (res['offer'] != null)
//                                 Container(
//                                   padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
//                                   decoration: BoxDecoration(
//                                     color: Colors.green.withOpacity(0.1),
//                                     borderRadius: BorderRadius.circular(4),
//                                   ),
//                                   child: Text(res['offer'], style: TextStyle(fontSize: 10, color: Colors.green)),
//                                 ),
//                             ],
//                           ),
//                           const SizedBox(height: 4),
//                           Row(
//                             children: [
//                               _buildStarRating(res['rating']),
//                               const SizedBox(width: 4),
//                               Text(res['reviews'], style: TextStyle(fontSize: 12, color: theme.colorScheme.onSurfaceVariant)),
//                               const SizedBox(width: 8),
//                               Text(res['time'], style: TextStyle(fontSize: 12, color: theme.colorScheme.onSurfaceVariant)),
//                             ],
//                           ),
//                           const SizedBox(height: 4),
//                           Text(res['cuisines'], style: TextStyle(fontSize: 12, color: theme.colorScheme.onSurfaceVariant)),
//                           const SizedBox(height: 4),
//                           Text(res['distance'], style: TextStyle(fontSize: 12, color: theme.colorScheme.onSurfaceVariant)),
//                         ],
//                       ),
//                     ),
//                     // const Icon(Icons.more_horiz, size: 20, color: Colors.grey),
//                   ],
//                 ),
//               ),
//             );
//           },
//         ),
//       ],
//     );
//   }

//   // Filter/Sort Bar (Static)
//   Widget _buildFilterSortBar(BuildContext context) {
//     final theme = Theme.of(context);
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//       decoration: BoxDecoration(
//         color: theme.colorScheme.surface,
//         borderRadius: BorderRadius.circular(8),
//         boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 4)],
//       ),
//       child: Row(
//         children: [
//           _buildIconButton(context, Icons.tune, 'Filter'),
//           const SizedBox(width: 8),
//           _buildIconButton(context, Icons.sort_by_alpha, 'Sort by'),
//           const SizedBox(width: 16),
//           _buildIconButton(context, Icons.currency_rupee, '₹99 Store'),
//           const SizedBox(width: 8),
//           _buildIconButton(context, Icons.bolt, 'Bolt'),
//           const SizedBox(width: 8),
//           _buildIconButton(context, Icons.favorite_border, 'Fc'),
//         ],
//       ),
//     );
//   }

//   Widget _buildIconButton(BuildContext context, IconData icon, String label) {
//     final theme = Theme.of(context);
//     return GestureDetector(
//       onTap: () {}, // Handle tap
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Icon(icon, size: 20, color: theme.colorScheme.onSurfaceVariant),
//           Text(label, style: TextStyle(fontSize: 10, color: theme.colorScheme.onSurfaceVariant)),
//         ],
//       ),
//     );
//   }

//   // Helper: Star Rating (Static for demo)
//   Widget _buildStarRating(double rating) {
//     return Row(
//       mainAxisSize: MainAxisSize.min,
//       children: List.generate(5, (index) {
//         if (index < rating.floor()) {
//           return const Icon(Icons.star, size: 12, color: Colors.amber);
//         } else if (index == rating.floor() && rating % 1 >= 0.5) {
//           return const Icon(Icons.star_half, size: 12, color: Colors.amber);
//         } else {
//           return const Icon(Icons.star_border, size: 12, color: Colors.amber);
//         }
//       }),
//     );
//   }
// }


// food_dashboard.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tryde_partner/core/constants/color_constants.dart';
import 'package:tryde_partner/dummy_api_data/food/model/meal_model.dart';
import 'package:tryde_partner/dummy_api_data/food/provider/food_provider.dart';
import 'package:tryde_partner/features/customer/food/restaurent_screen.dart';

class FoodDashboard extends StatefulWidget {
  const FoodDashboard({super.key});

  @override
  State<FoodDashboard> createState() => _FoodDashboardState();
}

class _FoodDashboardState extends State<FoodDashboard> {
  @override
  void initState() {
    super.initState();
    // Auto-load Indian meals for the dashboard (as per Swiggy-like Indian foods)
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<MealProvider>(context, listen: false);
      if (provider.meals.isEmpty) {
        provider.loadMealsByArea('Indian');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MealProvider>(
      builder: (context, provider, child) {
        if (provider.isLoadingMeals && provider.meals.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }
        if (provider.errorMeals != null) {
          return Center(child: Text('Error: ${provider.errorMeals}'));
        }
        final meals = provider.meals; // Use API-loaded Indian meals
        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top Offers Banner (Static, as API is recipes, not brands; kept placeholders)
              _buildOffersBanner(context, meals),
              const SizedBox(height: 16),

              // Use ₹15 Free Cash Banner (Static)
              _buildFreeCashBanner(context),
              const SizedBox(height: 20),

              // What's on your mind? Horizontal Carousel (Using first 5 API meals)
              _buildWhatsOnYourMind(context, meals.take(5).toList()),
              const SizedBox(height: 20),

              // ₹99 Store Section (Using next 3 API meals)
              _build99StoreSection(context, meals.skip(5).take(3).toList()),
              const SizedBox(height: 20),

              // More on Swiggy Icons (Static)
              _buildMoreOnSwiggy(context),
              const SizedBox(height: 20),

              // Top Restaurants List (Static, as no restaurant API; placeholders)
              _buildTopRestaurants(context, meals),
              const SizedBox(height: 20),

              // Bottom Filter/Sort Bar (Static)
              _buildFilterSortBar(context),
            ],
          ),
        );
      },
    );
  }

  // Top Offers Banner (Horizontal scrollable cards for KFC, etc. - Static placeholders)
  Widget _buildOffersBanner(BuildContext context, List<Meal> meals) {
    final theme = Theme.of(context);
    final List<Map<String, dynamic>> offers = [
      {
        'image': 'https://www.themealdb.com/images/media/meals/kcv6hj1598733479.jpg',
        'title': 'KFC',
        'subtitle': 'Burgers',
        'price': '₹69',
        'rating': 4.0,
        'time': '15-20 min',
        'distance': '4.5 km',
      },
      {
        'image': 'https://www.themealdb.com/images/media/meals/kcv6hj1598733479.jpg',
        'title': 'Theobroma',
        'subtitle': 'Bakery',
        'price': '₹99',
        'rating': 4.5,
        'time': '10-15 min',
        'distance': '4.4 km',
      },
      {
        'image': 'https://www.themealdb.com/images/media/meals/kcv6hj1598733479.jpg',
        'title': 'Behrouz Biryani',
        'subtitle': 'Biryani',
        'price': '₹199',
        'rating': 4.4,
        'time': '20-25 min',
        'distance': '4.2 km',
      },
      {
        'image': 'https://www.themealdb.com/images/media/meals/kcv6hj1598733479.jpg',
        'title': 'Behrouz Biryani',
        'subtitle': 'Biryani',
        'price': '₹199',
        'rating': 4.4,
        'time': '20-25 min',
        'distance': '4.2 km',
      },
      {
        'image': 'https://www.themealdb.com/images/media/meals/kcv6hj1598733479.jpg',
        'title': 'Behrouz Biryani',
        'subtitle': 'Biryani',
        'price': '₹199',
        'rating': 4.4,
        'time': '20-25 min',
        'distance': '4.2 km',
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Min ₹100 off', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            const Text('Fast Delivery', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.green)),
          ],
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: offers.length,
            itemBuilder: (context, index) {
              final offer = offers[index];
              return Padding(
                padding: const EdgeInsets.only(right: 12),
                child: GestureDetector(
                  onTap: () {
                    // Create dummy Meal for navigation
                    final dummyMeal = Meal(
                      strMeal: offer['title'],
                      strMealThumb: offer['image'],
                      idMeal: 'dummy_offer_$index',
                    );
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RestaurantScreen(selectedMeal: dummyMeal),
                      ),
                    );
                  },
                  child: _buildOfferCard(context, offer),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildOfferCard(BuildContext context, Map<String, dynamic> offer) {
    final theme = Theme.of(context);
    return Container(
      width: 150,
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 8)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            child: Image.network(
              offer['image'],
              height: 80,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                height: 80,
                color: Colors.grey[300],
                child: const Icon(Icons.image_not_supported, color: Colors.grey),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(offer['title'], style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                Text(offer['subtitle'], style: TextStyle(fontSize: 12, color: theme.colorScheme.onSurfaceVariant)),
                const SizedBox(height: 4),
                Text('${offer['price']} AD', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
                Row(
                  children: [
                    _buildStarRating(offer['rating']),
                    const SizedBox(width: 4),
                    Text(offer['time'], style: TextStyle(fontSize: 12, color: theme.colorScheme.onSurfaceVariant)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Free Cash Banner (Static)
  Widget _buildFreeCashBanner(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.foodPrimary.withOpacity(0.1), Colors.transparent],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.foodPrimary.withOpacity(0.2)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.amber[100],
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.monetization_on, color: Colors.amber, size: 24),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Use your ₹15 free cash on your order!',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: theme.colorScheme.onBackground),
                ),
                Text(
                  'Expires in 13:10:58',
                  style: TextStyle(fontSize: 12, color: theme.colorScheme.onSurfaceVariant),
                ),
              ],
            ),
          ),
          const Icon(Icons.arrow_forward_ios, size: 16, color: AppColors.foodPrimary),
        ],
      ),
    );
  }

  // What's on your mind? Carousel (Dynamic with API meals)
  Widget _buildWhatsOnYourMind(BuildContext context, List<Meal> meals) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('What\'s on your mind?', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: theme.colorScheme.onBackground)),
        const SizedBox(height: 12),
        SizedBox(
          height: 120,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: meals.length,
            itemBuilder: (context, index) {
              final meal = meals[index];
              return Padding(
                padding: const EdgeInsets.only(right: 12),
                child: GestureDetector(
                  onTap: () {
                    // Navigate to restaurant screen
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RestaurantScreen(selectedMeal: meal),
                      ),
                    );
                  },
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(
                          meal.strMealThumb,
                          height: 100,
                          width: 100,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Icon(Icons.restaurant, size: 40, color: Colors.grey),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Expanded(
                        child: Text(
                          meal.strMeal,
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: theme.colorScheme.onBackground),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
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
    );
  }

  // ₹99 Store Section (Dynamic with API meals)
  Widget _build99StoreSection(BuildContext context, List<Meal> meals) {
    final theme = Theme.of(context);
    if (meals.isEmpty) {
      return const SizedBox.shrink(); // No data, hide section
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('₹99 store', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.check_circle, size: 16, color: Colors.green),
                      const SizedBox(width: 4),
                      const Text('Meals at ₹99 + Free delivery', style: TextStyle(fontSize: 12, color: Colors.green)),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                const Icon(Icons.arrow_forward_ios, size: 16),
              ],
            ),
          ],
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 250,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: meals.length,
            itemBuilder: (context, index) {
              final meal = meals[index];
              return Padding(
                padding: const EdgeInsets.only(right: 12),
                child: GestureDetector(
                  onTap: () {
                    // Navigate to restaurant screen
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RestaurantScreen(selectedMeal: meal),
                      ),
                    );
                  },
                  child: Container(
                    width: 150,
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surface,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 8)],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                              child: Image.network(
                                meal.strMealThumb,
                                height: 120,
                                width: double.infinity,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) => Container(
                                  height: 120,
                                  color: Colors.grey[300],
                                  child: const Icon(Icons.restaurant_menu, color: Colors.grey),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 4,
                              right: 4,
                              child: Container(
                                padding: const EdgeInsets.all(4),
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(Icons.add, size: 16, color: Colors.grey),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                meal.strMeal,
                                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const Text('₹99', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.green)), // Static price for demo
                              Row(
                                children: [
                                  _buildStarRating(4.0), // Static rating for demo
                                  const SizedBox(width: 4),
                                  const Text('(100+)', style: TextStyle(fontSize: 12, color: Colors.grey)),
                                ],
                              ),
                              const Text('Quick Bite Store', style: TextStyle(fontSize: 12, color: Colors.grey)), // Static store
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
    );
  }

  // More on Swiggy Icons (Static)
  Widget _buildMoreOnSwiggy(BuildContext context) {
    final theme = Theme.of(context);
    final List<Map<String, dynamic>> moreItems = [
      {'icon': Icons.currency_rupee, 'title': '99 STORE\nMEALS AT ₹99'},
      {'icon': Icons.local_offer, 'title': 'OFFER\nZONE'},
      {'icon': Icons.flash_on, 'title': 'BOLT\nFOOD IN 10MINS'},
      {'icon': Icons.train, 'title': 'FOOD ON\nTRAIN'},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('More on Swiggy', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: theme.colorScheme.onBackground)),
        const SizedBox(height: 12),
        SizedBox(
          height: 80,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: moreItems.length,
            itemBuilder: (context, index) {
              final item = moreItems[index];
              return Padding(
                padding: const EdgeInsets.only(right: 12),
                child: GestureDetector(
                  onTap: () {}, // Navigate
                  child: Container(
                    width: 80,
                    decoration: BoxDecoration(
                      color: AppColors.foodPrimary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(item['icon'], size: 32, color: AppColors.foodPrimary),
                        const SizedBox(height: 8),
                        Text(
                          item['title'],
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: theme.colorScheme.onBackground),
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
    );
  }

  // Top Restaurants List (Static placeholders)
  Widget _buildTopRestaurants(BuildContext context, List<Meal> meals) {
    final theme = Theme.of(context);
    final List<Map<String, dynamic>> restaurants = [
      {
        'image': 'https://www.themealdb.com/images/media/meals/kcv6hj1598733479.jpg',
        'title': 'Haldiram\'s',
        'rating': 4.4,
        'reviews': '(6.3k+)',
        'time': '',
        'cuisines': 'North Indian, Chaat, Chine...',
        'distance': 'Vijay Nagar, 1.1 km',
        'offer': null
      },
      {
        'image': 'https://www.themealdb.com/images/media/meals/kcv6hj1598733479.jpg',
        'title': 'Apna Sweets',
        'rating': 4.4,
        'reviews': '(64k+)',
        'time': '10-15 mins',
        'cuisines': 'North Indian, Sweets, Thali...',
        'distance': 'Vijay Nagar, 0.7 km',
        'offer': null,
      },
      {
        'image': 'https://www.themealdb.com/images/media/meals/kcv6hj1598733479.jpg',
        'title': 'Haldiram\'s Sweets a...',
        'rating': 4.7,
        'reviews': '(528)',
        'time': '5-10 mins',
        'cuisines': 'Sweets, Desserts, Indian Sn...',
        'distance': 'Vijay Nagar, 1.1 km',
        'offer': null,
      },
      {
        'image': 'https://www.themealdb.com/images/media/meals/kcv6hj1598733479.jpg',
        'title': 'Kesar Shree',
        'rating': 4.2,
        'reviews': '(11)',
        'time': '10-15 mins',
        'cuisines': 'Fast Food',
        'distance': 'Vijay Nagar, 1.2 km',
        'offer': null,
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Top 1540 restaurants to explore', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: theme.colorScheme.onBackground)),
            Row(
              children: [
                Icon(Icons.bolt, color: Colors.orange, size: 20),
                const SizedBox(width: 4),
                Text('Bolt', style: TextStyle(color: Colors.orange, fontWeight: FontWeight.w600)),
              ],
            ),
          ],
        ),
        const SizedBox(height: 12),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: restaurants.length,
          separatorBuilder: (context, index) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final res = restaurants[index];
            return GestureDetector(
              onTap: () {
                // Create dummy Meal for navigation
                final dummyMeal = Meal(
                  strMeal: res['title'],
                  strMealThumb: res['image'],
                  idMeal: 'dummy_rest_$index',
                );
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RestaurantScreen(selectedMeal: dummyMeal),
                  ),
                );
              }, // Navigate to restaurant
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: theme.colorScheme.surface,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: theme.colorScheme.outline.withOpacity(0.1)),
                ),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        res['image'],
                        height: 80,
                        width: 120,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Container(
                          height: 80,
                          width: 120,
                          color: Colors.grey[300],
                          child: const Icon(Icons.restaurant, color: Colors.grey),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  res['title'],
                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: theme.colorScheme.onBackground),
                                ),
                              ),
                              if (res['offer'] != null)
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: Colors.green.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Text(res['offer'], style: TextStyle(fontSize: 10, color: Colors.green)),
                                ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              _buildStarRating(res['rating']),
                              const SizedBox(width: 4),
                              Text(res['reviews'], style: TextStyle(fontSize: 12, color: theme.colorScheme.onSurfaceVariant)),
                              const SizedBox(width: 8),
                              Text(res['time'], style: TextStyle(fontSize: 12, color: theme.colorScheme.onSurfaceVariant)),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(res['cuisines'], style: TextStyle(fontSize: 12, color: theme.colorScheme.onSurfaceVariant)),
                          const SizedBox(height: 4),
                          Text(res['distance'], style: TextStyle(fontSize: 12, color: theme.colorScheme.onSurfaceVariant)),
                        ],
                      ),
                    ),
                    // const Icon(Icons.more_horiz, size: 20, color: Colors.grey),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  // Filter/Sort Bar (Static)
  Widget _buildFilterSortBar(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 4)],
      ),
      child: Row(
        children: [
          _buildIconButton(context, Icons.tune, 'Filter'),
          const SizedBox(width: 8),
          _buildIconButton(context, Icons.sort_by_alpha, 'Sort by'),
          const SizedBox(width: 16),
          _buildIconButton(context, Icons.currency_rupee, '₹99 Store'),
          const SizedBox(width: 8),
          _buildIconButton(context, Icons.bolt, 'Bolt'),
          const SizedBox(width: 8),
          _buildIconButton(context, Icons.favorite_border, 'Fc'),
        ],
      ),
    );
  }

  Widget _buildIconButton(BuildContext context, IconData icon, String label) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: () {}, // Handle tap
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 20, color: theme.colorScheme.onSurfaceVariant),
          Text(label, style: TextStyle(fontSize: 10, color: theme.colorScheme.onSurfaceVariant)),
        ],
      ),
    );
  }

  // Helper: Star Rating (Static for demo)
  Widget _buildStarRating(double rating) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        if (index < rating.floor()) {
          return const Icon(Icons.star, size: 12, color: Colors.amber);
        } else if (index == rating.floor() && rating % 1 >= 0.5) {
          return const Icon(Icons.star_half, size: 12, color: Colors.amber);
        } else {
          return const Icon(Icons.star_border, size: 12, color: Colors.amber);
        }
      }),
    );
  }
}


