// // New file: lib/screens/item_details_screen.dart
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:google_mlkit_object_detection/google_mlkit_object_detection.dart'; // Add to pubspec.yaml: google_mlkit_object_detection: ^0.12.0
// import 'package:path/path.dart' as path; // For file name
// import 'package:tryde_partner/core/constants/color_constants.dart';

// class ItemDetailsScreen extends StatefulWidget {
//   const ItemDetailsScreen({super.key});

//   @override
//   State<ItemDetailsScreen> createState() => _ItemDetailsScreenState();
// }

// class _ItemDetailsScreenState extends State<ItemDetailsScreen> {
//   final ImagePicker _picker = ImagePicker();
//   List<File> _photos = []; // Up to 5 photos
//   File? _video;
//   final TextEditingController _descriptionController = TextEditingController();
//   final TextEditingController _weightController = TextEditingController();
//   final TextEditingController _heightController = TextEditingController();

//   late ObjectDetector _objectDetector;

//   @override
//   void initState() {
//     super.initState();
//     final options = ObjectDetectorOptions(
//       mode: DetectionMode.single,
//       classifyObjects: true,
//       multipleObjects: true,
//     );
//     _objectDetector = ObjectDetector(options: options);
//   }

//   @override
//   void dispose() {
//     _objectDetector.close();
//     super.dispose();
//   }

//   Future<void> _pickPhotos() async {
//     if (_photos.length >= 5) {
//       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Max 5 photos allowed")));
//       return;
//     }
//     final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
//     if (image != null) {
//       setState(() {
//         _photos.add(File(image.path));
//       });
//       _estimateDimensionsAndWeight();
//     }
//   }

//   Future<void> _pickVideo() async {
//     if (_video != null) {
//       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Only 1 video allowed")));
//       return;
//     }
//     final XFile? video = await _picker.pickVideo(source: ImageSource.gallery);
//     if (video != null) {
//       final file = File(video.path);
//       final sizeInBytes = await file.length();
//       if (sizeInBytes > 10 * 1024 * 1024) { // 10 MB limit
//         ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Video size exceeds 10 MB")));
//         return;
//       }
//       setState(() {
//         _video = file;
//       });
//       // For video, estimation could use frames, but for simplicity, skip or extract frame
//       // Placeholder: Extract first frame and process like image
//       _estimateDimensionsAndWeight(); // Assuming we process a frame
//     }
//   }

//   Future<void> _estimateDimensionsAndWeight() async {
//     if (_photos.isEmpty) return;

//     // Example with last photo; in practice, process all or selected
//     final inputImage = InputImage.fromFile(_photos.last);

//     final List<DetectedObject> objects = await _objectDetector.processImage(inputImage);

//     if (objects.isNotEmpty) {
//       final label = objects.first.labels.isNotEmpty ? objects.first.labels.first.text : 'Unknown';
//       // Placeholder estimation based on detected object
//       // In real app, use bounding box size relative to image, with reference scale
//       // Or lookup average sizes in a map
//       Map<String, Map<String, double>> averageSizes = {
//         'bottle': {'height': 20.0, 'weight': 0.5},
//         'book': {'height': 25.0, 'weight': 1.0},
//         // Add more
//       };

//       final estimates = averageSizes[label.toLowerCase()] ?? {'height': 0.0, 'weight': 0.0};

