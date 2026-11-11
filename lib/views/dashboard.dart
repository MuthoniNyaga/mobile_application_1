
import 'package:flutter/material.dart';
import 'package:flutter_application_1/configs/colors.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  // Hardcoded summary statistics
  // ignore: library_private_types_in_public_api
  static const List<_Stat> stats = [
    _Stat(
      label: 'Products',
      value: '156',
      icon: Icons.inventory_2,
    ),
    _Stat(
      label: 'Orders',
      value: '48',
      icon: Icons.shopping_bag,
    ),
    _Stat(
      label: 'Pending',
      value: '12',
      icon: Icons.hourglass_bottom,
    ),
    _Stat(
      label: 'Revenue',
      value: 'KES 450K',
      icon: Icons.payments,
    ),
  ];

  // Hardcoded featured baby products
  // ignore: library_private_types_in_public_api
  static const List<_Product> featured = [
    _Product(
      name: 'Baby Feeding Chair',
      price: 'KES 8,500',
      category: 'Feeding',
      icon: Icons.chair,
    ),
    _Product(
      name: 'Baby Car Seat',
      price: 'KES 12,000',
      category: 'Travelling',
      icon: Icons.car_rental,
    ),
    _Product(
      name: 'Baby Stroller',
      price: 'KES 15,500',
      category: 'Travelling',
      icon: Icons.child_friendly,
    ),
    _Product(
      name: 'Bathing Station',
      price: 'KES 9,500',
      category: 'Bathing',
      icon: Icons.bathtub,
    ),
    _Product(
      name: 'Receiving Set',
      price: 'KES 4,500',
      category: 'Clothing',
      icon: Icons.child_care,
    ),
    _Product(
      name: 'Electric Baby Toy',
      price: 'KES 3,000',
      category: 'Toys',
      icon: Icons.toys,
    ),
  ];

  // Hardcoded product categories
  // ignore: library_private_types_in_public_api
  static const List<_Category> categories = [
    _Category(name: 'Feeding', icon: Icons.restaurant),
    _Category(name: 'Bathing', icon: Icons.bathtub),
    _Category(name: 'Clothing', icon: Icons.checkroom),
    _Category(name: 'Travelling', icon: Icons.directions_car),
    _Category(name: 'Toys', icon: Icons.toys),
  ];

  // Hardcoded recent activities
  // ignore: library_private_types_in_public_api
  static const List<_Activity> activity = [
    _Activity(
      title: 'New order for Baby Stroller',
      time: '20 minutes ago',
      icon: Icons.shopping_cart,
    ),
    _Activity(
      title: 'Baby Car Seat order completed',
      time: '2 hours ago',
      icon: Icons.check_circle,
    ),
    _Activity(
      title: 'New stock added - Feeding Chairs',
      time: 'Yesterday',
      icon: Icons.inventory,
    ),
    _Activity(
      title: 'Receiving Set order cancelled',
      time: '2 days ago',
      icon: Icons.cancel,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        centerTitle: true,
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // Greeting
            const Text(
              'Welcome back, Admin 👋',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 4),

            const Text(
              "Here's how your baby shop is doing today.",
              style: TextStyle(color: Colors.grey),
            ),

            const SizedBox(height: 20),

            // Statistics grid
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: stats.length,

              gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 1.6,
              ),

              itemBuilder: (context, index) =>
                  _StatCard(stat: stats[index]),
            ),

            const SizedBox(height: 24),

            // Product categories
            const Text(
              'Product Categories',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            SizedBox(
              height: 90,

              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,

                // ignore: unnecessary_underscores
                separatorBuilder: (_, __) =>
                    const SizedBox(width: 12),

                itemBuilder: (context, index) =>
                    _CategoryCard(category: categories[index]),
              ),
            ),

            const SizedBox(height: 24),

            // Featured products
            const Text(
              'Featured Baby Products',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            SizedBox(
              height: 205,

              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: featured.length,

                // ignore: unnecessary_underscores
                separatorBuilder: (_, __) =>
                    const SizedBox(width: 12),

                itemBuilder: (context, index) =>
                    _FeaturedCard(product: featured[index]),
              ),
            ),

            const SizedBox(height: 24),

            // Recent activities
            const Text(
              'Recent Activity',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            ...activity.map(
              (a) => _ActivityTile(activity: a),
            ),

            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

// ---------- DATA CLASSES ----------

class _Stat {
  final String label;
  final String value;
  final IconData icon;

  const _Stat({
    required this.label,
    required this.value,
    required this.icon,
  });
}

class _Product {
  final String name;
  final String price;
  final String category;
  final IconData icon;

  const _Product({
    required this.name,
    required this.price,
    required this.category,
    required this.icon,
  });
}

class _Category {
  final String name;
  final IconData icon;

  const _Category({
    required this.name,
    required this.icon,
  });
}

class _Activity {
  final String title;
  final String time;
  final IconData icon;

  const _Activity({
    required this.title,
    required this.time,
    required this.icon,
  });
}

// ---------- STATISTICS WIDGET ----------

class _StatCard extends StatelessWidget {
  final _Stat stat;

  const _StatCard({required this.stat});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),

      child: Padding(
        padding: const EdgeInsets.all(14),

        child: Row(
          children: [

            Container(
              height: 44,
              width: 44,

              decoration: BoxDecoration(
                color: primaryColor.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),

              child: Icon(
                stat.icon,
                color: primaryColor,
              ),
            ),

            const SizedBox(width: 12),

            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [

                  Text(
                    stat.value,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,

                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  Text(
                    stat.label,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------- CATEGORY WIDGET ----------

class _CategoryCard extends StatelessWidget {
  final _Category category;

  const _CategoryCard({required this.category});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 85,

      decoration: BoxDecoration(
        color: primaryColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
      ),

      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,

        children: [

          Icon(
            category.icon,
            color: primaryColor,
            size: 28,
          ),

          const SizedBox(height: 6),

          Text(
            category.name,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

// ---------- FEATURED PRODUCT WIDGET ----------

class _FeaturedCard extends StatelessWidget {
  final _Product product;

  const _FeaturedCard({required this.product});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 180,

      child: Card(
        elevation: 2,
        clipBehavior: Clip.antiAlias,

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            Container(
              height: 95,
              width: double.infinity,

              color: primaryColor.withValues(alpha: 0.1),

              child: Icon(
                product.icon,
                size: 55,
                color: primaryColor,
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(12),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [

                  Text(
                    product.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,

                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 4),

                  Text(
                    product.category,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                  ),

                  const SizedBox(height: 6),

                  Text(
                    product.price,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------- RECENT ACTIVITY WIDGET ----------

class _ActivityTile extends StatelessWidget {
  final _Activity activity;

  const _ActivityTile({required this.activity});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,

      leading: CircleAvatar(
        backgroundColor: primaryColor.withValues(alpha: 0.1),

        child: Icon(
          activity.icon,
          color: primaryColor,
          size: 20,
        ),
      ),

      title: Text(activity.title),

      subtitle: Text(activity.time),
    );
  }
}
