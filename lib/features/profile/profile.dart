import 'package:flutter/material.dart';
import 'package:swift_cart/core/resources/app_text_styles.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swift_cart/core/resources/app_colors.dart';
import 'package:swift_cart/features/auth/auth_injection.dart';
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
    return Scaffold(body: Center(child: Text("profile")));
    return Scaffold(
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
              name = state.user.name ?? name;
              email = state.user.email ?? email;
            }

            return SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: AppColors.primary.withOpacity(0.1),
                    child: Text(
                      name[0].toUpperCase(),
                      style: AppTextStyles.semiBold16.copyWith(
                        fontSize: 32,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  Text(name, style: AppTextStyles.semiBold16),
                  const SizedBox(height: 4),
                  Text(
                    email,
                    style: AppTextStyles.regular14.copyWith(color: Colors.grey),
                  ),

                  const SizedBox(height: 32),
                  _buildProfileOption(
                    icon: Icons.person_outline,
                    title: 'Edit Profile',
                    onTap: () {
                      // TODO: Navigate to edit profile
                    },
                  ),
                  _buildProfileOption(
                    icon: Icons.shopping_bag_outlined,
                    title: 'My Orders',

                    onTap: () {
                      // TODO: Navigate to orders
                    },
                  ),
                  _buildProfileOption(
                    icon: Icons.location_on_outlined,
                    title: 'Addresses',
                    onTap: () {
                      // TODO: Navigate to addresses
                    },
                  ),
                  _buildProfileOption(
                    icon: Icons.payment_outlined,
                    title: 'Payment Methods',
                    onTap: () {
                      // TODO: Navigate to payment methods
                    },
                  ),
                  _buildProfileOption(
                    icon: Icons.settings_outlined,
                    title: 'Settings',
                    onTap: () {
                      // TODO: Navigate to settings
                    },
                  ),
                  _buildProfileOption(
                    icon: Icons.help_outline,
                    title: 'Help & Support',
                    onTap: () {
                      // TODO: Navigate to help
                    },
                  ),
                  const SizedBox(height: 16),

                  const SizedBox(height: 32),

                  _buildLogoutButton(context, state),
                ],
              ),
            );
          },
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

  // Profile Options
  Widget _buildProfileOption({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Icon(icon, color: AppColors.primary),
        title: Text(title, style: AppTextStyles.medium14),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }
}
