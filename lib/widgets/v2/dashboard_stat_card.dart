import 'package:flutter/material.dart';

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
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                icon,
                color: color ?? AppColors.primary,
                size: 32,
              ),

              const Spacer(),

              Text(
                value,
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 4),

              Text(
                title,
                style: const TextStyle(
                  color: AppColors.subtitle,
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}