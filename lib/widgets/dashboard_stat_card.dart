import 'package:flutter/material.dart';
import '../../screens/reorder/reorder_screen.dart';
import '../core/theme/app_colors.dart';

class DashboardStatCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final Color? color;
  final VoidCallback? onTap;

  const DashboardStatCard({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
    this.color,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final cardColor = color ?? AppColors.primary;

    return Card(
      elevation: 3,
      shadowColor: Colors.black12,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      child: InkWell(
        onTap: onTap,
        child: Column(
          children: [
            Container(
              height: 5,
              color: cardColor,
            ),

            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 14,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 42,
                      height: 42,
                      decoration: BoxDecoration(
                        color: cardColor.withOpacity(.10),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        icon,
                        color: cardColor,
                        size: 22,
                      ),
                    ),

                    const Spacer(),

                    Text(
                      value,
                      style: const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w700,
                        height: 1,
                      ),
                    ),

                    const SizedBox(height: 6),

                    Text(
                      title,
                      style: const TextStyle(
                        color: AppColors.subtitle,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
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