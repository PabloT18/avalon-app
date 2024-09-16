import 'package:avalon_app/features/avalon_info/formaspago/data/models/metodo_pago_model.dart';
import 'package:shared_models/shared_models.dart';

abstract class FormasPagoRepository {
  Future<List<MetodoPago>> getMetodosPago(User user);
}
