part of 'smart_refresh_custom.dart';

class CustomFooterSmartRefrsh extends StatelessWidget {
  const CustomFooterSmartRefrsh({
    super.key,
    this.moreelements = true,
  });
  final bool moreelements;
  @override
  Widget build(BuildContext context) {
    return CustomFooter(
      builder: (BuildContext context, LoadStatus? mode) {
        Widget body;
        if (mode == LoadStatus.idle || mode == LoadStatus.canLoading) {
          body = Row(
              mainAxisAlignment: MainAxisAlignment.center,
              // children: const [Icon(Icons.refresh), Text('Pull up load')]);
              children: [
                const Icon(Icons.refresh),
                Text(apptexts.appOptions.scrollMore)
              ]);
        } else if (mode == LoadStatus.loading) {
          body = const CupertinoActivityIndicator();
        } else if (mode == LoadStatus.failed) {
          body = Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            const Icon(Icons.error),
            Text(apptexts.appOptions.scrollError)
          ]);
        } else {
          body = moreelements
              ? Text(apptexts.appOptions.scrollNoMoreData)
              : Container();
        }
        return Container(
          margin: const EdgeInsets.only(bottom: 10),
          height: 55.0,
          child: Center(child: body),
        );
      },
    );
  }
}
