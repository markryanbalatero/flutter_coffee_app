import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'login_screen.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../theme/app_theme.dart';
import '../utils/app_colors.dart';
import '../cubit/theme/theme_cubit.dart';
import '../services/auth_service.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
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
    return BlocBuilder<ThemeCubit, ThemeMode>(
      builder: (context, themeMode) {
        final isDarkMode = themeMode == ThemeMode.dark;
        final theme = isDarkMode ? AppTheme.darkTheme : AppTheme.lightTheme;

        return Scaffold(
          backgroundColor: theme.scaffoldBackgroundColor,
          appBar: AppBar(
            backgroundColor: theme.scaffoldBackgroundColor,
            elevation: 0,
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: theme.textTheme.bodyMedium?.color),
              onPressed: () => Navigator.pop(context),
            ),
            centerTitle: true,
            title: Text(
              'Profile',
              style: TextStyle(
                color: isDarkMode 
                  ? AppColors.darkTextOnBackground  // Primary text color for dark mode
                  : AppColors.textColor,  // Primary text color for light mode
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
                  child: FutureBuilder<DocumentSnapshot>(
                    future: FirebaseAuth.instance.currentUser != null
                        ? FirebaseFirestore.instance
                            .collection('users')
                            .doc(FirebaseAuth.instance.currentUser!.uid)
                            .get()
                        : Future.value(null),
                    builder: (context, snapshot) {
                      String? imagePath;
                      String? name;
                      String? email;
                      if (snapshot.hasData && snapshot.data != null) {
                        final data = snapshot.data!.data() as Map<String, dynamic>?;
                        imagePath = data?['imagePath'];
                        name = data?['name'];
                        email = data?['email'];
                        // Update controllers if Firestore has newer data
                        if (name != null && name != _nameController.text) {
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            _nameController.text = name!;
                          });
                        }
                        if (email != null && email != _emailController.text) {
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            _emailController.text = email!;
                          });
                        }
                      }
                      ImageProvider imageProvider;
                      if (_imageFile != null) {
                        imageProvider = FileImage(_imageFile!);
                      } else if (imagePath != null && imagePath.isNotEmpty) {
                        imageProvider = FileImage(File(imagePath));
                      } else {
                        imageProvider =
                            const AssetImage('assets/images/profile.png');
                      }
                      return CircleAvatar(
                        radius: 81,
                        backgroundColor: theme.cardColor,
                        backgroundImage: imageProvider,
                      );
                    },
                  ),
                ),
                const SizedBox(height: 8),
                TextButton(
                  onPressed: _pickImage,
                  child: Text(
                    'Browse...',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: isDarkMode 
                        ? AppColors.darkOnSurface  // Secondary text color for dark mode
                        : AppColors.coffeeTextSecondary,  // Secondary text color for light mode
                      fontSize: 12,
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                // Name Field
                _buildLabel('Name', isDarkMode 
                  ? AppColors.darkOnSurface  // Secondary text color for dark mode
                  : AppColors.coffeeTextSecondary  // Secondary text color for light mode
                ),
                _buildTextField(
                  _nameController, 
                  theme.cardColor, 
                  isDarkMode 
                    ? AppColors.darkTextOnBackground  // Primary text color for dark mode
                    : AppColors.textColor,  // Primary text color for light mode
                  isDarkMode 
                    ? AppColors.darkOnSurface  // Secondary text color for dark mode
                    : AppColors.coffeeTextSecondary  // Secondary text color for light mode
                ),
                const SizedBox(height: 16),
                // Email Field
                _buildLabel('Email', isDarkMode 
                  ? AppColors.darkOnSurface  // Secondary text color for dark mode
                  : AppColors.coffeeTextSecondary  // Secondary text color for light mode
                ),
                _buildTextField(
                  _emailController, 
                  theme.cardColor, 
                  isDarkMode 
                    ? AppColors.darkTextOnBackground  // Primary text color for dark mode
                    : AppColors.textColor,  // Primary text color for light mode
                  isDarkMode 
                    ? AppColors.darkOnSurface  // Secondary text color for dark mode
                    : AppColors.coffeeTextSecondary  // Secondary text color for light mode
                ),
                const SizedBox(height: 32),
                // Update Button
                SizedBox(
                  width: 208,
                  height: 47,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: theme.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    onPressed: () async {
                      final user = FirebaseAuth.instance.currentUser;
                      if (user == null) return;

                      // Update Firebase Auth profile
                      await user.updateDisplayName(_nameController.text);

                      // Update Firestore document
                      final docRef = FirebaseFirestore.instance
                          .collection('users')
                          .doc(user.uid);
                      final docSnapshot = await docRef.get();

                      final data = {
                        'name': _nameController.text,
                        'email': _emailController.text,
                        'imagePath': _imageFile?.path ?? '',
                      };

                      if (docSnapshot.exists) {
                        await docRef.update(data);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Profile updated!', 
                              style: TextStyle(
                                color: isDarkMode 
                                  ? AppColors.darkTextOnBackground  // Primary text color for dark mode
                                  : AppColors.textColor,  // Primary text color for light mode
                              ),
                            ),
                            backgroundColor: theme.cardColor,
                          ),
                        );
                      } else {
                        await docRef.set(data);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Profile created!', 
                              style: TextStyle(
                                color: isDarkMode 
                                  ? AppColors.darkTextOnBackground  // Primary text color for dark mode
                                  : AppColors.textColor,  // Primary text color for light mode
                              ),
                            ),
                            backgroundColor: theme.cardColor,
                          ),
                        );
                      }

                      // Refresh UI with new values
                      setState(() {});
                    },
                    child: Text(
                      'Update',
                      style: TextStyle(
                        fontSize: 16, 
                        color: isDarkMode 
                          ? AppColors.darkOnPrimary  // On primary color for dark mode
                          : AppColors.buttonTextColor,  // Button text color for light mode
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                Divider(
                  thickness: 0.5,
                  color: isDarkMode 
                    ? AppColors.darkDivider  // Divider color for dark mode
                    : AppColors.dividerColor,  // Divider color for light mode
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
                          color: isDarkMode 
                            ? AppColors.darkOnSurface  // Secondary text color for dark mode
                            : AppColors.coffeeTextSecondary,  // Secondary text color for light mode
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
                                  color: isDarkMode ? Colors.white : Colors.grey,
                                ),
                              ),
                              const SizedBox(width: 48),
                              Text(
                                'Light',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                  color: !isDarkMode ? Colors.white : Colors.grey,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          _buildThemeSwitch(context, isDarkMode),
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
                      backgroundColor: theme.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    onPressed: () async {
                      try {
                        final authService = AuthService();
                        await authService.logout(context);
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Error logging out: $e')),
                        );
                      }
                    },
                    child: Text(
                      'Logout',
                      style: TextStyle(
                        fontSize: 16, 
                        color: isDarkMode 
                          ? AppColors.darkOnPrimary  // On primary color for dark mode
                          : AppColors.buttonTextColor,  // Button text color for light mode
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 32),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildLabel(String text, Color? labelColor) {
    return Padding(
      padding: const EdgeInsets.only(right: 310, bottom: 4),
      child: Text(
        text,
        style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 12,
          color: labelColor ?? AppColors.textColor,
        ),
      ),
    );
  }

  Widget _buildTextField(
    TextEditingController controller, 
    Color? fillColor, 
    Color? textColor, 
    Color? borderColor,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          filled: true,
          fillColor: fillColor ?? AppColors.inputFieldBackground,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
            borderSide: BorderSide(color: borderColor?.withOpacity(0.3) ?? AppColors.inputBorderColor),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
            borderSide: BorderSide(color: borderColor?.withOpacity(0.3) ?? AppColors.inputBorderColor),
          ),
          contentPadding: const EdgeInsets.symmetric(
            vertical: 16,
            horizontal: 12,
          ),
        ),
        style: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 12,
          color: textColor ?? AppColors.textColor,
        ),
      ),
    );
  }

  Widget _buildThemeSwitch(BuildContext context, bool isDarkMode) {
    return GestureDetector(
      onTap: () {
        context.read<ThemeCubit>().toggleTheme();
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 103,
        height: 31,
        decoration: BoxDecoration(
          color: isDarkMode 
            ? AppColors.darkPrimary  // Dark mode primary color
            : AppColors.buttonColor,   // Light mode button color
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
