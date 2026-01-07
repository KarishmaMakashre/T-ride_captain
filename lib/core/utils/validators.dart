

class Validators {
  // Phone number validator: Required, exactly 10 digits, numeric only
  static String? validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number is required';
    }
    if (value.length != 10) {
      return 'Phone number must be exactly 10 digits';
    }
    if (!RegExp(r'^\d{10}$').hasMatch(value)) {
      return 'Enter valid 10-digit phone number';
    }
    return null; // Valid
  }

  // Generic required validator (reusable for any field)
  static String? validateRequired(String? value, {String fieldName = 'This field'}) {
    if (value == null || value.isEmpty) {
      return '$fieldName is required';
    }
    return null;
  }


  // OTP validator
  static String? validateOtp(String? value) {
  if (value == null || value.length != 6) {
    return 'Enter 6-digit OTP';
  }
  if (!RegExp(r'^\d{6}$').hasMatch(value)) {
    return 'Enter valid OTP';
  }
  return null;
}

  // Email validator (example for future use)
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'Enter a valid email';
    }
    return null;
  }

  // Password validator (example: min 8 chars, with number and special char)
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 8) {
      return 'Password must be at least 8 characters';
    }
    if (!RegExp(r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$').hasMatch(value)) {
      return 'Password must contain a letter, number, and special character';
    }
    return null;
  }

  // Add more validators here as needed (e.g., for OTP, name, etc.)
}