import 'package:flutter/material.dart';
import 'package:flutter_application_1/configs/colors.dart';
import 'package:flutter_application_1/services/api_service.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  final ApiService _apiService = ApiService();
  late Future<List<ProductCategory>> _categoriesFuture;

  @override
  void initState() {
    super.initState();
    _loadCategories();
  }

  void _loadCategories() {
    _categoriesFuture = _apiService.fetchCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
        centerTitle: true,
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
      ),

      body: FutureBuilder<List<ProductCategory>>(
        future: _categoriesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Could not load categories.\n${snapshot.error}',
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: () {
                        setState(_loadCategories);
                      },
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              ),
            );
          }

          final categories = snapshot.data ?? const <ProductCategory>[];
          if (categories.isEmpty) {
            return const Center(
              child: Text('No product categories found in the database.'),
            );
          }

          return GridView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: categories.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 14,
              mainAxisSpacing: 14,
              childAspectRatio: 1.1,
            ),
            itemBuilder: (context, index) {
              return _CategoryCard(category: categories[index]);
            },
          );
        },
      ),
    );
  }
}

// ---------- CATEGORY CARD WIDGET ----------

class _CategoryCard extends StatelessWidget {
  final ProductCategory category;

  const _CategoryCard({required this.category});

  IconData get _icon {
    switch (category.name) {
      case 'Feeding Chairs':
        return Icons.chair_alt;
      case 'Bathing Stations':
        return Icons.bathtub;
      case 'Receiving Sets':
        return Icons.child_care;
      case 'Strollers':
        return Icons.stroller;
      case 'Car Seats':
        return Icons.car_rental;
      case 'Bathing Toys':
      case 'Electric Toys':
        return Icons.toys;
      default:
        return Icons.category;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,

      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),

      child: InkWell(
        borderRadius: BorderRadius.circular(16),

        onTap: () {
          // Navigate to products in this category
        },

        child: Padding(
          padding: const EdgeInsets.all(14),

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,

            children: [
              // Category icon
              Container(
                height: 60,
                width: 60,

                decoration: BoxDecoration(
                  color: primaryColor.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),

                child: Icon(_icon, size: 32, color: primaryColor),
              ),

              const SizedBox(height: 12),

              // Category name
              Text(
                category.name,
                textAlign: TextAlign.center,

                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 4),

              // Number of products
              Text(
                '${category.productCount} products',
                style: const TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
