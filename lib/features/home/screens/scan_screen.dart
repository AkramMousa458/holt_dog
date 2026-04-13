import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_typography.dart';
import '../widgets/quick_actions_widgets.dart';

class ScanScreen extends StatelessWidget {
  const ScanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          const QuickActionHeader(userName: '', showSearch: false),
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.all(40.w),
                    decoration: BoxDecoration(
                      color: AppColors.backgroundGray.withOpacity(0.5),
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.primaryPurple, width: 2),
                    ),
                    child: Icon(Icons.qr_code_scanner, color: AppColors.primaryPurple, size: 80.w),
                  ),
                  SizedBox(height: 30.h),
                  Text(
                    'AI Scan',
                    style: AppTypography.h2.copyWith(color: AppColors.primaryPurple),
                  ),
                  SizedBox(height: 12.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40.w),
                    child: Text(
                      'Scan a dog to identify its breed and help state instantly.',
                      textAlign: TextAlign.center,
                      style: AppTypography.bodyMedium.copyWith(color: AppColors.textSecondary),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 140.h), // Bottom Nav space
        ],
      ),
    );
  }
}
