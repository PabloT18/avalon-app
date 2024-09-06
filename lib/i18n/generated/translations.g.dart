/// Generated file. Do not edit.
///
/// Original: lib/i18n
/// To regenerate, run: `dart run slang`
///
/// Locales: 2
/// Strings: 194 (97 per locale)
///
/// Built on 2024-08-15 at 23:03 UTC

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
	late final _TranslationsCentrosMedicosEs centrosMedicos = _TranslationsCentrosMedicosEs._(_root);
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
	String get oldPassword => 'Contraseña Antigua';
	String get newPassword => 'Nueva Contraseña';
	String get confirmPassword => 'Confirmar Contraseña';
	String get passwordNotMatch => 'Las contraseñas no coinciden';
	String get passwordChanged => 'Contraseña cambiada con éxito';
	late final _TranslationsAppOptionsValidatorsEs validators = _TranslationsAppOptionsValidatorsEs._(_root);
}

// Path: avalonInfo
class _TranslationsAvalonInfoEs {
	_TranslationsAvalonInfoEs._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get aboutUs => 'Sobre Nosotros';
	String get aboutDescription => 'AVALON PLUS es una empresa líder en el conserjería médica integral internacional, fundada en Texas, formada por profesionales con más de 25 años de experiencia en las áreas de administración de cuentas hospitalarias, servicios médicos y seguros internacionales.\nEl Know-How de nuestro equipo de profesionales nos permite comprender las necesidades de nuestros clientes.';
	String get services => 'Servicios.';
	String get servicesDescription => 'Contamos con un equipo de profesionales, multilingüe y multicultural, con una basta experiencia en la administración y solución integral de casos médicos complejos alrededor del mundo.';
	late final _TranslationsAvalonInfoDetailsEs details = _TranslationsAvalonInfoDetailsEs._(_root);
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
}

// Path: preferenciasPage
class _TranslationsPreferenciasPageEs {
	_TranslationsPreferenciasPageEs._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get preferenciasTitle => 'Preferencias';
	String get preferenciasUser => 'Preferencias de usuario';
	String get notificaciones => 'Notificaciones';
	String get notificacionesPermiso => 'Permiso de notificaciones';
	String get idioma => 'Idioma';
	String get title => 'Ajustes';
	String get spanish => 'Español';
	String get ingles => 'Ingles';
	String get lanES => 'Idioma Español';
	String get lanEN => 'Idioma Ingles';
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
	@override late final _TranslationsCentrosMedicosEn centrosMedicos = _TranslationsCentrosMedicosEn._(_root);
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
	@override String get oldPassword => 'Old Password';
	@override String get newPassword => 'New Password';
	@override String get confirmPassword => 'Confirm Password';
	@override String get passwordNotMatch => 'Passwords do not match';
	@override String get passwordChanged => 'Password changed successfully';
	@override late final _TranslationsAppOptionsValidatorsEn validators = _TranslationsAppOptionsValidatorsEn._(_root);
}

