// import 'package:flutter/material.dart';
// import 'package:tryde_partner/core/constants/color_constants.dart';
// import 'package:tryde_partner/features/porter_partner/screens/porter_dashboard_screen.dart';
// import 'package:tryde_partner/features/porter_partner/screens/portner_verification.dart';

// class OrderDetailScreen extends StatelessWidget {
//   const OrderDetailScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         iconTheme: const IconThemeData(color: Colors.black),
//         title: const Text(
//           'Order Details',
//           style: TextStyle(color: Colors.black),
//         ),
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             _goodsImages(),
//             const SizedBox(height: 20),
//             _goodsInfo(),
//             const SizedBox(height: 16),
//             _description(),
//             const SizedBox(height: 20),
//             _locationCard(),
//             const SizedBox(height: 20),
//             _ownerDetails(),
//             const SizedBox(height: 20),
//             _pickupTime(),
//             const SizedBox(height: 20),
//             _videoSection(),
//             const SizedBox(height: 30),
//             _acceptRejectButtons(context),
//           ],
//         ),
//       ),
//     );
//   }

//   // 🔹 GOODS IMAGES
//   Widget _goodsImages() {
//     return SizedBox(
//       height: 160,
//       child: ListView(
//         scrollDirection: Axis.horizontal,
//         children: [
//           _imageItem(),
//           _imageItem(),
//           _imageItem(),
//         ],
//       ),
//     );
//   }

//   Widget _imageItem() {
//     return Container(
//       width: 160,
//       margin: const EdgeInsets.only(right: 12),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(12),
//         color: Colors.grey.shade300,
//       ),
//       child: const Icon(Icons.image, size: 60, color: Colors.grey),
//     );
//   }

//   // 🔹 GOODS INFO
//   Widget _goodsInfo() {
//     return Container(
//       padding: const EdgeInsets.all(16),
//       decoration: _cardDecoration(),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Text(
//             'Goods Details',
//             style: TextStyle(fontWeight: FontWeight.bold),
//           ),
//           const SizedBox(height: 12),
//           _infoRow('Height', '4 ft'),
//           _infoRow('Width', '3 ft'),
//           _infoRow('Weight', '120 kg'),
//         ],
//       ),
//     );
//   }

//   // 🔹 DESCRIPTION
//   Widget _description() {
//     return Container(
//       padding: const EdgeInsets.all(16),
//       decoration: _cardDecoration(),
//       child: const Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             'Description',
//             style: TextStyle(fontWeight: FontWeight.bold),
//           ),
//           SizedBox(height: 8),
//           Text(
//             'House shifting goods including bed, table, chairs and kitchen items. Handle with care.',
//             style: TextStyle(color: Colors.grey),
//           ),
//         ],
//       ),
//     );
//   }

//   // 🔹 PICKUP & DROP
//   Widget _locationCard() {
//     return Container(
//       padding: const EdgeInsets.all(16),
//       decoration: _cardDecoration(),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: const [
//           Text(
//             'Locations',
//             style: TextStyle(fontWeight: FontWeight.bold),
//           ),
//           SizedBox(height: 12),
//           Row(
//             children: [
//               Icon(Icons.my_location, color: Colors.green),
//               SizedBox(width: 8),
//               Expanded(child: Text('Vijay Nagar, Indore')),
//             ],
//           ),
//           SizedBox(height: 10),
//           Row(
//             children: [
//               Icon(Icons.location_on, color: Colors.red),
//               SizedBox(width: 8),
//               Expanded(child: Text('MP Nagar, Bhopal')),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   // 🔹 OWNER DETAILS
//   Widget _ownerDetails() {
//     return Container(
//       padding: const EdgeInsets.all(16),
//       decoration: _cardDecoration(),
//       child: Row(
//         children: [
//           const CircleAvatar(
//             radius: 24,
//             child: Icon(Icons.person),
//           ),
//           const SizedBox(width: 12),
//           const Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text('Rahul Sharma',
//                     style: TextStyle(fontWeight: FontWeight.bold)),
//                 Text('Goods Owner', style: TextStyle(color: Colors.grey)),
//               ],
//             ),
//           ),
//           IconButton(
//             icon: const Icon(Icons.call, color: Colors.green),
//             onPressed: () {},
//           ),
//         ],
//       ),
//     );
//   }

