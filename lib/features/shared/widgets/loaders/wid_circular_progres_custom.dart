part of 'loaders_widgets.dart';

class CircularProgressIndicatorCustom extends StatelessWidget {
  const CircularProgressIndicatorCustom({
    super.key,
    this.paddinghorizontal = 0.0,
  });
  final double paddinghorizontal;

  @override
  Widget build(BuildContext context) {
    // final isDarkTheme = BlocProvider.of<AppSettingsCubit>(context).isDarkTheme;

    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: paddinghorizontal),
        child: CircularProgressIndicator.adaptive(
          backgroundColor: Platform.isIOS ? AppColors.primaryBlue : null,
          valueColor:
              const AlwaysStoppedAnimation<Color>(AppColors.primaryBlue),
          // backgroundColor: isDarkTheme ? Colors.white : AppColors.primaryBlue,
        ),
      ),
    );
  }
}
