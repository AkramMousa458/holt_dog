import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:holt_dog/features/user_side/user_home/screens/user_home_screen.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_styles.dart';
import '../../../core/constants/app_typography.dart';
import '../../../core/routes/app_router.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/custom_text_field.dart';
import '../widgets/auth_header.dart';
import '../cubit/auth_cubit.dart';
import '../cubit/auth_state.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleSignup() {
    if (_formKey.currentState!.validate()) {
      context.read<AuthCubit>().signup(
            _emailController.text.trim(),
            _passwordController.text.trim(),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is Authenticated) {
          context.go(UserHomeScreen.routeName);
        } else if (state is AuthError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.backgroundGray,
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const AuthHeader(
                  title: 'Create Account',
                  subtitle: 'Register',
                  showBackButton: true,
                ),
                Padding(
                  padding: EdgeInsets.all(AppStyles.spaceL.w),
                  child: Column(
                    children: [
                      SizedBox(height: 20.h),
                      CustomTextField(
                        label: 'Full Name :',
                        hint: 'Enter Your Name',
                        controller: _nameController,
                        prefixIcon: null,
                        suffixIcon: const Icon(Icons.person_outline,
                            color: AppColors.textSecondary),
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your name';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20.h),
                      CustomTextField(
                        label: 'Email :',
                        hint: 'Enter Your Email',
                        controller: _emailController,
                        prefixIcon: null,
                        suffixIcon: const Icon(Icons.email_outlined,
                            color: AppColors.textSecondary),
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          }
                          if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                              .hasMatch(value)) {
                            return 'Please enter a valid email';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20.h),
                      CustomTextField(
                        label: 'Password :',
                        hint: 'Enter Your Password',
                        controller: _passwordController,
                        isPassword: true,
                        prefixIcon: null,
                        suffixIcon: const Icon(Icons.lock_outline,
                            color: AppColors.textSecondary),
                        textInputAction: TextInputAction.done,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          if (value.length < 6) {
                            return 'Password must be at least 6 characters';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 10.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Already Have An Account ? ',
                            style: AppTypography.bodyMedium,
                          ),
                          GestureDetector(
                            onTap: () => context.pop(),
                            child: Text(
                              'Login',
                              style: AppTypography.bodyMedium.copyWith(
                                color: AppColors.primaryMagenta,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 40.h),
                      BlocBuilder<AuthCubit, AuthState>(
                        builder: (context, state) {
                          return CustomButton(
                            text: 'Sign Up',
                            isLoading: state is AuthLoading,
                            onPressed: _handleSignup,
                          );
                        },
                      ),
                      SizedBox(height: 20.h),
                      GestureDetector(
                        onTap: () => context.push(AppRouter.privacyPolicy),
                        child: Text(
                          'Privacy Policy',
                          style: AppTypography.bodySmall.copyWith(
                            decoration: TextDecoration.underline,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ),
                      SizedBox(height: 20.h),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
