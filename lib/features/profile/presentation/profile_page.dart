import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../notifications/presentation/notification_page.dart';
import '../../settings/presentation/settings_page.dart';
import '../../placeholder/presentation/placeholder_page.dart';
import '../../../shared/presentation/widgets/custom_bottom_bar.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _phoneController;
  late final TextEditingController _addressController;
  late final TextEditingController _locationController;
  late final TextEditingController _location2Controller;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: 'Mohamed karam');
    _emailController = TextEditingController();
    _phoneController = TextEditingController();
    _addressController = TextEditingController();
    _locationController = TextEditingController();
    _location2Controller = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _locationController.dispose();
    _location2Controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const backgroundColor = Color(0xFFF3F3F3);
    const bottomBarColor = Color(0xFF384569);

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: _buildAppBar(context),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Column(
                children: [
                  const _ProfileHeader(),
                  const SizedBox(height: 24),
                  Column(
                    children: [
                      _ProfileTextField(
                        label: 'Name ',
                        controller: _nameController,
                      ),
                      const SizedBox(height: 20),
                      _ProfileTextField(
                        label: 'Email ',
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                      ),
                      const SizedBox(height: 20),
                      _ProfileTextField(
                        label: 'Phone Number ',
                        controller: _phoneController,
                        keyboardType: TextInputType.phone,
                      ),
                      const SizedBox(height: 20),
                      _ProfileTextField(
                        label: 'Address ',
                        controller: _addressController,
                      ),
                      const SizedBox(height: 20),
                      _ProfileTextField(
                        label: 'Location ',
                        controller: _locationController,
                      ),
                      const SizedBox(height: 20),
                      _ProfileTextField(
                        label: 'Location ',
                        controller: _location2Controller,
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: bottomBarColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                      onPressed: () {
                        // UI only - no functionality
                      },
                      child: Text(
                        'Update account',
                        style: GoogleFonts.openSans(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomBar(
        selectedIndex: 3,
        onItemTapped: (index) {
          if (index == 3) {
            // Already on Profile tab.
            return;
          }

          switch (index) {
            case 0:
              // Home icon => open placeholder "Home" screen
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (_) =>
                      const PlaceholderPage(tabIndex: 0, title: 'Home'),
                ),
              );
              break;
            case 1:
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (_) =>
                      const PlaceholderPage(tabIndex: 1, title: 'Calendar'),
                ),
              );
              break;
            case 2:
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (_) => const NotificationPage()),
              );
              break;
          }
        },
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    const textColor = Colors.black;

    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new_rounded),
        color: textColor,
        onPressed: () {
          Navigator.of(context).maybePop();
        },
      ),
      title: const Text(
        'Profile',
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.5,
          color: textColor,
        ),
      ),
      centerTitle: true,
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 16),
          child: IconButton(
            icon: const Icon(Icons.settings_outlined, color: textColor),
            onPressed: () {
              Navigator.of(
                context,
              ).push(MaterialPageRoute(builder: (_) => const SettingsPage()));
            },
          ),
        ),
      ],
      backgroundColor: const Color(0xFFF3F3F3),
      elevation: 0,
    );
  }
}

class _ProfileHeader extends StatelessWidget {
  const _ProfileHeader();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CircleAvatar(
          radius: 38,
          backgroundColor: Color(0xFF384569),
          child: Icon(
            Icons.person_outline_rounded,
            color: Colors.white,
            size: 32,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Mohamed karam',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(width: 6),
            const Icon(Icons.verified, color: Colors.blue, size: 18),
          ],
        ),
        const SizedBox(height: 4),
        const Text(
          '@mohamedkaram',
          style: TextStyle(fontSize: 13, color: Colors.grey),
        ),
      ],
    );
  }
}

class _ProfileTextField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final TextInputType? keyboardType;

  const _ProfileTextField({
    required this.label,
    required this.controller,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    const borderRadius = 12.0;
    const greyBorder = Color(0xFFD5D5D5);
    const focused = Color(0xFF384569);

    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.always,
        labelText: label,
        labelStyle: GoogleFonts.openSans(
          fontSize: 14,
          color: Colors.black87,
          fontWeight: FontWeight.w600,
        ),
        floatingLabelStyle: GoogleFonts.openSans(
          fontSize: 14,
          color: Colors.black87,
          fontWeight: FontWeight.w600,
        ),
        hintText: null,
        isDense: true,
        contentPadding: const EdgeInsets.fromLTRB(16, 20, 16, 12),
        filled: true,
        fillColor: Colors.white,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: const BorderSide(color: greyBorder, width: 1),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: const BorderSide(color: greyBorder, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: const BorderSide(color: focused, width: 1.4),
        ),
      ),
      style: GoogleFonts.openSans(fontSize: 14, color: Colors.black87),
      cursorColor: focused,
    );
  }
}
