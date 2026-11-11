
import 'package:flutter/material.dart';
import 'package:flutter_application_1/configs/colors.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  // Hardcoded baby shop orders
  static const List<Map<String, String>> orders = [
    {
      'id': '#BS-1001',
      'item': 'Baby Feeding Chair',
      'date': '28 Oct 2026',
      'price': 'KES 10,000',
      'status': 'Delivered',
    },
    {
      'id': '#BS-1002',
      'item': 'Baby Stroller & Car Seat',
      'date': '30 Oct 2026',
      'price': 'KES 22,500',
      'status': 'Shipped',
    },
    {
      'id': '#BS-1003',
      'item': 'Baby Bathing Station',
      'date': '02 Nov 2026',
      'price': 'KES 9,800',
      'status': 'Processing',
    },
    {
      'id': '#BS-1004',
      'item': 'Baby Receiving Sets',
      'date': '03 Nov 2026',
      'price': 'KES 24,000',
      'status': 'Cancelled',
    },
    {
      'id': '#BS-1005',
      'item': 'Electric Baby Toys',
      'date': '04 Nov 2026',
      'price': 'KES 5,500',
      'status': 'Delivered',
    },
    {
      'id': '#BS-1006',
      'item': 'Baby Bathing Toys',
      'date': '05 Nov 2026',
      'price': 'KES 2,800',
      'status': 'Processing',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Orders'),
        centerTitle: true,
        backgroundColor: Colors.brown,
        foregroundColor: Colors.white,
      ),

      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: orders.length,

        // ignore: unnecessary_underscores
        separatorBuilder: (_, __) =>
            const SizedBox(height: 12),

        itemBuilder: (context, index) {
          final order = orders[index];

          return _OrderCard(
            id: order['id']!,
            item: order['item']!,
            date: order['date']!,
            price: order['price']!,
            status: order['status']!,
          );
        },
      ),
    );
  }
}

// ---------- ORDER CARD WIDGET ----------

class _OrderCard extends StatelessWidget {
  final String id;
  final String item;
  final String date;
  final String price;
  final String status;

  const _OrderCard({
    required this.id,
    required this.item,
    required this.date,
    required this.price,
    required this.status,
  });

  // Status colours
  Color _statusColor() {
    switch (status) {
      case 'Delivered':
        return Colors.green;

      case 'Shipped':
        return Colors.blue;

      case 'Processing':
        return Colors.orange;

      case 'Cancelled':
        return Colors.red;

      default:
        return Colors.grey;
    }
  }

  // Status icons
  IconData _statusIcon() {
    switch (status) {
      case 'Delivered':
        return Icons.check_circle;

      case 'Shipped':
        return Icons.local_shipping;

      case 'Processing':
        return Icons.hourglass_top;

      case 'Cancelled':
        return Icons.cancel;

      default:
        return Icons.info;
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = _statusColor();

    return Card(
      elevation: 2,

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),

      child: Padding(
        padding: const EdgeInsets.all(14),

        child: Row(
          children: [

            // Order icon
            Container(
              height: 56,
              width: 56,

              decoration: BoxDecoration(
                color: primaryColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),

              child: Icon(
                Icons.shopping_bag,
                size: 30,
                color: primaryColor,
              ),
            ),

            const SizedBox(width: 14),

            // Order details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [

                  Text(
                    item,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 4),

                  Text(
                    '$id  •  $date',
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                  ),

                  const SizedBox(height: 6),

                  Text(
                    price,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(width: 6),

            // Order status
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 6,
              ),

              decoration: BoxDecoration(
                color: primaryColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(20),
              ),

              child: Row(
                mainAxisSize: MainAxisSize.min,

                children: [

                  Icon(
                    _statusIcon(),
                    size: 13,
                    color: color,
                  ),

                  const SizedBox(width: 4),

                  Text(
                    status,
                    style: TextStyle(
                      color: color,
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
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
