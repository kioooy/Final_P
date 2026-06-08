import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_dimensions.dart';
import '../../../products/domain/entities/product_entity.dart';
import '../../../categories/presentation/providers/category_provider.dart';
import '../providers/admin_product_provider.dart';

class AdminProductFormScreen extends ConsumerStatefulWidget {
  final ProductEntity? productToEdit;

  const AdminProductFormScreen({super.key, this.productToEdit});

  @override
  ConsumerState<AdminProductFormScreen> createState() => _AdminProductFormScreenState();
}

class _AdminProductFormScreenState extends ConsumerState<AdminProductFormScreen> {
  final _formKey = GlobalKey<FormState>();
  
  late final TextEditingController _nameController;
  late final TextEditingController _descriptionController;
  late final TextEditingController _priceController;
  late final TextEditingController _stockController;
  late final TextEditingController _imageUrlController;
  
  String? _selectedCategoryId;
  String? _selectedCategoryName;

  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    final p = widget.productToEdit;
    _nameController = TextEditingController(text: p?.name ?? '');
    _descriptionController = TextEditingController(text: p?.description ?? '');
    _priceController = TextEditingController(text: p?.price.toString() ?? '');
    _stockController = TextEditingController(text: p?.stock.toString() ?? '');
    _imageUrlController = TextEditingController(text: p?.imageUrls.isNotEmpty == true ? p!.imageUrls.first : '');
    
    _selectedCategoryId = p?.categoryId;
    _selectedCategoryName = p?.categoryName;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    _stockController.dispose();
    _imageUrlController.dispose();
    super.dispose();
  }

  void _saveProduct() async {
    if (!_formKey.currentState!.validate()) return;
    if (_selectedCategoryId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a category'), backgroundColor: AppColors.error),
      );
      return;
    }

    setState(() => _isSaving = true);

    try {
      final isEditing = widget.productToEdit != null;
      final productId = isEditing ? widget.productToEdit!.productId : const Uuid().v4();
      
      final product = ProductEntity(
        productId: productId,
        name: _nameController.text.trim(),
        brand: isEditing ? widget.productToEdit!.brand : 'Generic',
        categoryId: _selectedCategoryId!,
        categoryName: _selectedCategoryName ?? 'Unknown',
        description: _descriptionController.text.trim(),
        price: double.parse(_priceController.text.trim()),
        stock: int.parse(_stockController.text.trim()),
        imageUrls: _imageUrlController.text.trim().isNotEmpty ? [_imageUrlController.text.trim()] : [],
        rating: isEditing ? widget.productToEdit!.rating : 0.0,
        reviewCount: isEditing ? widget.productToEdit!.reviewCount : 0,
        warranty: isEditing ? widget.productToEdit!.warranty : 'No warranty',
        specifications: isEditing ? widget.productToEdit!.specifications : {},
        isActive: isEditing ? widget.productToEdit!.isActive : true,
        createdAt: isEditing ? widget.productToEdit!.createdAt : DateTime.now(),
        updatedAt: DateTime.now(),
      );

      if (isEditing) {
        await ref.read(adminProductProvider.notifier).updateProduct(product);
      } else {
        await ref.read(adminProductProvider.notifier).createProduct(product);
      }

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(isEditing ? 'Product updated successfully' : 'Product created successfully')),
        );
        Navigator.of(context).pop();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to save product: $e'), backgroundColor: AppColors.error),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isSaving = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final categoriesState = ref.watch(categoryProvider);
    final isEditing = widget.productToEdit != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Edit Product' : 'Create Product'),
      ),
      body: _isSaving
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(AppDimensions.spaceMd),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextFormField(
                      controller: _nameController,
                      decoration: const InputDecoration(labelText: 'Product Name', border: OutlineInputBorder()),
                      validator: (val) => val == null || val.trim().isEmpty ? 'Required' : null,
                    ),
                    const SizedBox(height: AppDimensions.spaceMd),
                    TextFormField(
                      controller: _descriptionController,
                      decoration: const InputDecoration(labelText: 'Description', border: OutlineInputBorder()),
                      maxLines: 3,
                      validator: (val) => val == null || val.trim().isEmpty ? 'Required' : null,
                    ),
                    const SizedBox(height: AppDimensions.spaceMd),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _priceController,
                            decoration: const InputDecoration(labelText: 'Price', border: OutlineInputBorder()),
                            keyboardType: const TextInputType.numberWithOptions(decimal: true),
                            validator: (val) {
                              if (val == null || val.trim().isEmpty) return 'Required';
                              final num = double.tryParse(val);
                              if (num == null || num <= 0) return 'Must be > 0';
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(width: AppDimensions.spaceMd),
                        Expanded(
                          child: TextFormField(
                            controller: _stockController,
                            decoration: const InputDecoration(labelText: 'Stock', border: OutlineInputBorder()),
                            keyboardType: TextInputType.number,
                            validator: (val) {
                              if (val == null || val.trim().isEmpty) return 'Required';
                              final num = int.tryParse(val);
                              if (num == null || num < 0) return 'Must be >= 0';
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppDimensions.spaceMd),
                    categoriesState.when(
                      data: (categories) {
                        return DropdownButtonFormField<String>(
                          initialValue: _selectedCategoryId,
                          decoration: const InputDecoration(labelText: 'Category', border: OutlineInputBorder()),
                          items: categories.map((c) {
                            return DropdownMenuItem(
                              value: c.categoryId,
                              child: Text(c.categoryName),
                            );
                          }).toList(),
                          onChanged: (val) {
                            setState(() {
                              _selectedCategoryId = val;
                              _selectedCategoryName = categories.firstWhere((c) => c.categoryId == val).categoryName;
                            });
                          },
                          validator: (val) => val == null ? 'Required' : null,
                        );
                      },
                      loading: () => const LinearProgressIndicator(),
                      error: (e, _) => Text('Error loading categories: $e', style: const TextStyle(color: AppColors.error)),
                    ),
                    const SizedBox(height: AppDimensions.spaceMd),
                    TextFormField(
                      controller: _imageUrlController,
                      decoration: const InputDecoration(
                        labelText: 'Image URL',
                        border: OutlineInputBorder(),
                        hintText: 'https://example.com/image.jpg',
                      ),
                      validator: (val) => val == null || val.trim().isEmpty ? 'Required' : null,
                    ),
                    const SizedBox(height: AppDimensions.spaceXl),
                    FilledButton(
                      onPressed: _saveProduct,
                      style: FilledButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: AppDimensions.spaceMd),
                      ),
                      child: Text(isEditing ? 'Save Changes' : 'Create Product'),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
