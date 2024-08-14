/// Generated file. Do not edit.
///
/// Original: lib/i18n
/// To regenerate, run: `dart run slang`
///
/// Locales: 2
/// Strings: 44 (22 per locale)
///
/// Built on 2024-08-07 at 22:49 UTC

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
	late final _TranslationsPerfilPageEs perfilPage = _TranslationsPerfilPageEs._(_root);
	late final _TranslationsPreferenciasPageEs preferenciasPage = _TranslationsPreferenciasPageEs._(_root);
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
	String get opt_yes => 'Si';
	String get observaciones => 'Observaciones';
	String get cancelar => 'Cancelar';
	String get envio_exitoso => 'Se ha enviado exitosamente.';
	String get follow => 'Seguir';
}

// Path: perfilPage
class _TranslationsPerfilPageEs {
	_TranslationsPerfilPageEs._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get userData => 'Datos del Usuario';
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
	@override late final _TranslationsPerfilPageEn perfilPage = _TranslationsPerfilPageEn._(_root);
	@override late final _TranslationsPreferenciasPageEn preferenciasPage = _TranslationsPreferenciasPageEn._(_root);
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
	@override String get opt_yes => 'Continue';
	@override String get observaciones => 'Comments';
	@override String get cancelar => 'Cancel';
	@override String get envio_exitoso => 'Sent successfully.';
	@override String get follow => 'Follow';
}

// Path: perfilPage
class _TranslationsPerfilPageEn implements _TranslationsPerfilPageEs {
	_TranslationsPerfilPageEn._(this._root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get userData => 'User Data';
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
			case 'appOptions.opt_yes': return 'Si';
			case 'appOptions.observaciones': return 'Observaciones';
			case 'appOptions.cancelar': return 'Cancelar';
			case 'appOptions.envio_exitoso': return 'Se ha enviado exitosamente.';
			case 'appOptions.follow': return 'Seguir';
			case 'perfilPage.userData': return 'Datos del Usuario';
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
			case 'appOptions.opt_yes': return 'Continue';
			case 'appOptions.observaciones': return 'Comments';
			case 'appOptions.cancelar': return 'Cancel';
			case 'appOptions.envio_exitoso': return 'Sent successfully.';
			case 'appOptions.follow': return 'Follow';
			case 'perfilPage.userData': return 'User Data';
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
			default: return null;
		}
	}
}
