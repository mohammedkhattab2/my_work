import 'package:flutter/material.dart';

class CustomBottomBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onItemTapped;

  const CustomBottomBar({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  static const Color _barColor = Color(0xFF3E4E70);
  static const double _barHeight = 72;
  static const double _totalHeight = 96;
  static const double _circleDiameter = 64;

  static const List<IconData> _icons = <IconData>[
    Icons.home_outlined,
    Icons.calendar_today_outlined,
    Icons.notifications_none_rounded,
    Icons.person_outline,
  ];

  static const List<String> _labels = <String>[
    'Home',
    'Calendar',
    'Notification',
    'Profile',
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: _totalHeight,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final double slotWidth = constraints.maxWidth / _icons.length;
          final double circleRadius = _circleDiameter / 2;

          // مركز الأيكون المختارة على محور الـ X
          final double selectedCenterX =
              slotWidth * (selectedIndex + 0.5); // 0.5 عشان نص السجمنت
          final double circleLeft = selectedCenterX - circleRadius;

          return Stack(
            clipBehavior: Clip.none,
            children: [
              // البار نفسه مع الكيرف المتحرك تحت الأيكون المختارة
              Align(
                alignment: Alignment.bottomCenter,
                child: ClipPath(
                  clipper: BottomBarClipper(
                    selectedIndex: selectedIndex,
                    itemCount: _icons.length,
                  ),
                  child: Container(
                    height: _barHeight,
                    decoration: const BoxDecoration(color: _barColor),
                    child: Row(
                      children: List.generate(
                        _icons.length,
                        (index) => Expanded(child: _buildBarItem(index)),
                      ),
                    ),
                  ),
                ),
              ),

              // الأيكون المختارة تطلع فوق وتاخد شكل البروفايل + الاسم تحتها
              Positioned(
                top: 1, // يخلي الدائرة طالعة فوق البار شوية
                left: circleLeft,
                child: _buildFloatingSelectedItem(),
              ),
            ],
          );
        },
      ),
    );
  }

  /// الأيقونة "الطبيعية" جوه البار لما تكون مش مختارة
  Widget _buildBarItem(int index) {
    final bool isSelected = selectedIndex == index;

    if (isSelected) {
      // الأيكون المختارة هتظهر في الشكل الطاير فقط، فهنا نخفيها من جوه البار
      return const SizedBox.shrink();
    }

    return GestureDetector(
      onTap: () => onItemTapped(index),
      child: Center(
        child: Icon(
          _icons[index],
          size: 24,
          color: Colors.white.withValues(alpha: 0.7),
        ),
      ),
    );
  }

  /// الشكل الطاير فوق البار للأيكون المختارة (نفس ستايل البروفايل)
  Widget _buildFloatingSelectedItem() {
    final IconData icon = _icons[selectedIndex];
    final String label = _labels[selectedIndex];

    return GestureDetector(
      onTap: () => onItemTapped(selectedIndex),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: _circleDiameter,
            height: _circleDiameter,
            decoration: BoxDecoration(
              color: _barColor,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 4),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.18),
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Icon(icon, color: Colors.white, size: 30),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class BottomBarClipper extends CustomClipper<Path> {
  final int selectedIndex;
  final int itemCount;

  BottomBarClipper({required this.selectedIndex, required this.itemCount});

  @override
  Path getClip(Size size) {
    final Path path = Path();

    // البداية من أعلى اليسار
    path.moveTo(0, 0);

    // عرض كل أيكون في البار
    final double slotWidth = size.width / itemCount;

    // مركز الأيكون المختارة على محور X
    final double centerX = slotWidth * (selectedIndex + 0.5);

    // نخلي النوتش تحت الأيكون شبه دايرة (radius حوالين الأيكون)
    const double notchRadius = 28.0; // قريب من نصف قطر الدائرة الطايرة

    final double notchStartX = (centerX - notchRadius).clamp(0.0, size.width);
    final double notchEndX = (centerX + notchRadius).clamp(0.0, size.width);

    // خط مستقيم من الشمال لحد بداية النوتش
    path.lineTo(notchStartX, 0);

    // الكيرف الأول: ينزل لتحت ناحية مركز الأيكون (قوس دايرة)
    final double controlPoint1X = centerX - notchRadius * 0.9;
    final double controlPoint1Y = 0;
    final double dipX = centerX;
    final double dipY = notchRadius * 0.7; // عمق النوتش
    path.quadraticBezierTo(controlPoint1X, controlPoint1Y, dipX, dipY);

    // الكيرف الثاني: يطلع تاني لفوق بشكل متماثل (تكملة القوس)
    final double controlPoint2X = centerX + notchRadius * 0.6;
    final double controlPoint2Y = dipY;
    path.quadraticBezierTo(controlPoint2X, controlPoint2Y, notchEndX, 0);

    // تكملة خط مستقيم لحد الركن اليمين
    path.lineTo(size.width, 0);

    // الجنب اليمين نازل رأسي لأسفل
    path.lineTo(size.width, size.height);
    // خط سفلي راجع للشمال
    path.lineTo(0, size.height);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant BottomBarClipper oldClipper) {
    // نعيد القص لما يتغير التاب المختار أو عدد العناصر
    return oldClipper.selectedIndex != selectedIndex ||
        oldClipper.itemCount != itemCount;
  }
}
