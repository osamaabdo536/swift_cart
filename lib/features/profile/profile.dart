import 'package:flutter/material.dart';
import 'package:swift_cart/core/resources/app_colors.dart';
import 'package:swift_cart/core/resources/app_text_styles.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  Widget _buildFieldTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0, top: 16.0),
      child: Text(title, style: AppTextStyles.description18Medium),
    );
  }

  Widget _buildRoundedTextField({String? hintText, String? value}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: AppColors.strokeColor),
      ),
      child: Text(
        value ?? hintText ?? "",
        style: value != null
            ? AppTextStyles.description14Medium
            : AppTextStyles.description14light,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final String fullName = "Mohamed Mohamed Nabil";
    final String email = "mohamed.N@gmail.com";
    final String mobile = "01122118855";
    final String address = "6th October, street 11...";

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Route",
                  style: AppTextStyles.main20SemiBold.copyWith(fontSize: 24),
                ),
                const SizedBox(height: 15),
                Text(
                  "Welcome, ${fullName.split(' ')[0]}",
                  style: AppTextStyles.main18Medium,
                ),
                Text(email, style: AppTextStyles.description14light),
                const SizedBox(height: 10),

                _buildFieldTitle("Your full name"),
                _buildRoundedTextField(value: fullName),

                _buildFieldTitle("Your E-mail"),
                _buildRoundedTextField(value: email),

                _buildFieldTitle("Your mobile number"),
                _buildRoundedTextField(value: mobile),

                _buildFieldTitle("Your Address"),
                _buildRoundedTextField(value: address),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
