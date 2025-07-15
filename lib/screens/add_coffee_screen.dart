import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../theme/app_theme.dart';
import '../utils/app_colors.dart';
import '../cubit/add_coffee/add_coffee_cubit.dart';

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
    return BlocListener<AddCoffeeCubit, AddCoffeeState>(
      listener: (context, state) {
        if (state.errorMessage != null) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.errorMessage!)));
        }
        if (state.isSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Coffee added successfully!'),
              backgroundColor: AppColors.buttonColor,
            ),
          );
          Navigator.pop(context);
        }
      },
      child: BlocBuilder<AddCoffeeCubit, AddCoffeeState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              leading: IconButton(
                icon: Icon(Icons.arrow_back, color: AppColors.coffeeTextDark),
                onPressed: () => Navigator.pop(context),
              ),
              title: Text(
                'Add New Coffee',
                style: AppTheme.titleStyle.copyWith(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: AppColors.coffeeTextDark,
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
                    _buildImageUploadSection(),
                    const SizedBox(height: 16),

                    _buildProductNameInput(),
                    const SizedBox(height: 16),

                    _buildDescriptionInput(),
                    const SizedBox(height: 16),

                    _buildChocolateSelection(),
                    const SizedBox(height: 16),

                    _buildSizeSelection(),
                    const SizedBox(height: 16),

                    _buildPriceAndQuantityRow(),
                    const SizedBox(height: 32),

                    _buildAddProductButton(state.isLoading),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildImageUploadSection() {
    return BlocBuilder<AddCoffeeCubit, AddCoffeeState>(
      builder: (context, state) {
        return Container(
          width: double.infinity,
          height: 200,
          decoration: BoxDecoration(
            color: AppColors.coffeeCardBackground,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.inputBorderColor, width: 1),
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

  Widget _buildProductNameInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Product Name',
          style: AppTheme.titleStyle.copyWith(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: _nameController,
          decoration: InputDecoration(
            hintText: 'Enter coffee name',
            filled: true,
            fillColor: AppColors.coffeeCardBackground,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
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

  Widget _buildDescriptionInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Description',
          style: AppTheme.titleStyle.copyWith(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: _descriptionController,
          maxLines: 4,
          decoration: InputDecoration(
            hintText: 'Enter coffee description',
            filled: true,
            fillColor: AppColors.coffeeCardBackground,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
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

  Widget _buildChocolateSelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Choice of Chocolate',
          style: AppTheme.titleStyle.copyWith(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            _buildChocolateButton('White'),
            const SizedBox(width: 12),
            _buildChocolateButton('Milk'),
            const SizedBox(width: 12),
            _buildChocolateButton('Dark'),
          ],
        ),
      ],
    );
  }

  Widget _buildSizeSelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Size',
          style: AppTheme.titleStyle.copyWith(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            _buildSizeButton('S'),
            const SizedBox(width: 16),
            _buildSizeButton('M'),
            const SizedBox(width: 16),
            _buildSizeButton('L'),
          ],
        ),
      ],
    );
  }

  Widget _buildChocolateButton(String type) {
    return BlocBuilder<AddCoffeeCubit, AddCoffeeState>(
      builder: (context, state) {
        final isSelected = state.selectedChocolate == type;
        Color backgroundColor;
        Color textColor;

        switch (type) {
          case 'White':
            backgroundColor = isSelected
                ? AppColors.coffeeCardBackground
                : AppColors.coffeeCardBackground;
            textColor = AppColors.textColor;
            break;
          case 'Milk':
            backgroundColor = isSelected
                ? AppColors.buttonColor
                : AppColors.coffeeCardBackground;
            textColor = isSelected
                ? AppColors.buttonTextColor
                : AppColors.textColor;
            break;
          case 'Dark':
            backgroundColor = isSelected
                ? AppColors.coffeeTextDark
                : AppColors.coffeeCardBackground;
            textColor = isSelected
                ? AppColors.buttonTextColor
                : AppColors.textColor;
            break;
          default:
            backgroundColor = AppColors.coffeeCardBackground;
            textColor = AppColors.textColor;
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
                    ? Border.all(color: AppColors.buttonColor, width: 2)
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

  Widget _buildSizeButton(String size) {
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
                  ? AppColors.buttonColor
                  : AppColors.coffeeCardBackground,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                size,
                style: AppTheme.buttonTextStyle.copyWith(
                  color: isSelected
                      ? AppColors.buttonTextColor
                      : AppColors.textColor,
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

  Widget _buildPriceAndQuantityRow() {
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
                  fillColor: AppColors.coffeeCardBackground,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
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
                      decoration: const BoxDecoration(
                        color: AppColors.buttonColor,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.remove,
                        color: AppColors.buttonTextColor,
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
                          color: AppColors.textColor,
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
                      decoration: const BoxDecoration(
                        color: AppColors.buttonColor,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.add,
                        color: AppColors.buttonTextColor,
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

  Widget _buildAddProductButton(bool isLoading) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: isLoading ? null : _addProduct,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.buttonColor,
          foregroundColor: AppColors.buttonTextColor,
          padding: const EdgeInsets.symmetric(vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 0,
        ),
        child: isLoading
            ? const SizedBox(
                height: 24,
                width: 24,
                child: CircularProgressIndicator(
                  color: AppColors.buttonTextColor,
                  strokeWidth: 2,
                ),
              )
            : Text(
                'Add Product',
                style: AppTheme.buttonTextStyle.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
      ),
    );
  }
}
