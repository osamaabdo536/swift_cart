import 'package:flutter/material.dart';
import 'package:swift_cart/core/resources/app_text_styles.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swift_cart/core/resources/app_colors.dart';
import 'package:swift_cart/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:swift_cart/features/auth/presentation/cubit/auth_state.dart';
import 'package:swift_cart/features/auth/login.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  void _handleLogout(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(dialogContext);
              context.read<AuthCubit>().logout();
            },
            child: const Text('Logout', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        title: Text('My Profile', style: AppTextStyles.semiBold16),
        centerTitle: true,
        backgroundColor: AppColors.whiteColor,
        elevation: 0,
      ),
      body: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthLoggedOut) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const Login()),
              (route) => false,
            );
          }
        },
        child: BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            String name = "Guest User";
            String email = "example@mail.com";

            if (state is AuthSuccess) {
              name = state.user.name;
              email = state.user.email;
            }

            return SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      const SizedBox(height: 20),
                      CircleAvatar(
                        radius: 50,
                        backgroundColor: AppColors.primary.withValues(
                          alpha: 0.1,
                        ),
                        child: Text(
                          name.isNotEmpty ? name[0].toUpperCase() : "G",
                          style: AppTextStyles.semiBold16.copyWith(
                            fontSize: 32,
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),

                      _buildInfoField(
                        icon: Icons.person_outline,
                        label: 'Name',
                        value: name,
                      ),
                      _buildInfoField(
                        icon: Icons.email_outlined,
                        label: 'Email',
                        value: email,
                      ),
                      const SizedBox(height: 150),
                    ],
                  ),

                  _buildLogoutButton(context, state),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildInfoField({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: ListTile(
        leading: Icon(icon, color: AppColors.primary),
        title: Text(
          label,
          style: AppTextStyles.regular14.copyWith(color: Colors.grey),
        ),
        subtitle: Text(
          value,
          style: AppTextStyles.medium14.copyWith(color: Colors.black87),
        ),
      ),
    );
  }

  Widget _buildLogoutButton(BuildContext context, AuthState state) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: state is AuthLoading ? null : () => _handleLogout(context),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red[50],
          foregroundColor: Colors.red,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        child: state is AuthLoading
            ? const CircularProgressIndicator(color: Colors.red)
            : const Text(
                'Logout',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
      ),
    );
  }
}
