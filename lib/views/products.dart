
import 'package:flutter/material.dart';
import 'package:flutter_application_1/configs/colors.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  // Hardcoded baby product categories
  // ignore: library_private_types_in_public_api
  static const List<_Category> categories = [
    _Category(
      name: 'Feeding Chairs',
      count: 30,
      icon: Icons.chair_alt,
    ),
    _Category(
      name: 'Bathing Stations',
      count: 25,
      icon: Icons.bathtub,
    ),
    _Category(
      name: 'Receiving Sets',
      count: 40,
      icon: Icons.child_care,
    ),
    _Category(
      name: 'Strollers',
      count: 50,
      icon: Icons.stroller,
    ),
    _Category(
      name: 'Car Seats',
      count: 70,
      icon: Icons.car_rental,
    ),
    _Category(
      name: 'Bathing Toys',
      count: 100,
      icon: Icons.toys,
    ),
    _Category(
      name: 'Electric Toys',
      count: 15,
      icon: Icons.electric_bolt,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
        centerTitle: true,
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
      ),

      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: categories.length,

        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 14,
          mainAxisSpacing: 14,
          childAspectRatio: 1.1,
        ),

        itemBuilder: (context, index) {
          return _CategoryCard(
            category: categories[index],
          );
        },
      ),
    );
  }
}

// ---------- DATA CLASS ----------

class _Category {
  final String name;
  final int count;
  final IconData icon;

  const _Category({
    required this.name,
    required this.count,
    required this.icon,
  });
}

// ---------- CATEGORY CARD WIDGET ----------

class _CategoryCard extends StatelessWidget {
  final _Category category;

  const _CategoryCard({
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),

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
                  color:primaryColor.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),

                child: Icon(
                  category.icon,
                  size: 32,
                  color: primaryColor,
                ),
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
                '${category.count} products',
                style: const TextStyle(
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
