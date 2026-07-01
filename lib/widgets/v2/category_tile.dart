import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';

class CategoryTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final int bottles;
  final VoidCallback onTap;

  const CategoryTile({
    super.key,
    required this.icon,
    required this.title,
    required this.bottles,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: AppColors.primary.withValues(alpha: 0.10),
                child: Icon(
                  icon,
                  color: AppColors.primary,
                ),
              ),

              const SizedBox(width: 16),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "$bottles bottiglie",
                      style: const TextStyle(
                        color: AppColors.subtitle,
                      ),
                    ),
                  ],
                ),
              ),

              const Icon(Icons.chevron_right),
            ],
          ),
        ),
      ),
    );
  }
}