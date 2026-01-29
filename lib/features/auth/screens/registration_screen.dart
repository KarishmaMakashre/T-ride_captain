import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tryde_partner/core/constants/color_constants.dart';
import '../../../core/constants/app_constants.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final PageController _pageController = PageController();
  int _currentStep = 0;

  Color _primaryColor = AppColors.primary;

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _dateOfBirthController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _districtController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _pincodeController = TextEditingController();
  final TextEditingController _aadharController = TextEditingController();
  final TextEditingController _panController = TextEditingController();
  final TextEditingController _emergencyContactController =
      TextEditingController();
  final TextEditingController _emergencyNameController =
      TextEditingController();
  final TextEditingController _emergencyRelationController =
      TextEditingController();

  String? _gender;
  String? _selectedVehicleType;

  final List<String> _genderOptions = ['Male', 'Female', 'Other'];
  List<String> get _vehicleTypes {
    if (_userRole == 'porter') {
      return ['Mini Truck', 'Truck', 'Pickup Van'];
    } else if (_userRole == 'rider') {
      return ['Motorcycle', 'Car', 'Auto Rickshaw', 'E-Rickshaw', 'Mini Bus'];
    } else {
      return ['Motorcycle', 'Car'];
    }
  }

  List<String> get _steps {
    return ['Personal', 'Address', 'Aadhar/PAN', 'Vehicle', 'Documents'];
  }

  String? _userRole;

  bool _acceptTerms = false;

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      _dateOfBirthController.text =
          '${picked.day}/${picked.month}/${picked.year}';
    }
  }

  @override
  void initState() {
    super.initState();
    _loadRoleColor();
  }

  /// 🔹 LOAD ROLE & SET COLOR
  Future<void> _loadRoleColor() async {
    final prefs = await SharedPreferences.getInstance();
    final role = prefs.getString('user_role');

    setState(() {
      _userRole = role; // ✅ STORE ROLE

      if (role == 'rider') {
        _primaryColor = const Color(0xFF2196F3);
      } else if (role == 'porter') {
        _primaryColor = const Color(0xFF5A189A);
      } else if (role == 'food') {
        _primaryColor = const Color(0xffD66D26);
      } else {
        _primaryColor = AppColors.primary;
      }
    });
  }

  String _getVehicleImage(String vehicle) {
    switch (vehicle) {
      case 'Motorcycle':
        return 'assets/images/vehicles/pickup_man.jpg';
      case 'Car':
        return 'assets/images/vehicles/car.png';
      case 'Auto Rickshaw':
        return 'assets/images/vehicles/rikshaw.png';
      case 'E-Rickshaw':
        return 'assets/images/vehicles/e-rikshaw.png';
      case 'Mini Bus':
        return 'assets/images/vehicles/mini_bus.jpg';
      case 'Mini Truck':
        return 'assets/images/vehicles/pickup_truck.jpg';
      case 'Truck':
        return 'assets/images/vehicles/eicher_truck.jpg';
      case 'Pickup Van':
        return 'assets/images/vehicles/pickup_van.jpg';
      default:
        return 'assets/images/bike.png';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: _primaryColor),
          onPressed: () => context.pop(),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Registration',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Column(
        children: [
          _buildProgressBar(),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _getStepTitle(),
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
                Text('Step ${_currentStep + 1}/${_steps.length}'),
              ],
            ),
          ),

          Expanded(
            child: PageView(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              onPageChanged: (index) {
                setState(() => _currentStep = index);
              },
              children: _userRole == 'food'
                  ? [
                      _buildPersonalInfoStep(),
                      _buildAddressStep(),
                      _buildAadharPanStep(),
                      _buildVehicleStep(),
                      _buildDocumentsStep(), // 🚫 Vehicle skipped
                    ]
                  : [
                      _buildPersonalInfoStep(),
                      _buildAddressStep(),
                      _buildAadharPanStep(),
                      _buildVehicleStep(),
                      _buildDocumentsStep(),
                    ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                if (_currentStep > 0)
                  Expanded(
                    child: OutlinedButton(
                      onPressed: _goToPreviousStep,
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        side: BorderSide(color: _primaryColor),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        'Back',
                        style: TextStyle(
                          color: _primaryColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),

                if (_currentStep > 0) const SizedBox(width: 12),

                Expanded(
                  child: ElevatedButton(
                    // 🔥 TERMS CONDITION APPLY ONLY ON LAST STEP
                    onPressed:
                        (_currentStep == _steps.length - 1 && !_acceptTerms)
                        ? null
                        : _goToNextStep,

                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          (_currentStep == _steps.length - 1 && !_acceptTerms)
                          ? _primaryColor.withOpacity(0.5)
                          : _primaryColor,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      // 🔥 ROLE SAFE SUBMIT TEXT
                      _currentStep == _steps.length - 1 ? 'Submit' : 'Next',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
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

  // ================= HELPERS =================

  Widget _buildProgressBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: _steps.asMap().entries.map((entry) {
              final index = entry.key;
              return Column(
                children: [
                  Text(
                    entry.value,
                    style: TextStyle(
                      fontSize: 12,
                      color: index <= _currentStep
                          ? _primaryColor
                          : Colors.grey.shade400,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: index <= _currentStep
                          ? _primaryColor
                          : Colors.grey.shade300,
                    ),
                  ),
                ],
              );
            }).toList(),
          ),
          const SizedBox(height: 4),
          LinearProgressIndicator(
            value: (_currentStep + 1) / _steps.length,
            backgroundColor: Colors.grey.shade300,
            color: _primaryColor,
            minHeight: 2,
          ),
        ],
      ),
    );
  }

  String _getStepTitle() {
    if (_userRole == 'food') {
      switch (_currentStep) {
        case 0:
          return 'Personal Information';
        case 1:
          return 'Address Details';
        case 2:
          return 'Aadhar & PAN';
        case 3:
          return 'Upload Documents';
        default:
          return '';
      }
    }

    // NON-FOOD
    switch (_currentStep) {
      case 0:
        return 'Personal Information';
      case 1:
        return 'Address Details';
      case 2:
        return 'Aadhar & PAN';
      case 3:
        return 'Vehicle Type';
      case 4:
        return 'Upload Documents';
      default:
        return '';
    }
  }

  void _goToNextStep() {
    if (_currentStep < _steps.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _showSuccessDialog(); // 🔥 LAST STEP
    }
  }

  void _goToPreviousStep() {
    if (_currentStep > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Widget _buildPersonalInfoStep() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          const SizedBox(height: 16),

          // Profile Image
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: _primaryColor, width: 2),
            ),
            child: Icon(Icons.person, size: 60, color: _primaryColor),
          ),

          const SizedBox(height: 24),

          _buildTextField(
            controller: _firstNameController,
            label: 'First Name',
            hintText: 'Enter first name',
            prefixIcon: Icons.person_outline,
          ),
          const SizedBox(height: 16),

          _buildTextField(
            controller: _lastNameController,
            label: 'Last Name',
            hintText: 'Enter last name',
            prefixIcon: Icons.person_outline,
          ),
          const SizedBox(height: 16),

          _buildTextField(
            controller: _dateOfBirthController,
            label: 'Date of Birth',
            hintText: 'DD/MM/YYYY',
            prefixIcon: Icons.calendar_today,
            readOnly: true,
            onTap: _selectDate,
          ),

          const SizedBox(height: 24),

          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Gender',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
          ),
          const SizedBox(height: 8),

          Wrap(
            spacing: 12,
            children: _genderOptions.map((g) {
              final selected = _gender == g;
              return ChoiceChip(
                label: Text(g),
                selected: selected,
                selectedColor: _primaryColor,
                labelStyle: TextStyle(
                  color: selected ? Colors.white : Colors.black,
                ),
                onSelected: (_) {
                  setState(() => _gender = g);
                },
              );
            }).toList(),
          ),

          const SizedBox(height: 24),

          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Emergency Contact Details',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
          ),

          const SizedBox(height: 12),

          // 🔹 Emergency Name
          _buildTextField(
            controller: _emergencyNameController,
            label: 'Emergency Contact Name',
            hintText: 'Enter contact name',
            prefixIcon: Icons.person_outline,
          ),

          const SizedBox(height: 16),

          // 🔹 Relationship
          _buildTextField(
            controller: _emergencyRelationController,
            label: 'Relationship',
            hintText: 'Father / Mother / Spouse / Friend',
            prefixIcon: Icons.people_outline,
          ),

          const SizedBox(height: 16),

          // 🔹 Emergency Number
          _buildTextField(
            controller: _emergencyContactController,
            label: 'Emergency Contact Number',
            hintText: '10 digit mobile number',
            prefixIcon: Icons.phone_in_talk_outlined,
            keyboardType: TextInputType.phone,
            maxLength: 10,
          ),
        ],
      ),
    );
  }

  Widget _buildAddressStep() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          _buildTextField(
            controller: _stateController,
            label: 'State',
            hintText: 'Enter state',
            prefixIcon: Icons.map_outlined,
          ),
          const SizedBox(height: 16),

          _buildTextField(
            controller: _districtController,
            label: 'District',
            hintText: 'Enter district',
            prefixIcon: Icons.location_city_outlined,
          ),
          const SizedBox(height: 16),

          _buildTextField(
            controller: _addressController,
            label: 'Address',
            hintText: 'Enter address',
            prefixIcon: Icons.home_outlined,
            maxLines: 3,
          ),
          const SizedBox(height: 16),

          _buildTextField(
            controller: _pincodeController,
            label: 'Pincode',
            hintText: '6 digit pincode',
            prefixIcon: Icons.pin_drop_outlined,
            keyboardType: TextInputType.number,
            maxLength: 6,
          ),
        ],
      ),
    );
  }

  Widget _buildAadharPanStep() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          _buildTextField(
            controller: _aadharController,
            label: 'Aadhar Number',
            hintText: '12 digit Aadhar',
            prefixIcon: Icons.credit_card,
            keyboardType: TextInputType.number,
            maxLength: 12,
          ),
          const SizedBox(height: 16),

          _buildUploadCard(
            title: 'Upload Aadhar Card',
            subtitle: 'Front & Back',
            onUpload: () {},
          ),
          const SizedBox(height: 24),

          _buildTextField(
            controller: _panController,
            label: 'PAN Number',
            hintText: 'Enter PAN',
            prefixIcon: Icons.badge_outlined,
            maxLength: 10,
          ),
          const SizedBox(height: 16),

          _buildUploadCard(
            title: 'Upload PAN Card',
            subtitle: 'Clear image',
            onUpload: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildVehicleStep() {
    return GridView.builder(
      padding: const EdgeInsets.all(24),
      itemCount: _vehicleTypes.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 1.2,
      ),
      itemBuilder: (_, index) {
        final vehicle = _vehicleTypes[index];
        final selected = _selectedVehicleType == vehicle;

        return GestureDetector(
          onTap: () {
            setState(() => _selectedVehicleType = vehicle);
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: selected ? _primaryColor : Colors.grey.shade300,
                width: selected ? 2 : 1,
              ),
              color: selected ? _primaryColor.withOpacity(0.05) : Colors.white,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  _getVehicleImage(vehicle),
                  height: 64,
                  width: 64,
                  fit: BoxFit.contain,
                  errorBuilder: (_, __, ___) => Icon(
                    Icons.directions_car,
                    size: 40,
                    color: Colors.grey.shade400,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  vehicle,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: selected ? _primaryColor : AppColors.textPrimary,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Widget _buildVehicleStep() {
  //   return GridView.builder(
  //     padding: const EdgeInsets.all(24),
  //     itemCount: _vehicleTypes.length,
  //     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
  //       crossAxisCount: 2,
  //       crossAxisSpacing: 16,
  //       mainAxisSpacing: 16,
  //       childAspectRatio: 1.2,
  //     ),
  //     itemBuilder: (_, index) {
  //       final vehicle = _vehicleTypes[index];
  //       final selected = _selectedVehicleType == vehicle;

  //       return GestureDetector(
  //         onTap: () {
  //           setState(() => _selectedVehicleType = vehicle);
  //         },
  //         child: Container(
  //           decoration: BoxDecoration(
  //             borderRadius: BorderRadius.circular(12),
  //             border: Border.all(
  //               color: selected ? _primaryColor : Colors.grey.shade300,
  //               width: selected ? 2 : 1,
  //             ),
  //           ),
  //           child: Column(
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             children: [
  //               Image.network(
  //                 _getVehicleImage(vehicle),
  //                 height: 48,
  //                 width: 48,
  //                 // color: selected ? null : Colors.grey.shade400,
  //                 loadingBuilder: (context, child, loadingProgress) {
  //                   if (loadingProgress == null) return child;
  //                   return const SizedBox(
  //                     height: 48,
  //                     width: 48,
  //                     child: CircularProgressIndicator(strokeWidth: 2),
  //                   );
  //                 },
  //                 errorBuilder: (_, __, ___) => Icon(
  //                   Icons.directions_car,
  //                   size: 32,
  //                   // color: Colors.grey,
  //                 ),
  //               ),

  //               const SizedBox(height: 12),
  //               Text(
  //                 vehicle,
  //                 style: TextStyle(
  //                   fontWeight: FontWeight.w600,
  //                   color: selected ? _primaryColor : Colors.black,
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }
  Widget _buildDocumentsStep() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          // ✅ VEHICLE IMAGE (NOW FOR FOOD ALSO)
          _buildDocumentUploadCard(
            title: 'Vehicle Image',
            subtitle: 'Clear photo of your vehicle',
            onUpload: () {},
          ),

          const SizedBox(height: 16),

          _buildDocumentUploadCard(
            title: 'Driving Licence',
            subtitle: 'Front & Back',
            onUpload: () {},
          ),

          const SizedBox(height: 16),

          _buildDocumentUploadCard(
            title: 'Vehicle RC',
            subtitle: 'Registration Certificate',
            onUpload: () {},
          ),

          const SizedBox(height: 16),

          _buildDocumentUploadCard(
            title: 'Insurance',
            subtitle: 'Valid Insurance',
            onUpload: () {},
          ),

          const SizedBox(height: 24),

          Row(
            children: [
              Checkbox(
                value: _acceptTerms,
                activeColor: _primaryColor,
                onChanged: (value) {
                  setState(() {
                    _acceptTerms = value ?? false;
                  });
                },
              ),
              const Expanded(child: Text('I agree to Terms & Conditions')),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDocumentUploadCard({
    required String title,
    required String subtitle,
    required VoidCallback onUpload,
  }) {
    return GestureDetector(
      onTap: onUpload,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: _primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                Icons.description_outlined,
                color: _primaryColor,
                size: 26,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
              decoration: BoxDecoration(
                color: _primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                'Upload',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: _primaryColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hintText,
    required IconData prefixIcon,
    bool readOnly = false,
    int maxLines = 1,
    TextInputType? keyboardType,
    int? maxLength,
    VoidCallback? onTap,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          readOnly: readOnly,
          maxLines: maxLines,
          keyboardType: keyboardType,
          maxLength: maxLength,
          onTap: onTap,
          decoration: InputDecoration(
            hintText: hintText,
            counterText: '',
            prefixIcon: Icon(prefixIcon, color: Colors.grey.shade600),
            filled: true,
            fillColor: Colors.grey.shade50,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: _primaryColor),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: _primaryColor, width: 2),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildUploadCard({
    required String title,
    required String subtitle,
    required VoidCallback onUpload,
  }) {
    return GestureDetector(
      onTap: onUpload,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: _primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(Icons.upload_file, color: _primaryColor, size: 24),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.chevron_right, color: Colors.grey.shade600),
          ],
        ),
      ),
    );
  }

  IconData _getVehicleIcon(String vehicle) {
    switch (vehicle) {
      case 'Motorcycle':
        return Icons.motorcycle;
      case 'Car':
        return Icons.directions_car;
      case 'Auto Rickshaw':
        return Icons.moped;
      case 'Mini Truck':
        return Icons.local_shipping;
      case 'Truck':
        return Icons.fire_truck;
      default:
        return Icons.directions_car;
    }
  }

  Future<void> _showSuccessDialog() async {
    final prefs = await SharedPreferences.getInstance();
    final role = prefs.getString('user_role');

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Registration Successful'),
        content: const Text(
          'Your registration has been completed successfully.',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // dialog close

              if (role == 'food') {
                context.go(AppConstants.routeFood);
              } else if (role == 'rider') {
                context.go('/home');
              } else if (role == 'porter') {
                context.go('/porter-dashboard');
              } else {
                context.go(AppConstants.routeLogin);
              }
            },
            child: Text(
              'OK',
              style: TextStyle(
                color: _primaryColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
