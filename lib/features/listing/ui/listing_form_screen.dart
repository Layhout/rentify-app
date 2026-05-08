import 'package:flutter/material.dart';
import 'package:rentify_app/common_widgets/theme/app_constants.dart';
import 'package:rentify_app/common_widgets/theme/theme_extensions.dart';

class ListingFormScreen extends StatefulWidget {
  const ListingFormScreen({super.key});

  @override
  State<ListingFormScreen> createState() => _ListingFormScreenState();
}

class _ListingFormScreenState extends State<ListingFormScreen> {
  final ScrollController _scrollController = ScrollController();

  int _currentIndex = 0;

  final List<String> _steps = ["Basic Information", "Media", "Pricing", "Review"];

  int get _totalSteps => _steps.length;
  int get _currentStep => _currentIndex + 1;

  @override
  void dispose() {
    _scrollController.dispose();

    super.dispose();
  }

  void _goToStep(int step) {
    if (step < 0 || step > _totalSteps - 1) return;

    final screenWidth = MediaQuery.sizeOf(context).width;

    _scrollController.animateTo(
      screenWidth * step,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );

    _currentIndex = step;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;

    return Scaffold(
      appBar: AppBar(title: Text("New Listing")),
      body: Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            spacing: AppConstants.spacingXS,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Step $_currentStep of $_totalSteps",
                    style: context.textTheme.labelMedium?.copyWith(
                      color: context.colorScheme.primary,
                    ),
                  ),
                  Text(
                    _steps[_currentIndex],
                    style: context.textTheme.labelMedium?.copyWith(
                      color: context.colorScheme.outline,
                    ),
                  ),
                ],
              ),
              LinearProgressIndicator(value: _currentStep / _totalSteps),
            ],
          ).paddingOnly(
            left: AppConstants.spacingMD,
            right: AppConstants.spacingMD,
            bottom: AppConstants.spacingMD,
          ),
          SingleChildScrollView(
            controller: _scrollController,
            scrollDirection: Axis.horizontal,
            physics: const NeverScrollableScrollPhysics(),
            child: Row(
              children: [
                Container(width: screenWidth, color: Colors.red),
                Container(width: screenWidth, color: Colors.green),
                Container(width: screenWidth, color: Colors.blue),
                Container(width: screenWidth, color: Colors.yellow),
              ],
            ),
          ).expanded(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            spacing: AppConstants.spacingXS,
            children: [
              FilledButton(
                onPressed: () {
                  _goToStep(_currentStep);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: AppConstants.spacingXS,
                  children: [Text("Continue"), Icon(Icons.arrow_forward)],
                ),
              ),
              TextButton(
                onPressed: () {
                  _goToStep(0);
                },
                child: Text('Save as draft'),
              ),
            ],
          ).paddingOnly(
            top: AppConstants.spacingMD,
            left: AppConstants.spacingMD,
            right: AppConstants.spacingMD,
            bottom: AppConstants.spacingXS,
          ),
        ],
      ).safeArea(top: false),
    );
  }
}
