import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swift_cart/core/resources/app_colors.dart';
import 'package:swift_cart/core/resources/app_text_styles.dart';
import 'package:swift_cart/features/auth/auth_injection.dart';
import 'package:swift_cart/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:swift_cart/features/auth/presentation/cubit/auth_state.dart';
import 'package:swift_cart/features/auth/login.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String? userName;
  String? userEmail;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final user = await AuthInjection.repository.getCurrentUser();
    if (user != null && mounted) {
      setState(() {
        userName = user.name;
        userEmail = user.email;
      });
    }
  }

  void _handleLogout() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              context.read<AuthCubit>().logout();
            },
            child: Text('Logout', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile', style: AppTextStyles.semiBold16),
        centerTitle: true,
        backgroundColor: Colors.white,
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
          } else if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              // Profile Avatar
              CircleAvatar(
                radius: 50,
                backgroundColor: AppColors.primary.withOpacity(0.1),
                child: Icon(Icons.person, size: 50, color: AppColors.primary),
              ),
              const SizedBox(height: 16),

              // User Name
              Text(userName ?? 'Loading...', style: AppTextStyles.semiBold16),
              const SizedBox(height: 4),

              // User Email
              Text(
                userEmail ?? '',
                style: AppTextStyles.regular14.copyWith(color: Colors.grey),
              ),
              const SizedBox(height: 32),

              // Profile Options
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

              // Logout Button
              BlocBuilder<AuthCubit, AuthState>(
                builder: (context, state) {
                  return SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: state is AuthLoading ? null : _handleLogout,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 0,
                      ),
                      child: state is AuthLoading
                          ? const SizedBox(
                              height: 24,
                              width: 24,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.logout, color: Colors.white),
                                const SizedBox(width: 8),
                                Text(
                                  'Logout',
                                  style: AppTextStyles.semiBold16.copyWith(
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileOption({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.grey[100],
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
