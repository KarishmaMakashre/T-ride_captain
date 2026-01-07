import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../../core/constants/color_constants.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isEditing = false;
  File? _profileImage;

  final ImagePicker _picker = ImagePicker();

  // TextControllers
  final TextEditingController nameController =
      TextEditingController(text: "Abhishek Kachhawa");

  final TextEditingController emailController =
      TextEditingController(text: "abhishekkachhawa1205@gmail.com");

  final TextEditingController phoneController =
      TextEditingController(text: "+91 9644782290");

  final TextEditingController ageController =
      TextEditingController(text: "24");

  String gender = "Male";


Future<void> pickImage(bool fromCamera) async {
  // Permission check karo
  Permission permission = fromCamera ? Permission.camera : Permission.photos;

  // Android 13+ ke liye alag handle
  if (Platform.isAndroid) {
    if (fromCamera) {
      permission = Permission.camera;
    } else {
      // Android 13+ -> READ_MEDIA_IMAGES
      if (await Permission.photos.isGranted || await Permission.storage.isGranted) {
        permission = Permission.photos;
      } else {
        permission = await [Permission.photos, Permission.storage].request().then((statuses) {
          return statuses.values.every((status) => status.isGranted) ? Permission.photos : Permission.unknown;
        });
      }
    }
  }

  var status = await permission.request();

  if (status.isGranted) {
    final XFile? image = await _picker.pickImage(
      source: fromCamera ? ImageSource.camera : ImageSource.gallery,
      imageQuality: 70,
    );

    if (image != null) {
      setState(() {
        _profileImage = File(image.path);
      });
    }
  } else if (status.isDenied) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Permission denied. Cannot pick image.")),
    );
  } else if (status.isPermanentlyDenied) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Please enable permission from settings"),
        action: SnackBarAction(
          label: "Open Settings",
          onPressed: () => openAppSettings(),
        ),
      ),
    );
  }
}

  void showPhotoOptions() {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.camera_alt, color: AppColors.primary),
                title: Text("Take Photo"),
                onTap: () {
                  Navigator.pop(context);
                  pickImage(true);
                },
              ),
              ListTile(
                leading: Icon(Icons.photo_library, color: AppColors.primary),
                title: Text("Choose From Gallery"),
                onTap: () {
                  Navigator.pop(context);
                  pickImage(false);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Color bubble = AppColors.primary.withOpacity(0.20);

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: const Text("My Profile"),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: AppColors.textPrimary,
      ),

      body: Stack(
        children: [
          Positioned(
            top: -60,
            right: -20,
            child: _bubble(160, bubble),
          ),
          Positioned(
            bottom: -50,
            left: -20,
            child: _bubble(140, bubble),
          ),
          Positioned(
            bottom: 120,
            right: -10,
            child: _bubble(90, bubble),
          ),

          // MAIN UI
          SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // ⭐ Profile Avatar
                GestureDetector(
                  onTap: showPhotoOptions,
                  child: Stack(
                    children: [
                      CircleAvatar(
                        radius: 55,
                        backgroundColor: AppColors.primary.withOpacity(0.3),
                        backgroundImage:
                            _profileImage != null ? FileImage(_profileImage!) : null,
                        child: _profileImage == null
                            ? Icon(Icons.person, size: 55, color: AppColors.primary)
                            : null,
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: CircleAvatar(
                          radius: 18,
                          backgroundColor: AppColors.primary,
                          child: Icon(Icons.edit, size: 16, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                _buildCard("Full Name", nameController, isEditing),
                _buildCard("Email", emailController, isEditing),
                _buildCard("Phone Number", phoneController, false), // locked
                _buildCard("Age", ageController, isEditing),

                // Gender Dropdown
                Container(
                  padding: EdgeInsets.all(14),
                  margin: EdgeInsets.only(top: 12),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5)],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Gender",
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textPrimary)),

                      DropdownButton<String>(
                        value: gender,
                        underline: SizedBox(),
                        onChanged: isEditing
                            ? (v) => setState(() => gender = v!)
                            : null,
                        items: const [
                          DropdownMenuItem(value: "Male", child: Text("Male")),
                          DropdownMenuItem(value: "Female", child: Text("Female")),
                          DropdownMenuItem(value: "Other", child: Text("Other")),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 80),
              ],
            ),
          ),
        ],
      ),

      // ✔ Edit button bottom me
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            padding: EdgeInsets.symmetric(vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          onPressed: () => setState(() => isEditing = !isEditing),
          child: Text(
            isEditing ? "Save Changes" : "Edit Profile",
            style: TextStyle(fontSize: 16, color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget _buildCard(
      String title, TextEditingController controller, bool enabled) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.95),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary)),
          TextField(
            controller: controller,
            enabled: enabled,
            decoration: const InputDecoration(
              border: InputBorder.none,
            ),
          ),
        ],
      ),
    );
  }

  Widget _bubble(double size, Color color) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}