//       setState(() {
//         _heightController.text = estimates['height']!.toStringAsFixed(1);
//         _weightController.text = estimates['weight']!.toStringAsFixed(1);
//       });
//     } else {
//       setState(() {
//         _heightController.text = '0.0';
//         _weightController.text = '0.0';
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Item Details"),
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Text("Photos (up to 5)"),
//             const SizedBox(height: 8),
//             Wrap(
//               spacing: 8,
//               children: _photos.map((photo) => Image.file(photo, width: 100, height: 100, fit: BoxFit.cover)).toList(),
//             ),
//             ElevatedButton(
//               onPressed: _pickPhotos,
//               child: const Text("Add Photo"),
//             ),
//             const SizedBox(height: 24),
//             const Text("Video (1, max 10MB)"),
//             const SizedBox(height: 8),
//             if (_video != null) Text(path.basename(_video!.path)),
//             ElevatedButton(
//               onPressed: _pickVideo,
//               child: const Text("Add Video"),
//             ),
//             const SizedBox(height: 24),
//             TextField(
//               controller: _descriptionController,
//               decoration: const InputDecoration(
//                 labelText: "Description",
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             const SizedBox(height: 16),
//             TextField(
//               controller: _weightController,
//               keyboardType: TextInputType.number,
//               decoration: const InputDecoration(
//                 labelText: "Weight (kg) - AI Estimated",
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             const SizedBox(height: 16),
//             TextField(
//               controller: _heightController,
//               keyboardType: TextInputType.number,
//               decoration: const InputDecoration(
//                 labelText: "Height (cm) - AI Estimated",
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             const SizedBox(height: 24),
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.pop(context, {
//                   'description': _descriptionController.text,
//                   'weight': double.tryParse(_weightController.text) ?? 0.0,
//                   'height': double.tryParse(_heightController.text) ?? 0.0,
//                 });
//               },
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: AppColors.porterPrimary,
//                 padding: const EdgeInsets.symmetric(vertical: 16),
//                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//               ),
//               child: const Text("Save Details", style: TextStyle(color: Colors.white)),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// // Notes:
// // 1. Add to pubspec.yaml:
// // dependencies:
// //   image_picker: ^1.1.2
// //   google_mlkit_object_detection: ^0.12.0
// //   intl: ^0.18.1
// //   path: ^1.8.3
// //
// // 2. For better AI estimation, consider integrating AR (arkit/arcore) for real dimensions, or use more advanced models.
// // 3. Current AI uses object detection to detect label, then placeholder averages. Enhance the map with more items.
// // 4. For video, to process, you can use video_player to extract frames and run detection on frames.
// // 5. Permissions for camera/gallery already handled in previous code.25.3sExpert

// New file: lib/screens/item_details_screen.dart
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart'; // Add to pubspec.yaml: camera: ^0.10.5+5
import 'package:google_mlkit_object_detection/google_mlkit_object_detection.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tryde_partner/core/constants/color_constants.dart';

class ItemDetailsScreen extends StatefulWidget {
  const ItemDetailsScreen({super.key});

  @override
  State<ItemDetailsScreen> createState() => _ItemDetailsScreenState();
}

class _ItemDetailsScreenState extends State<ItemDetailsScreen> {
  List<File> _photos = []; // Up to 5 photos
  File? _video;
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _lengthController = TextEditingController();
  final TextEditingController _breadthController = TextEditingController();
  final TextEditingController _areaController = TextEditingController();

  late ObjectDetector _objectDetector;
  CameraController? _cameraController;
  bool _isCameraInitialized = false;
  bool _isDetecting = false;
  DetectedObject? _detectedObject;
  Map<String, double> _estimates = {};

  @override
  void initState() {
    super.initState();
    _initializeObjectDetector();
    _initializeCamera();
  }

  Future<void> _initializeObjectDetector() async {
    final options = ObjectDetectorOptions(
      mode: DetectionMode.single,
      classifyObjects: true,
      multipleObjects: true,
    );
    _objectDetector = ObjectDetector(options: options);
  }

  Future<void> _initializeCamera() async {
    final cameras = await availableCameras();
    if (cameras.isNotEmpty) {
      _cameraController = CameraController(
        cameras.first,
        ResolutionPreset.medium,
        enableAudio: false,
      );
      await _cameraController!.initialize();
      setState(() {
        _isCameraInitialized = true;
      });
      _startImageStream();
    }
  }

  void _startImageStream() {
    _cameraController?.startImageStream((CameraImage image) {
      if (_isDetecting || !_isCameraInitialized) return;
      _isDetecting = true;
      _processCameraImage(image);
    });
  }

  Future<void> _processCameraImage(CameraImage image) async {
    final WriteBuffer allBytes = WriteBuffer();
    for (Plane plane in image.planes) {
      allBytes.putUint8List(plane.bytes);
    }
    final bytes = allBytes.done().buffer.asUint8List();

    final Size imageSize = Size(
      image.width.toDouble(),
      image.height.toDouble(),
    );

    final camera = _cameraController!.description;
    final imageRotation = InputImageRotationValue.fromRawValue(
      camera.sensorOrientation,
    );
    final inputImageFormat = InputImageFormatValue.fromRawValue(
      image.format.raw,
    );

    final inputImageMetadata = InputImageMetadata(
      size: imageSize,
      rotation: imageRotation!,
      format: inputImageFormat!,
      bytesPerRow: image.planes[0].bytesPerRow,
    );

    final inputImage = InputImage.fromBytes(
      bytes: bytes,
      metadata: inputImageMetadata,
    );

    if (inputImage != null) {
      final predictedObjects = await _objectDetector.processImage(inputImage);
      if (predictedObjects.isNotEmpty && mounted) {
        setState(() {
          _detectedObject = predictedObjects.first;
          _updateEstimates();
        });
      }
    }

    if (mounted) {
      setState(() {
        _isDetecting = false;
      });
    }
  }

  void _updateEstimates() {
    if (_detectedObject == null || _detectedObject!.labels.isEmpty) return;

    final label = _detectedObject!.labels.first.text.toLowerCase();
    // Enhanced map with length, breadth, height, weight, area (assuming square base for simplicity)
    Map<String, Map<String, double>> averageSizes = {
      'bottle': {
        'length': 8.0,
        'breadth': 8.0,
        'height': 20.0,
        'weight': 0.5,
        'area': 64.0,
      },
      'book': {
        'length': 15.0,
        'breadth': 2.0,
        'height': 25.0,
        'weight': 1.0,
        'area': 30.0,
      },
      'box': {
        'length': 20.0,
        'breadth': 15.0,
        'height': 10.0,
        'weight': 2.0,
        'area': 300.0,
      },
      'phone': {
        'length': 15.0,
        'breadth': 7.0,
        'height': 0.8,
        'weight': 0.2,
        'area': 105.0,
      },
      // Add more based on common objects
    };

    final estimates =
        averageSizes[label] ??
        {
          'length': 0.0,
          'breadth': 0.0,
          'height': 0.0,
          'weight': 0.0,
          'area': 0.0,
        };

    setState(() {
      _estimates = estimates;
    });
  }

  Future<void> _captureAndSet() async {
    if (_cameraController == null || !_cameraController!.value.isInitialized)
      return;

    try {
      final XFile imageFile = await _cameraController!.takePicture();
      final file = File(imageFile.path);
      if (_photos.length < 5) {
        setState(() {
          _photos.add(file);
        });
      }

      // Set estimates to fields
      _heightController.text =
          _estimates['height']?.toStringAsFixed(1) ?? '0.0';
      _lengthController.text =
          _estimates['length']?.toStringAsFixed(1) ?? '0.0';
      _breadthController.text =
          _estimates['breadth']?.toStringAsFixed(1) ?? '0.0';
      _areaController.text = _estimates['area']?.toStringAsFixed(1) ?? '0.0';
      _weightController.text =
          _estimates['weight']?.toStringAsFixed(1) ?? '0.0';

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "Object detected: ${_detectedObject?.labels.first.text ?? 'Unknown'} - Estimates set!",
            ),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Error capturing: $e")));
      }
    }
  }

  Future<void> _pickVideo() async {
    // Keep gallery for video, or extend camera to video if needed
    // For now, using gallery as before
    final picker = ImagePicker();
    if (_video != null) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text("Only 1 video allowed")));
      }
      return;
    }
    final XFile? video = await picker.pickVideo(source: ImageSource.gallery);
    if (video != null) {
      final file = File(video.path);
      final sizeInBytes = await file.length();
      if (sizeInBytes > 10 * 1024 * 1024) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Video size exceeds 10 MB")),
          );
        }
        return;
      }
      setState(() {
        _video = file;
      });
    }
  }

  @override
  void dispose() {
    _objectDetector.close();
    _cameraController?.dispose();
    _descriptionController.dispose();
    _weightController.dispose();
    _heightController.dispose();
    _lengthController.dispose();
    _breadthController.dispose();
    _areaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Item Details"),
        backgroundColor: AppColors.porterPrimary,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Camera Preview Section for AI Detection
            const Text(
              "Capture Item with AI (Camera)",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Container(
              height: 240,
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: _isCameraInitialized
                    ? Stack(
                        fit: StackFit.expand,
                        children: [
                          CameraPreview(_cameraController!),
                          if (_detectedObject != null && _estimates.isNotEmpty)
                            Positioned(
                              bottom: 20,
                              left: 20,
                              right: 20,
                              child: Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: Colors.black54,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Column(
                                  children: [
                                    Text(
                                      "Detected: ${_detectedObject!.labels.first.text}",
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      "Est. L: ${_estimates['length']?.toStringAsFixed(1)}cm | B: ${_estimates['breadth']?.toStringAsFixed(1)}cm | H: ${_estimates['height']?.toStringAsFixed(1)}cm\nArea: ${_estimates['area']?.toStringAsFixed(1)}cm² | W: ${_estimates['weight']?.toStringAsFixed(1)}kg",
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                        ],
                      )
                    : const Center(child: CircularProgressIndicator()),
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _captureAndSet,
                icon: const Icon(Icons.camera_alt),
                label: const Text("Capture & Set Estimates"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.porterPrimary,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Photos Thumbnails
            const Text(
              "Photos (up to 5)",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: 120,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _photos.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.only(right: 8),
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.file(
                            _photos[index],
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned(
                          top: 0,
                          right: 0,
                          child: GestureDetector(
                            onTap: () =>
                                setState(() => _photos.removeAt(index)),
                            child: Container(
                              padding: const EdgeInsets.all(4),
                              decoration: const BoxDecoration(
                                color: Colors.red,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.close,
                                color: Colors.white,
                                size: 16,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 24),

            // Video
            const Text(
              "Video (1, max 10MB)",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            if (_video != null) ...[
              Text(
                "Video: ${_video!.path.split('/').last}",
                style: const TextStyle(fontSize: 14),
              ),
              const SizedBox(height: 4),
              ElevatedButton.icon(
                onPressed: () => setState(() => _video = null),
                icon: const Icon(Icons.delete),
                label: const Text("Remove Video"),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              ),
            ],
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _pickVideo,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.porterPrimary,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
                icon: const Icon(Icons.video_library),
                label: const Text("Add Video from Gallery"),
              ),
            ),

            const SizedBox(height: 24),

            // Description
            const Text(
              "Description",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _descriptionController,
              maxLines: 3,
              decoration: const InputDecoration(
                hintText: "Enter item description...",
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.all(12),
              ),
            ),
            const SizedBox(height: 16),

            // AI Estimated Fields
            const Text(
              "AI Estimated Dimensions",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _lengthController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: "Length (cm)",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    controller: _breadthController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: "Breadth (cm)",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _heightController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: "Height (cm)",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    controller: _areaController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: "Area (cm²)",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _weightController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Weight (kg)",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),

            // Save Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context, {
                    'description': _descriptionController.text,
                    'weight': double.tryParse(_weightController.text) ?? 0.0,
                    'height': double.tryParse(_heightController.text) ?? 0.0,
                    'length': double.tryParse(_lengthController.text) ?? 0.0,
                    'breadth': double.tryParse(_breadthController.text) ?? 0.0,
                    'area': double.tryParse(_areaController.text) ?? 0.0,
                    'photos': _photos,
                    'video': _video,
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.porterPrimary,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  "Save Details",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
