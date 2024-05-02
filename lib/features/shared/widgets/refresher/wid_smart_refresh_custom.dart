part of 'smart_refresh_custom.dart';

class SmartRefrehsCustom extends StatelessWidget {
  const SmartRefrehsCustom({
    super.key,
    required this.child,
    required this.refreshController,
    required this.onRefresh,
    this.onLoading,
    this.enablePullUp = false,
  });

  final Widget child;
  final RefreshController refreshController;
  final Function()? onRefresh;
  final Function()? onLoading;

  final bool enablePullUp;

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      key: key,
      physics: const BouncingScrollPhysics(),
      enablePullDown: true,
      enablePullUp: enablePullUp,
      controller: refreshController,
      header: WaterDropMaterialHeader(
        backgroundColor: AppColors.primaryBlue.withOpacity(0.7),
      ),
      onRefresh: onRefresh,
      onLoading: onLoading,
      footer: const CustomFooterSmartRefrsh(),
      child: child,
    );
  }
}
