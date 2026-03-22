import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  Widget _buildFieldTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0, top: 16.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          color: Color(0xFF06004F),
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildRoundedTextField({String? hintText, String? value}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey.withOpacity(0.3), width: 1),
      ),
      child: Text(
        value ?? hintText ?? "",
        style: TextStyle(
          fontSize: 14,
          color: value != null ? const Color(0xFF06004F) : Colors.grey,
          fontWeight: value != null ? FontWeight.w400 : FontWeight.w300,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const routePrimaryColor = Color(0xFF06004F);

    final String fullName = "Mohamed Mohamed Nabil";
    final String email = "mohamed.N@gmail.com";
    final String mobile = "01122118855";
    final String address = "6th October, street 11...";

    return Scaffold(
      backgroundColor: Colors.white,
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
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins',
                    color: routePrimaryColor,
                  ),
                ),
                const SizedBox(height: 15),
                Text(
                  "Welcome, ${fullName.split(' ')[0]}",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: routePrimaryColor,
                  ),
                ),
                Text(
                  email,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                    fontWeight: FontWeight.w400,
                  ),
                ),
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
