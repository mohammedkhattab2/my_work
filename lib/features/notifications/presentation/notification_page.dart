import 'package:flutter/material.dart';

import '../../placeholder/presentation/placeholder_page.dart';
import '../../profile/presentation/profile_page.dart';
import '../../../shared/presentation/widgets/custom_bottom_bar.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  static const Color _backgroundColor = Color(0xFFF7F7F7);

  static const List<_NotificationSectionData> _sections = [
    _NotificationSectionData(
      title: 'New',
      items: [
        _NotificationItemData(
          message:
              'Lorem ipsum dolorLorem ipsum dolor do Lorem ipsum dolorLorem ipsum dolor do',
          time: '2m ago',
        ),
        _NotificationItemData(
          message:
              'Lorem ipsum dolorLorem ipsum dolor do Lorem ipsum dolorLorem ipsum dolor do',
          time: '2m ago',
        ),
      ],
    ),
    _NotificationSectionData(
      title: 'Today',
      items: [
        _NotificationItemData(
          message:
              'Lorem ipsum dolorLorem ipsum dolor do Lorem ipsum dolorLorem ipsum dolor do',
          time: '2m ago',
        ),
        _NotificationItemData(
          message:
              'Lorem ipsum dolorLorem ipsum dolor do Lorem ipsum dolorLorem ipsum dolor do',
          time: '2m ago',
        ),
        _NotificationItemData(
          message:
              'Lorem ipsum dolorLorem ipsum dolor do Lorem ipsum dolorLorem ipsum dolor do',
          time: '2m ago',
        ),
      ],
    ),
    _NotificationSectionData(
      title: 'Yesterday',
      items: [
        _NotificationItemData(
          message:
              'Lorem ipsum dolorLorem ipsum dolor do Lorem ipsum dolorLorem ipsum dolor do',
          time: '2m ago',
        ),
        _NotificationItemData(
          message:
              'Lorem ipsum dolorLorem ipsum dolor do Lorem ipsum dolorLorem ipsum dolor do',
          time: '2m ago',
        ),
      ],
    ),
  ];

  void _onNavTap(BuildContext context, int index) {
    if (index == 2) {
      return;
    }

    switch (index) {
      case 0:
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (_) => const PlaceholderPage(tabIndex: 0, title: 'Home'),
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
      case 3:
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const ProfilePage()),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _backgroundColor,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(22, 18, 22, 12),
          children: [
            const Text(
              'Notification',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 18),
            ..._sections.map(
              (section) => Padding(
                padding: const EdgeInsets.only(bottom: 22),
                child: _NotificationSection(section: section),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomBar(
        selectedIndex: 2,
        onItemTapped: (index) => _onNavTap(context, index),
      ),
    );
  }
}

class _NotificationSection extends StatelessWidget {
  const _NotificationSection({required this.section});

  final _NotificationSectionData section;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          section.title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 14),
        ...section.items.map(
          (item) => Padding(
            padding: const EdgeInsets.only(bottom: 18),
            child: _NotificationTile(item: item),
          ),
        ),
      ],
    );
  }
}

class _NotificationTile extends StatelessWidget {
  const _NotificationTile({required this.item});

  final _NotificationItemData item;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CircleAvatar(
          radius: 22,
          backgroundImage: AssetImage('assets/notification_image.png'),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.message,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 14,
                  height: 1.4,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                item.time,
                style: const TextStyle(
                  fontSize: 12,
                  color: Color(0xFF8A8A8A),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _NotificationSectionData {
  final String title;
  final List<_NotificationItemData> items;

  const _NotificationSectionData({required this.title, required this.items});
}

class _NotificationItemData {
  final String message;
  final String time;

  const _NotificationItemData({required this.message, required this.time});
}
