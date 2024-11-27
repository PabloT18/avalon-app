import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:avalon_app/core/config/theme/app_colors.dart';

import '../../bloc/cita_detalle/cita_detalle_panels_cubit.dart';

class CitaOptionButton extends StatelessWidget {
  const CitaOptionButton(
      {super.key,
      required this.option,
      required this.optionSelected,
      required this.title});

  final CitaDetallePanelsState option;
  final CitaDetallePanelsState? optionSelected;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        FloatingActionButton(
          key: Key(option.toString()),
          heroTag: null,

          onPressed: () {
            if (option == optionSelected) {
              return;
            } else {
              context.read<CitaDetallePanelsCubit>().togglePanel(option);
            }
          },
          elevation: option == optionSelected ? 8 : 1,
          // backgroundColor: option == optionSelected ? null : null,
          backgroundColor: AppColors.primaryBlue,

          foregroundColor:
              option == optionSelected ? AppColors.white : Colors.white30,
          child: iconByOption(),
        ),
        Text(
          title,
          style: TextStyle(
              fontSize: 12,
              fontWeight: option == optionSelected
                  ? FontWeight.bold
                  : FontWeight.normal),
        ),
      ],
    );
  }

  Widget iconByOption() {
    return switch (option) {
      CitaDetalleInfo() => const FaIcon(FontAwesomeIcons.notesMedical),
      CitaDetalleHistorial() => const FaIcon(FontAwesomeIcons.book),
      // CitaDetalleOption.reembolso => const FaIcon(FontAwesomeIcons.fileMedical),
    };
  }
}
