import 'package:flutter/material.dart';
import 'dart:math' as math;

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // State variables
  double _height = 175;
  double _weight = 85;

  // Colors based on the design
  final Color _creamyBackground = const Color(0xFFFFF8F0);
  final Color _headerYellow = const Color(0xFFFFD93D);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _creamyBackground,
      body: Stack(
        children: [
          // Background decorations
          _buildBackgroundDecorations(),

          // Main Content
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildHeader(),
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Column(
                        children: [
                          const SizedBox(height: 20),
                          _buildInputCard(),
                          const SizedBox(height: 20),
                          _buildResultCard(),
                          const SizedBox(height: 20),
                          _buildCategoryList(),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBackgroundDecorations() {
    return Stack(
      children: [
        // Top gradient blob
        Positioned(
          top: -100,
          left: 0,
          right: 0,
          height: 350,
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFFF8A65), Color(0xFFFF5252)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.vertical(
                bottom: Radius.elliptical(300, 100),
              ),
            ),
          ),
        ),
        // Top right yellow circle decorative
        Positioned(
          top: -60,
          right: -40,
          child: Container(
            width: 220,
            height: 220,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _headerYellow.withValues(alpha: 0.4),
            ),
          ),
        ),
        Positioned(
          top: 40,
          right: 40,
          child: Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withValues(alpha: 0.1),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHeader() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Center(
        child: Text(
          "BMi Calculator",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildInputCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFE6F4D0), // Light greenish background
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            offset: const Offset(0, 5),
            blurRadius: 10,
          ),
        ],
      ),
      child: Column(
        children: [
          // Height Slider
          _buildSliderRow(
            label: "Height",
            value: _height,
            unit: "cm",
            min: 100,
            max: 220,
            onChanged: (val) {
              setState(() {
                _height = val;
              });
            },
          ),
          const SizedBox(height: 15),
          // Divider or Separator if needed, but visually it looks continuous

          // Weight Slider
          _buildSliderRow(
            label: "Weight",
            value: _weight,
            unit: "kg",
            min: 30,
            max: 150,
            onChanged: (val) {
              setState(() {
                _weight = val;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSliderRow({
    required String label,
    required double value,
    required String unit,
    required double min,
    required double max,
    required ValueChanged<double> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2E3E2E),
              ),
            ),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: value.toInt().toString(),
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2E3E2E),
                    ),
                  ),
                  TextSpan(
                    text: " $unit",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2E3E2E), // Slightly more opaque
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            trackHeight: 10,
            activeTrackColor: const Color(0xFF5CB85C), // Green active
            inactiveTrackColor: Colors.black.withValues(
              alpha: 0.05,
            ), // Light gray inactive
            thumbColor: Colors.white,
            thumbShape: const RoundSliderThumbShape(
              enabledThumbRadius: 12,
              elevation: 5,
            ),
            overlayColor: const Color(0xFF5CB85C).withValues(alpha: 0.2),
          ),
          child: Slider(value: value, min: min, max: max, onChanged: onChanged),
        ),
      ],
    );
  }

  double get _bmi => _weight / math.pow(_height / 100, 2);

  String _getBmiCategory(double bmi) {
    if (bmi < 18.5) return "Underweight";
    if (bmi < 25) return "Normal";
    if (bmi < 30) return "Overweight";
    return "Obese";
  }

  List<Color> _getCategoryGradientColors(String category) {
    switch (category) {
      case "Overweight":
        return [const Color(0xFFFF7E5F), const Color(0xFFFF5E62)];
      case "Obese":
        return [const Color(0xFFEF5350), const Color(0xFFD32F2F)];
      case "Underweight":
        return [const Color(0xFFEF5350), const Color(0xFFD32F2F)];
      case "Normal":
      default:
        return [const Color(0xFF6CC447), const Color(0xFF4CA335)];
    }
  }

  Widget _buildResultCard() {
    final bmi = _bmi;
    final category = _getBmiCategory(bmi);
    final gradientColors = _getCategoryGradientColors(category);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: gradientColors,
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: gradientColors.first.withValues(alpha: 0.4),
            offset: const Offset(0, 10),
            blurRadius: 20,
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            "BMI: ${bmi.toStringAsFixed(1)}",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                category,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(width: 10),
              _getEmojiForCategory(category, size: 28),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryList() {
    return Column(
      children: [
        _buildCategoryItem(
          "Underweight",
          Icons.restaurant_menu,
          isColored: true,
          colorStart: const Color(0xFFEF5350),
          colorEnd: const Color(0xFFD32F2F),
        ), // Trying to match crossed fork slightly
        const SizedBox(height: 10),
        _buildCategoryItem(
          "Normal",
          Icons.sentiment_satisfied_alt,
          isColored: true,
          colorStart: const Color(0xFFFF7E5F),
          colorEnd: const Color(0xFFFF5E62),
        ),
        const SizedBox(height: 10),
        _buildCategoryItem(
          "Overweight",
          Icons.sentiment_neutral,
          isColored: true,
          colorStart: const Color(0xFFFF7E5F),
          colorEnd: const Color(0xFFFF5E62),
        ),
        const SizedBox(height: 10),
        _buildCategoryItem(
          "Obese",
          Icons.sentiment_very_dissatisfied,
          isColored: true,
          colorStart: const Color(0xFFEF5350),
          colorEnd: const Color(0xFFD32F2F),
        ),
      ],
    );
  }

  Widget _buildCategoryItem(
    String label,
    IconData icon, {
    bool isColored = false,
    Color? colorStart,
    Color? colorEnd,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: isColored ? null : Colors.white,
        gradient: isColored
            ? LinearGradient(colors: [colorStart!, colorEnd!])
            : null,
        borderRadius: BorderRadius.circular(30), // Pill shape
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            offset: const Offset(0, 3),
            blurRadius: 5,
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: isColored
                  ? Colors.white.withValues(alpha: 0.2)
                  : Colors.green.shade100,
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: isColored ? Colors.white : const Color(0xFF5CB85C),
              size: 24,
            ),
          ),
          const SizedBox(width: 12),
          Text(
            label,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: isColored ? Colors.white : const Color(0xFF2E3E2E),
            ),
          ),
          if (label == "Normal" ||
              label == "Overweight" ||
              label == "Obese") ...[
            const SizedBox(width: 8),
            _getEmojiForCategory(label),
          ],
          const Spacer(),
          Icon(
            Icons.chevron_right,
            color: isColored ? Colors.white : Colors.grey,
          ),
        ],
      ),
    );
  }

  Widget _getEmojiForCategory(String category, {double size = 20}) {
    // Returning Text widget with emoji for exact look
    String emoji = "";
    switch (category) {
      case "Underweight":
        emoji = "";
        break; // No emoji in text in image, only icon
      case "Normal":
        emoji = "🙂";
        break;
      case "Overweight":
        emoji = "😏";
        break;
      case "Obese":
        emoji = "😅";
        break; // Close match
    }
    if (emoji.isNotEmpty) {
      return Text(emoji, style: TextStyle(fontSize: size));
    }
    return const SizedBox.shrink();
  }
}