//   // 🔹 PICKUP TIME
//   Widget _pickupTime() {
//     return Container(
//       padding: const EdgeInsets.all(16),
//       decoration: _cardDecoration(),
//       child: const Row(
//         children: [
//           Icon(Icons.access_time, color: Colors.orange),
//           SizedBox(width: 10),
//           Text(
//             'Pickup Time: 22 Dec, 10:30 AM',
//             style: TextStyle(fontWeight: FontWeight.w500),
//           ),
//         ],
//       ),
//     );
//   }

//   // 🔹 VIDEO SECTION
//   Widget _videoSection() {
//     return Container(
//       padding: const EdgeInsets.all(16),
//       decoration: _cardDecoration(),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Text(
//             'Goods Video',
//             style: TextStyle(fontWeight: FontWeight.bold),
//           ),
//           const SizedBox(height: 12),
//           Container(
//             height: 180,
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(12),
//               color: Colors.black12,
//             ),
//             child: const Center(
//               child: Icon(Icons.play_circle_fill,
//                   size: 64, color: Colors.black54),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   // 🔹 ACCEPT / REJECT
//   Widget _acceptRejectButtons(BuildContext context) {
//     return Row(
//       children: [
//         Expanded(
//           child: OutlinedButton(
//             onPressed: () => Navigator.pop(context),
//             style: OutlinedButton.styleFrom(
//               foregroundColor: Colors.red,
//               side: const BorderSide(color: Colors.red),
//               padding: const EdgeInsets.symmetric(vertical: 14),
//             ),
//             child: const Text('Reject'),
//           ),
//         ),
//         const SizedBox(width: 12),
//         Expanded(
//           child: ElevatedButton(
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => const PickupVerificationMapScreen(),
//                 ),
//               );
//             },
//             style: ElevatedButton.styleFrom(
//               backgroundColor: AppColors.primary,
//               padding: const EdgeInsets.symmetric(vertical: 14),
//             ),
//             child: const Text('Accept Order'),
//           ),
//         ),
//       ],
//     );
//   }

//   // 🔹 COMMON
//   BoxDecoration _cardDecoration() {
//     return BoxDecoration(
//       borderRadius: BorderRadius.circular(12),
//       border: Border.all(color: Colors.grey.shade300),
//       color: Colors.white,
//     );
//   }

//   Widget _infoRow(String t, String v) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 4),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(t, style: const TextStyle(color: Colors.grey)),
//           Text(v, style: const TextStyle(fontWeight: FontWeight.w600)),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';  // Add this: video_player: ^2.9.1 in pubspec.yaml
import 'package:tryde_partner/core/constants/color_constants.dart';
import 'package:tryde_partner/features/porter_partner/screens/porter_dashboard_screen.dart';
import 'package:tryde_partner/features/porter_partner/screens/portner_verification.dart';

class OrderDetailScreen extends StatefulWidget {  // Changed to StatefulWidget for video controllers
  const OrderDetailScreen({super.key});

  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  late List<VideoPlayerController> _videoControllers;  // List for multiple videos

  @override
  void initState() {
    super.initState();
    _initializeVideos();
  }

  void _initializeVideos() {
    // Replace these paths with your actual MP4 asset paths (declare in pubspec.yaml: assets: - assets/videos/)
    final List<String> videoPaths = [
      'assets/goods/video1.mp4',  // Video 1
      'assets/goods/video2.mp4',  // Video 2
      'assets/goods/video3.mp4',  // Video 3
      'assets/goods/video4.mp4',  // Video 4
    ];

    _videoControllers = videoPaths.map((path) {
      final controller = VideoPlayerController.asset(path);
      controller.initialize().then((_) {
        if (mounted) setState(() {});  // Refresh UI after init
      }).catchError((error) {
        print('Video init error: $error');  // Handle errors
      });
      return controller;
    }).toList();
  }

