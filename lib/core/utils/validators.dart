class Validators {
  static String? validateRequired(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return "$fieldName is required";
    }
    return null;
  }

  static String? validateStudentID(String? value, String email){
    if (value == null || value.trim().isEmpty) {
      return "Student ID is required";
    }
    String extractedId = email.substring(0, 8);
    if(extractedId != value){
      return "StudentID not matching email";
    }
    return null;
  }
  
  static String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Email is required";
    }
    final RegExp emailRegex = RegExp(r"^\d{8}@stud\.fci-cu\.edu\.eg$");
    if (!emailRegex.hasMatch(value)) {
      return "Enter a valid email address";
    }
    return null;
  }

  /// Validates password strength (min 6 chars)
  static String? validatePassword(String? value) {
    if (value == null || value.length < 8) {
      return "Password must be at least 8 characters long";
    }
    final containDigit = RegExp(r"\d");
    if(!containDigit.hasMatch(value)){
      return "Password must contain at least 1 number";
    }
    return null;
  }

  static String? validateConfirmPassword(String? value, String originalPassword) {
    if (value == null || value.isEmpty) {
      return "Confirm Password is required";
    }
    if (value != originalPassword) {
      return "Passwords do not match";
    }
    return null;
  }
}
