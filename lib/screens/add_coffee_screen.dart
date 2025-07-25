import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../theme/app_theme.dart';
import '../utils/app_colors.dart';
import '../cubit/add_coffee/add_coffee_cubit.dart';
import '../cubit/theme/theme_cubit.dart';

class AddCoffeeScreen extends StatefulWidget {
  const AddCoffeeScreen({super.key});

  @override
  State<AddCoffeeScreen> createState() => _AddCoffeeScreenState();

  static Widget create() {
    return BlocProvider(
      create: (context) => AddCoffeeCubit(),
      child: const AddCoffeeScreen(),
    );
  }
}

class _AddCoffeeScreenState extends State<AddCoffeeScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _priceController = TextEditingController();

  final ImagePicker _picker = ImagePicker();

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    try {
      showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SafeArea(
            child: Wrap(
              children: [
                ListTile(
                  leading: const Icon(Icons.photo_library),
                  title: const Text('Photo Library'),
                  onTap: () async {
                    Navigator.of(context).pop();
                    await _pickImageFromSource(ImageSource.gallery);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.photo_camera),
                  title: const Text('Camera'),
                  onTap: () async {
                    Navigator.of(context).pop();
                    await _pickImageFromSource(ImageSource.camera);
                  },
                ),
              ],
            ),
          );
        },
      );
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error opening image picker: $e')),
        );
      }
    }
  }

  Future<void> _pickImageFromSource(ImageSource source) async {
    try {
      // Clear any previous errors
      context.read<AddCoffeeCubit>().clearError();

      print('Attempting to pick image from ${source.name}');

      final XFile? image = await _picker.pickImage(
        source: source,
        maxWidth: 1024,
        maxHeight: 1024,
        imageQuality: 85,
      );

      if (image != null) {
        print('Image picked successfully: ${image.path}');

        // Check if file exists
        final file = File(image.path);
        if (await file.exists()) {
          print('Image file exists, size: ${await file.length()} bytes');

          if (mounted) {
            context.read<AddCoffeeCubit>().selectImage(file);
          }
        } else {
          throw Exception('Selected image file does not exist');
        }
      } else {
        print('No image was selected');
        if (mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('No image selected')));
        }
      }
    } catch (e) {
      print('Error picking image: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to pick image: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void _incrementQuantity() {
    context.read<AddCoffeeCubit>().incrementQuantity();
  }

  void _decrementQuantity() {
    context.read<AddCoffeeCubit>().decrementQuantity();
  }

  Future<void> _addProduct() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final cubit = context.read<AddCoffeeCubit>();
    await cubit.addCoffee(
      name: _nameController.text.trim(),
      description: _descriptionController.text.trim(),
      price: double.parse(_priceController.text),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeMode>(
      builder: (context, themeMode) {
        final isDarkMode = themeMode == ThemeMode.dark;
        final theme = isDarkMode ? AppTheme.darkTheme : AppTheme.lightTheme;

        return BlocListener<AddCoffeeCubit, AddCoffeeState>(
          listener: (context, state) {
            if (state.errorMessage != null) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.errorMessage!)));
            }
            if (state.isSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Coffee added successfully!',
                    style: TextStyle(
                      color: isDarkMode 
                        ? AppColors.darkTextOnBackground 
                        : Colors.white,
                    ),
                  ),
                  backgroundColor: isDarkMode 
                    ? AppColors.darkPrimary 
                    : AppColors.buttonColor,
                ),
              );
              Navigator.pop(context);
            }
          },
          child: BlocBuilder<AddCoffeeCubit, AddCoffeeState>(
            builder: (context, state) {
              return Scaffold(
                backgroundColor: isDarkMode 
                  ? AppColors.darkBackground 
                  : Colors.white,
                appBar: AppBar(
                  backgroundColor: isDarkMode 
                    ? AppColors.darkSurface 
                    : Colors.white,
                  elevation: 0,
                  leading: IconButton(
                    icon: Icon(
                      Icons.arrow_back, 
                      color: isDarkMode 
                        ? AppColors.darkTextOnBackground 
                        : AppColors.coffeeTextDark,
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                  title: Text(
                    'Add New Coffee',
                    style: AppTheme.titleStyle.copyWith(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: isDarkMode 
                        ? AppColors.darkTextOnBackground 
                        : AppColors.coffeeTextDark,
                    ),
                  ),
                  centerTitle: true,
                ),
                body: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildImageUploadSection(isDarkMode),
                        const SizedBox(height: 16),
                        _buildProductNameInput(isDarkMode),
                        const SizedBox(height: 16),
                        _buildDescriptionInput(isDarkMode),
                        const SizedBox(height: 16),
                        _buildCategorySelection(isDarkMode),
                        const SizedBox(height: 16),
                        _buildChocolateSelection(isDarkMode),
                        const SizedBox(height: 16),
                        _buildSizeSelection(isDarkMode),
                        const SizedBox(height: 16),
                        _buildPriceAndQuantityRow(isDarkMode),
                        const SizedBox(height: 32),
                        _buildAddProductButton(state.isLoading, isDarkMode),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildImageUploadSection(bool isDarkMode) {
    return BlocBuilder<AddCoffeeCubit, AddCoffeeState>(
      builder: (context, state) {
        return Container(
          width: double.infinity,
          height: 200,
          decoration: BoxDecoration(
            color: isDarkMode 
              ? AppColors.darkSurface 
              : AppColors.coffeeCardBackground,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isDarkMode 
                ? AppColors.darkDivider 
                : AppColors.inputBorderColor, 
              width: 1
            ),
          ),
          child: InkWell(
            onTap: _pickImage,
            borderRadius: BorderRadius.circular(16),
            child: state.selectedImage != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.file(
                      state.selectedImage!,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                    ),
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: AppColors.inputBorderColor,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          Icons.image_outlined,
                          size: 48,
                          color: AppColors.inputTextColor,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Tap to add image',
                        style: AppTheme.hintTextStyle.copyWith(
                          color: AppColors.inputTextColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
          ),
        );
      },
    );
  }

  Widget _buildProductNameInput(bool isDarkMode) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Product Name',
          style: AppTheme.titleStyle.copyWith(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: isDarkMode 
              ? AppColors.darkTextOnBackground 
              : null,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: _nameController,
          decoration: InputDecoration(
            hintText: 'Enter coffee name',
            filled: true,
            fillColor: isDarkMode 
              ? AppColors.darkSurface 
              : AppColors.coffeeCardBackground,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
            hintStyle: TextStyle(
              color: isDarkMode 
                ? AppColors.darkOnSurface 
                : null,
            ),
          ),
          style: TextStyle(
            color: isDarkMode 
              ? AppColors.darkTextOnBackground 
              : null,
          ),
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Please enter a product name';
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildDescriptionInput(bool isDarkMode) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Description',
          style: AppTheme.titleStyle.copyWith(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: isDarkMode 
              ? AppColors.darkTextOnBackground 
              : null,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: _descriptionController,
          maxLines: 4,
          decoration: InputDecoration(
            hintText: 'Enter coffee description',
            filled: true,
            fillColor: isDarkMode 
              ? AppColors.darkSurface 
              : AppColors.coffeeCardBackground,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
            hintStyle: TextStyle(
              color: isDarkMode 
                ? AppColors.darkOnSurface 
                : null,
            ),
          ),
          style: TextStyle(
            color: isDarkMode 
              ? AppColors.darkTextOnBackground 
              : null,
          ),
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Please enter a description';
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildCategorySelection(bool isDarkMode) {
    const categories = ['espresso', 'latte', 'cappuccino', 'cafetière'];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Coffee Category *',
          style: AppTheme.titleStyle.copyWith(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: isDarkMode 
              ? AppColors.darkTextOnBackground 
              : AppColors.coffeeTextDark,
          ),
        ),
        const SizedBox(height: 16),
        // Use Row with equal flex to fit all chips on one line
        Row(
          children: categories.asMap().entries.map((entry) {
            final index = entry.key;
            final category = entry.value;
            return Expanded(
              child: Padding(
                padding: EdgeInsets.only(
                  right: index < categories.length - 1 ? 8 : 0,
                ),
                child: _buildCategoryChip(category, isDarkMode),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildCategoryChip(String category, bool isDarkMode) {
    return BlocBuilder<AddCoffeeCubit, AddCoffeeState>(
      builder: (context, state) {
        final isSelected = state.selectedCategory == category;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                context.read<AddCoffeeCubit>().selectCategory(category);
                HapticFeedback.lightImpact();
              },
              borderRadius: BorderRadius.circular(20),
              splashColor: AppColors.buttonColor.withValues(alpha: 0.1),
              highlightColor: AppColors.buttonColor.withValues(alpha: 0.05),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeInOut,
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: isSelected
                      ? (isDarkMode 
                          ? AppColors.darkPrimary 
                          : AppColors.buttonColor)
                      : (isDarkMode 
                          ? AppColors.darkSurface 
                          : AppColors.coffeeCardBackground),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: isSelected
                        ? (isDarkMode 
                            ? AppColors.darkPrimary 
                            : AppColors.buttonColor)
                        : (isDarkMode 
                            ? AppColors.darkDivider 
                            : AppColors.inputBorderColor.withValues(alpha: 0.3)),
                    width: isSelected ? 2 : 1,
                  ),
                  boxShadow: isSelected
                      ? [
                          BoxShadow(
                            color: AppColors.buttonShadowColor
                                .withValues(alpha: 0.3),
                            blurRadius: 6,
                            offset: const Offset(0, 2),
                          ),
                        ]
                      : [
                          BoxShadow(
                            color: AppColors.coffeeCardShadow
                                .withValues(alpha: 0.1),
                            blurRadius: 3,
                            offset: const Offset(0, 1),
                          ),
                        ],
                ),
                child: AnimatedDefaultTextStyle(
                  duration: const Duration(milliseconds: 200),
                  style: AppTheme.buttonTextStyle.copyWith(
                    color: isSelected
                        ? (isDarkMode 
                            ? AppColors.darkOnPrimary 
                            : AppColors.buttonTextColor)
                        : (isDarkMode 
                            ? AppColors.darkTextOnBackground 
                            : AppColors.coffeeTextDark),
                    fontSize: 11,
                    fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
                    letterSpacing: 0.3,
                  ),
                  child: Center(
                    child: Text(
                      _formatCategoryName(category),
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  String _formatCategoryName(String category) {
    // Shorter names for better fit
    switch (category.toLowerCase()) {
      case 'espresso':
        return 'Espresso';
      case 'latte':
        return 'Latte';
      case 'cappuccino':
        return 'Cappuccino';
      case 'cafetière':
        return 'Cafetière';
      default:
        return category.substring(0, 1).toUpperCase() +
            category.substring(1).toLowerCase();
    }
  }

  Widget _buildChocolateSelection(bool isDarkMode) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Choice of Chocolate',
          style: AppTheme.titleStyle.copyWith(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: isDarkMode 
              ? AppColors.darkTextOnBackground 
              : null,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            _buildChocolateButton('White', isDarkMode),
            const SizedBox(width: 12),
            _buildChocolateButton('Milk', isDarkMode),
            const SizedBox(width: 12),
            _buildChocolateButton('Dark', isDarkMode),
          ],
        ),
      ],
    );
  }

  Widget _buildSizeSelection(bool isDarkMode) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Size',
          style: AppTheme.titleStyle.copyWith(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: isDarkMode 
              ? AppColors.darkTextOnBackground 
              : null,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            _buildSizeButton('S', isDarkMode),
            const SizedBox(width: 16),
            _buildSizeButton('M', isDarkMode),
            const SizedBox(width: 16),
            _buildSizeButton('L', isDarkMode),
          ],
        ),
      ],
    );
  }

  Widget _buildChocolateButton(String type, bool isDarkMode) {
    return BlocBuilder<AddCoffeeCubit, AddCoffeeState>(
      builder: (context, state) {
        final isSelected = state.selectedChocolate == type;
        Color backgroundColor;
        Color textColor;

        switch (type) {
          case 'White':
            backgroundColor = isSelected
                ? (isDarkMode 
                    ? AppColors.darkPrimary 
                    : AppColors.buttonColor)
                : (isDarkMode 
                    ? AppColors.darkSurface 
                    : AppColors.coffeeCardBackground);
            textColor = isSelected
                ? (isDarkMode 
                    ? AppColors.darkOnPrimary 
                    : AppColors.buttonTextColor)
                : (isDarkMode 
                    ? AppColors.darkTextOnBackground 
                    : AppColors.textColor);
            break;
          case 'Milk':
            backgroundColor = isSelected
                ? (isDarkMode 
                    ? AppColors.darkPrimary 
                    : AppColors.buttonColor)
                : (isDarkMode 
                    ? AppColors.darkSurface 
                    : AppColors.coffeeCardBackground);
            textColor = isSelected
                ? (isDarkMode 
                    ? AppColors.darkOnPrimary 
                    : AppColors.buttonTextColor)
                : (isDarkMode 
                    ? AppColors.darkTextOnBackground 
                    : AppColors.textColor);
            break;
          case 'Dark':
            backgroundColor = isSelected
                ? (isDarkMode 
                    ? AppColors.darkPrimary 
                    : AppColors.buttonColor)
                : (isDarkMode 
                    ? AppColors.darkSurface 
                    : AppColors.coffeeCardBackground);
            textColor = isSelected
                ? (isDarkMode 
                    ? AppColors.darkOnPrimary 
                    : AppColors.buttonTextColor)
                : (isDarkMode 
                    ? AppColors.darkTextOnBackground 
                    : AppColors.textColor);
            break;
          default:
            backgroundColor = isDarkMode 
                ? AppColors.darkSurface 
                : AppColors.coffeeCardBackground;
            textColor = isDarkMode 
                ? AppColors.darkTextOnBackground 
                : AppColors.textColor;
        }

        return Expanded(
          child: GestureDetector(
            onTap: () {
              context.read<AddCoffeeCubit>().selectChocolate(type);
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(24),
                border: isSelected
                    ? Border.all(
                        color: isDarkMode 
                          ? AppColors.darkPrimary 
                          : AppColors.buttonColor, 
                        width: 2
                      )
                    : null,
              ),
              child: Text(
                type,
                textAlign: TextAlign.center,
                style: AppTheme.buttonTextStyle.copyWith(
                  color: textColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildSizeButton(String size, bool isDarkMode) {
    return BlocBuilder<AddCoffeeCubit, AddCoffeeState>(
      builder: (context, state) {
        final isSelected = state.selectedSize == size;
        return GestureDetector(
          onTap: () {
            context.read<AddCoffeeCubit>().selectSize(size);
          },
          child: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: isSelected
                  ? (isDarkMode 
                      ? AppColors.darkPrimary 
                      : AppColors.buttonColor)
                  : (isDarkMode 
                      ? AppColors.darkSurface 
                      : AppColors.coffeeCardBackground),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                size,
                style: AppTheme.buttonTextStyle.copyWith(
                  color: isSelected
                      ? (isDarkMode 
                          ? AppColors.darkOnPrimary 
                          : AppColors.buttonTextColor)
                      : (isDarkMode 
                          ? AppColors.darkTextOnBackground 
                          : AppColors.textColor),
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildPriceAndQuantityRow(bool isDarkMode) {
    return Row(
      children: [
        // Price Input
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Price',
                style: AppTheme.titleStyle.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: isDarkMode 
                    ? AppColors.darkTextOnBackground 
                    : null,
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _priceController,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
                ],
                decoration: InputDecoration(
                  hintText: '0.00',
                  prefixText: '\$ ',
                  filled: true,
                  fillColor: isDarkMode 
                    ? AppColors.darkSurface 
                    : AppColors.coffeeCardBackground,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  hintStyle: TextStyle(
                    color: isDarkMode 
                      ? AppColors.darkOnSurface 
                      : null,
                  ),
                ),
                style: TextStyle(
                  color: isDarkMode 
                    ? AppColors.darkTextOnBackground 
                    : null,
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Enter price';
                  }
                  final price = double.tryParse(value);
                  if (price == null || price <= 0) {
                    return 'Invalid price';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
        const SizedBox(width: 16),

        // Quantity Selector
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Quantity',
                style: AppTheme.titleStyle.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: isDarkMode 
                    ? AppColors.darkTextOnBackground 
                    : null,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: _decrementQuantity,
                    child: Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: isDarkMode 
                          ? AppColors.darkPrimary 
                          : AppColors.buttonColor,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.remove,
                        color: isDarkMode 
                          ? AppColors.darkOnPrimary 
                          : AppColors.buttonTextColor,
                        size: 20,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  BlocBuilder<AddCoffeeCubit, AddCoffeeState>(
                    builder: (context, state) {
                      return Text(
                        state.quantity.toString(),
                        style: AppTheme.titleStyle.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: isDarkMode 
                            ? AppColors.darkTextOnBackground 
                            : AppColors.textColor,
                        ),
                      );
                    },
                  ),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: _incrementQuantity,
                    child: Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: isDarkMode 
                          ? AppColors.darkPrimary 
                          : AppColors.buttonColor,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.add,
                        color: isDarkMode 
                          ? AppColors.darkOnPrimary 
                          : AppColors.buttonTextColor,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAddProductButton(bool isLoading, bool isDarkMode) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: isLoading ? null : _addProduct,
        style: ElevatedButton.styleFrom(
          backgroundColor: isDarkMode 
            ? AppColors.darkPrimary 
            : AppColors.buttonColor,
          foregroundColor: isDarkMode 
            ? AppColors.darkOnPrimary 
            : AppColors.buttonTextColor,
          padding: const EdgeInsets.symmetric(vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 0,
        ),
        child: isLoading
            ? SizedBox(
                height: 24,
                width: 24,
                child: CircularProgressIndicator(
                  color: isDarkMode 
                    ? AppColors.darkOnPrimary 
                    : AppColors.buttonTextColor,
                  strokeWidth: 2,
                ),
              )
            : Text(
                'Add Product',
                style: AppTheme.buttonTextStyle.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: isDarkMode 
                    ? AppColors.darkOnPrimary 
                    : null,
                ),
              ),
      ),
    );
  }
}
