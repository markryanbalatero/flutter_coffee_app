import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'login_screen.dart'; 
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  bool isDarkMode = false;
  File? _imageFile;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      _nameController.text = user.displayName ?? '';
      _emailController.text = user.email ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    final backgroundColor = isDarkMode ? const Color(0xFF232323) : Colors.white;
    final cardColor = isDarkMode ? const Color(0xFF2C2C2C) : Colors.white;
    final textColor = isDarkMode ? Colors.white : const Color(0xFF333333);
    final labelColor = isDarkMode ? Colors.white70 : const Color(0xFF333333);

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: textColor),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: Text(
          'Profile',
          style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 32),
            // Avatar
            Center(
              child: CircleAvatar(
                radius: 81,
                backgroundColor: cardColor,
                backgroundImage: _imageFile != null
                    ? FileImage(_imageFile!)
                    : const AssetImage('assets/images/profile.png') as ImageProvider,
              ),
            ),
            const SizedBox(height: 8),
            TextButton(
              onPressed: _pickImage,
              child: Text(
                'Browse...',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: textColor,
                  fontSize: 12,
                ),
              ),
            ),
            const SizedBox(height: 32),
            // Name Field
            _buildLabel('Name', labelColor),
            _buildTextField(_nameController, cardColor, textColor, labelColor),
            const SizedBox(height: 16),
            // Email Field
            _buildLabel('Email', labelColor),
            _buildTextField(_emailController, cardColor, textColor, labelColor),
            const SizedBox(height: 32),
            // Update Button
            SizedBox(
              width: 208,
              height: 47,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFA2775B),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                onPressed: () {
                  // TODO: Implement update logic
                },
                child: const Text(
                  'Update',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 32),
            Divider(
              thickness: 0.5,
              color: isDarkMode ? Colors.white24 : Colors.black,
              indent: 20,
              endIndent: 20,
            ),
            const SizedBox(height: 32),
            // Theme Mode Toggle
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Text(
                    'Theme Mode',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                      color: labelColor,
                    ),
                  ),
                  const Spacer(),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Dark',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: isDarkMode ? Colors.black : Colors.grey,
                            ),
                          ),
                          const SizedBox(width: 48),
                          Text(
                            'Light',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: !isDarkMode ? Colors.black : Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      _buildThemeSwitch(),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 64),
            // Logout Button
            SizedBox(
              width: 208,
              height: 44,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFA2775B),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                onPressed: () {
                  // TODO: Implement logout logic

                   Navigator.push(
                      context,
                     MaterialPageRoute(builder: (context) => const LoginScreen()),
          );
                },
                child: const Text(
                  'Logout',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildLabel(String text, Color labelColor) {
    return Padding(
      padding: const EdgeInsets.only(right: 310, bottom: 4),
      child: Text(
        text,
        style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 12,
          color: labelColor,
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, Color fillColor, Color textColor, Color borderColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          filled: true,
          fillColor: fillColor,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
            borderSide: BorderSide(color: borderColor.withOpacity(0.3)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
            borderSide: BorderSide(color: borderColor.withOpacity(0.3)),
          ),
          contentPadding: const EdgeInsets.symmetric(
            vertical: 16,
            horizontal: 12,
          ),
        ),
        style: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 12,
          color: textColor,
        ),
      ),
    );
  }
  Widget _buildThemeSwitch() {
    return GestureDetector(
      onTap: () {
        setState(() {
          isDarkMode = !isDarkMode;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 103,
        height: 31,
        decoration: BoxDecoration(
          color: const Color(0xFFA2775B),
          borderRadius: BorderRadius.circular(100),
        ),
        child: Stack(
          children: [
            AnimatedPositioned(
              duration: const Duration(milliseconds: 200),
              left: isDarkMode ? 2 : 74,
              top: 2,
              child: Container(
                width: 27,
                height: 27,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(100),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.04),
                      blurRadius: 1,
                      spreadRadius: 0,
                    ),
                    BoxShadow(
                      color: Colors.black.withOpacity(0.15),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                    BoxShadow(
                      color: Colors.black.withOpacity(0.06),
                      blurRadius: 1,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}