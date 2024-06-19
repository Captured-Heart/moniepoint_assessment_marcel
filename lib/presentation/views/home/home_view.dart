// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:moniepoint_assessment_marcel/app.dart';
import 'package:moniepoint_assessment_marcel/data/home_view_mixins.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<StatefulWidget> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with HomeViewMixins {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // saint petersburg row
            IstSectionHomeView(expandText: expandText, hideCircleRow: hideCircleRow)
                .padSymmetric(horizontal: 15, vertical: 10),
            // BUY AND RENT ROW WIDGETS
            SecondSectionHomeView(
              numValue1: numValue1,
              numValue2: numValue2,
              hideCircleRow: hideCircleRow,
            ),
          ],
        ),
      ),
    );
  }
}


