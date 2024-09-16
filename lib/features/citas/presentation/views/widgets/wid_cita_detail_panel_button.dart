import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:avalon_app/core/config/theme/app_colors.dart';

import '../../bloc/cita_detalle/cita_detalle_panels_cubit.dart';

class CitaOptionButton extends StatelessWidget {
  const CitaOptionButton(
      {super.key, required this.option, required this.optionSelected});

  final CitaDetallePanelsState option;
  final CitaDetallePanelsState? optionSelected;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
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
      backgroundColor: option == optionSelected ? null : null,
      foregroundColor:
          option == optionSelected ? AppColors.primaryBlue : Colors.black45,
      child: iconByOption(),
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
