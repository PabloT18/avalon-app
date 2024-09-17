import 'package:avalon_app/app/presentation/bloc/app/app_bloc.dart';
import 'package:avalon_app/core/config/responsive/responsive_class.dart';
import 'package:avalon_app/core/config/responsive/responsive_layouts.dart';
import 'package:avalon_app/core/config/theme/app_colors.dart';
import 'package:avalon_app/features/shared/functions/fun_views.dart';
import 'package:avalon_app/i18n/generated/translations.g.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:shared_models/shared_models.dart';

import '../bloc/editPerfil/edit_perfil_bloc.dart';

class EditPerfilPage extends StatelessWidget {
  const EditPerfilPage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = (context.read<AppBloc>().state as AppAuthenticated).user;

    return BlocProvider(
      create: (context) => EditPerfilBloc(user: user),
      child: Scaffold(
          appBar: AppBar(
            elevation: 4,
            title: Text(apptexts.perfilPage.editData),
          ),
          body: EditPerfilPageBody(user: user)),
    );
  }
}

class EditPerfilPageBody extends StatelessWidget {
  const EditPerfilPageBody({super.key, required this.user});
  final User user;
  @override
  Widget build(BuildContext context) {
    final editPerfilBloc = context.read<EditPerfilBloc>();
    final responsive = ResponsiveCustom.of(context);
    return BlocListener<EditPerfilBloc, EditPerfilState>(
      listener: (context, state) {
        if (state.updateSuccess != null) {
          if (state.updateSuccess! && !state.isUpdating) {
            // context.read<AppBloc>().add();
            // Navigator.of(context).pop();
            UtilsFunctionsViews.showFlushBar(
              message: apptexts.perfilPage.successUpdateUserAddress,
              positionOffset: responsive.hp(8),
              isError: false,
            ).show(context);
            context.read<AppBloc>().add(const AppUpdateUser());
          } else if (!state.isUpdating) {
            UtilsFunctionsViews.showFlushBar(
                    message: apptexts.perfilPage.errorUpdateUserAddress,
                    positionOffset: responsive.hp(8),
                    isError: true)
                .show(context);
          }
        }
      },
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: editPerfilBloc.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                apptexts.perfilPage.editData,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Divider(
                color: AppColors.secondaryBlue,
              ),
              _buildEditableProfileInfoRow(
                  apptexts.perfilPage.firstName, editPerfilBloc.firstName),
              _buildEditableProfileInfoRow(
                  apptexts.perfilPage.secondName, editPerfilBloc.secondName,
                  beNull: true),
              _buildEditableProfileInfoRow(apptexts.perfilPage.firstLastName,
                  editPerfilBloc.firstLastName),
              _buildEditableProfileInfoRow(apptexts.perfilPage.secondLastName,
                  editPerfilBloc.secondLastName),
              _buildEditableProfileInfoRow(
                  apptexts.perfilPage.correo, editPerfilBloc.emailController),
              _buildEditableProfileInfoRow(apptexts.perfilPage.phone,
                  editPerfilBloc.phoneNumberController),
              if (user.isClient) ...[
                _buildEditableProfileInfoRow(apptexts.perfilPage.placeOfBirth,
                    editPerfilBloc.birthPlaceController),
                _buildEditableProfileInfoRow(
                    apptexts.perfilPage.placeOfResidence,
                    editPerfilBloc.residenceController),
                EditableProfileDate(
                  label: apptexts.perfilPage.dob,
                  dateTextController: editPerfilBloc.birthDateController,
                ),
              ],
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    editPerfilBloc.add(const ValidateAndSubmitEvent());
                  },
                  child: Text(apptexts.appOptions.save),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEditableProfileInfoRow(
      String label, TextEditingController controller,
      {bool beNull = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label:',
            style: const TextStyle(
              fontSize: 14,
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
              if (beNull) {
                return null;
              }
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
        const SizedBox(height: AppLayoutConst.spaceM),
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: AppLayoutConst.spaceM),
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
