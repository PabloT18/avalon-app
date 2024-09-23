import 'package:avalon_app/app/presentation/bloc/app/app_bloc.dart';
import 'package:avalon_app/core/config/responsive/responsive_class.dart';
import 'package:avalon_app/core/config/responsive/responsive_layouts.dart';
import 'package:avalon_app/core/config/theme/app_colors.dart';
import 'package:avalon_app/features/shared/functions/fun_views.dart';
import 'package:avalon_app/features/shared/widgets/fields/editable_date_description.dart';
import 'package:avalon_app/i18n/generated/translations.g.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:shared_models/shared_models.dart';

import '../../../shared/widgets/fields/editable_text_description.dart';
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
              EditableTextDescription(
                  apptexts.perfilPage.firstName, editPerfilBloc.firstName),
              EditableTextDescription(
                  apptexts.perfilPage.secondName, editPerfilBloc.secondName,
                  beNull: true),
              EditableTextDescription(apptexts.perfilPage.firstLastName,
                  editPerfilBloc.firstLastName),
              EditableTextDescription(apptexts.perfilPage.secondLastName,
                  editPerfilBloc.secondLastName),
              EditableTextDescription(
                  apptexts.perfilPage.correo, editPerfilBloc.emailController),
              EditableTextDescription(apptexts.perfilPage.phone,
                  editPerfilBloc.phoneNumberController),
              if (user.isClient) ...[
                EditableTextDescription(apptexts.perfilPage.placeOfBirth,
                    editPerfilBloc.birthPlaceController),
                EditableTextDescription(apptexts.perfilPage.placeOfResidence,
                    editPerfilBloc.residenceController),
                EditableDateDescription(
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
}
