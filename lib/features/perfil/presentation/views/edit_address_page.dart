import 'package:avalon_app/core/config/responsive/responsive_class.dart';
import 'package:avalon_app/features/shared/functions/fun_views.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:avalon_app/features/perfil/perfil.dart';
import 'package:avalon_app/features/shared/widgets/buttons/buttons_custom.dart';
import 'package:avalon_app/i18n/generated/translations.g.dart';

import 'package:avalon_app/app/presentation/bloc/app/app_bloc.dart';

import 'package:avalon_app/core/config/theme/app_colors.dart';
import 'package:shared_models/shared_models.dart';

import '../../../../app/domain/usecases/general_uc/app_general_uses_cases.dart';
import '../bloc/edit_address/edit_address_bloc.dart';

class EditAddressPage extends StatelessWidget {
  const EditAddressPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EditAddressBloc(
        user: context.read<AppBloc>().state.user,
        getPaisesUseCase: RepositoryProvider.of<GetPaisesUseCase>(context),
        getEstadosUseCase: RepositoryProvider.of<GetEstadosUseCase>(context),
        updateUserAddressUseCase:
            RepositoryProvider.of<UpdateUserAddressUseCase>(context),
      )..add(LoadPaisesEvent()),
      child: Scaffold(
          appBar: AppBar(
            elevation: 4,
            title: Text(apptexts.perfilPage.editProfile),
          ),
          body: const EditAddressPageBody()),
    );
  }
}

class EditAddressPageBody extends StatelessWidget {
  const EditAddressPageBody({super.key});

  @override
  Widget build(BuildContext context) {
    final editAddressBloc = context.read<EditAddressBloc>();
    final responsive = ResponsiveCustom.of(context);
    return BlocListener<EditAddressBloc, EditAddressState>(
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
          key: editAddressBloc.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                apptexts.perfilPage.editAddress,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),

              Container(
                margin: const EdgeInsets.symmetric(
                  vertical: AppLayoutConst.marginM,
                ),
                height: 1,
                color: AppColors.secondaryBlue.withOpacity(0.5),
              ),
              _buildEditableProfileInfoRow(
                  apptexts.perfilPage.address, editAddressBloc.addressMain),
              _buildEditableProfileInfoRow(apptexts.perfilPage.addressSecondary,
                  editAddressBloc.addressSecondary),
              _buildDropdownCountryField(editAddressBloc),
              _buildDropdownStateField(editAddressBloc),
              // _buildEditableProfileInfoRow(
              //     apptexts.perfilPage.state, editAddressBloc.estado),
              _buildEditableProfileInfoRow(
                  apptexts.perfilPage.city, editAddressBloc.ciudad),
              _buildEditableProfileInfoRow(
                  apptexts.perfilPage.zipCode, editAddressBloc.zipCode),
              const SizedBox(height: 20),
              Center(
                child: BlocBuilder<EditAddressBloc, EditAddressState>(
                  builder: (context, state) {
                    return CustomButton(
                      title: apptexts.appOptions.save,
                      onPressed: !state.isUpdating
                          ? () {
                              // if (editAddressBloc.formKey.currentState!.validate()) {}
                              editAddressBloc
                                  .add(const ValidateAndSubmitEvent());
                            }
                          : null,
                    );
                  },
                ),
              ),
              const SizedBox(height: AppLayoutConst.spaceXL),
            ],
          ),
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
              if (value == null || value.isEmpty) {
                return apptexts.appOptions.validators.requiredField;
              }
              return null;
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDropdownCountryField(EditAddressBloc bloc) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            apptexts.perfilPage.country,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: AppLayoutConst.spaceM,
          ),
          BlocBuilder<EditAddressBloc, EditAddressState>(
            buildWhen: (previous, current) => previous.paises != current.paises,
            builder: (context, state) {
              return DropdownButtonFormField<int>(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  isDense: true,
                ),
                menuMaxHeight: 500,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                  color: Colors.black,
                ),
                value: state.selectedCountryId,
                items: bloc.state.paises
                    .map((Pais pais) => DropdownMenuItem<int>(
                          value: pais.id!,
                          child: Text(pais.nombre ?? '-'),
                        ))
                    .toList(),
                onChanged: (value) {
                  if (value != null) {
                    bloc.add(UpdateSelectedCountryEvent(value));
                  }
                },
                isExpanded: false,
                validator: (value) {
                  if (value == null || value == 0) {
                    return apptexts.appOptions.validators.requiredField;
                  }
                  return null;
                },
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDropdownStateField(EditAddressBloc bloc) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            apptexts.perfilPage.state,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: AppLayoutConst.spaceM,
          ),
          BlocBuilder<EditAddressBloc, EditAddressState>(
            buildWhen: (previous, current) =>
                previous.estados != current.estados,
            builder: (context, state) {
              return DropdownButtonFormField<int>(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  isDense: true,
                ),
                menuMaxHeight: 500,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                  color: Colors.black,
                ),
                value: state.selectedEstadoId, // ID del estado seleccionado
                items: state.estados
                    .map((Estado estado) => DropdownMenuItem<int>(
                          value: estado.id,
                          child: Text(estado.nombre ?? '-'),
                        ))
                    .toList(),
                onChanged: (value) {
                  if (value != null) {
                    bloc.add(UpdateSelectedEstadoEvent(
                        value)); // Crear y manejar este evento en el BLoC
                  }
                },
                isExpanded: false,
                validator: (value) {
                  if (value == null || value == 0) {
                    return apptexts.appOptions.validators.requiredField;
                  }
                  return null;
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
