import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_typography.dart';
import '../../user_home/widgets/quick_actions_widgets.dart';

class ScanScreen extends StatefulWidget {
  const ScanScreen({super.key});

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  static const String _predictUrl = 'https://yh-777-dog-ai-api.hf.space/predict';
  static final Dio _dio = Dio(
    BaseOptions(
      baseUrl: _predictUrl,
      connectTimeout: const Duration(seconds: 20),
      receiveTimeout: const Duration(seconds: 20),
      validateStatus: (status) => status != null && status < 500,
    ),
  );

  final ImagePicker _imagePicker = ImagePicker();
  File? _image;
  bool _isLoading = false;
  String _result = 'اختار صورة الكلب لبدء الفحص';

  Future<void> _pickImage() async {
    final XFile? pickedFile = await _imagePicker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile == null) return;

    setState(() {
      _image = File(pickedFile.path);
      _result = 'تم اختيار الصورة، اضغط على تحليل';
    });
  }

  Future<void> _analyzeImage() async {
    final File? selectedImage = _image;
    if (selectedImage == null) return;

    setState(() {
      _isLoading = true;
      _result = 'جاري التحليل... انتظر قليلاً';
    });

    final _ApiResponse response = await _sendImage(selectedImage);
    log('API data: ${response.data}');

    if (!mounted) return;

    setState(() {
      _isLoading = false;
      if (response.isSuccess && response.data?['success'] == true) {
        final Map<String, dynamic> data = response.data!;
        _result =
            'المرض المتوقع: ${data['predicted_disease']}\n'
            'المزاج: ${data['predicted_mood']}\n'
            'الدقة: ${data['disease_confidence']}%';
      } else {
        log('API error: ${response.errorMessage}');
        _result =
            response.errorMessage ??
            response.data?['message']?.toString() ??
            'حدث خطأ غير متوقع';
      }
    });
  }

  Future<_ApiResponse> _sendImage(File image) async {
    try {
      final FormData formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(image.path),
      });

      final Response<dynamic> response = await _dio.post<dynamic>(
        '',
        data: formData,
      );

      if (response.statusCode == 200 && response.data is Map<String, dynamic>) {
        return _ApiResponse.success(response.data as Map<String, dynamic>);
      }

      return _ApiResponse.failure(
        'خطأ من السيرفر: ${response.statusCode ?? 'Unknown'}',
      );
    } on DioException catch (error) {
      return _ApiResponse.failure(_mapDioError(error));
    } catch (error) {
      return _ApiResponse.failure('فشل الاتصال بالسيرفر: $error');
    }
  }

  String _mapDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.sendTimeout:
        return 'انتهت مهلة الاتصال، حاول مرة أخرى';
      case DioExceptionType.connectionError:
        return 'لا يوجد اتصال بالسيرفر، تأكد من الإنترنت';
      case DioExceptionType.badResponse:
        return 'السيرفر رجع خطأ: ${error.response?.statusCode ?? 'Unknown'}';
      default:
        return 'حدث خطأ غير متوقع أثناء الاتصال';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          const QuickActionHeader(userName: '', showSearch: false),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
              child: Column(
                children: [
                  SizedBox(height: 8.h),
                  _image != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(16.r),
                          child: Image.file(
                            _image!,
                            height: 260.h,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        )
                      : Container(
                          height: 240.h,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: AppColors.backgroundGray.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(16.r),
                            border: Border.all(
                              color: AppColors.primaryPurple,
                              width: 2,
                            ),
                          ),
                          child: Center(
                            child: Icon(
                              Icons.photo_library_outlined,
                              size: 80.w,
                              color: AppColors.primaryPurple,
                            ),
                          ),
                        ),
                  SizedBox(height: 24.h),
                  Text(
                    'AI Scan',
                    style: AppTypography.h2.copyWith(
                      color: AppColors.primaryPurple,
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Text(
                    'Upload your dog image and run an instant AI health and mood analysis.',
                    textAlign: TextAlign.center,
                    style: AppTypography.bodyMedium.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  SizedBox(height: 24.h),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: _pickImage,
                      icon: const Icon(Icons.image_outlined),
                      label: const Text('اختار صورة من الجاليري'),
                    ),
                  ),
                  SizedBox(height: 12.h),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed:
                          _isLoading || _image == null ? null : _analyzeImage,
                      icon: _isLoading
                          ? SizedBox(
                              width: 18.w,
                              height: 18.w,
                              child: const CircularProgressIndicator(
                                strokeWidth: 2.2,
                                color: Colors.white,
                              ),
                            )
                          : const Icon(Icons.analytics_outlined),
                      label: Text(
                        _isLoading ? 'جاري التحليل...' : 'ابدأ التحليل الآن',
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryPurple,
                        foregroundColor: Colors.white,
                        disabledBackgroundColor: AppColors.primaryPurple
                            .withOpacity(0.45),
                      ),
                    ),
                  ),
                  SizedBox(height: 24.h),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      color: AppColors.backgroundGray.withOpacity(0.45),
                      borderRadius: BorderRadius.circular(14.r),
                    ),
                    child: Text(
                      _result,
                      textAlign: TextAlign.center,
                      style: AppTypography.bodyMedium.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  SizedBox(height: 140.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ApiResponse {
  final bool isSuccess;
  final Map<String, dynamic>? data;
  final String? errorMessage;

  const _ApiResponse._({required this.isSuccess, this.data, this.errorMessage});

  factory _ApiResponse.success(Map<String, dynamic> data) =>
      _ApiResponse._(isSuccess: true, data: data);

  factory _ApiResponse.failure(String message) =>
      _ApiResponse._(isSuccess: false, errorMessage: message);
}
