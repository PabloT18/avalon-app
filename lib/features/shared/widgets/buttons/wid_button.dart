part of 'buttons_custom.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.onPressed,
    required this.title,
    this.shape,
    this.backgroundColor = Colors.white,
    this.onPrimary = Colors.black,
    this.fontSize = 14,
  });

  final VoidCallback onPressed;
  final String title;
  final Color backgroundColor;
  final Color onPrimary;
  final RoundedRectangleBorder? shape;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      key: key,
      style: ElevatedButton.styleFrom(
        foregroundColor: onPrimary,
        backgroundColor: backgroundColor,
        // minimumSize: const Size(120, 50),
        shadowColor: AppColors.secondaryBlue,
        shape: shape ??
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      ),
      onPressed: onPressed,
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: fontSize,
        ),
      ),
    );
  }
}