// Path: avalonInfo
class _TranslationsAvalonInfoEn implements _TranslationsAvalonInfoEs {
	_TranslationsAvalonInfoEn._(this._root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get aboutUs => 'About Us';
	@override String get aboutDescription => 'AVALON PLUS is a leading international comprehensive medical concierge company, founded in Texas, made up of professionals with more than 25 years of experience in the areas of hospital account management, medical services and international insurance.\nThe Know-How of our team of professionals allows us to understand the needs of our clients.';
	@override String get services => 'Services.';
	@override String get servicesDescription => 'We have a multilingual and multicultural team of professionals, with extensive experience in the administration and comprehensive solution of complex medical cases around the world.';
	@override late final _TranslationsAvalonInfoDetailsEn details = _TranslationsAvalonInfoDetailsEn._(_root);
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
}

// Path: preferenciasPage
class _TranslationsPreferenciasPageEn implements _TranslationsPreferenciasPageEs {
	_TranslationsPreferenciasPageEn._(this._root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get preferenciasTitle => 'Preferences';
	@override String get preferenciasUser => 'User Preferences';
	@override String get notificaciones => 'Notifications';
	@override String get notificacionesPermiso => 'Notification Permission';
	@override String get idioma => 'Language';
	@override String get title => 'Settings';
	@override String get spanish => 'Spanish';
	@override String get ingles => 'English';
	@override String get lanES => 'Set Spanish';
	@override String get lanEN => 'Set English';
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
}

// Path: segurosPage
class _TranslationsSegurosPageEn implements _TranslationsSegurosPageEs {
	_TranslationsSegurosPageEn._(this._root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String title({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: 'Insurance',
		other: 'Insurance',
	);
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

/// Flat map(s) containing all translations.
/// Only for edge cases! For simple maps, use the map function of this library.

extension on Translations {
	dynamic _flatMapFunction(String path) {
		switch (path) {
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
			case 'appOptions.oldPassword': return 'Contraseña Antigua';
			case 'appOptions.newPassword': return 'Nueva Contraseña';
			case 'appOptions.confirmPassword': return 'Confirmar Contraseña';
			case 'appOptions.passwordNotMatch': return 'Las contraseñas no coinciden';
			case 'appOptions.passwordChanged': return 'Contraseña cambiada con éxito';
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
			case 'avalonInfo.aboutUs': return 'Sobre Nosotros';
			case 'avalonInfo.aboutDescription': return 'AVALON PLUS es una empresa líder en el conserjería médica integral internacional, fundada en Texas, formada por profesionales con más de 25 años de experiencia en las áreas de administración de cuentas hospitalarias, servicios médicos y seguros internacionales.\nEl Know-How de nuestro equipo de profesionales nos permite comprender las necesidades de nuestros clientes.';
			case 'avalonInfo.services': return 'Servicios.';
			case 'avalonInfo.servicesDescription': return 'Contamos con un equipo de profesionales, multilingüe y multicultural, con una basta experiencia en la administración y solución integral de casos médicos complejos alrededor del mundo.';
			case 'avalonInfo.details.experience': return 'Años de experiencia Comprobada';
			case 'avalonInfo.details.experts': return 'Expertos en facturación y contención costos';
			case 'avalonInfo.details.offices': return 'Oficinas y operaciones en Houston';
			case 'avalonInfo.details.lead': return 'TPA Líder en consejería médica integral internacional';
			case 'centrosMedicos.title': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
				one: 'Centro Médico',
				other: 'Centro Médicos',
			);
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
			case 'preferenciasPage.preferenciasTitle': return 'Preferencias';
			case 'preferenciasPage.preferenciasUser': return 'Preferencias de usuario';
			case 'preferenciasPage.notificaciones': return 'Notificaciones';
			case 'preferenciasPage.notificacionesPermiso': return 'Permiso de notificaciones';
			case 'preferenciasPage.idioma': return 'Idioma';
			case 'preferenciasPage.title': return 'Ajustes';
			case 'preferenciasPage.spanish': return 'Español';
			case 'preferenciasPage.ingles': return 'Ingles';
			case 'preferenciasPage.lanES': return 'Idioma Español';
			case 'preferenciasPage.lanEN': return 'Idioma Ingles';
			case 'reclamacionesPage.title': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
				one: 'Recalmación',
				other: 'Recalmaciones',
			);
			case 'segurosPage.title': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
				one: 'Seguro',
				other: 'Seguros',
			);
			default: return null;
		}
	}
}

extension on _TranslationsEn {
	dynamic _flatMapFunction(String path) {
		switch (path) {
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
			case 'appOptions.oldPassword': return 'Old Password';
			case 'appOptions.newPassword': return 'New Password';
			case 'appOptions.confirmPassword': return 'Confirm Password';
			case 'appOptions.passwordNotMatch': return 'Passwords do not match';
			case 'appOptions.passwordChanged': return 'Password changed successfully';
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
			case 'avalonInfo.aboutUs': return 'About Us';
			case 'avalonInfo.aboutDescription': return 'AVALON PLUS is a leading international comprehensive medical concierge company, founded in Texas, made up of professionals with more than 25 years of experience in the areas of hospital account management, medical services and international insurance.\nThe Know-How of our team of professionals allows us to understand the needs of our clients.';
			case 'avalonInfo.services': return 'Services.';
			case 'avalonInfo.servicesDescription': return 'We have a multilingual and multicultural team of professionals, with extensive experience in the administration and comprehensive solution of complex medical cases around the world.';
			case 'avalonInfo.details.experience': return 'Years of proven experience';
			case 'avalonInfo.details.experts': return 'Experts in billing and cost containment';
			case 'avalonInfo.details.offices': return 'Headquarters located in Houston, Texas';
			case 'avalonInfo.details.lead': return 'TPA leader in international medical concierge services';
			case 'centrosMedicos.title': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
				one: 'Medical Center',
				other: 'Medical Centers',
			);
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
			case 'preferenciasPage.preferenciasTitle': return 'Preferences';
			case 'preferenciasPage.preferenciasUser': return 'User Preferences';
			case 'preferenciasPage.notificaciones': return 'Notifications';
			case 'preferenciasPage.notificacionesPermiso': return 'Notification Permission';
			case 'preferenciasPage.idioma': return 'Language';
			case 'preferenciasPage.title': return 'Settings';
			case 'preferenciasPage.spanish': return 'Spanish';
			case 'preferenciasPage.ingles': return 'English';
			case 'preferenciasPage.lanES': return 'Set Spanish';
			case 'preferenciasPage.lanEN': return 'Set English';
			case 'reclamacionesPage.title': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
				one: 'Claim',
				other: 'Claims',
			);
			case 'segurosPage.title': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
				one: 'Insurance',
				other: 'Insurance',
			);
			default: return null;
		}
	}
}
