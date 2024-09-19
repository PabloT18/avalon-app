/// Generated file. Do not edit.
///
/// Original: lib/i18n
/// To regenerate, run: `dart run slang`
///
/// Locales: 2
/// Strings: 482 (241 per locale)
///
/// Built on 2024-09-19 at 04:53 UTC

// coverage:ignore-file
// ignore_for_file: type=lint

import 'package:flutter/widgets.dart';
import 'package:slang/builder/model/node.dart';
import 'package:slang_flutter/slang_flutter.dart';
export 'package:slang_flutter/slang_flutter.dart';

const AppLocale _baseLocale = AppLocale.es;

/// Supported locales, see extension methods below.
///
/// Usage:
/// - LocaleSettings.setLocale(AppLocale.es) // set locale
/// - Locale locale = AppLocale.es.flutterLocale // get flutter locale from enum
/// - if (LocaleSettings.currentLocale == AppLocale.es) // locale check
enum AppLocale with BaseAppLocale<AppLocale, Translations> {
	es(languageCode: 'es', build: Translations.build),
	en(languageCode: 'en', build: _TranslationsEn.build);

	const AppLocale({required this.languageCode, this.scriptCode, this.countryCode, required this.build}); // ignore: unused_element

	@override final String languageCode;
	@override final String? scriptCode;
	@override final String? countryCode;
	@override final TranslationBuilder<AppLocale, Translations> build;

	/// Gets current instance managed by [LocaleSettings].
	Translations get translations => LocaleSettings.instance.translationMap[this]!;
}

/// Method A: Simple
///
/// No rebuild after locale change.
/// Translation happens during initialization of the widget (call of apptexts).
/// Configurable via 'translate_var'.
///
/// Usage:
/// String a = apptexts.someKey.anotherKey;
/// String b = apptexts['someKey.anotherKey']; // Only for edge cases!
Translations get apptexts => LocaleSettings.instance.currentTranslations;

/// Method B: Advanced
///
/// All widgets using this method will trigger a rebuild when locale changes.
/// Use this if you have e.g. a settings page where the user can select the locale during runtime.
///
/// Step 1:
/// wrap your App with
/// TranslationProvider(
/// 	child: MyApp()
/// );
///
/// Step 2:
/// final apptexts = Translations.of(context); // Get apptexts variable.
/// String a = apptexts.someKey.anotherKey; // Use apptexts variable.
/// String b = apptexts['someKey.anotherKey']; // Only for edge cases!
class TranslationProvider extends BaseTranslationProvider<AppLocale, Translations> {
	TranslationProvider({required super.child}) : super(settings: LocaleSettings.instance);

	static InheritedLocaleData<AppLocale, Translations> of(BuildContext context) => InheritedLocaleData.of<AppLocale, Translations>(context);
}

/// Method B shorthand via [BuildContext] extension method.
/// Configurable via 'translate_var'.
///
/// Usage (e.g. in a widget's build method):
/// context.apptexts.someKey.anotherKey
extension BuildContextTranslationsExtension on BuildContext {
	Translations get apptexts => TranslationProvider.of(this).translations;
}

/// Manages all translation instances and the current locale
class LocaleSettings extends BaseFlutterLocaleSettings<AppLocale, Translations> {
	LocaleSettings._() : super(utils: AppLocaleUtils.instance);

	static final instance = LocaleSettings._();

	// static aliases (checkout base methods for documentation)
	static AppLocale get currentLocale => instance.currentLocale;
	static Stream<AppLocale> getLocaleStream() => instance.getLocaleStream();
	static AppLocale setLocale(AppLocale locale, {bool? listenToDeviceLocale = false}) => instance.setLocale(locale, listenToDeviceLocale: listenToDeviceLocale);
	static AppLocale setLocaleRaw(String rawLocale, {bool? listenToDeviceLocale = false}) => instance.setLocaleRaw(rawLocale, listenToDeviceLocale: listenToDeviceLocale);
	static AppLocale useDeviceLocale() => instance.useDeviceLocale();
	@Deprecated('Use [AppLocaleUtils.supportedLocales]') static List<Locale> get supportedLocales => instance.supportedLocales;
	@Deprecated('Use [AppLocaleUtils.supportedLocalesRaw]') static List<String> get supportedLocalesRaw => instance.supportedLocalesRaw;
	static void setPluralResolver({String? language, AppLocale? locale, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver}) => instance.setPluralResolver(
		language: language,
		locale: locale,
		cardinalResolver: cardinalResolver,
		ordinalResolver: ordinalResolver,
	);
}

/// Provides utility functions without any side effects.
class AppLocaleUtils extends BaseAppLocaleUtils<AppLocale, Translations> {
	AppLocaleUtils._() : super(baseLocale: _baseLocale, locales: AppLocale.values);

	static final instance = AppLocaleUtils._();

	// static aliases (checkout base methods for documentation)
	static AppLocale parse(String rawLocale) => instance.parse(rawLocale);
	static AppLocale parseLocaleParts({required String languageCode, String? scriptCode, String? countryCode}) => instance.parseLocaleParts(languageCode: languageCode, scriptCode: scriptCode, countryCode: countryCode);
	static AppLocale findDeviceLocale() => instance.findDeviceLocale();
	static List<Locale> get supportedLocales => instance.supportedLocales;
	static List<String> get supportedLocalesRaw => instance.supportedLocalesRaw;
}

// translations

