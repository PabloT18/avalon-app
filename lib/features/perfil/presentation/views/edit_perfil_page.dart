import 'package:avalon_app/app/presentation/bloc/app/app_bloc.dart';
import 'package:avalon_app/core/config/responsive/responsive_layouts.dart';
import 'package:avalon_app/core/config/theme/app_colors.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../bloc/bloc/edit_perfil_bloc.dart';

class EditPerfilPage extends StatelessWidget {
  const EditPerfilPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          EditPerfilBloc(user: context.read<AppBloc>().state.user),
      child: Scaffold(
          appBar: AppBar(
            elevation: 4,
            title: const Text('Editar Datos Personales'),
          ),
          body: const EditPerfilPageBody()),
    );
  }
}

class EditPerfilPageBody extends StatelessWidget {
  const EditPerfilPageBody({super.key});

  @override
  Widget build(BuildContext context) {
    final editPerfilBloc = context.read<EditPerfilBloc>();
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Form(
        key: editPerfilBloc.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'Editar Datos Personales',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Divider(
              color: AppColors.secondaryBlue,
            ),
            _buildEditableProfileInfoRow(
                'Nombres :', editPerfilBloc.nombreController),
            _buildEditableProfileInfoRow(
                'Apellidos:', editPerfilBloc.apellidoController),
            _buildEditableProfileInfoRow(
                'Correo Electrónico:', editPerfilBloc.emailController),
            _buildEditableProfileInfoRow(
                'Número de Teléfono:', editPerfilBloc.phoneNumberController),
            _buildEditableProfileInfoRow(
                'Lugar de Nacimiento:', editPerfilBloc.birthPlaceController),
            _buildEditableProfileInfoRow(
                'Lugar de Residencia:', editPerfilBloc.residenceController),
            EditableProfileDate(
              label: 'Fecha de Nacimiento:',
              dateTextController: editPerfilBloc.birthDateController,
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  if (editPerfilBloc.formKey.currentState!.validate()) {
                    // Aquí manejarías la lógica de guardado o actualización
                  }
                },
                child: const Text('Guardar Cambios'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEditableProfileInfoRow(
      String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: AppLayoutConst.spaceM,
          ),
          TextFormField(
            controller: controller,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              isDense: true,
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Este campo no puede estar vacío';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }
}

class EditableProfileDate extends StatelessWidget {
  const EditableProfileDate({
    super.key,
    required this.label,
    required this.dateTextController,
  });

  final TextEditingController dateTextController;
  final String label;

  @override
  Widget build(BuildContext context) {
    final FocusNode focusNode = FocusNode();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        TextFormField(
          controller: dateTextController,
          focusNode: focusNode,
          keyboardType: TextInputType.datetime,
          onTap: () {
            focusNode.unfocus();
            showCupertinoModalPopup(
              context: context,
              builder: (context) => Center(
                child: SizedBox(
                  height: 200,
                  child: Card(
                    color: Colors.white,
                    child: CupertinoDatePicker(
                      mode: CupertinoDatePickerMode.date,
                      dateOrder: DatePickerDateOrder.ydm,
                      initialDateTime: DateTime.now(),
                      // onDateTimeChanged: (DateTime newDateTime) {
                      //   dateTextController.text = newDateTime.toString();
                      // },
                      onDateTimeChanged: (DateTime newDateTime) {
                        String formattedDate =
                            DateFormat('dd/MM/yyyy').format(newDateTime);
                        dateTextController.text = formattedDate;
                      },
                      maximumDate: DateTime.now(),
                    ),
                  ),
                ),
              ),
            );
          },
          decoration: InputDecoration(
            labelText: label,
            //filled: true,
            icon: const Icon(Icons.calendar_today),
            labelStyle:
                const TextStyle(decorationStyle: TextDecorationStyle.solid),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Este campo no puede estar vacío';
            }
            return null;
          },
        ),
      ],
    );
  }
}
