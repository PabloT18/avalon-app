import 'package:avalon_app/features/membresias/domain/models/membresia_register_entity.dart';

abstract class MembresiasRepository {
  Future<List<MembresiaRegister>> getRegistrosMembresias(
      String id, String token);
}