// Path: <root>
class Translations implements BaseTranslations<AppLocale, Translations> {
	/// Returns the current translations of the given [context].
	///
	/// Usage:
	/// final apptexts = Translations.of(context);
	static Translations of(BuildContext context) => InheritedLocaleData.of<AppLocale, Translations>(context).translations;

	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	Translations.build({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = TranslationMetadata(
		    locale: AppLocale.es,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <es>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	dynamic operator[](String key) => $meta.getTranslation(key);

	late final Translations _root = this; // ignore: unused_field

	// Translations
	late final _TranslationsAppOptionsEs appOptions = _TranslationsAppOptionsEs._(_root);
	late final _TranslationsAvalonInfoEs avalonInfo = _TranslationsAvalonInfoEs._(_root);
	late final _TranslationsCasosPageEs casosPage = _TranslationsCasosPageEs._(_root);
	late final _TranslationsCentrosMedicosEs centrosMedicos = _TranslationsCentrosMedicosEs._(_root);
	late final _TranslationsCitasPageEs citasPage = _TranslationsCitasPageEs._(_root);
	late final _TranslationsComunicadospageEs comunicadospage = _TranslationsComunicadospageEs._(_root);
	late final _TranslationsEmergenciasPageEs emergenciasPage = _TranslationsEmergenciasPageEs._(_root);
	late final _TranslationsFamiliaresPageEs familiaresPage = _TranslationsFamiliaresPageEs._(_root);
	late final _TranslationsFaqsPAgeEs faqsPAge = _TranslationsFaqsPAgeEs._(_root);
	late final _TranslationsMedicosPageEs medicosPage = _TranslationsMedicosPageEs._(_root);
	late final _TranslationsMembresiasPageEs membresiasPage = _TranslationsMembresiasPageEs._(_root);
	late final _TranslationsMetodosPagoPageEs metodosPagoPage = _TranslationsMetodosPagoPageEs._(_root);
	late final _TranslationsPerfilPageEs perfilPage = _TranslationsPerfilPageEs._(_root);
	late final _TranslationsPreferenciasPageEs preferenciasPage = _TranslationsPreferenciasPageEs._(_root);
	late final _TranslationsReclamacionesPageEs reclamacionesPage = _TranslationsReclamacionesPageEs._(_root);
	late final _TranslationsSegurosPageEs segurosPage = _TranslationsSegurosPageEs._(_root);
}

// Path: appOptions
class _TranslationsAppOptionsEs {
	_TranslationsAppOptionsEs._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get asesor => 'Asesor';
	String get agente => 'Agente';
	String get cliente => 'Usuario';
	String get administrador => 'Admin';
	String get rol => 'Rol';
	String detalle({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
		one: 'Detalle',
		other: 'Detalles',
	);
	String coment({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
		one: 'Comentario',
		other: 'Comentarios',
	);
	String get codigo => 'Código';
	String get fecha => 'Fecha';
	String get noData => 'No hay información cargada';
	String get scrollMore => 'Más';
	String get scrollNoMoreData => 'No hay más datos';
	String get scrollError => 'Error al cargar datos';
	String get filtro => 'Filtro';
	String filtro_de({required Object option}) => 'Filtro de ${option}';
	String get error_servers => 'Servidores en mantenimiento. Por favor intente mas tarde.';
	String get error_access_internet => 'Problemas en su conexion de red. Por favor intente mas tarde.';
	String get siguiente => 'Siguiente';
	String get continuar => 'Continuar';
	String get logout => 'Cerrar Sesión';
	String get login => 'Iniciar Sesión';
	String get opt_yes => 'Si';
	String get observaciones => 'Observaciones';
	String get cancelar => 'Cancelar';
	String get envio_exitoso => 'Se ha enviado exitosamente.';
	String get follow => 'Seguir';
	String get edit => 'Editar';
	String get save => 'Guardar';
	String get cancel => 'Cancelar';
	String get changePassword => 'Cambiar Contraseña';
	String get newPassword => 'Nueva Contraseña';
	String get confirmPassword => 'Confirmar Contraseña';
	String get passwordNotMatch => 'Las contraseñas no coinciden';
	String get passwordChanged => 'Contraseña cambiada con éxito';
	String get passwordChangedError => 'Error al cambiar la contraseña';
	String get currentPassword => 'Contraseña Actual';
	String get verificationCode => 'Código de Verificación';
	String get ingresarCode => 'Ingresar Código';
	String get verificar => 'Verificar';
	String get passwordDebil => 'La contraseña debe tener al menos 8 caracteres, una mayúscula, una minúscula y un número';
	String get historialEmpty => 'No hay un historial de comentarios aún';
	String get historialError => 'Erroral cargar el historial de comentarios';
	String get comentMessage => 'Escribe un comentario';
	String get comentError => 'Error al enviar el comentario';
	String get comentSuccess => 'Comentario enviado con éxito';
	String get comentEmpty => 'El comentario no puede estar vacío';
	late final _TranslationsAppOptionsValidatorsEs validators = _TranslationsAppOptionsValidatorsEs._(_root);
}

// Path: avalonInfo
class _TranslationsAvalonInfoEs {
	_TranslationsAvalonInfoEs._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get contactUs => 'Contáctenos';
	String get aboutUs => 'Sobre Nosotros';
	String get aboutDescription => 'AVALON PLUS es una empresa líder en el conserjería médica integral internacional, fundada en Texas, formada por profesionales con más de 25 años de experiencia en las áreas de administración de cuentas hospitalarias, servicios médicos y seguros internacionales.\nEl Know-How de nuestro equipo de profesionales nos permite comprender las necesidades de nuestros clientes.';
	String get services => 'Servicios.';
	String get servicesDescription => 'Contamos con un equipo de profesionales, multilingüe y multicultural, con una basta experiencia en la administración y solución integral de casos médicos complejos alrededor del mundo.';
	late final _TranslationsAvalonInfoDetailsEs details = _TranslationsAvalonInfoDetailsEs._(_root);
}

// Path: casosPage
class _TranslationsCasosPageEs {
	_TranslationsCasosPageEs._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String title({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
		one: 'Caso',
		other: 'Casos',
	);
	String casoDetalle({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
		one: 'Detalle de caso',
		other: 'Detalles de caso',
	);
}

// Path: centrosMedicos
class _TranslationsCentrosMedicosEs {
	_TranslationsCentrosMedicosEs._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String title({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
		one: 'Centro Médico',
		other: 'Centro Médicos',
	);
	String get noData => 'No se encontraron centros médicos';
}

// Path: citasPage
class _TranslationsCitasPageEs {
	_TranslationsCitasPageEs._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String title({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
		one: 'Cita Médica',
		other: 'Citas Médicas',
	);
	String citaDetalle({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
		one: 'Detalle Cita Médica',
		other: 'Detalles Citas Médicas',
	);
	String historial({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
		one: 'Historial de Citas',
		other: 'Historial de Citas',
	);
	String moreDetails({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
		one: 'Más Detalle',
		other: 'Más Detalles',
	);
	String get detailFechaTentativa => 'Fecha Tentativa';
	String get detailPreferenceCity => 'Ciudad de preferencia';
	String get detailAseguradoraName => 'Aseguradora';
	String get detailHospital => 'Hospital';
	String get detailPreferenceDoctor => 'Doctor de preferencia';
	String get detailPadecimeiento => 'Padecimeiento';
	String get detailAditionalInformation => 'Información adicional';
	String get detailAditionalRequaimentes => 'Requerimientos adicionales';
	late final _TranslationsCitasPageAditionalRequaimentesEs aditionalRequaimentes = _TranslationsCitasPageAditionalRequaimentesEs._(_root);
	String get detailOthersRequaimentes => 'Otros requerimientos';
	String get detalleFoto => 'Foto';
	String get estados => 'Estados de las citas';
	String get estadoCerrado => 'Cerrado';
	String get estadoGestionando => 'Gestionando';
	String get estadoPorGestionar => 'Por Gestionar';
	String get nuevaCita => 'Nueva Cita';
	String get citaSinCaso => 'Cita sin caso';
	String get creaCasoCita => 'Crea un caso para la cita médica';
	String get citaEnCaso => 'Escoje el caso para la cita médica';
	String get citaEstado => 'Estado de la cita';
	String get historialEmpty => 'No hay un historial de comentarios aún';
	String get historialError => 'Erroral cargar el historial de comentarios';
}

// Path: comunicadospage
class _TranslationsComunicadospageEs {
	_TranslationsComunicadospageEs._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String title({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
		one: 'Noticia',
		other: 'Noticias',
	);
}

// Path: emergenciasPage
class _TranslationsEmergenciasPageEs {
	_TranslationsEmergenciasPageEs._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String title({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
		one: 'Emergencia',
		other: 'Emergencias',
	);
	String emergenciaDetalle({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
		one: 'Detalle de Emergencia',
		other: 'Detalles de Emergencia',
	);
	String historial({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
		one: 'Historial de Emergencia',
		other: 'Historial de Emergencias',
	);
	String moreDetails({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
		one: 'Más Detalle',
		other: 'Más Detalles',
	);
	String get diagnostico => 'Diagnóstico';
	String get sintomas => 'Síntomas';
}

// Path: familiaresPage
class _TranslationsFamiliaresPageEs {
	_TranslationsFamiliaresPageEs._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String title({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
		one: 'Familiar',
		other: 'Familiares',
	);
}

// Path: faqsPAge
class _TranslationsFaqsPAgeEs {
	_TranslationsFaqsPAgeEs._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String title({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
		one: 'Pregunta Frecuente',
		other: 'Preguntas Frecuentes',
	);
}

// Path: medicosPage
class _TranslationsMedicosPageEs {
	_TranslationsMedicosPageEs._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String title({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
		one: 'Médico',
		other: 'Médicos',
	);
	String get noData => 'No se encontraron médicos';
}

// Path: membresiasPage
class _TranslationsMembresiasPageEs {
	_TranslationsMembresiasPageEs._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String membresia({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
		one: 'Membresía',
		other: 'Membresías',
	);
	String get description => 'Accede a nuestro plan de Membresía de Asistencia Médica en el extranjero, diseñado para brindarte la mejor atención médica disponible dentro de un marco rentable.';
	String get description2 => 'Lista de historial de membresías actuales y vencidas';
}

// Path: metodosPagoPage
class _TranslationsMetodosPagoPageEs {
	_TranslationsMetodosPagoPageEs._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String title({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
		one: 'Método de Pago',
		other: 'Métodos de Pago',
	);
	String get noData => 'No se encontraron métodos de pago';
}

// Path: perfilPage
class _TranslationsPerfilPageEs {
	_TranslationsPerfilPageEs._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get userData => 'Datos del Usuario';
	String get userPersonalData => 'Datos Personales';
	String get username => 'Nombre de Usuario';
	String get correo => 'Correo Electrónico';
	String get fullName => 'Nombre Completo';
	String get phone => 'Teléfono';
	String get editProfile => 'Editar Perfil';
	String get editData => 'Editar Datos Personales';
	String get editAddress => 'Editar Dirección';
	String get dob => 'Fecha de Nacimiento';
	String get placeOfBirth => 'Lugar de Nacimiento';
	String get placeOfResidence => 'Lugar de Residencia';
	String get completeInformation => 'Por favor, completa tu información personal';
	String get address => 'Dirección';
	String get addressMain => 'Nombre de la calle';
	String get addressSecondary => 'Departamento, piso, unidad, edificion (opcional)';
	String get city => 'Ciudad';
	String get state => 'Estado';
	String get zipCode => 'Código Postal';
	String get country => 'País';
	String get errorUpdateUserData => 'Error al actualizar los datos del usuario';
	String get errorUpdateUserAddress => 'Error al actualizar la dirección del usuario';
	String get successUpdateUserData => 'Datos del usuario actualizados correctamente';
	String get successUpdateUserAddress => 'Dirección del usuario actualizada correctamente';
	String get identificacion => 'Identificación';
	String get tipoIdentificacion => 'Tipo de Identificación';
	String get memberFamily => 'Familiar';
	String get firstName => 'Nombre';
	String get secondName => 'Segundo Nombre';
	String get firstLastName => 'Apellido';
	String get secondLastName => 'Segundo Apellido';
}

// Path: preferenciasPage
class _TranslationsPreferenciasPageEs {
	_TranslationsPreferenciasPageEs._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get preferenciasTitle => 'Preferencias';
	String get preferenciasUser => 'Preferencias de usuario';
	String get notificaciones => 'Preferencias de Notificaciones';
	String get notificacionesPermiso => 'Recivir notificaciones AvalonPlus';
	String get idioma => 'Idioma';
	String get title => 'Ajustes';
	String get spanish => 'Español';
	String get ingles => 'Ingles';
	String get lanES => 'Idioma Español';
	String get lanEN => 'Idioma Ingles';
	late final _TranslationsPreferenciasPagePermisosEs permisos = _TranslationsPreferenciasPagePermisosEs._(_root);
}

// Path: reclamacionesPage
class _TranslationsReclamacionesPageEs {
	_TranslationsReclamacionesPageEs._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String title({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
		one: 'Recalmación',
		other: 'Recalmaciones',
	);
	String reclamacionDetalle({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
		one: 'Detalle Reclamación',
		other: 'Detalles Reclamaciones',
	);
	String historial({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
		one: 'Historial de Reclamaciones',
		other: 'Historial de Reclamaciones',
	);
	String moreDetails({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
		one: 'Más Detalle',
		other: 'Más Detalles',
	);
	String get detailFechaTentativa => 'Fecha Tentativa';
	String get detailPreferenceCity => 'Ciudad de preferencia';
	String get detailAseguradoraName => 'Aseguradora';
	String get detailHospital => 'Hospital';
	String get detailPreferenceDoctor => 'Doctor de preferencia';
	String get detailPadecimeiento => 'Padecimeiento';
	String get detailPadecimeientoDiagnostico => 'Padecimeiento/Diagnóstico';
	String get detailAditionalInformation => 'Información adicional';
	String get detailAditionalRequaimentes => 'Requerimientos adicionales';
	String get detailOthersRequaimentes => 'Otros requerimientos';
	String get detalleFoto => 'Foto';
	String get estados => 'Estados de las reclamaciones';
	String get estadoCerrado => 'Cerrado';
	String get estadoGestionando => 'Gestionando';
	String get estadoPorGestionar => 'Por Gestionar';
	String get nuevaReclamacion => 'Nueva Reclamación';
	String get reclamacionSinCaso => 'Reclamación sin caso';
	String get creaCasoReclamacion => 'Crea un caso para la reclamación';
	String get reclamacionEnCaso => 'Escoje el caso para la reclamación';
	String get reclamacionEstado => 'Estado de la reclamación';
	String get historialEmpty => 'No hay un historial de comentarios aún';
	String get historialError => 'Error al cargar el historial de comentarios';
	String get tipoAdministacion => 'Tipo de Administración';
}

// Path: segurosPage
class _TranslationsSegurosPageEs {
	_TranslationsSegurosPageEs._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String title({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
		one: 'Seguro',
		other: 'Seguros',
	);
	String polizaSeguros({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
		one: 'Poliza de seguro',
		other: 'Polizas de seguro',
	);
	String cliente({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
		one: 'Cliente',
		other: 'Clientes',
	);
	String clienteDetalle({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
		one: 'Detalle de cliente',
		other: 'Detalle de clientes',
	);
	String agente({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
		one: 'Agente AVALON',
		other: 'Agentes AVALON',
	);
	String agenteDetalle({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
		one: 'Detalle de agente AVALON',
		other: 'Detalle de agentes AVALON',
	);
	String asesor({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
		one: 'Agente del Broker',
		other: 'Agentes del Broker',
	);
	String asesosDetalle({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
		one: 'Detalle de agente del Broker',
		other: 'Detalle de agentes del Broker',
	);
	String detalleSeguro({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
		one: 'Detalle de poliza',
		other: 'Detalles de poliza',
	);
	String get empresa => 'Empresa';
	String get numeroCertificado => 'Número de certificado';
	String get aseguradora => 'Aseguradora';
	String get initDate => 'Fecha de inicio';
	String get endDate => 'Fecha de fin';
	String get tipoSeguro => 'Tipo de poliza';
}

// Path: appOptions.validators
class _TranslationsAppOptionsValidatorsEs {
	_TranslationsAppOptionsValidatorsEs._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get required => 'Este campo es requerido';
	String get email => 'Correo electrónico inválido';
	String minLength({required Object min}) => 'Debe tener al menos ${min} caracteres';
	String maxLength({required Object max}) => 'Debe tener máximo ${max} caracteres';
	String get passwordMatch => 'Las contraseñas no coinciden';
	String passwordLength({required Object min}) => 'Debe tener al menos ${min} caracteres';
	String get passwordUppercase => 'Debe tener al menos una mayúscula';
	String get passwordLowercase => 'Debe tener al menos una minúscula';
	String get passwordNumber => 'Debe tener al menos un número';
	String get passwordSpecial => 'Debe tener al menos un caracter especial';
	String get passwordOld => 'La contraseña antigua es requerida';
	String get passwordNew => 'La nueva contraseña es requerida';
	String get passwordConfirm => 'La confirmación de la contraseña es requerida';
	String get passwordChanged => 'Contraseña cambiada con éxito';
	String get passwordNotMatch => 'Las contraseñas no coinciden';
}

// Path: avalonInfo.details
class _TranslationsAvalonInfoDetailsEs {
	_TranslationsAvalonInfoDetailsEs._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get experience => 'Años de experiencia Comprobada';
	String get experts => 'Expertos en facturación y contención costos';
	String get offices => 'Oficinas y operaciones en Houston';
	String get lead => 'TPA Líder en consejería médica integral internacional';
}

// Path: citasPage.aditionalRequaimentes
class _TranslationsCitasPageAditionalRequaimentesEs {
	_TranslationsCitasPageAditionalRequaimentesEs._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get ambulanciaTerrestre => 'Ambulancia Terrestre';
	String get recetaMedica => 'Receta Médica';
	String get ambulanciaAerea => 'Ambulancia Aérea';
	String get sillaRuedas => 'Silla de Ruedas';
	String get servicioTransporte => 'Servicio de Transporte';
	String get viajes => 'Viajes';
	String get hospedaje => 'Hospedaje';
}

// Path: preferenciasPage.permisos
class _TranslationsPreferenciasPagePermisosEs {
	_TranslationsPreferenciasPagePermisosEs._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Permisos del dispositivo';
	String get notificaciones => 'Notificaciones';
	String get camara => 'Cámara';
	String get almacenamiento => 'Almacenamiento';
}

// Path: <root>
class _TranslationsEn implements Translations {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	_TranslationsEn.build({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = TranslationMetadata(
		    locale: AppLocale.en,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <en>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	@override dynamic operator[](String key) => $meta.getTranslation(key);

	@override late final _TranslationsEn _root = this; // ignore: unused_field

	// Translations
	@override late final _TranslationsAppOptionsEn appOptions = _TranslationsAppOptionsEn._(_root);
	@override late final _TranslationsAvalonInfoEn avalonInfo = _TranslationsAvalonInfoEn._(_root);
	@override late final _TranslationsCasosPageEn casosPage = _TranslationsCasosPageEn._(_root);
	@override late final _TranslationsCentrosMedicosEn centrosMedicos = _TranslationsCentrosMedicosEn._(_root);
	@override late final _TranslationsCitasPageEn citasPage = _TranslationsCitasPageEn._(_root);
	@override late final _TranslationsComunicadospageEn comunicadospage = _TranslationsComunicadospageEn._(_root);
	@override late final _TranslationsEmergenciasPageEn emergenciasPage = _TranslationsEmergenciasPageEn._(_root);
	@override late final _TranslationsFamiliaresPageEn familiaresPage = _TranslationsFamiliaresPageEn._(_root);
	@override late final _TranslationsFaqsPAgeEn faqsPAge = _TranslationsFaqsPAgeEn._(_root);
	@override late final _TranslationsMedicosPageEn medicosPage = _TranslationsMedicosPageEn._(_root);
	@override late final _TranslationsMembresiasPageEn membresiasPage = _TranslationsMembresiasPageEn._(_root);
	@override late final _TranslationsMetodosPagoPageEn metodosPagoPage = _TranslationsMetodosPagoPageEn._(_root);
	@override late final _TranslationsPerfilPageEn perfilPage = _TranslationsPerfilPageEn._(_root);
	@override late final _TranslationsPreferenciasPageEn preferenciasPage = _TranslationsPreferenciasPageEn._(_root);
	@override late final _TranslationsReclamacionesPageEn reclamacionesPage = _TranslationsReclamacionesPageEn._(_root);
	@override late final _TranslationsSegurosPageEn segurosPage = _TranslationsSegurosPageEn._(_root);
}

// Path: appOptions
class _TranslationsAppOptionsEn implements _TranslationsAppOptionsEs {
	_TranslationsAppOptionsEn._(this._root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get asesor => 'Advisor';
	@override String get agente => 'Agent';
	@override String get cliente => 'Client';
	@override String get administrador => 'Admin';
	@override String get rol => 'Role';
	@override String detalle({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: 'Detail',
		other: 'Details',
	);
	@override String coment({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: 'Comment',
		other: 'Comments',
	);
	@override String get codigo => 'Code';
	@override String get fecha => 'Date';
	@override String get noData => 'No data loaded';
	@override String get scrollMore => 'Scroll for more';
	@override String get scrollNoMoreData => 'No more data';
	@override String get scrollError => 'Error loading data';
	@override String get filtro => 'Filter';
	@override String filtro_de({required Object option}) => '${option} Filter';
	@override String get error_servers => 'Servers under maintenance. Please try later';
	@override String get error_access_internet => 'Problems with your network connection. Please try again later.';
	@override String get siguiente => 'Next';
	@override String get continuar => 'Continue';
	@override String get logout => 'Logout';
	@override String get login => 'Login';
	@override String get opt_yes => 'Continue';
	@override String get observaciones => 'Comments';
	@override String get cancelar => 'Cancel';
	@override String get envio_exitoso => 'Sent successfully.';
	@override String get follow => 'Follow';
	@override String get edit => 'Edit';
	@override String get save => 'Save';
	@override String get cancel => 'Cancel';
	@override String get changePassword => 'Change Password';
	@override String get newPassword => 'New Password';
	@override String get confirmPassword => 'Confirm Password';
	@override String get passwordNotMatch => 'Passwords do not match';
	@override String get passwordChanged => 'Password changed successfully';
	@override String get passwordChangedError => 'Error changing password';
	@override String get currentPassword => 'Current Password';
	@override String get verificationCode => 'Verification Code';
	@override String get ingresarCode => 'Enter Code';
	@override String get verificar => 'Verify';
	@override String get passwordDebil => 'The password must have at least 8 characters, one uppercase letter, one lowercase letter, and one number';
	@override String get historialEmpty => 'No comment history yet';
	@override String get historialError => 'Error loading comment history';
	@override String get comentMessage => 'Write a comment';
	@override String get comentError => 'Error sending comment';
	@override String get comentSuccess => 'Comment sent successfully';
	@override String get comentEmpty => 'Comment cannot be empty';
	@override late final _TranslationsAppOptionsValidatorsEn validators = _TranslationsAppOptionsValidatorsEn._(_root);
}

// Path: avalonInfo
class _TranslationsAvalonInfoEn implements _TranslationsAvalonInfoEs {
	_TranslationsAvalonInfoEn._(this._root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get contactUs => 'Contact Us';
	@override String get aboutUs => 'About Us';
	@override String get aboutDescription => 'AVALON PLUS is a leading international comprehensive medical concierge company, founded in Texas, made up of professionals with more than 25 years of experience in the areas of hospital account management, medical services and international insurance.\nThe Know-How of our team of professionals allows us to understand the needs of our clients.';
	@override String get services => 'Services.';
	@override String get servicesDescription => 'We have a multilingual and multicultural team of professionals, with extensive experience in the administration and comprehensive solution of complex medical cases around the world.';
	@override late final _TranslationsAvalonInfoDetailsEn details = _TranslationsAvalonInfoDetailsEn._(_root);
}

// Path: casosPage
class _TranslationsCasosPageEn implements _TranslationsCasosPageEs {
	_TranslationsCasosPageEn._(this._root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String title({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: 'Case',
		other: 'Cases',
	);
	@override String casoDetalle({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: 'Case detail',
		other: 'Case details',
	);
}

// Path: centrosMedicos
class _TranslationsCentrosMedicosEn implements _TranslationsCentrosMedicosEs {
	_TranslationsCentrosMedicosEn._(this._root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String title({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: 'Medical Center',
		other: 'Medical Centers',
	);
	@override String get noData => 'No medical centers found';
}

// Path: citasPage
class _TranslationsCitasPageEn implements _TranslationsCitasPageEs {
	_TranslationsCitasPageEn._(this._root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String title({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: 'Appointment',
		other: 'Appointments',
	);
	@override String citaDetalle({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: 'Appointment Detail',
		other: 'Appointment Details',
	);
	@override String historial({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: 'Appointment History',
		other: 'Appointment History',
	);
	@override String moreDetails({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: 'More Detail',
		other: 'More Details',
	);
	@override String get detailFechaTentativa => 'Tentative Date';
	@override String get detailPreferenceCity => 'Preferred City';
	@override String get detailAseguradoraName => 'Insurance Company';
	@override String get detailHospital => 'Hospital';
	@override String get detailPreferenceDoctor => 'Preferred Doctor';
	@override String get detailPadecimeiento => 'Condition';
	@override String get detailAditionalInformation => 'Additional Information';
	@override String get detailAditionalRequaimentes => 'Additional Requirements';
	@override late final _TranslationsCitasPageAditionalRequaimentesEn aditionalRequaimentes = _TranslationsCitasPageAditionalRequaimentesEn._(_root);
	@override String get detailOthersRequaimentes => 'Other Requirements';
	@override String get detalleFoto => 'Photo';
	@override String get estados => 'Appointment States';
	@override String get estadoCerrado => 'Closed';
	@override String get estadoGestionando => 'Managing';
	@override String get estadoPorGestionar => 'Pending';
	@override String get nuevaCita => 'New Appointment';
	@override String get citaSinCaso => 'Appointment without Case';
	@override String get creaCasoCita => 'Create a case for the appointment';
	@override String get citaEnCaso => 'Choose the case for the appointment';
	@override String get citaEstado => 'Appointment State';
	@override String get historialEmpty => 'No comment history yet';
	@override String get historialError => 'Error loading comment history';
}

// Path: comunicadospage
class _TranslationsComunicadospageEn implements _TranslationsComunicadospageEs {
	_TranslationsComunicadospageEn._(this._root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String title({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: 'New',
		other: 'News',
	);
}

// Path: emergenciasPage
class _TranslationsEmergenciasPageEn implements _TranslationsEmergenciasPageEs {
	_TranslationsEmergenciasPageEn._(this._root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String title({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: 'Emergency',
		other: 'Emergencies',
	);
	@override String emergenciaDetalle({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: 'Emergency Detail',
		other: 'Emergency Details',
	);
	@override String historial({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: 'Emergency History',
		other: 'Emergency History',
	);
	@override String moreDetails({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: 'More Detail',
		other: 'More Details',
	);
	@override String get diagnostico => 'Diagnosis';
	@override String get sintomas => 'Symptoms';
}

// Path: familiaresPage
class _TranslationsFamiliaresPageEn implements _TranslationsFamiliaresPageEs {
	_TranslationsFamiliaresPageEn._(this._root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String title({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: 'Family',
		other: 'Family',
	);
}

// Path: faqsPAge
class _TranslationsFaqsPAgeEn implements _TranslationsFaqsPAgeEs {
	_TranslationsFaqsPAgeEn._(this._root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String title({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: 'FAQ',
		other: 'FAQs',
	);
}

// Path: medicosPage
class _TranslationsMedicosPageEn implements _TranslationsMedicosPageEs {
	_TranslationsMedicosPageEn._(this._root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String title({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: 'Doctor',
		other: 'Doctors',
	);
	@override String get noData => 'No doctors found';
}

// Path: membresiasPage
class _TranslationsMembresiasPageEn implements _TranslationsMembresiasPageEs {
	_TranslationsMembresiasPageEn._(this._root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String membresia({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: 'Membership',
		other: 'Memberships',
	);
	@override String get description => 'Access our Overseas Medical Assistance Membership plan, which is designed to provide you with the best medical care available within a cost-effective framework.';
	@override String get description2 => 'List of current and expired membership history';
}

// Path: metodosPagoPage
class _TranslationsMetodosPagoPageEn implements _TranslationsMetodosPagoPageEs {
	_TranslationsMetodosPagoPageEn._(this._root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String title({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: 'Payment Method',
		other: 'Payment Methods',
	);
	@override String get noData => 'No payment methods found';
}

// Path: perfilPage
class _TranslationsPerfilPageEn implements _TranslationsPerfilPageEs {
	_TranslationsPerfilPageEn._(this._root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get userData => 'User Data';
	@override String get userPersonalData => 'Personal Data';
	@override String get username => 'Username';
	@override String get correo => 'Email';
	@override String get fullName => 'Full Name';
	@override String get phone => 'Phone';
	@override String get editProfile => 'Edit Profile';
	@override String get editData => 'Edit Personal Data';
	@override String get editAddress => 'Edit Address';
	@override String get dob => 'Date of Birth';
	@override String get placeOfBirth => 'Place of Birth';
	@override String get placeOfResidence => 'Place of Residence';
	@override String get completeInformation => 'Please complete your personal information';
	@override String get address => 'Address';
	@override String get addressMain => 'Street Name';
	@override String get addressSecondary => 'Apartment, Floor, Building (optional)';
	@override String get city => 'City';
	@override String get state => 'State';
	@override String get zipCode => 'Zip Code';
	@override String get country => 'Country';
	@override String get errorUpdateUserData => 'Error updating user data';
	@override String get errorUpdateUserAddress => 'Error updating user address';
	@override String get successUpdateUserData => 'User data updated successfully';
	@override String get successUpdateUserAddress => 'User address updated successfully';
	@override String get identificacion => 'ID number';
	@override String get tipoIdentificacion => 'ID Type';
	@override String get memberFamily => 'Family Member';
	@override String get firstName => 'First Name';
	@override String get secondName => 'Middle Name';
	@override String get firstLastName => 'Last Name';
	@override String get secondLastName => 'Second Last Name';
}

// Path: preferenciasPage
class _TranslationsPreferenciasPageEn implements _TranslationsPreferenciasPageEs {
	_TranslationsPreferenciasPageEn._(this._root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get preferenciasTitle => 'Preferences';
	@override String get preferenciasUser => 'User Preferences';
	@override String get notificaciones => 'Notification Preferences';
	@override String get notificacionesPermiso => 'Receive AvalonPlus notifications';
	@override String get idioma => 'Language';
	@override String get title => 'Settings';
	@override String get spanish => 'Spanish';
	@override String get ingles => 'English';
	@override String get lanES => 'Set Spanish';
	@override String get lanEN => 'Set English';
	@override late final _TranslationsPreferenciasPagePermisosEn permisos = _TranslationsPreferenciasPagePermisosEn._(_root);
}

// Path: reclamacionesPage
class _TranslationsReclamacionesPageEn implements _TranslationsReclamacionesPageEs {
	_TranslationsReclamacionesPageEn._(this._root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String title({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: 'Claim',
		other: 'Claims',
	);
	@override String reclamacionDetalle({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: 'Claim Detail',
		other: 'Claim Details',
	);
	@override String historial({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: 'Claims History',
		other: 'Claims History',
	);
	@override String moreDetails({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: 'More Detail',
		other: 'More Details',
	);
	@override String get detailFechaTentativa => 'Tentative Date';
	@override String get detailPreferenceCity => 'Preferred City';
	@override String get detailAseguradoraName => 'Insurance Company';
	@override String get detailHospital => 'Hospital';
	@override String get detailPreferenceDoctor => 'Preferred Doctor';
	@override String get detailPadecimeiento => 'Condition';
	@override String get detailPadecimeientoDiagnostico => 'Condition/Diagnosis';
	@override String get detailAditionalInformation => 'Additional Information';
	@override String get detailAditionalRequaimentes => 'Additional Requirements';
	@override String get detailOthersRequaimentes => 'Other Requirements';
	@override String get detalleFoto => 'Photo';
	@override String get estados => 'Claim States';
	@override String get estadoCerrado => 'Closed';
	@override String get estadoGestionando => 'Managing';
	@override String get estadoPorGestionar => 'Pending Management';
	@override String get nuevaReclamacion => 'New Claim';
	@override String get reclamacionSinCaso => 'Claim without Case';
	@override String get creaCasoReclamacion => 'Create a Case for the Claim';
	@override String get reclamacionEnCaso => 'Choose the Case for the Claim';
	@override String get reclamacionEstado => 'Claim Status';
	@override String get historialEmpty => 'No comment history yet';
	@override String get historialError => 'Error loading comment history';
	@override String get tipoAdministacion => 'Administration Type';
}

// Path: segurosPage
class _TranslationsSegurosPageEn implements _TranslationsSegurosPageEs {
	_TranslationsSegurosPageEn._(this._root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String title({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: 'Insurance Company',
		other: 'Insurance Company',
	);
	@override String polizaSeguros({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: 'Insurance policy',
		other: 'Insurance policies',
	);
	@override String cliente({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: 'Client',
		other: 'Clients',
	);
	@override String clienteDetalle({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: 'Client detail',
		other: 'Clients details',
	);
	@override String agente({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: 'AVALON Agent',
		other: 'AVALON Agents',
	);
	@override String agenteDetalle({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: 'AVALON Agent detail',
		other: 'AVALON Agents details',
	);
	@override String asesor({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: 'Broker Advisor',
		other: 'Broker Advisors',
	);
	@override String asesosDetalle({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: 'Broker Advisor detail',
		other: 'Broker Advisors details',
	);
	@override String detalleSeguro({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: 'Insurance detail',
		other: 'Insurance details',
	);
	@override String get empresa => 'Company';
	@override String get numeroCertificado => 'Certificate number';
	@override String get aseguradora => 'Insurance company';
	@override String get initDate => 'Init date';
	@override String get endDate => 'End date';
	@override String get tipoSeguro => 'Insurance type';
}

// Path: appOptions.validators
class _TranslationsAppOptionsValidatorsEn implements _TranslationsAppOptionsValidatorsEs {
	_TranslationsAppOptionsValidatorsEn._(this._root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get required => 'This field is required';
	@override String get email => 'Invalid email';
	@override String minLength({required Object min}) => 'Must have at least ${min} characters';
	@override String maxLength({required Object max}) => 'Must have a maximum of ${max} characters';
	@override String get passwordMatch => 'Passwords do not match';
	@override String passwordLength({required Object min}) => 'Must have at least ${min} characters';
	@override String get passwordUppercase => 'Must have at least one uppercase letter';
	@override String get passwordLowercase => 'Must have at least one lowercase letter';
	@override String get passwordNumber => 'Must have at least one number';
	@override String get passwordSpecial => 'Must have at least one special character';
	@override String get passwordOld => 'Old password is required';
	@override String get passwordNew => 'New password is required';
	@override String get passwordConfirm => 'Password confirmation is required';
	@override String get passwordChanged => 'Password changed successfully';
	@override String get passwordNotMatch => 'Passwords do not match';
}

// Path: avalonInfo.details
class _TranslationsAvalonInfoDetailsEn implements _TranslationsAvalonInfoDetailsEs {
	_TranslationsAvalonInfoDetailsEn._(this._root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get experience => 'Years of proven experience';
	@override String get experts => 'Experts in billing and cost containment';
	@override String get offices => 'Headquarters located in Houston, Texas';
	@override String get lead => 'TPA leader in international medical concierge services';
}

// Path: citasPage.aditionalRequaimentes
class _TranslationsCitasPageAditionalRequaimentesEn implements _TranslationsCitasPageAditionalRequaimentesEs {
	_TranslationsCitasPageAditionalRequaimentesEn._(this._root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get ambulanciaTerrestre => 'Ground Ambulance';
	@override String get recetaMedica => 'Medical Prescription';
	@override String get ambulanciaAerea => 'Air Ambulance';
	@override String get sillaRuedas => 'Wheelchair';
	@override String get servicioTransporte => 'Transportation Service';
	@override String get viajes => 'Trips';
	@override String get hospedaje => 'Accommodation';
}

// Path: preferenciasPage.permisos
class _TranslationsPreferenciasPagePermisosEn implements _TranslationsPreferenciasPagePermisosEs {
	_TranslationsPreferenciasPagePermisosEn._(this._root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Device Permissions';
	@override String get notificaciones => 'Notifications Permission';
	@override String get camara => 'Camera';
	@override String get almacenamiento => 'Storage';
}

/// Flat map(s) containing all translations.
/// Only for edge cases! For simple maps, use the map function of this library.

extension on Translations {
	dynamic _flatMapFunction(String path) {
		switch (path) {
			case 'appOptions.asesor': return 'Asesor';
			case 'appOptions.agente': return 'Agente';
			case 'appOptions.cliente': return 'Usuario';
			case 'appOptions.administrador': return 'Admin';
			case 'appOptions.rol': return 'Rol';
			case 'appOptions.detalle': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
				one: 'Detalle',
				other: 'Detalles',
			);
			case 'appOptions.coment': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
				one: 'Comentario',
				other: 'Comentarios',
			);
			case 'appOptions.codigo': return 'Código';
			case 'appOptions.fecha': return 'Fecha';
			case 'appOptions.noData': return 'No hay información cargada';
			case 'appOptions.scrollMore': return 'Más';
			case 'appOptions.scrollNoMoreData': return 'No hay más datos';
			case 'appOptions.scrollError': return 'Error al cargar datos';
			case 'appOptions.filtro': return 'Filtro';
			case 'appOptions.filtro_de': return ({required Object option}) => 'Filtro de ${option}';
			case 'appOptions.error_servers': return 'Servidores en mantenimiento. Por favor intente mas tarde.';
			case 'appOptions.error_access_internet': return 'Problemas en su conexion de red. Por favor intente mas tarde.';
			case 'appOptions.siguiente': return 'Siguiente';
			case 'appOptions.continuar': return 'Continuar';
			case 'appOptions.logout': return 'Cerrar Sesión';
			case 'appOptions.login': return 'Iniciar Sesión';
			case 'appOptions.opt_yes': return 'Si';
			case 'appOptions.observaciones': return 'Observaciones';
			case 'appOptions.cancelar': return 'Cancelar';
			case 'appOptions.envio_exitoso': return 'Se ha enviado exitosamente.';
			case 'appOptions.follow': return 'Seguir';
			case 'appOptions.edit': return 'Editar';
			case 'appOptions.save': return 'Guardar';
			case 'appOptions.cancel': return 'Cancelar';
			case 'appOptions.changePassword': return 'Cambiar Contraseña';
			case 'appOptions.newPassword': return 'Nueva Contraseña';
			case 'appOptions.confirmPassword': return 'Confirmar Contraseña';
			case 'appOptions.passwordNotMatch': return 'Las contraseñas no coinciden';
			case 'appOptions.passwordChanged': return 'Contraseña cambiada con éxito';
			case 'appOptions.passwordChangedError': return 'Error al cambiar la contraseña';
			case 'appOptions.currentPassword': return 'Contraseña Actual';
			case 'appOptions.verificationCode': return 'Código de Verificación';
			case 'appOptions.ingresarCode': return 'Ingresar Código';
			case 'appOptions.verificar': return 'Verificar';
			case 'appOptions.passwordDebil': return 'La contraseña debe tener al menos 8 caracteres, una mayúscula, una minúscula y un número';
			case 'appOptions.historialEmpty': return 'No hay un historial de comentarios aún';
			case 'appOptions.historialError': return 'Erroral cargar el historial de comentarios';
			case 'appOptions.comentMessage': return 'Escribe un comentario';
			case 'appOptions.comentError': return 'Error al enviar el comentario';
			case 'appOptions.comentSuccess': return 'Comentario enviado con éxito';
			case 'appOptions.comentEmpty': return 'El comentario no puede estar vacío';
			case 'appOptions.validators.required': return 'Este campo es requerido';
			case 'appOptions.validators.email': return 'Correo electrónico inválido';
			case 'appOptions.validators.minLength': return ({required Object min}) => 'Debe tener al menos ${min} caracteres';
			case 'appOptions.validators.maxLength': return ({required Object max}) => 'Debe tener máximo ${max} caracteres';
			case 'appOptions.validators.passwordMatch': return 'Las contraseñas no coinciden';
			case 'appOptions.validators.passwordLength': return ({required Object min}) => 'Debe tener al menos ${min} caracteres';
			case 'appOptions.validators.passwordUppercase': return 'Debe tener al menos una mayúscula';
			case 'appOptions.validators.passwordLowercase': return 'Debe tener al menos una minúscula';
			case 'appOptions.validators.passwordNumber': return 'Debe tener al menos un número';
			case 'appOptions.validators.passwordSpecial': return 'Debe tener al menos un caracter especial';
			case 'appOptions.validators.passwordOld': return 'La contraseña antigua es requerida';
			case 'appOptions.validators.passwordNew': return 'La nueva contraseña es requerida';
			case 'appOptions.validators.passwordConfirm': return 'La confirmación de la contraseña es requerida';
			case 'appOptions.validators.passwordChanged': return 'Contraseña cambiada con éxito';
			case 'appOptions.validators.passwordNotMatch': return 'Las contraseñas no coinciden';
			case 'avalonInfo.contactUs': return 'Contáctenos';
			case 'avalonInfo.aboutUs': return 'Sobre Nosotros';
			case 'avalonInfo.aboutDescription': return 'AVALON PLUS es una empresa líder en el conserjería médica integral internacional, fundada en Texas, formada por profesionales con más de 25 años de experiencia en las áreas de administración de cuentas hospitalarias, servicios médicos y seguros internacionales.\nEl Know-How de nuestro equipo de profesionales nos permite comprender las necesidades de nuestros clientes.';
			case 'avalonInfo.services': return 'Servicios.';
			case 'avalonInfo.servicesDescription': return 'Contamos con un equipo de profesionales, multilingüe y multicultural, con una basta experiencia en la administración y solución integral de casos médicos complejos alrededor del mundo.';
			case 'avalonInfo.details.experience': return 'Años de experiencia Comprobada';
			case 'avalonInfo.details.experts': return 'Expertos en facturación y contención costos';
			case 'avalonInfo.details.offices': return 'Oficinas y operaciones en Houston';
			case 'avalonInfo.details.lead': return 'TPA Líder en consejería médica integral internacional';
			case 'casosPage.title': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
				one: 'Caso',
				other: 'Casos',
			);
			case 'casosPage.casoDetalle': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
				one: 'Detalle de caso',
				other: 'Detalles de caso',
			);
			case 'centrosMedicos.title': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
				one: 'Centro Médico',
				other: 'Centro Médicos',
			);
			case 'centrosMedicos.noData': return 'No se encontraron centros médicos';
			case 'citasPage.title': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
				one: 'Cita Médica',
				other: 'Citas Médicas',
			);
			case 'citasPage.citaDetalle': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
				one: 'Detalle Cita Médica',
				other: 'Detalles Citas Médicas',
			);
			case 'citasPage.historial': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
				one: 'Historial de Citas',
				other: 'Historial de Citas',
			);
			case 'citasPage.moreDetails': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
				one: 'Más Detalle',
				other: 'Más Detalles',
			);
			case 'citasPage.detailFechaTentativa': return 'Fecha Tentativa';
			case 'citasPage.detailPreferenceCity': return 'Ciudad de preferencia';
			case 'citasPage.detailAseguradoraName': return 'Aseguradora';
			case 'citasPage.detailHospital': return 'Hospital';
			case 'citasPage.detailPreferenceDoctor': return 'Doctor de preferencia';
			case 'citasPage.detailPadecimeiento': return 'Padecimeiento';
			case 'citasPage.detailAditionalInformation': return 'Información adicional';
			case 'citasPage.detailAditionalRequaimentes': return 'Requerimientos adicionales';
			case 'citasPage.aditionalRequaimentes.ambulanciaTerrestre': return 'Ambulancia Terrestre';
			case 'citasPage.aditionalRequaimentes.recetaMedica': return 'Receta Médica';
			case 'citasPage.aditionalRequaimentes.ambulanciaAerea': return 'Ambulancia Aérea';
			case 'citasPage.aditionalRequaimentes.sillaRuedas': return 'Silla de Ruedas';
			case 'citasPage.aditionalRequaimentes.servicioTransporte': return 'Servicio de Transporte';
			case 'citasPage.aditionalRequaimentes.viajes': return 'Viajes';
			case 'citasPage.aditionalRequaimentes.hospedaje': return 'Hospedaje';
			case 'citasPage.detailOthersRequaimentes': return 'Otros requerimientos';
			case 'citasPage.detalleFoto': return 'Foto';
			case 'citasPage.estados': return 'Estados de las citas';
			case 'citasPage.estadoCerrado': return 'Cerrado';
			case 'citasPage.estadoGestionando': return 'Gestionando';
			case 'citasPage.estadoPorGestionar': return 'Por Gestionar';
			case 'citasPage.nuevaCita': return 'Nueva Cita';
			case 'citasPage.citaSinCaso': return 'Cita sin caso';
			case 'citasPage.creaCasoCita': return 'Crea un caso para la cita médica';
			case 'citasPage.citaEnCaso': return 'Escoje el caso para la cita médica';
			case 'citasPage.citaEstado': return 'Estado de la cita';
			case 'citasPage.historialEmpty': return 'No hay un historial de comentarios aún';
			case 'citasPage.historialError': return 'Erroral cargar el historial de comentarios';
			case 'comunicadospage.title': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
				one: 'Noticia',
				other: 'Noticias',
			);
			case 'emergenciasPage.title': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
				one: 'Emergencia',
				other: 'Emergencias',
			);
			case 'emergenciasPage.emergenciaDetalle': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
				one: 'Detalle de Emergencia',
				other: 'Detalles de Emergencia',
			);
			case 'emergenciasPage.historial': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
				one: 'Historial de Emergencia',
				other: 'Historial de Emergencias',
			);
			case 'emergenciasPage.moreDetails': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
				one: 'Más Detalle',
				other: 'Más Detalles',
			);
			case 'emergenciasPage.diagnostico': return 'Diagnóstico';
			case 'emergenciasPage.sintomas': return 'Síntomas';
			case 'familiaresPage.title': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
				one: 'Familiar',
				other: 'Familiares',
			);
			case 'faqsPAge.title': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
				one: 'Pregunta Frecuente',
				other: 'Preguntas Frecuentes',
			);
			case 'medicosPage.title': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
				one: 'Médico',
				other: 'Médicos',
			);
			case 'medicosPage.noData': return 'No se encontraron médicos';
			case 'membresiasPage.membresia': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
				one: 'Membresía',
				other: 'Membresías',
			);
			case 'membresiasPage.description': return 'Accede a nuestro plan de Membresía de Asistencia Médica en el extranjero, diseñado para brindarte la mejor atención médica disponible dentro de un marco rentable.';
			case 'membresiasPage.description2': return 'Lista de historial de membresías actuales y vencidas';
			case 'metodosPagoPage.title': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
				one: 'Método de Pago',
				other: 'Métodos de Pago',
			);
			case 'metodosPagoPage.noData': return 'No se encontraron métodos de pago';
			case 'perfilPage.userData': return 'Datos del Usuario';
			case 'perfilPage.userPersonalData': return 'Datos Personales';
			case 'perfilPage.username': return 'Nombre de Usuario';
			case 'perfilPage.correo': return 'Correo Electrónico';
			case 'perfilPage.fullName': return 'Nombre Completo';
			case 'perfilPage.phone': return 'Teléfono';
			case 'perfilPage.editProfile': return 'Editar Perfil';
			case 'perfilPage.editData': return 'Editar Datos Personales';
			case 'perfilPage.editAddress': return 'Editar Dirección';
			case 'perfilPage.dob': return 'Fecha de Nacimiento';
			case 'perfilPage.placeOfBirth': return 'Lugar de Nacimiento';
			case 'perfilPage.placeOfResidence': return 'Lugar de Residencia';
			case 'perfilPage.completeInformation': return 'Por favor, completa tu información personal';
			case 'perfilPage.address': return 'Dirección';
			case 'perfilPage.addressMain': return 'Nombre de la calle';
			case 'perfilPage.addressSecondary': return 'Departamento, piso, unidad, edificion (opcional)';
			case 'perfilPage.city': return 'Ciudad';
			case 'perfilPage.state': return 'Estado';
			case 'perfilPage.zipCode': return 'Código Postal';
			case 'perfilPage.country': return 'País';
			case 'perfilPage.errorUpdateUserData': return 'Error al actualizar los datos del usuario';
			case 'perfilPage.errorUpdateUserAddress': return 'Error al actualizar la dirección del usuario';
			case 'perfilPage.successUpdateUserData': return 'Datos del usuario actualizados correctamente';
			case 'perfilPage.successUpdateUserAddress': return 'Dirección del usuario actualizada correctamente';
			case 'perfilPage.identificacion': return 'Identificación';
			case 'perfilPage.tipoIdentificacion': return 'Tipo de Identificación';
			case 'perfilPage.memberFamily': return 'Familiar';
			case 'perfilPage.firstName': return 'Nombre';
			case 'perfilPage.secondName': return 'Segundo Nombre';
			case 'perfilPage.firstLastName': return 'Apellido';
			case 'perfilPage.secondLastName': return 'Segundo Apellido';
			case 'preferenciasPage.preferenciasTitle': return 'Preferencias';
			case 'preferenciasPage.preferenciasUser': return 'Preferencias de usuario';
			case 'preferenciasPage.notificaciones': return 'Preferencias de Notificaciones';
			case 'preferenciasPage.notificacionesPermiso': return 'Recivir notificaciones AvalonPlus';
			case 'preferenciasPage.idioma': return 'Idioma';
			case 'preferenciasPage.title': return 'Ajustes';
			case 'preferenciasPage.spanish': return 'Español';
			case 'preferenciasPage.ingles': return 'Ingles';
			case 'preferenciasPage.lanES': return 'Idioma Español';
			case 'preferenciasPage.lanEN': return 'Idioma Ingles';
			case 'preferenciasPage.permisos.title': return 'Permisos del dispositivo';
			case 'preferenciasPage.permisos.notificaciones': return 'Notificaciones';
			case 'preferenciasPage.permisos.camara': return 'Cámara';
			case 'preferenciasPage.permisos.almacenamiento': return 'Almacenamiento';
			case 'reclamacionesPage.title': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
				one: 'Recalmación',
				other: 'Recalmaciones',
			);
			case 'reclamacionesPage.reclamacionDetalle': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
				one: 'Detalle Reclamación',
				other: 'Detalles Reclamaciones',
			);
			case 'reclamacionesPage.historial': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
				one: 'Historial de Reclamaciones',
				other: 'Historial de Reclamaciones',
			);
			case 'reclamacionesPage.moreDetails': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
				one: 'Más Detalle',
				other: 'Más Detalles',
			);
			case 'reclamacionesPage.detailFechaTentativa': return 'Fecha Tentativa';
			case 'reclamacionesPage.detailPreferenceCity': return 'Ciudad de preferencia';
			case 'reclamacionesPage.detailAseguradoraName': return 'Aseguradora';
			case 'reclamacionesPage.detailHospital': return 'Hospital';
			case 'reclamacionesPage.detailPreferenceDoctor': return 'Doctor de preferencia';
			case 'reclamacionesPage.detailPadecimeiento': return 'Padecimeiento';
			case 'reclamacionesPage.detailPadecimeientoDiagnostico': return 'Padecimeiento/Diagnóstico';
			case 'reclamacionesPage.detailAditionalInformation': return 'Información adicional';
			case 'reclamacionesPage.detailAditionalRequaimentes': return 'Requerimientos adicionales';
			case 'reclamacionesPage.detailOthersRequaimentes': return 'Otros requerimientos';
			case 'reclamacionesPage.detalleFoto': return 'Foto';
			case 'reclamacionesPage.estados': return 'Estados de las reclamaciones';
			case 'reclamacionesPage.estadoCerrado': return 'Cerrado';
			case 'reclamacionesPage.estadoGestionando': return 'Gestionando';
			case 'reclamacionesPage.estadoPorGestionar': return 'Por Gestionar';
			case 'reclamacionesPage.nuevaReclamacion': return 'Nueva Reclamación';
			case 'reclamacionesPage.reclamacionSinCaso': return 'Reclamación sin caso';
			case 'reclamacionesPage.creaCasoReclamacion': return 'Crea un caso para la reclamación';
			case 'reclamacionesPage.reclamacionEnCaso': return 'Escoje el caso para la reclamación';
			case 'reclamacionesPage.reclamacionEstado': return 'Estado de la reclamación';
			case 'reclamacionesPage.historialEmpty': return 'No hay un historial de comentarios aún';
			case 'reclamacionesPage.historialError': return 'Error al cargar el historial de comentarios';
			case 'reclamacionesPage.tipoAdministacion': return 'Tipo de Administración';
			case 'segurosPage.title': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
				one: 'Seguro',
				other: 'Seguros',
			);
			case 'segurosPage.polizaSeguros': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
				one: 'Poliza de seguro',
				other: 'Polizas de seguro',
			);
			case 'segurosPage.cliente': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
				one: 'Cliente',
				other: 'Clientes',
			);
			case 'segurosPage.clienteDetalle': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
				one: 'Detalle de cliente',
				other: 'Detalle de clientes',
			);
			case 'segurosPage.agente': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
				one: 'Agente AVALON',
				other: 'Agentes AVALON',
			);
			case 'segurosPage.agenteDetalle': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
				one: 'Detalle de agente AVALON',
				other: 'Detalle de agentes AVALON',
			);
			case 'segurosPage.asesor': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
				one: 'Agente del Broker',
				other: 'Agentes del Broker',
			);
			case 'segurosPage.asesosDetalle': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
				one: 'Detalle de agente del Broker',
				other: 'Detalle de agentes del Broker',
			);
			case 'segurosPage.detalleSeguro': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
				one: 'Detalle de poliza',
				other: 'Detalles de poliza',
			);
			case 'segurosPage.empresa': return 'Empresa';
			case 'segurosPage.numeroCertificado': return 'Número de certificado';
			case 'segurosPage.aseguradora': return 'Aseguradora';
			case 'segurosPage.initDate': return 'Fecha de inicio';
			case 'segurosPage.endDate': return 'Fecha de fin';
			case 'segurosPage.tipoSeguro': return 'Tipo de poliza';
			default: return null;
		}
	}
}

extension on _TranslationsEn {
	dynamic _flatMapFunction(String path) {
		switch (path) {
			case 'appOptions.asesor': return 'Advisor';
			case 'appOptions.agente': return 'Agent';
			case 'appOptions.cliente': return 'Client';
			case 'appOptions.administrador': return 'Admin';
			case 'appOptions.rol': return 'Role';
			case 'appOptions.detalle': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
				one: 'Detail',
				other: 'Details',
			);
			case 'appOptions.coment': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
				one: 'Comment',
				other: 'Comments',
			);
			case 'appOptions.codigo': return 'Code';
			case 'appOptions.fecha': return 'Date';
			case 'appOptions.noData': return 'No data loaded';
			case 'appOptions.scrollMore': return 'Scroll for more';
			case 'appOptions.scrollNoMoreData': return 'No more data';
			case 'appOptions.scrollError': return 'Error loading data';
			case 'appOptions.filtro': return 'Filter';
			case 'appOptions.filtro_de': return ({required Object option}) => '${option} Filter';
			case 'appOptions.error_servers': return 'Servers under maintenance. Please try later';
			case 'appOptions.error_access_internet': return 'Problems with your network connection. Please try again later.';
			case 'appOptions.siguiente': return 'Next';
			case 'appOptions.continuar': return 'Continue';
			case 'appOptions.logout': return 'Logout';
			case 'appOptions.login': return 'Login';
			case 'appOptions.opt_yes': return 'Continue';
			case 'appOptions.observaciones': return 'Comments';
			case 'appOptions.cancelar': return 'Cancel';
			case 'appOptions.envio_exitoso': return 'Sent successfully.';
			case 'appOptions.follow': return 'Follow';
			case 'appOptions.edit': return 'Edit';
			case 'appOptions.save': return 'Save';
			case 'appOptions.cancel': return 'Cancel';
			case 'appOptions.changePassword': return 'Change Password';
			case 'appOptions.newPassword': return 'New Password';
			case 'appOptions.confirmPassword': return 'Confirm Password';
			case 'appOptions.passwordNotMatch': return 'Passwords do not match';
			case 'appOptions.passwordChanged': return 'Password changed successfully';
			case 'appOptions.passwordChangedError': return 'Error changing password';
			case 'appOptions.currentPassword': return 'Current Password';
			case 'appOptions.verificationCode': return 'Verification Code';
			case 'appOptions.ingresarCode': return 'Enter Code';
			case 'appOptions.verificar': return 'Verify';
			case 'appOptions.passwordDebil': return 'The password must have at least 8 characters, one uppercase letter, one lowercase letter, and one number';
			case 'appOptions.historialEmpty': return 'No comment history yet';
			case 'appOptions.historialError': return 'Error loading comment history';
			case 'appOptions.comentMessage': return 'Write a comment';
			case 'appOptions.comentError': return 'Error sending comment';
			case 'appOptions.comentSuccess': return 'Comment sent successfully';
			case 'appOptions.comentEmpty': return 'Comment cannot be empty';
			case 'appOptions.validators.required': return 'This field is required';
			case 'appOptions.validators.email': return 'Invalid email';
			case 'appOptions.validators.minLength': return ({required Object min}) => 'Must have at least ${min} characters';
			case 'appOptions.validators.maxLength': return ({required Object max}) => 'Must have a maximum of ${max} characters';
			case 'appOptions.validators.passwordMatch': return 'Passwords do not match';
			case 'appOptions.validators.passwordLength': return ({required Object min}) => 'Must have at least ${min} characters';
			case 'appOptions.validators.passwordUppercase': return 'Must have at least one uppercase letter';
			case 'appOptions.validators.passwordLowercase': return 'Must have at least one lowercase letter';
			case 'appOptions.validators.passwordNumber': return 'Must have at least one number';
			case 'appOptions.validators.passwordSpecial': return 'Must have at least one special character';
			case 'appOptions.validators.passwordOld': return 'Old password is required';
			case 'appOptions.validators.passwordNew': return 'New password is required';
			case 'appOptions.validators.passwordConfirm': return 'Password confirmation is required';
			case 'appOptions.validators.passwordChanged': return 'Password changed successfully';
			case 'appOptions.validators.passwordNotMatch': return 'Passwords do not match';
			case 'avalonInfo.contactUs': return 'Contact Us';
			case 'avalonInfo.aboutUs': return 'About Us';
			case 'avalonInfo.aboutDescription': return 'AVALON PLUS is a leading international comprehensive medical concierge company, founded in Texas, made up of professionals with more than 25 years of experience in the areas of hospital account management, medical services and international insurance.\nThe Know-How of our team of professionals allows us to understand the needs of our clients.';
			case 'avalonInfo.services': return 'Services.';
			case 'avalonInfo.servicesDescription': return 'We have a multilingual and multicultural team of professionals, with extensive experience in the administration and comprehensive solution of complex medical cases around the world.';
			case 'avalonInfo.details.experience': return 'Years of proven experience';
			case 'avalonInfo.details.experts': return 'Experts in billing and cost containment';
			case 'avalonInfo.details.offices': return 'Headquarters located in Houston, Texas';
			case 'avalonInfo.details.lead': return 'TPA leader in international medical concierge services';
			case 'casosPage.title': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
				one: 'Case',
				other: 'Cases',
			);
			case 'casosPage.casoDetalle': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
				one: 'Case detail',
				other: 'Case details',
			);
			case 'centrosMedicos.title': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
				one: 'Medical Center',
				other: 'Medical Centers',
			);
			case 'centrosMedicos.noData': return 'No medical centers found';
			case 'citasPage.title': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
				one: 'Appointment',
				other: 'Appointments',
			);
			case 'citasPage.citaDetalle': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
				one: 'Appointment Detail',
				other: 'Appointment Details',
			);
			case 'citasPage.historial': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
				one: 'Appointment History',
				other: 'Appointment History',
			);
			case 'citasPage.moreDetails': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
				one: 'More Detail',
				other: 'More Details',
			);
			case 'citasPage.detailFechaTentativa': return 'Tentative Date';
			case 'citasPage.detailPreferenceCity': return 'Preferred City';
			case 'citasPage.detailAseguradoraName': return 'Insurance Company';
			case 'citasPage.detailHospital': return 'Hospital';
			case 'citasPage.detailPreferenceDoctor': return 'Preferred Doctor';
			case 'citasPage.detailPadecimeiento': return 'Condition';
			case 'citasPage.detailAditionalInformation': return 'Additional Information';
			case 'citasPage.detailAditionalRequaimentes': return 'Additional Requirements';
			case 'citasPage.aditionalRequaimentes.ambulanciaTerrestre': return 'Ground Ambulance';
			case 'citasPage.aditionalRequaimentes.recetaMedica': return 'Medical Prescription';
			case 'citasPage.aditionalRequaimentes.ambulanciaAerea': return 'Air Ambulance';
			case 'citasPage.aditionalRequaimentes.sillaRuedas': return 'Wheelchair';
			case 'citasPage.aditionalRequaimentes.servicioTransporte': return 'Transportation Service';
			case 'citasPage.aditionalRequaimentes.viajes': return 'Trips';
			case 'citasPage.aditionalRequaimentes.hospedaje': return 'Accommodation';
			case 'citasPage.detailOthersRequaimentes': return 'Other Requirements';
			case 'citasPage.detalleFoto': return 'Photo';
			case 'citasPage.estados': return 'Appointment States';
			case 'citasPage.estadoCerrado': return 'Closed';
			case 'citasPage.estadoGestionando': return 'Managing';
			case 'citasPage.estadoPorGestionar': return 'Pending';
			case 'citasPage.nuevaCita': return 'New Appointment';
			case 'citasPage.citaSinCaso': return 'Appointment without Case';
			case 'citasPage.creaCasoCita': return 'Create a case for the appointment';
			case 'citasPage.citaEnCaso': return 'Choose the case for the appointment';
			case 'citasPage.citaEstado': return 'Appointment State';
			case 'citasPage.historialEmpty': return 'No comment history yet';
			case 'citasPage.historialError': return 'Error loading comment history';
			case 'comunicadospage.title': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
				one: 'New',
				other: 'News',
			);
			case 'emergenciasPage.title': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
				one: 'Emergency',
				other: 'Emergencies',
			);
			case 'emergenciasPage.emergenciaDetalle': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
				one: 'Emergency Detail',
				other: 'Emergency Details',
			);
			case 'emergenciasPage.historial': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
				one: 'Emergency History',
				other: 'Emergency History',
			);
			case 'emergenciasPage.moreDetails': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
				one: 'More Detail',
				other: 'More Details',
			);
			case 'emergenciasPage.diagnostico': return 'Diagnosis';
			case 'emergenciasPage.sintomas': return 'Symptoms';
			case 'familiaresPage.title': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
				one: 'Family',
				other: 'Family',
			);
			case 'faqsPAge.title': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
				one: 'FAQ',
				other: 'FAQs',
			);
			case 'medicosPage.title': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
				one: 'Doctor',
				other: 'Doctors',
			);
			case 'medicosPage.noData': return 'No doctors found';
			case 'membresiasPage.membresia': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
				one: 'Membership',
				other: 'Memberships',
			);
			case 'membresiasPage.description': return 'Access our Overseas Medical Assistance Membership plan, which is designed to provide you with the best medical care available within a cost-effective framework.';
			case 'membresiasPage.description2': return 'List of current and expired membership history';
			case 'metodosPagoPage.title': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
				one: 'Payment Method',
				other: 'Payment Methods',
			);
			case 'metodosPagoPage.noData': return 'No payment methods found';
			case 'perfilPage.userData': return 'User Data';
			case 'perfilPage.userPersonalData': return 'Personal Data';
			case 'perfilPage.username': return 'Username';
			case 'perfilPage.correo': return 'Email';
			case 'perfilPage.fullName': return 'Full Name';
			case 'perfilPage.phone': return 'Phone';
			case 'perfilPage.editProfile': return 'Edit Profile';
			case 'perfilPage.editData': return 'Edit Personal Data';
			case 'perfilPage.editAddress': return 'Edit Address';
			case 'perfilPage.dob': return 'Date of Birth';
			case 'perfilPage.placeOfBirth': return 'Place of Birth';
			case 'perfilPage.placeOfResidence': return 'Place of Residence';
			case 'perfilPage.completeInformation': return 'Please complete your personal information';
			case 'perfilPage.address': return 'Address';
			case 'perfilPage.addressMain': return 'Street Name';
			case 'perfilPage.addressSecondary': return 'Apartment, Floor, Building (optional)';
			case 'perfilPage.city': return 'City';
			case 'perfilPage.state': return 'State';
			case 'perfilPage.zipCode': return 'Zip Code';
			case 'perfilPage.country': return 'Country';
			case 'perfilPage.errorUpdateUserData': return 'Error updating user data';
			case 'perfilPage.errorUpdateUserAddress': return 'Error updating user address';
			case 'perfilPage.successUpdateUserData': return 'User data updated successfully';
			case 'perfilPage.successUpdateUserAddress': return 'User address updated successfully';
			case 'perfilPage.identificacion': return 'ID number';
			case 'perfilPage.tipoIdentificacion': return 'ID Type';
			case 'perfilPage.memberFamily': return 'Family Member';
			case 'perfilPage.firstName': return 'First Name';
			case 'perfilPage.secondName': return 'Middle Name';
			case 'perfilPage.firstLastName': return 'Last Name';
			case 'perfilPage.secondLastName': return 'Second Last Name';
			case 'preferenciasPage.preferenciasTitle': return 'Preferences';
			case 'preferenciasPage.preferenciasUser': return 'User Preferences';
			case 'preferenciasPage.notificaciones': return 'Notification Preferences';
			case 'preferenciasPage.notificacionesPermiso': return 'Receive AvalonPlus notifications';
			case 'preferenciasPage.idioma': return 'Language';
			case 'preferenciasPage.title': return 'Settings';
			case 'preferenciasPage.spanish': return 'Spanish';
			case 'preferenciasPage.ingles': return 'English';
			case 'preferenciasPage.lanES': return 'Set Spanish';
			case 'preferenciasPage.lanEN': return 'Set English';
			case 'preferenciasPage.permisos.title': return 'Device Permissions';
			case 'preferenciasPage.permisos.notificaciones': return 'Notifications Permission';
			case 'preferenciasPage.permisos.camara': return 'Camera';
			case 'preferenciasPage.permisos.almacenamiento': return 'Storage';
			case 'reclamacionesPage.title': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
				one: 'Claim',
				other: 'Claims',
			);
			case 'reclamacionesPage.reclamacionDetalle': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
				one: 'Claim Detail',
				other: 'Claim Details',
			);
			case 'reclamacionesPage.historial': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
				one: 'Claims History',
				other: 'Claims History',
			);
			case 'reclamacionesPage.moreDetails': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
				one: 'More Detail',
				other: 'More Details',
			);
			case 'reclamacionesPage.detailFechaTentativa': return 'Tentative Date';
			case 'reclamacionesPage.detailPreferenceCity': return 'Preferred City';
			case 'reclamacionesPage.detailAseguradoraName': return 'Insurance Company';
			case 'reclamacionesPage.detailHospital': return 'Hospital';
			case 'reclamacionesPage.detailPreferenceDoctor': return 'Preferred Doctor';
			case 'reclamacionesPage.detailPadecimeiento': return 'Condition';
			case 'reclamacionesPage.detailPadecimeientoDiagnostico': return 'Condition/Diagnosis';
			case 'reclamacionesPage.detailAditionalInformation': return 'Additional Information';
			case 'reclamacionesPage.detailAditionalRequaimentes': return 'Additional Requirements';
			case 'reclamacionesPage.detailOthersRequaimentes': return 'Other Requirements';
			case 'reclamacionesPage.detalleFoto': return 'Photo';
			case 'reclamacionesPage.estados': return 'Claim States';
			case 'reclamacionesPage.estadoCerrado': return 'Closed';
			case 'reclamacionesPage.estadoGestionando': return 'Managing';
			case 'reclamacionesPage.estadoPorGestionar': return 'Pending Management';
			case 'reclamacionesPage.nuevaReclamacion': return 'New Claim';
			case 'reclamacionesPage.reclamacionSinCaso': return 'Claim without Case';
			case 'reclamacionesPage.creaCasoReclamacion': return 'Create a Case for the Claim';
			case 'reclamacionesPage.reclamacionEnCaso': return 'Choose the Case for the Claim';
			case 'reclamacionesPage.reclamacionEstado': return 'Claim Status';
			case 'reclamacionesPage.historialEmpty': return 'No comment history yet';
			case 'reclamacionesPage.historialError': return 'Error loading comment history';
			case 'reclamacionesPage.tipoAdministacion': return 'Administration Type';
			case 'segurosPage.title': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
				one: 'Insurance Company',
				other: 'Insurance Company',
			);
			case 'segurosPage.polizaSeguros': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
				one: 'Insurance policy',
				other: 'Insurance policies',
			);
			case 'segurosPage.cliente': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
				one: 'Client',
				other: 'Clients',
			);
			case 'segurosPage.clienteDetalle': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
				one: 'Client detail',
				other: 'Clients details',
			);
			case 'segurosPage.agente': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
				one: 'AVALON Agent',
				other: 'AVALON Agents',
			);
			case 'segurosPage.agenteDetalle': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
				one: 'AVALON Agent detail',
				other: 'AVALON Agents details',
			);
			case 'segurosPage.asesor': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
				one: 'Broker Advisor',
				other: 'Broker Advisors',
			);
			case 'segurosPage.asesosDetalle': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
				one: 'Broker Advisor detail',
				other: 'Broker Advisors details',
			);
			case 'segurosPage.detalleSeguro': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
				one: 'Insurance detail',
				other: 'Insurance details',
			);
			case 'segurosPage.empresa': return 'Company';
			case 'segurosPage.numeroCertificado': return 'Certificate number';
			case 'segurosPage.aseguradora': return 'Insurance company';
			case 'segurosPage.initDate': return 'Init date';
			case 'segurosPage.endDate': return 'End date';
			case 'segurosPage.tipoSeguro': return 'Insurance type';
			default: return null;
		}
	}
}
