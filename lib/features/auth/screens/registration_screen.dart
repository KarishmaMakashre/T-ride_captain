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

  // 🔹 ROLE BASED PRIMARY COLOR
  Color _primaryColor = AppColors.primary;

  // Form Controllers
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _dateOfBirthController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _districtController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _pincodeController = TextEditingController();
  final TextEditingController _aadharController = TextEditingController();
  final TextEditingController _panController = TextEditingController();
  final TextEditingController _emergencyContactController = TextEditingController();
  final TextEditingController _emergencyNameController = TextEditingController();
  final TextEditingController _emergencyRelationController = TextEditingController();



  String? _gender;
  String? _selectedVehicleType;

  final List<String> _genderOptions = ['Male', 'Female', 'Other'];
  List<String> get _vehicleTypes {
    if (_userRole == 'food') {
      return ['Motorcycle']; // 🍔 FOOD → ONLY BIKE
    }
    return [
      'Motorcycle',
      'Car',
      'Auto Rickshaw',
      'Mini Bus',
    ];
  }


  List<String> get _steps {
    if (_userRole == 'food') {
      return [
        'Personal',
        'Address',
        'Aadhar/PAN',
        'Documents',
      ];
    }
    return [
      'Personal',
      'Address',
      'Aadhar/PAN',
      'Vehicle',
      'Documents',
    ];
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
        return 'https://cdn-icons-png.flaticon.com/512/9983/9983137.png';
      case 'Car':
        return 'https://cdn-icons-png.flaticon.com/512/741/741407.png';
      case 'Auto Rickshaw':
        return 'data:image/jpeg;base64,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';
      case 'Mini Truck':
        return 'https://cdn-icons-png.flaticon.com/512/743/743131.png';
      default:
        return '';
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
                Text('Step ${_currentStep + 1}/${_steps.length}')

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
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.network(
                  _getVehicleImage(vehicle),
                  height: 48,
                  width: 48,
                  // color: selected ? null : Colors.grey.shade400,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return const SizedBox(
                      height: 48,
                      width: 48,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    );
                  },
                  errorBuilder: (_, __, ___) => Icon(
                    Icons.directions_car,
                    size: 32,
                    // color: Colors.grey,
                  ),
                ),

                const SizedBox(height: 12),
                Text(
                  vehicle,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: selected ? _primaryColor : Colors.black,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
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
              const Expanded(
                child: Text('I agree to Terms & Conditions'),
              ),
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
              padding:
              const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
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
              child: Icon(
                Icons.upload_file,
                color: _primaryColor,
                size: 24,
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
            Icon(
              Icons.chevron_right,
              color: Colors.grey.shade600,
            ),
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
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
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
