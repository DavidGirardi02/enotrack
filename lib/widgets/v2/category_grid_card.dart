import 'package:flutter/material.dart';

class CategoryGridCard extends StatelessWidget {
  final String title;
  final int bottles;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const CategoryGridCard({
    super.key,
    required this.title,
    required this.bottles,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: color,
      borderRadius: BorderRadius.circular(22),
      child: InkWell(
        borderRadius: BorderRadius.circular(22),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              CircleAvatar(
                radius: 22,
                backgroundColor: Colors.white24,
                child: Icon(
                  icon,
                  color: Colors.white,
                ),
              ),

              const Spacer(),

              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 6),

              Text(
                "$bottles bottiglie",
                style: const TextStyle(
                  color: Colors.white70,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}