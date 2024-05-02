import 'package:flutter/widgets.dart';

class BackgroundImageWidget extends StatelessWidget {
  const BackgroundImageWidget({
    super.key,
    required this.child,
    this.color,
    this.image,
  });

  final Widget child;
  final ImageProvider? image;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      decoration: BoxDecoration(
        image: image != null
            ? DecorationImage(
                image: image!,
                fit: BoxFit.cover,
              )
            : null,
      ),
      child: child,
    );
  }
}
