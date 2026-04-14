import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_typography.dart';
import '../../home/widgets/quick_actions_widgets.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          const QuickActionHeader(userName: '', showSearch: false),
          Expanded(
            child: Stack(
              children: [
                // Simulated Map Background
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: AppColors.backgroundGray.withOpacity(0.3),
                  child: Center(
                    child: Opacity(
                      opacity: 0.1,
                      child: Icon(Icons.map, size: 200.w),
                    ),
                  ),
                ),
                // Location Markers
                _buildMarker(200.h, 100.w, Icons.pets, AppColors.primaryMagenta),
                _buildMarker(350.h, 250.w, Icons.medical_services, Colors.blue),
                _buildMarker(150.h, 280.w, Icons.home_work, Colors.orange),
                
                // Floating Search/Filter
                Positioned(
                  top: 20.h,
                  left: 20.w,
                  right: 20.w,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.search, color: AppColors.textHint),
                        SizedBox(width: 12.w),
                        Text('Find nearby help...', style: AppTypography.bodySmall),
                        const Spacer(),
                        const Icon(Icons.filter_list, color: AppColors.primaryPurple),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 140.h), // Bottom Nav space
        ],
      ),
    );
  }

  Widget _buildMarker(double top, double left, IconData icon, Color color) {
    return Positioned(
      top: top,
      left: left,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 2),
            ),
            child: Icon(icon, color: Colors.white, size: 20.w),
          ),
          Container(
            width: 2.w,
            height: 10.h,
            color: color,
          ),
        ],
      ),
    );
  }
}
