part of 'buttons_custom.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.onPressed,
    required this.title,
    this.shape,
    this.backgroundColor,
    this.onPrimary,
  });

  final VoidCallback onPressed;
  final String title;
  final Color? onPrimary;
  final Color? backgroundColor;
  final RoundedRectangleBorder? shape;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      key: key,
      style: ElevatedButton.styleFrom(
        foregroundColor: onPrimary,
        backgroundColor: backgroundColor,
        minimumSize: const Size(160, 40),
        shadowColor: AppColors.secondaryBlue,
        shape: shape ??
            RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(AppLayoutConst.buttonBorderRadius)),
      ),
      onPressed: onPressed,
      child: Text(
        title,
        textAlign: TextAlign.center,
      ),
    );
  }
}
