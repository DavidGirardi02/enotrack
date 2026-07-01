import 'package:flutter/material.dart';

import '../../widgets/v2/category_section.dart';
import '../../widgets/v2/dashboard_header.dart';
import '../../widgets/v2/dashboard_summary.dart';
import '../../widgets/v2/global_search_bar.dart';

class HomeScreenV2 extends StatelessWidget {
  const HomeScreenV2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.only(bottom: 24),
          children: [

            DashboardHeader(),

            Transform.translate(
              offset: Offset(0, -28),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: GlobalSearchBar(),
              ),
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: DashboardSummary(),
            ),

            SizedBox(height: 28),

            CategorySection(),

            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}