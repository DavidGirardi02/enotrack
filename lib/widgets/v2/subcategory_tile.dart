import 'package:flutter/material.dart';

class SubCategoryTile extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const SubCategoryTile({
    super.key,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 18,
          ),
          child: Row(
            children: [
              const Icon(Icons.folder_open),

              const SizedBox(width: 16),

              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                  ),
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