part of 'smart_refresh_custom.dart';

class CustomFooterSmartRefrsh extends StatelessWidget {
  const CustomFooterSmartRefrsh({
    Key? key,
    this.moreelements = true,
  }) : super(key: key);
  final bool moreelements;
  @override
  Widget build(BuildContext context) {
    return CustomFooter(
      builder: (BuildContext context, LoadStatus? mode) {
        Widget body;
        if (mode == LoadStatus.idle || mode == LoadStatus.canLoading) {
          body = const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              // children: const [Icon(Icons.refresh), Text('Pull up load')]);
              children: [Icon(Icons.refresh), Text('Más')]);
        } else if (mode == LoadStatus.loading) {
          body = const CupertinoActivityIndicator();
        } else if (mode == LoadStatus.failed) {
          body = const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Icon(Icons.error), Text('Error en conexion')]);
        } else {
          body = moreelements
              ? const Text('No hay mas datos por ahora')
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
