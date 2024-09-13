import 'package:avalon_app/core/config/responsive/responsive_layouts.dart';
import 'package:flutter/material.dart';
import 'package:shared_models/shared_models.dart';

import 'widgets/detalleCaso/wid_agente.dart';
import 'widgets/detalleCaso/wid_asesor.dart';
import 'widgets/detalleCaso/wid_cliente.dart';
import 'widgets/detalleCaso/wid_cliente_poliza.dart';

class CasoDetalleBox extends StatelessWidget {
  const CasoDetalleBox({super.key, required this.clientePoliza});

  final ClientePoliza clientePoliza;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        padding:
            const EdgeInsets.symmetric(horizontal: AppLayoutConst.paddingL),
        children: [
          ...[
            ClientePolizaDetail(
              clientePoliza: clientePoliza,
            ),
            if (clientePoliza.cliente != null)
              ClienteDetailCard(
                cliente: clientePoliza.cliente!,
                parentesco: clientePoliza.parentesco,
              ),
            if (clientePoliza.agente != null)
              AgenteDetailCard(
                agente: clientePoliza.agente!,
              ),
            if (clientePoliza.asesor != null)
              AsesorDetailCard(
                asesor: clientePoliza.asesor!,
              ),
            if (clientePoliza.asesor != null)
              const SizedBox(height: AppLayoutConst.marginXL),
          ],
        ],
      ),
    );
  }
}
