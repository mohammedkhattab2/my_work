import 'package:flutter/material.dart';

import '../../profile/presentation/profile_page.dart';
import '../../placeholder/presentation/placeholder_page.dart';
import '../../../shared/presentation/widgets/custom_bottom_bar.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  static const Color _backgroundColor = Color(0xFFF3F3F3);
  static const Color _textColor = Colors.black;

  static const List<_SettingsItem> _settingsItems = [
    _SettingsItem(
      icon: Icons.assignment_outlined,
      title: 'My Orders',
    ),
    _SettingsItem(
      icon: Icons.open_in_new_outlined,
      title: 'Edit Profile',
    ),
    _SettingsItem(
      icon: Icons.language_outlined,
      title: 'Language',
    ),
    _SettingsItem(
      icon: Icons.payment,
      title: 'Payment Method',
    ),
    _SettingsItem(
      icon: Icons.location_on_outlined,
      title: 'My Address',
    ),
    _SettingsItem(
      icon: Icons.notifications_none,
      title: 'Notifications',
    ),
    _SettingsItem(
      icon: Icons.help_outline,
      title: 'Help Center',
    ),
    _SettingsItem(
      icon: Icons.lock_outline,
      title: 'Privacy Policy',
    ),
    _SettingsItem(
      icon: Icons.logout,
      title: 'Log Out',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _backgroundColor,
      appBar: _buildAppBar(context),
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              itemBuilder: (context, index) {
                final item = _settingsItems[index];
                return _SettingsTile(
                  icon: item.icon,
                  title: item.title,
                  onTap: () {
                    // UI only - no functionality
                  },
                );
              },
              separatorBuilder: (context, index) => const SizedBox(height: 12),
              itemCount: _settingsItems.length,
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomBar(
        selectedIndex: 3,
        onItemTapped: (index) {
          if (index == 3) {
            // Already on Profile-related screen (Settings), go back to Profile
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (_) => const ProfilePage(),
              ),
            );
            return;
          }

          switch (index) {
            case 0:
              // Home icon opens placeholder "Home" screen
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (_) => const PlaceholderPage(
                    tabIndex: 0,
                    title: 'Home',
                  ),
                ),
              );
              break;
            case 1:
            case 2:
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (_) => PlaceholderPage(
                    tabIndex: index,
                    title: index == 1 ? 'Calendar' : 'My Packages',
                  ),
                ),
              );
              break;
          }
        },
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new_rounded),
        color: _textColor,
        onPressed: () {
          Navigator.of(context).maybePop();
        },
      ),
      title: const Text(
        'Settings',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
          color: _textColor,
        ),
      ),
      centerTitle: true,
      actions: const [
        Padding(
          padding: EdgeInsets.only(right: 16),
          child: Icon(
            Icons.settings_outlined,
            color: _textColor,
          ),
        ),
      ],
      backgroundColor: _backgroundColor,
      elevation: 0,
    );
  }
}

class _SettingsItem {
  final IconData icon;
  final String title;

  const _SettingsItem({
    required this.icon,
    required this.title,
  });
}

class _SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback? onTap;

  const _SettingsTile({
    required this.icon,
    required this.title,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Row(
            children: [
              Icon(
                icon,
                color: Colors.black87,
                size: 24,
              ),
              const SizedBox(width: 18),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black87,
                  ),
                ),
              ),
              const Icon(
                Icons.arrow_forward_ios_rounded,
                size: 18,
                color: Colors.black87,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
