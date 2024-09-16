import 'package:flutter/material.dart';

class TitleDescripcion extends StatelessWidget {
  const TitleDescripcion({
    super.key,
    required this.title,
    required this.value,
    this.isSubdescription = false,
  });

  final String title;
  final String value;
  final bool isSubdescription;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: '$title: ',
        style: isSubdescription
            ? Theme.of(context)
                .textTheme
                .bodySmall!
                .copyWith(fontWeight: FontWeight.bold)
            : Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(fontWeight: FontWeight.bold),
        children: <TextSpan>[
          TextSpan(
            text: value,
            style: isSubdescription
                ? Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(fontWeight: FontWeight.normal)
                : Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(fontWeight: FontWeight.normal),
          ),
        ],
      ),
    );
  }
}
