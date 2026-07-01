import 'package:flutter/material.dart';

class DashboardHeader extends StatelessWidget {
  const DashboardHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 280,
      margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 20,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(28),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              "assets/images/header.png",
              fit: BoxFit.cover,
            ),

            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Colors.black.withOpacity(.82),
                    Colors.black.withOpacity(.35),
                    Colors.transparent,
                  ],
                ),
              ),
            ),

            Positioned(
              top: 18,
              right: 18,
              child: CircleAvatar(
                radius: 22,
                backgroundColor: Colors.black45,
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.settings,
                    color: Colors.white,
                  ),
                ),
              ),
            ),

            const Padding(
              padding: EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Spacer(),

                  
                  SizedBox(height: 32),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}