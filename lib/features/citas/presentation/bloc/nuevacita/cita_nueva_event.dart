part of 'cita_nueva_bloc.dart';

sealed class CitaNuevaEvent extends Equatable {
  const CitaNuevaEvent();

  @override
  List<Object?> get props => [];
}

class GetCasosCita extends CitaNuevaEvent {
  const GetCasosCita();
}

class WaitForCreateCase extends CitaNuevaEvent {
  const WaitForCreateCase();
}

class SubmitCitaEvent extends CitaNuevaEvent {
  const SubmitCitaEvent({
    this.image,
  });

  final File? image;
}

class SelectCaso extends CitaNuevaEvent {
  const SelectCaso(this.caso);

  final CasoEntity caso;
}

class UpdateSelectedTipoCita extends CitaNuevaEvent {
  final String tipoCita;

  const UpdateSelectedTipoCita(this.tipoCita);

  @override
  List<Object?> get props => [tipoCita];
}

// Nuevos eventos para países y estados
class LoadPaisesEvent extends CitaNuevaEvent {
  const LoadPaisesEvent();
}

class UpdateSelectedCountryEvent extends CitaNuevaEvent {
  final int countryId;
  const UpdateSelectedCountryEvent(this.countryId);

  @override
  List<Object?> get props => [countryId];
}

class UpdateSelectedEstadoEvent extends CitaNuevaEvent {
  final int estadoId;
  const UpdateSelectedEstadoEvent(this.estadoId);

  @override
  List<Object?> get props => [estadoId];
}

class UpdateRequisitoAdicional extends CitaNuevaEvent {
  final String field;
  final bool value;

  const UpdateRequisitoAdicional({required this.field, required this.value});

  @override
  List<Object?> get props => [field, value];
}

class ImageSelected extends CitaNuevaEvent {
  const ImageSelected();
}

class RemoveImage extends CitaNuevaEvent {
  const RemoveImage();
}

class PdfSelected extends CitaNuevaEvent {
  const PdfSelected();
}

class RemovePdf extends CitaNuevaEvent {
  const RemovePdf();
}
