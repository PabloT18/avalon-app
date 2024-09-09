part of 'user_data_secction.dart';

class AddressCard extends StatelessWidget {
  const AddressCard({
    super.key,
    required this.user,
  });

  final User user;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          margin:
              const EdgeInsets.symmetric(horizontal: AppLayoutConst.marginL),
          child: Text(
            apptexts.perfilPage.address,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: AppLayoutConst.spaceM),
        Card(
            shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(AppLayoutConst.cardBorderRadius),
            ),
            // shadowColor: Colors.transparent,

            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(width: double.maxFinite),
                  if (!user.isAddressComplete)
                    Align(
                        alignment: Alignment.center,
                        child: TextButton(
                          onPressed: () {
                            context.goNamed(PAGES.editPerfil.pageName);
                          },
                          child: Text(
                            apptexts.perfilPage.completeInformation,
                            style: const TextStyle(
                              color: Colors.black54,
                            ),
                          ),
                        )),
                  if (user.isAddressComplete) ...[
                    Text(
                      user.direccion!.direccionCompleta,
                      style: const TextStyle(
                        color: Colors.black54,
                      ),
                    ),
                    Text(
                      user.direccion?.estadoNombreCompleto ?? '-',
                      style: const TextStyle(
                        color: Colors.black54,
                      ),
                    ),
                    Text(
                      user.direccion?.ciudad ?? '-',
                      style: const TextStyle(
                        color: Colors.black54,
                      ),
                    ),
                    Text(
                      user.direccion?.codigoPostal ?? '-',
                      style: const TextStyle(
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ],
              ),
            )),
      ],
    );
  }
}