  @override
  void dispose() {
    for (final controller in _videoControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          'Order Details',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _goodsImages(),
            const SizedBox(height: 20),
            _goodsInfo(),
            const SizedBox(height: 16),
            _description(),
            const SizedBox(height: 20),
            _locationCard(),
            const SizedBox(height: 20),
            _ownerDetails(),
            const SizedBox(height: 20),
            _pickupTime(),
            const SizedBox(height: 20),
            _videoSection(),
            const SizedBox(height: 30),
            _acceptRejectButtons(context),
          ],
        ),
      ),
    );
  }

  // 🔹 GOODS IMAGES (Unchanged from previous)
  Widget _goodsImages() {
    // Replace these paths with your actual asset paths in pubspec.yaml
    final List<String> goodsImagePaths = [
      'assets/goods/image1.avif',
      'assets/goods/image2.jpg',
      'assets/goods/image3.webp',
      'assets/goods/image4.avif',
    ];

    return SizedBox(
      height: 160,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: goodsImagePaths.length,
        itemBuilder: (context, index) {
          return _imageItem(goodsImagePaths[index]);
        },
      ),
    );
  }

  Widget _imageItem(String assetPath) {
    return Container(
      width: 160,
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        image: DecorationImage(
          image: AssetImage(assetPath),
          fit: BoxFit.cover,
        ),
        color: Colors.grey.shade300,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.asset(
          assetPath,
          width: 160,
          height: 160,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return const Icon(Icons.image, size: 60, color: Colors.grey);
          },
        ),
      ),
    );
  }

  // 🔹 GOODS INFO (Unchanged)
  Widget _goodsInfo() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Goods Details',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          _infoRow('Height', '4 ft'),
          _infoRow('Width', '3 ft'),
          _infoRow('Weight', '120 kg'),
        ],
      ),
    );
  }

  // 🔹 DESCRIPTION (Unchanged)
  Widget _description() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: _cardDecoration(),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Description',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text(
            'House shifting goods including bed, table, chairs and kitchen items. Handle with care.',
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }

  // 🔹 PICKUP & DROP (Unchanged)
  Widget _locationCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            'Locations',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 12),
          Row(
            children: [
              Icon(Icons.my_location, color: Colors.green),
              SizedBox(width: 8),
              Expanded(child: Text('Vijay Nagar, Indore')),
            ],
          ),
          SizedBox(height: 10),
          Row(
            children: [
              Icon(Icons.location_on, color: Colors.red),
              SizedBox(width: 8),
              Expanded(child: Text('MP Nagar, Bhopal')),
            ],
          ),
        ],
      ),
    );
  }

  // 🔹 OWNER DETAILS (Unchanged)
  Widget _ownerDetails() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: _cardDecoration(),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 24,
            child: Icon(Icons.person),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Rahul Sharma',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                Text('Goods Owner', style: TextStyle(color: Colors.grey)),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.call, color: Colors.green),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  // 🔹 PICKUP TIME (Unchanged)
  Widget _pickupTime() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: _cardDecoration(),
      child: const Row(
        children: [
          Icon(Icons.access_time, color: Colors.orange),
          SizedBox(width: 10),
          Text(
            'Pickup Time: 22 Dec, 10:30 AM',
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  // 🔹 VIDEO SECTION (Updated: Now plays 4 actual MP4 videos from assets)
  // Videos show as paused thumbnails; tap to play/pause. Horizontal scroll.
  Widget _videoSection() {
    if (_videoControllers.isEmpty || _videoControllers.every((c) => !c.value.isInitialized)) {
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: _cardDecoration(),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Goods Videos', style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 12),
            Center(child: CircularProgressIndicator()),
          ],
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Goods Videos (4 Videos)',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 180,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _videoControllers.length,  // 4 videos
              itemBuilder: (context, index) {
                final controller = _videoControllers[index];
                return _videoItem(controller, index);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _videoItem(VideoPlayerController controller, int index) {
    return Container(
      width: 160,
      margin: const EdgeInsets.only(right: 12),
      child: GestureDetector(
        onTap: () {
          setState(() {
            if (controller.value.isPlaying) {
              controller.pause();
            } else {
              controller.play();
            }
          });
        },
        child: Stack(
          alignment: Alignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: AspectRatio(
                aspectRatio: controller.value.aspectRatio,
                child: VideoPlayer(controller),
              ),
            ),
            if (!controller.value.isPlaying)
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.black26,
                ),
                child: const Icon(
                  Icons.play_circle_fill,
                  size: 64,
                  color: Colors.white,
                ),
              ),
            Positioned(
              bottom: 4,
              right: 4,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  'Video ${index + 1}',
                  style: const TextStyle(color: Colors.white, fontSize: 10),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 🔹 ACCEPT / REJECT (Unchanged)
  Widget _acceptRejectButtons(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: () => Navigator.pop(context),
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.red,
              side: const BorderSide(color: Colors.red),
              padding: const EdgeInsets.symmetric(vertical: 14),
            ),
            child: const Text('Reject'),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const PickupVerificationMapScreen(),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              padding: const EdgeInsets.symmetric(vertical: 14),
            ),
            child: const Text('Accept Order'),
          ),
        ),
      ],
    );
  }

  // 🔹 COMMON (Unchanged)
  BoxDecoration _cardDecoration() {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade300),
      color: Colors.white,
    );
  }

  Widget _infoRow(String t, String v) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(t, style: const TextStyle(color: Colors.grey)),
          Text(v, style: const TextStyle(fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}
