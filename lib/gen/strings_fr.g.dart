///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import

import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:slang/generated.dart';
import 'strings.g.dart';

// Path: <root>
class TranslationsFr implements Translations {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	TranslationsFr({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = TranslationMetadata(
		    locale: AppLocale.fr,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <fr>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	@override dynamic operator[](String key) => $meta.getTranslation(key);

	late final TranslationsFr _root = this; // ignore: unused_field

	// Translations
	@override late final _TranslationsAppFr app = _TranslationsAppFr._(_root);
	@override late final _TranslationsPagesFr pages = _TranslationsPagesFr._(_root);
	@override late final _TranslationsMessagesFr messages = _TranslationsMessagesFr._(_root);
	@override late final _TranslationsComponentsFr components = _TranslationsComponentsFr._(_root);
	@override late final _TranslationsActionsFr actions = _TranslationsActionsFr._(_root);
	@override late final _TranslationsOthersFr others = _TranslationsOthersFr._(_root);
}

// Path: app
class _TranslationsAppFr implements TranslationsAppEn {
	_TranslationsAppFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get name => 'mauritius emergency services';
	@override String get short_name => 'mes';
}

// Path: pages
class _TranslationsPagesFr implements TranslationsPagesEn {
	_TranslationsPagesFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsPagesWelcomeFr welcome = _TranslationsPagesWelcomeFr._(_root);
	@override late final _TranslationsPagesHomeFr home = _TranslationsPagesHomeFr._(_root);
	@override late final _TranslationsPagesServicesFr services = _TranslationsPagesServicesFr._(_root);
	@override late final _TranslationsPagesCycloneFr cyclone = _TranslationsPagesCycloneFr._(_root);
	@override late final _TranslationsPagesVicinityAlertsFr vicinity_alerts = _TranslationsPagesVicinityAlertsFr._(_root);
	@override late final _TranslationsPagesPrecallFr precall = _TranslationsPagesPrecallFr._(_root);
	@override late final _TranslationsPagesThemeSelectorFr theme_selector = _TranslationsPagesThemeSelectorFr._(_root);
	@override late final _TranslationsPagesAboutFr about = _TranslationsPagesAboutFr._(_root);
	@override late final _TranslationsPagesSettingsFr settings = _TranslationsPagesSettingsFr._(_root);
}

// Path: messages
class _TranslationsMessagesFr implements TranslationsMessagesEn {
	_TranslationsMessagesFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsMessagesErrorFr error = _TranslationsMessagesErrorFr._(_root);
	@override late final _TranslationsMessagesSuccessFr success = _TranslationsMessagesSuccessFr._(_root);
	@override late final _TranslationsMessagesInfoFr info = _TranslationsMessagesInfoFr._(_root);
}

// Path: components
class _TranslationsComponentsFr implements TranslationsComponentsEn {
	_TranslationsComponentsFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsComponentsSearchBarFr search_bar = _TranslationsComponentsSearchBarFr._(_root);
}

// Path: actions
class _TranslationsActionsFr implements TranslationsActionsEn {
	_TranslationsActionsFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get proceed => 'continuer';
	@override String get cancel => 'annuler';
	@override String get close => 'fermer';
	@override String get slide_to_cancel => 'glissez pour annuler';
	@override String get get_started => 'commencer';
	@override String get contact_us => 'contactez-nous';
	@override String get coming_soon => 'bientôt disponible';
	@override String get toll_free => 'gratuit';
	@override String get retry => 'réessayer';
}

// Path: others
class _TranslationsOthersFr implements TranslationsOthersEn {
	_TranslationsOthersFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get hour_abbr => 'h';
	@override String get minute_abbr => 'min';
	@override String get ooops => 'ooups!';
	@override Map<String, String> get themes => {
		'light': 'clair',
		'dark': 'sombre',
		'system': 'système',
	};
	@override Map<String, String> get language => {
		'english': 'anglais',
		'french': 'français',
	};
}

// Path: pages.welcome
class _TranslationsPagesWelcomeFr implements TranslationsPagesWelcomeEn {
	_TranslationsPagesWelcomeFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'bienvenue';
	@override late final _TranslationsPagesWelcomeHeaderFr header = _TranslationsPagesWelcomeHeaderFr._(_root);
	@override late final _TranslationsPagesWelcomeCarouselFr carousel = _TranslationsPagesWelcomeCarouselFr._(_root);
	@override late final _TranslationsPagesWelcomePermissionsDialogFr permissions_dialog = _TranslationsPagesWelcomePermissionsDialogFr._(_root);
}

// Path: pages.home
class _TranslationsPagesHomeFr implements TranslationsPagesHomeEn {
	_TranslationsPagesHomeFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'accueil';
	@override String get primary_title => 'besoin d\'aide d\'urgence ?';
	@override String get primary_subtitle => 'maintenez le bouton d\'urgence pour appeler';
	@override String get secondary_title => 'besoin d\'autres actions d\'urgence rapides ?';
	@override String get secondary_subtitle => 'cliquez sur l\'une d\'entre elles ci-dessous pour appeler';
}

// Path: pages.services
class _TranslationsPagesServicesFr implements TranslationsPagesServicesEn {
	_TranslationsPagesServicesFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'services';
}

// Path: pages.cyclone
class _TranslationsPagesCycloneFr implements TranslationsPagesCycloneEn {
	_TranslationsPagesCycloneFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'rapport cyclonique';
	@override String get no_warning => 'il n\'y a actuellement aucune alerte cyclonique à Maurice';
	@override late final _TranslationsPagesCycloneWarningFr warning = _TranslationsPagesCycloneWarningFr._(_root);
	@override late final _TranslationsPagesCycloneNamesFr names = _TranslationsPagesCycloneNamesFr._(_root);
	@override late final _TranslationsPagesCycloneGuidelinesFr guidelines = _TranslationsPagesCycloneGuidelinesFr._(_root);
}

// Path: pages.vicinity_alerts
class _TranslationsPagesVicinityAlertsFr implements TranslationsPagesVicinityAlertsEn {
	_TranslationsPagesVicinityAlertsFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'alertes de proximité';
}

// Path: pages.precall
class _TranslationsPagesPrecallFr implements TranslationsPagesPrecallEn {
	_TranslationsPagesPrecallFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'démarrage d\'un appel vers';
	@override String get calling_in => 'appel dans';
}

// Path: pages.theme_selector
class _TranslationsPagesThemeSelectorFr implements TranslationsPagesThemeSelectorEn {
	_TranslationsPagesThemeSelectorFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'préférences de thème';
}

// Path: pages.about
class _TranslationsPagesAboutFr implements TranslationsPagesAboutEn {
	_TranslationsPagesAboutFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'à propos';
	@override late final _TranslationsPagesAboutHeaderFr header = _TranslationsPagesAboutHeaderFr._(_root);
	@override late final _TranslationsPagesAboutSupportSectionFr support_section = _TranslationsPagesAboutSupportSectionFr._(_root);
	@override late final _TranslationsPagesAboutOtherSectionFr other_section = _TranslationsPagesAboutOtherSectionFr._(_root);
}

// Path: pages.settings
class _TranslationsPagesSettingsFr implements TranslationsPagesSettingsEn {
	_TranslationsPagesSettingsFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'paramètres';
	@override late final _TranslationsPagesSettingsSectionFeatureFr section_feature = _TranslationsPagesSettingsSectionFeatureFr._(_root);
	@override late final _TranslationsPagesSettingsSectionApplicationFr section_application = _TranslationsPagesSettingsSectionApplicationFr._(_root);
}

// Path: messages.error
class _TranslationsMessagesErrorFr implements TranslationsMessagesErrorEn {
	_TranslationsMessagesErrorFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get cannot_load_data => 'il semble que quelque chose ne va pas et nous n\'avons pas pu charger les données.';
	@override String services_unavailable({required Object app_name_short}) => 'il semble qu\'aucun service ne soit disponible. Assurez-vous d\'être connecté à Internet la première fois pour que ${app_name_short} puisse télécharger les services.';
	@override String get cannot_load_cyclone_report => 'il semble que quelque chose ne va pas et nous n\'avons pas pu charger le rapport cyclonique.';
	@override String get cannot_load_cyclone_names => 'une erreur s\'est produite lors de la récupération des noms des cyclones.';
	@override String get cannot_load_cyclone_guidelines => 'une erreur s\'est produite lors de la récupération des directives cycloniques.';
}

// Path: messages.success
class _TranslationsMessagesSuccessFr implements TranslationsMessagesSuccessEn {
	_TranslationsMessagesSuccessFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
}

// Path: messages.info
class _TranslationsMessagesInfoFr implements TranslationsMessagesInfoEn {
	_TranslationsMessagesInfoFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get loading_component => 'chargement...';
	@override String get unknown_component => 'inconnu';
	@override String get no_match_for_query => 'oups, votre recherche ne correspond à aucun service. Essayez autre chose ?';
	@override String get other_contacts => 'pas d\'autres contacts';
	@override String get no_other_contacts => 'pas d\'autres contacts';
}

// Path: components.search_bar
class _TranslationsComponentsSearchBarFr implements TranslationsComponentsSearchBarEn {
	_TranslationsComponentsSearchBarFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String title({required Object app_name_short}) => 'bienvenue sur ${app_name_short}';
	@override String get subtitle => 'de quelle aide avez-vous besoin ?';
}

// Path: pages.welcome.header
class _TranslationsPagesWelcomeHeaderFr implements TranslationsPagesWelcomeHeaderEn {
	_TranslationsPagesWelcomeHeaderFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'bienvenue à';
}

// Path: pages.welcome.carousel
class _TranslationsPagesWelcomeCarouselFr implements TranslationsPagesWelcomeCarouselEn {
	_TranslationsPagesWelcomeCarouselFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title_1 => 'liste des services';
	@override String get subtitle_1 => 'obtenez une liste de tous les services d\'urgence et non urgents pour Maurice directement sur votre téléphone.';
	@override String get title_2 => 'alertes cycloniques';
	@override String get subtitle_2 => 'soyez informé des alertes cycloniques et consultez les directives cycloniques en direct depuis votre téléphone.';
	@override String get title_3 => 'actions d\'urgence';
	@override String get subtitle_3 => 'obtenez un espace dédié sur votre tableau de bord uniquement pour les services d\'urgence.';
	@override String get title_4 => 'sos';
	@override String get subtitle_4 => 'appelez à l\'aide d\'urgence directement depuis l\'application en utilisant le gros bouton rouge.';
	@override String get title_5 => 'disponibilité hors ligne';
	@override String get subtitle_5 => 'connectez-vous une fois à Internet et accédez à tous vos services hors ligne.';
}

// Path: pages.welcome.permissions_dialog
class _TranslationsPagesWelcomePermissionsDialogFr implements TranslationsPagesWelcomePermissionsDialogEn {
	_TranslationsPagesWelcomePermissionsDialogFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String primary_text({required Object app_name_short}) => '${app_name_short} a besoin d\'autorisation pour continuer';
	@override String get secondary_text => 'pour offrir la meilleure expérience, l\'application nécessite l\'autorisation d\'effectuer des appels téléphoniques pour vous, car c\'est sa fonction principale.';
	@override String get tertiary_text => 'nous demandons également l\'accès aux notifications pour vous tenir informé et à jour.';
	@override String get quaternary_text => 'veuillez accorder ces autorisations pour continuer à utiliser l\'application sans problème. Si cela ne fonctionne pas, vous devrez le faire manuellement dans les paramètres.';
}

// Path: pages.cyclone.warning
class _TranslationsPagesCycloneWarningFr implements TranslationsPagesCycloneWarningEn {
	_TranslationsPagesCycloneWarningFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Maurice est actuellement en';
	@override String subtitle({required Object level}) => 'classe ${level}';
	@override String get next_bulletin_title => 'prochain bulletin';
	@override String get latest_news_title => 'dernières nouvelles';
}

// Path: pages.cyclone.names
class _TranslationsPagesCycloneNamesFr implements TranslationsPagesCycloneNamesEn {
	_TranslationsPagesCycloneNamesFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'noms des cyclones';
	@override String get table_header_name => 'nom';
	@override String get table_header_gender => 'genre';
	@override String get table_header_provided_by => 'fourni par';
}

// Path: pages.cyclone.guidelines
class _TranslationsPagesCycloneGuidelinesFr implements TranslationsPagesCycloneGuidelinesEn {
	_TranslationsPagesCycloneGuidelinesFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String title({required Object level}) => 'directives pour la classe ${level}';
	@override String get header_precautions_title => 'précautions';
}

// Path: pages.about.header
class _TranslationsPagesAboutHeaderFr implements TranslationsPagesAboutHeaderEn {
	_TranslationsPagesAboutHeaderFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'à propos';
	@override String get developer_name => 'mervin hemaraju';
	@override String get developer_title => 'développeur principal & designer';
	@override String get designer_name => 'nick foo kune';
	@override String get designer_title => 'bannière & images playstore';
	@override String get caption => 'développé avec ❤ à 🇲🇺';
}

// Path: pages.about.support_section
class _TranslationsPagesAboutSupportSectionFr implements TranslationsPagesAboutSupportSectionEn {
	_TranslationsPagesAboutSupportSectionFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'support';
	@override String rate_app_title({required Object app_name_short}) => 'évaluer ${app_name_short}';
	@override String get rate_app_subtitle => 'si vous aimez l\'application, faites-le nous savoir sur le Google Play Store et nous pourrons l\'améliorer davantage.';
	@override String share_app_title({required Object app_name_short}) => 'partager ${app_name_short}';
	@override String share_app_subtitle({required Object app_name_short}) => 'n\'oubliez pas de partager ${app_name_short} avec vos amis et votre famille.';
}

// Path: pages.about.other_section
class _TranslationsPagesAboutOtherSectionFr implements TranslationsPagesAboutOtherSectionEn {
	_TranslationsPagesAboutOtherSectionFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'autre';
	@override String about_app_title({required Object app_name_short}) => 'à propos de ${app_name_short}';
	@override String get about_app_subtitle => 'découvrez-nous sur notre site officiel.';
	@override String get developer_api_title => 'API développeur';
	@override String developer_api_subtitle({required Object app_name_short}) => 'Interface de Programmation d\'Application (API) utilisée dans ${app_name_short}.';
	@override String get privacy_policy_title => 'politique de confidentialité';
	@override String privacy_policy_subtitle({required Object app_name_short}) => 'consultez la politique de confidentialité de ${app_name_short}.';
	@override String get version_title => 'version';
}

// Path: pages.settings.section_feature
class _TranslationsPagesSettingsSectionFeatureFr implements TranslationsPagesSettingsSectionFeatureEn {
	_TranslationsPagesSettingsSectionFeatureFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'fonctionnalité';
	@override late final _TranslationsPagesSettingsSectionFeatureEmergencyButtonActionFr emergency_button_action = _TranslationsPagesSettingsSectionFeatureEmergencyButtonActionFr._(_root);
}

// Path: pages.settings.section_application
class _TranslationsPagesSettingsSectionApplicationFr implements TranslationsPagesSettingsSectionApplicationEn {
	_TranslationsPagesSettingsSectionApplicationFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'application';
	@override late final _TranslationsPagesSettingsSectionApplicationChangeLanguageFr change_language = _TranslationsPagesSettingsSectionApplicationChangeLanguageFr._(_root);
}

// Path: pages.settings.section_feature.emergency_button_action
class _TranslationsPagesSettingsSectionFeatureEmergencyButtonActionFr implements TranslationsPagesSettingsSectionFeatureEmergencyButtonActionEn {
	_TranslationsPagesSettingsSectionFeatureEmergencyButtonActionFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get sheet_title => 'choisir l\'action d\'urgence';
	@override String get tile_title => 'action du bouton d\'urgence';
	@override String get tile_subtitle => 'définir un service d\'urgence pour le bouton rouge';
}

// Path: pages.settings.section_application.change_language
class _TranslationsPagesSettingsSectionApplicationChangeLanguageFr implements TranslationsPagesSettingsSectionApplicationChangeLanguageEn {
	_TranslationsPagesSettingsSectionApplicationChangeLanguageFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get sheet_title => 'choisir la langue';
	@override String get tile_title => 'changer de langue';
	@override String get tile_subtitle => 'changer la langue de votre application';
}

/// Flat map(s) containing all translations.
/// Only for edge cases! For simple maps, use the map function of this library.
extension on TranslationsFr {
	dynamic _flatMapFunction(String path) {
		switch (path) {
			case 'app.name': return 'mauritius emergency services';
			case 'app.short_name': return 'mes';
			case 'pages.welcome.title': return 'bienvenue';
			case 'pages.welcome.header.title': return 'bienvenue à';
			case 'pages.welcome.carousel.title_1': return 'liste des services';
			case 'pages.welcome.carousel.subtitle_1': return 'obtenez une liste de tous les services d\'urgence et non urgents pour Maurice directement sur votre téléphone.';
			case 'pages.welcome.carousel.title_2': return 'alertes cycloniques';
			case 'pages.welcome.carousel.subtitle_2': return 'soyez informé des alertes cycloniques et consultez les directives cycloniques en direct depuis votre téléphone.';
			case 'pages.welcome.carousel.title_3': return 'actions d\'urgence';
			case 'pages.welcome.carousel.subtitle_3': return 'obtenez un espace dédié sur votre tableau de bord uniquement pour les services d\'urgence.';
			case 'pages.welcome.carousel.title_4': return 'sos';
			case 'pages.welcome.carousel.subtitle_4': return 'appelez à l\'aide d\'urgence directement depuis l\'application en utilisant le gros bouton rouge.';
			case 'pages.welcome.carousel.title_5': return 'disponibilité hors ligne';
			case 'pages.welcome.carousel.subtitle_5': return 'connectez-vous une fois à Internet et accédez à tous vos services hors ligne.';
			case 'pages.welcome.permissions_dialog.primary_text': return ({required Object app_name_short}) => '${app_name_short} a besoin d\'autorisation pour continuer';
			case 'pages.welcome.permissions_dialog.secondary_text': return 'pour offrir la meilleure expérience, l\'application nécessite l\'autorisation d\'effectuer des appels téléphoniques pour vous, car c\'est sa fonction principale.';
			case 'pages.welcome.permissions_dialog.tertiary_text': return 'nous demandons également l\'accès aux notifications pour vous tenir informé et à jour.';
			case 'pages.welcome.permissions_dialog.quaternary_text': return 'veuillez accorder ces autorisations pour continuer à utiliser l\'application sans problème. Si cela ne fonctionne pas, vous devrez le faire manuellement dans les paramètres.';
			case 'pages.home.title': return 'accueil';
			case 'pages.home.primary_title': return 'besoin d\'aide d\'urgence ?';
			case 'pages.home.primary_subtitle': return 'maintenez le bouton d\'urgence pour appeler';
			case 'pages.home.secondary_title': return 'besoin d\'autres actions d\'urgence rapides ?';
			case 'pages.home.secondary_subtitle': return 'cliquez sur l\'une d\'entre elles ci-dessous pour appeler';
			case 'pages.services.title': return 'services';
			case 'pages.cyclone.title': return 'rapport cyclonique';
			case 'pages.cyclone.no_warning': return 'il n\'y a actuellement aucune alerte cyclonique à Maurice';
			case 'pages.cyclone.warning.title': return 'Maurice est actuellement en';
			case 'pages.cyclone.warning.subtitle': return ({required Object level}) => 'classe ${level}';
			case 'pages.cyclone.warning.next_bulletin_title': return 'prochain bulletin';
			case 'pages.cyclone.warning.latest_news_title': return 'dernières nouvelles';
			case 'pages.cyclone.names.title': return 'noms des cyclones';
			case 'pages.cyclone.names.table_header_name': return 'nom';
			case 'pages.cyclone.names.table_header_gender': return 'genre';
			case 'pages.cyclone.names.table_header_provided_by': return 'fourni par';
			case 'pages.cyclone.guidelines.title': return ({required Object level}) => 'directives pour la classe ${level}';
			case 'pages.cyclone.guidelines.header_precautions_title': return 'précautions';
			case 'pages.vicinity_alerts.title': return 'alertes de proximité';
			case 'pages.precall.title': return 'démarrage d\'un appel vers';
			case 'pages.precall.calling_in': return 'appel dans';
			case 'pages.theme_selector.title': return 'préférences de thème';
			case 'pages.about.title': return 'à propos';
			case 'pages.about.header.title': return 'à propos';
			case 'pages.about.header.developer_name': return 'mervin hemaraju';
			case 'pages.about.header.developer_title': return 'développeur principal & designer';
			case 'pages.about.header.designer_name': return 'nick foo kune';
			case 'pages.about.header.designer_title': return 'bannière & images playstore';
			case 'pages.about.header.caption': return 'développé avec ❤ à 🇲🇺';
			case 'pages.about.support_section.title': return 'support';
			case 'pages.about.support_section.rate_app_title': return ({required Object app_name_short}) => 'évaluer ${app_name_short}';
			case 'pages.about.support_section.rate_app_subtitle': return 'si vous aimez l\'application, faites-le nous savoir sur le Google Play Store et nous pourrons l\'améliorer davantage.';
			case 'pages.about.support_section.share_app_title': return ({required Object app_name_short}) => 'partager ${app_name_short}';
			case 'pages.about.support_section.share_app_subtitle': return ({required Object app_name_short}) => 'n\'oubliez pas de partager ${app_name_short} avec vos amis et votre famille.';
			case 'pages.about.other_section.title': return 'autre';
			case 'pages.about.other_section.about_app_title': return ({required Object app_name_short}) => 'à propos de ${app_name_short}';
			case 'pages.about.other_section.about_app_subtitle': return 'découvrez-nous sur notre site officiel.';
			case 'pages.about.other_section.developer_api_title': return 'API développeur';
			case 'pages.about.other_section.developer_api_subtitle': return ({required Object app_name_short}) => 'Interface de Programmation d\'Application (API) utilisée dans ${app_name_short}.';
			case 'pages.about.other_section.privacy_policy_title': return 'politique de confidentialité';
			case 'pages.about.other_section.privacy_policy_subtitle': return ({required Object app_name_short}) => 'consultez la politique de confidentialité de ${app_name_short}.';
			case 'pages.about.other_section.version_title': return 'version';
			case 'pages.settings.title': return 'paramètres';
			case 'pages.settings.section_feature.title': return 'fonctionnalité';
			case 'pages.settings.section_feature.emergency_button_action.sheet_title': return 'choisir l\'action d\'urgence';
			case 'pages.settings.section_feature.emergency_button_action.tile_title': return 'action du bouton d\'urgence';
			case 'pages.settings.section_feature.emergency_button_action.tile_subtitle': return 'définir un service d\'urgence pour le bouton rouge';
			case 'pages.settings.section_application.title': return 'application';
			case 'pages.settings.section_application.change_language.sheet_title': return 'choisir la langue';
			case 'pages.settings.section_application.change_language.tile_title': return 'changer de langue';
			case 'pages.settings.section_application.change_language.tile_subtitle': return 'changer la langue de votre application';
			case 'messages.error.cannot_load_data': return 'il semble que quelque chose ne va pas et nous n\'avons pas pu charger les données.';
			case 'messages.error.services_unavailable': return ({required Object app_name_short}) => 'il semble qu\'aucun service ne soit disponible. Assurez-vous d\'être connecté à Internet la première fois pour que ${app_name_short} puisse télécharger les services.';
			case 'messages.error.cannot_load_cyclone_report': return 'il semble que quelque chose ne va pas et nous n\'avons pas pu charger le rapport cyclonique.';
			case 'messages.error.cannot_load_cyclone_names': return 'une erreur s\'est produite lors de la récupération des noms des cyclones.';
			case 'messages.error.cannot_load_cyclone_guidelines': return 'une erreur s\'est produite lors de la récupération des directives cycloniques.';
			case 'messages.info.loading_component': return 'chargement...';
			case 'messages.info.unknown_component': return 'inconnu';
			case 'messages.info.no_match_for_query': return 'oups, votre recherche ne correspond à aucun service. Essayez autre chose ?';
			case 'messages.info.other_contacts': return 'pas d\'autres contacts';
			case 'messages.info.no_other_contacts': return 'pas d\'autres contacts';
			case 'components.search_bar.title': return ({required Object app_name_short}) => 'bienvenue sur ${app_name_short}';
			case 'components.search_bar.subtitle': return 'de quelle aide avez-vous besoin ?';
			case 'actions.proceed': return 'continuer';
			case 'actions.cancel': return 'annuler';
			case 'actions.close': return 'fermer';
			case 'actions.slide_to_cancel': return 'glissez pour annuler';
			case 'actions.get_started': return 'commencer';
			case 'actions.contact_us': return 'contactez-nous';
			case 'actions.coming_soon': return 'bientôt disponible';
			case 'actions.toll_free': return 'gratuit';
			case 'actions.retry': return 'réessayer';
			case 'others.hour_abbr': return 'h';
			case 'others.minute_abbr': return 'min';
			case 'others.ooops': return 'ooups!';
			case 'others.themes.light': return 'clair';
			case 'others.themes.dark': return 'sombre';
			case 'others.themes.system': return 'système';
			case 'others.language.english': return 'anglais';
			case 'others.language.french': return 'français';
			default: return null;
		}
	}
}

