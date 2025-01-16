import 'package:flutter/material.dart';

// Widget untuk field nama
Widget buildNameField(TextEditingController controller) {
  return TextFormField(
    controller: controller,
    decoration: InputDecoration(
      hintText: 'Enter your name',
      filled: true,
      fillColor: const Color(0xFFF3F8FF),
      labelStyle: const TextStyle(color: Colors.black),
      hintStyle: const TextStyle(color: Colors.grey),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Colors.blue, width: 2),
      ),
    ),
    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'Please enter your name';
      }
      return null;
    },
  );
}

// Widget untuk field username
Widget buildUsernameField(TextEditingController controller) {
  return TextFormField(
    controller: controller,
    decoration: InputDecoration(
      hintText: 'Enter your username',
      filled: true,
      fillColor: const Color(0xFFF3F8FF),
      labelStyle: const TextStyle(color: Colors.black),
      hintStyle: const TextStyle(color: Colors.grey),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Colors.blue, width: 2),
      ),
    ),
    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'Please enter your username';
      }
      return null;
    },
  );
}

// Widget untuk field email
Widget buildEmailField(TextEditingController controller) {
  return TextFormField(
    controller: controller,
    decoration: InputDecoration(
      hintText: 'Enter your email',
      filled: true,
      fillColor: const Color(0xFFF3F8FF),
      labelStyle: const TextStyle(color: Colors.black),
      hintStyle: const TextStyle(color: Colors.grey),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Colors.blue, width: 2),
      ),
    ),
    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'Please enter your email';
      }
      if (!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$').hasMatch(value)) {
        return 'Please enter a valid email';
      }
      return null;
    },
  );
}

// Widget untuk field gender
Widget buildGenderField(String? selectedGender, Function(String?) onChanged) {
  return DropdownButtonFormField<String>(
    value: selectedGender,
    decoration: InputDecoration(
      hintText: 'Select your gender',
      filled: true,
      fillColor: const Color(0xFFF3F8FF),
      labelStyle: const TextStyle(color: Colors.black),
      hintStyle: const TextStyle(color: Colors.grey),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Colors.blue, width: 2),
      ),
    ),
    items: const [
      DropdownMenuItem(
        value: 'Man',
        child: Text('Man'),
      ),
      DropdownMenuItem(
        value: 'Woman',
        child: Text('Woman'),
      ),
    ],
    onChanged: onChanged,
    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'Please select your gender';
      }
      return null;
    },
  );
}

// Widget untuk field phone
Widget buildPhoneField(TextEditingController phoneController) {
  return TextFormField(
    controller: phoneController,
    keyboardType: TextInputType.phone,
    decoration: InputDecoration(
      hintText: 'Enter your phone number',
      filled: true,
      fillColor: const Color(0xFFF3F8FF),
      labelStyle: const TextStyle(color: Colors.black),
      hintStyle: const TextStyle(color: Colors.grey),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Colors.blue, width: 2),
      ),
    ),
    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'Please enter your phone number';
      }
      if (value.length < 12) {
        return 'Phone number must be at least 12 digits';
      }
      return null;
    },
  );
}

// Widget untuk field address
Widget buildAddressField(TextEditingController controller) {
  return TextFormField(
    controller: controller,
    decoration: InputDecoration(
      hintText: 'Enter your address',
      filled: true,
      fillColor: const Color(0xFFF3F8FF),
      labelStyle: const TextStyle(color: Colors.black),
      hintStyle: const TextStyle(color: Colors.grey),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Colors.blue, width: 2),
      ),
    ),
    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'Please enter your address';
      }
      return null;
    },
  );
}

// Widget untuk field password
Widget buildPasswordField(TextEditingController controller) {
  return TextFormField(
    controller: controller,
    obscureText: true,
    decoration: InputDecoration(
      hintText: 'Enter your password',
      filled: true,
      fillColor: const Color(0xFFF3F8FF),
      labelStyle: const TextStyle(color: Colors.black),
      hintStyle: const TextStyle(color: Colors.grey),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Colors.blue, width: 2),
      ),
    ),
    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'Please enter a password';
      }
      if (value.length < 6) {
        return 'Password must be at least 6 characters long';
      }
      return null;
    },
  );
}

// Widget untuk field confirm password
Widget buildConfirmPasswordField(TextEditingController controller, TextEditingController passwordController) {
  return TextFormField(
    controller: controller,
    obscureText: true,
    decoration: InputDecoration(
      hintText: 'Confirm your password',
      filled: true,
      fillColor: const Color(0xFFF3F8FF),
      labelStyle: const TextStyle(color: Colors.black),
      hintStyle: const TextStyle(color: Colors.grey),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Colors.blue, width: 2),
      ),
    ),
    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'Please confirm your password';
      }
      if (value != passwordController.text) {
        return 'Passwords do not match';
      }
      return null;
    },
  );
}
