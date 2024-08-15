import 'package:avalon_app/features/membresias/domain/models/membresia_entities.dart';
import 'package:avalon_app/features/membresias/domain/repository/membresias_repository.dart';

class GetMembresiasUC {
  const GetMembresiasUC(
    this._membresiasRepository,
  );

  final MembresiasRepository _membresiasRepository;

  Future<List<MembresiaRegister>> call(String id, String token) =>
      _membresiasRepository.getRegistrosMembresias(id, token);
}
