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
	@override String get proceed => 'proceed';
	@override String get cancel => 'cancel';
	@override String get close => 'close';
	@override String get slide_to_cancel => 'slide to cancel';
	@override String get get_started => 'get started';
	@override String get contact_us => 'contact us';
	@override String get coming_soon => 'coming soon';
	@override String get toll_free => 'toll free';
	@override String get retry => 'retry';
}

// Path: others
class _TranslationsOthersFr implements TranslationsOthersEn {
	_TranslationsOthersFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get hour_abbr => 'hr';
	@override String get minute_abbr => 'min';
	@override String get ooops => 'ooops!';
}

// Path: pages.welcome
class _TranslationsPagesWelcomeFr implements TranslationsPagesWelcomeEn {
	_TranslationsPagesWelcomeFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'welcome';
	@override late final _TranslationsPagesWelcomeHeaderFr header = _TranslationsPagesWelcomeHeaderFr._(_root);
	@override late final _TranslationsPagesWelcomeCarouselFr carousel = _TranslationsPagesWelcomeCarouselFr._(_root);
	@override late final _TranslationsPagesWelcomePermissionsDialogFr permissions_dialog = _TranslationsPagesWelcomePermissionsDialogFr._(_root);
}

// Path: pages.home
class _TranslationsPagesHomeFr implements TranslationsPagesHomeEn {
	_TranslationsPagesHomeFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'home';
	@override String get primary_title => 'emergency help needed?';
	@override String get primary_subtitle => 'hold the emergency button to call';
	@override String get secondary_title => 'need other quick emergency actions?';
	@override String get secondary_subtitle => 'click any one below to call';
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
	@override String get title => 'cyclone report';
	@override String get no_warning => 'there\'s currently no cyclone warning in Mauritius';
	@override late final _TranslationsPagesCycloneWarningFr warning = _TranslationsPagesCycloneWarningFr._(_root);
	@override late final _TranslationsPagesCycloneNamesFr names = _TranslationsPagesCycloneNamesFr._(_root);
	@override late final _TranslationsPagesCycloneGuidelinesFr guidelines = _TranslationsPagesCycloneGuidelinesFr._(_root);
}

// Path: pages.vicinity_alerts
class _TranslationsPagesVicinityAlertsFr implements TranslationsPagesVicinityAlertsEn {
	_TranslationsPagesVicinityAlertsFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'vicinity alerts';
}

// Path: pages.precall
class _TranslationsPagesPrecallFr implements TranslationsPagesPrecallEn {
	_TranslationsPagesPrecallFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'starting a call to';
	@override String get calling_in => 'calling in';
}

// Path: pages.theme_selector
class _TranslationsPagesThemeSelectorFr implements TranslationsPagesThemeSelectorEn {
	_TranslationsPagesThemeSelectorFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'theme preferences';
}

// Path: pages.about
class _TranslationsPagesAboutFr implements TranslationsPagesAboutEn {
	_TranslationsPagesAboutFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'about';
	@override late final _TranslationsPagesAboutHeaderFr header = _TranslationsPagesAboutHeaderFr._(_root);
	@override late final _TranslationsPagesAboutSupportSectionFr support_section = _TranslationsPagesAboutSupportSectionFr._(_root);
	@override late final _TranslationsPagesAboutOtherSectionFr other_section = _TranslationsPagesAboutOtherSectionFr._(_root);
}

// Path: pages.settings
class _TranslationsPagesSettingsFr implements TranslationsPagesSettingsEn {
	_TranslationsPagesSettingsFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'settings';
	@override late final _TranslationsPagesSettingsSectionFeatureFr section_feature = _TranslationsPagesSettingsSectionFeatureFr._(_root);
	@override late final _TranslationsPagesSettingsSectionApplicationFr section_application = _TranslationsPagesSettingsSectionApplicationFr._(_root);
}

// Path: messages.error
class _TranslationsMessagesErrorFr implements TranslationsMessagesErrorEn {
	_TranslationsMessagesErrorFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get cannot_load_data => 'looks like something went wrong and we couldn\'t load the data.';
	@override String services_unavailable({required Object app_name_short}) => 'looks like no services are available. Make sure you are connected to the internet the first time for ${app_name_short} to download the services.';
	@override String get cannot_load_cyclone_report => 'looks like something went wrong and we couldn\'t load the cyclone report.';
	@override String get cannot_load_cyclone_names => 'an error occurred while fetching the cyclone names.';
	@override String get cannot_load_cyclone_guidelines => 'an error occurred while fetching the cyclone guidelines.';
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
	@override String get loading_component => 'loading...';
	@override String get unknown_component => 'unknown';
	@override String get no_match_for_query => 'ooops, your query didn\'t match any services. Try something else?';
	@override String get other_contacts => 'no other contacts';
	@override String get no_other_contacts => 'no other contacts';
}

// Path: components.search_bar
class _TranslationsComponentsSearchBarFr implements TranslationsComponentsSearchBarEn {
	_TranslationsComponentsSearchBarFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String title({required Object app_name_short}) => 'welcome to ${app_name_short}';
	@override String get subtitle => 'what do you need help with ?';
}

// Path: pages.welcome.header
class _TranslationsPagesWelcomeHeaderFr implements TranslationsPagesWelcomeHeaderEn {
	_TranslationsPagesWelcomeHeaderFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'welcome to';
}

// Path: pages.welcome.carousel
class _TranslationsPagesWelcomeCarouselFr implements TranslationsPagesWelcomeCarouselEn {
	_TranslationsPagesWelcomeCarouselFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title_1 => 'services list';
	@override String get subtitle_1 => 'get a list of all emergency and non-emergency services for Mauritius right in your phone.';
	@override String get title_2 => 'cyclone alerts';
	@override String get subtitle_2 => 'get notified of cyclone warnings and read the cyclone guidelines live from your phone.';
	@override String get title_3 => 'emergency actions';
	@override String get subtitle_3 => 'get a dedicated corder on your dashboard just for emergency services.';
	@override String get title_4 => 'sos';
	@override String get subtitle_4 => 'call for urgent help right from the app using the big red button.';
	@override String get title_5 => 'offline availability';
	@override String get subtitle_5 => 'connect once to the internet and get all your services available to you offline.';
}

// Path: pages.welcome.permissions_dialog
class _TranslationsPagesWelcomePermissionsDialogFr implements TranslationsPagesWelcomePermissionsDialogEn {
	_TranslationsPagesWelcomePermissionsDialogFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String primary_text({required Object app_name_short}) => '${app_name_short} needs permission to proceed';
	@override String get secondary_text => 'to provide the best experience, the app requires permission to perform phone calls for you, as this is its main feature.';
	@override String get tertiary_text => 'we also request notification access to keep you informed and up to date.';
	@override String get quaternary_text => 'please grant these permissions to continue using the app seamlessly. If it doesn\'t work, then you\'ll need to do it manually in the settings.';
}

// Path: pages.cyclone.warning
class _TranslationsPagesCycloneWarningFr implements TranslationsPagesCycloneWarningEn {
	_TranslationsPagesCycloneWarningFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Mauritius is currently in';
	@override String subtitle({required Object level}) => 'class ${level}';
	@override String get next_bulletin_title => 'next bulletin';
	@override String get latest_news_title => 'latest news';
}

// Path: pages.cyclone.names
class _TranslationsPagesCycloneNamesFr implements TranslationsPagesCycloneNamesEn {
	_TranslationsPagesCycloneNamesFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'cyclone names';
	@override String get table_header_name => 'name';
	@override String get table_header_gender => 'gender';
	@override String get table_header_provided_by => 'provided by';
}

// Path: pages.cyclone.guidelines
class _TranslationsPagesCycloneGuidelinesFr implements TranslationsPagesCycloneGuidelinesEn {
	_TranslationsPagesCycloneGuidelinesFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String title({required Object level}) => 'guidelines for class ${level}';
	@override String get header_precautions_title => 'precautions';
}

// Path: pages.about.header
class _TranslationsPagesAboutHeaderFr implements TranslationsPagesAboutHeaderEn {
	_TranslationsPagesAboutHeaderFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'about';
	@override String get developer_name => 'mervin hemaraju';
	@override String get developer_title => 'lead developer & designer';
	@override String get designer_name => 'nick foo kune';
	@override String get designer_title => 'playstore banner & images';
	@override String get caption => 'developed with ❤ in 🇲🇺';
}

// Path: pages.about.support_section
class _TranslationsPagesAboutSupportSectionFr implements TranslationsPagesAboutSupportSectionEn {
	_TranslationsPagesAboutSupportSectionFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'support';
	@override String rate_app_title({required Object app_name_short}) => 'rate ${app_name_short}';
	@override String get rate_app_subtitle => 'if you love the app, let us know in the Google Play Store and we can make it even better.';
	@override String share_app_title({required Object app_name_short}) => 'share ${app_name_short}';
	@override String share_app_subtitle({required Object app_name_short}) => 'do not forget to share ${app_name_short} with your friends and families.';
}

// Path: pages.about.other_section
class _TranslationsPagesAboutOtherSectionFr implements TranslationsPagesAboutOtherSectionEn {
	_TranslationsPagesAboutOtherSectionFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'other';
	@override String about_app_title({required Object app_name_short}) => 'about ${app_name_short}';
	@override String get about_app_subtitle => 'check us out on our official website.';
	@override String get developer_api_title => 'developer API';
	@override String developer_api_subtitle({required Object app_name_short}) => 'Application Program Interface (API) used in ${app_name_short}.';
	@override String get privacy_policy_title => 'privacy policy';
	@override String privacy_policy_subtitle({required Object app_name_short}) => 'view the privacy policy for ${app_name_short}.';
	@override String get version_title => 'version';
}

// Path: pages.settings.section_feature
class _TranslationsPagesSettingsSectionFeatureFr implements TranslationsPagesSettingsSectionFeatureEn {
	_TranslationsPagesSettingsSectionFeatureFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'feature';
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
	@override String get sheet_title => 'choose Emergency Action';
	@override String get tile_title => 'emergency button action';
	@override String get tile_subtitle => 'set an emergency service for the red button';
}

// Path: pages.settings.section_application.change_language
class _TranslationsPagesSettingsSectionApplicationChangeLanguageFr implements TranslationsPagesSettingsSectionApplicationChangeLanguageEn {
	_TranslationsPagesSettingsSectionApplicationChangeLanguageFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get sheet_title => 'choose language';
	@override String get tile_title => 'change language';
	@override String get tile_subtitle => 'change your app\'s language';
}

/// Flat map(s) containing all translations.
/// Only for edge cases! For simple maps, use the map function of this library.
extension on TranslationsFr {
	dynamic _flatMapFunction(String path) {
		switch (path) {
			case 'app.name': return 'mauritius emergency services';
			case 'app.short_name': return 'mes';
			case 'pages.welcome.title': return 'welcome';
			case 'pages.welcome.header.title': return 'welcome to';
			case 'pages.welcome.carousel.title_1': return 'services list';
			case 'pages.welcome.carousel.subtitle_1': return 'get a list of all emergency and non-emergency services for Mauritius right in your phone.';
			case 'pages.welcome.carousel.title_2': return 'cyclone alerts';
			case 'pages.welcome.carousel.subtitle_2': return 'get notified of cyclone warnings and read the cyclone guidelines live from your phone.';
			case 'pages.welcome.carousel.title_3': return 'emergency actions';
			case 'pages.welcome.carousel.subtitle_3': return 'get a dedicated corder on your dashboard just for emergency services.';
			case 'pages.welcome.carousel.title_4': return 'sos';
			case 'pages.welcome.carousel.subtitle_4': return 'call for urgent help right from the app using the big red button.';
			case 'pages.welcome.carousel.title_5': return 'offline availability';
			case 'pages.welcome.carousel.subtitle_5': return 'connect once to the internet and get all your services available to you offline.';
			case 'pages.welcome.permissions_dialog.primary_text': return ({required Object app_name_short}) => '${app_name_short} needs permission to proceed';
			case 'pages.welcome.permissions_dialog.secondary_text': return 'to provide the best experience, the app requires permission to perform phone calls for you, as this is its main feature.';
			case 'pages.welcome.permissions_dialog.tertiary_text': return 'we also request notification access to keep you informed and up to date.';
			case 'pages.welcome.permissions_dialog.quaternary_text': return 'please grant these permissions to continue using the app seamlessly. If it doesn\'t work, then you\'ll need to do it manually in the settings.';
			case 'pages.home.title': return 'home';
			case 'pages.home.primary_title': return 'emergency help needed?';
			case 'pages.home.primary_subtitle': return 'hold the emergency button to call';
			case 'pages.home.secondary_title': return 'need other quick emergency actions?';
			case 'pages.home.secondary_subtitle': return 'click any one below to call';
			case 'pages.services.title': return 'services';
			case 'pages.cyclone.title': return 'cyclone report';
			case 'pages.cyclone.no_warning': return 'there\'s currently no cyclone warning in Mauritius';
			case 'pages.cyclone.warning.title': return 'Mauritius is currently in';
			case 'pages.cyclone.warning.subtitle': return ({required Object level}) => 'class ${level}';
			case 'pages.cyclone.warning.next_bulletin_title': return 'next bulletin';
			case 'pages.cyclone.warning.latest_news_title': return 'latest news';
			case 'pages.cyclone.names.title': return 'cyclone names';
			case 'pages.cyclone.names.table_header_name': return 'name';
			case 'pages.cyclone.names.table_header_gender': return 'gender';
			case 'pages.cyclone.names.table_header_provided_by': return 'provided by';
			case 'pages.cyclone.guidelines.title': return ({required Object level}) => 'guidelines for class ${level}';
			case 'pages.cyclone.guidelines.header_precautions_title': return 'precautions';
			case 'pages.vicinity_alerts.title': return 'vicinity alerts';
			case 'pages.precall.title': return 'starting a call to';
			case 'pages.precall.calling_in': return 'calling in';
			case 'pages.theme_selector.title': return 'theme preferences';
			case 'pages.about.title': return 'about';
			case 'pages.about.header.title': return 'about';
			case 'pages.about.header.developer_name': return 'mervin hemaraju';
			case 'pages.about.header.developer_title': return 'lead developer & designer';
			case 'pages.about.header.designer_name': return 'nick foo kune';
			case 'pages.about.header.designer_title': return 'playstore banner & images';
			case 'pages.about.header.caption': return 'developed with ❤ in 🇲🇺';
			case 'pages.about.support_section.title': return 'support';
			case 'pages.about.support_section.rate_app_title': return ({required Object app_name_short}) => 'rate ${app_name_short}';
			case 'pages.about.support_section.rate_app_subtitle': return 'if you love the app, let us know in the Google Play Store and we can make it even better.';
			case 'pages.about.support_section.share_app_title': return ({required Object app_name_short}) => 'share ${app_name_short}';
			case 'pages.about.support_section.share_app_subtitle': return ({required Object app_name_short}) => 'do not forget to share ${app_name_short} with your friends and families.';
			case 'pages.about.other_section.title': return 'other';
			case 'pages.about.other_section.about_app_title': return ({required Object app_name_short}) => 'about ${app_name_short}';
			case 'pages.about.other_section.about_app_subtitle': return 'check us out on our official website.';
			case 'pages.about.other_section.developer_api_title': return 'developer API';
			case 'pages.about.other_section.developer_api_subtitle': return ({required Object app_name_short}) => 'Application Program Interface (API) used in ${app_name_short}.';
			case 'pages.about.other_section.privacy_policy_title': return 'privacy policy';
			case 'pages.about.other_section.privacy_policy_subtitle': return ({required Object app_name_short}) => 'view the privacy policy for ${app_name_short}.';
			case 'pages.about.other_section.version_title': return 'version';
			case 'pages.settings.title': return 'settings';
			case 'pages.settings.section_feature.title': return 'feature';
			case 'pages.settings.section_feature.emergency_button_action.sheet_title': return 'choose Emergency Action';
			case 'pages.settings.section_feature.emergency_button_action.tile_title': return 'emergency button action';
			case 'pages.settings.section_feature.emergency_button_action.tile_subtitle': return 'set an emergency service for the red button';
			case 'pages.settings.section_application.title': return 'application';
			case 'pages.settings.section_application.change_language.sheet_title': return 'choose language';
			case 'pages.settings.section_application.change_language.tile_title': return 'change language';
			case 'pages.settings.section_application.change_language.tile_subtitle': return 'change your app\'s language';
			case 'messages.error.cannot_load_data': return 'looks like something went wrong and we couldn\'t load the data.';
			case 'messages.error.services_unavailable': return ({required Object app_name_short}) => 'looks like no services are available. Make sure you are connected to the internet the first time for ${app_name_short} to download the services.';
			case 'messages.error.cannot_load_cyclone_report': return 'looks like something went wrong and we couldn\'t load the cyclone report.';
			case 'messages.error.cannot_load_cyclone_names': return 'an error occurred while fetching the cyclone names.';
			case 'messages.error.cannot_load_cyclone_guidelines': return 'an error occurred while fetching the cyclone guidelines.';
			case 'messages.info.loading_component': return 'loading...';
			case 'messages.info.unknown_component': return 'unknown';
			case 'messages.info.no_match_for_query': return 'ooops, your query didn\'t match any services. Try something else?';
			case 'messages.info.other_contacts': return 'no other contacts';
			case 'messages.info.no_other_contacts': return 'no other contacts';
			case 'components.search_bar.title': return ({required Object app_name_short}) => 'welcome to ${app_name_short}';
			case 'components.search_bar.subtitle': return 'what do you need help with ?';
			case 'actions.proceed': return 'proceed';
			case 'actions.cancel': return 'cancel';
			case 'actions.close': return 'close';
			case 'actions.slide_to_cancel': return 'slide to cancel';
			case 'actions.get_started': return 'get started';
			case 'actions.contact_us': return 'contact us';
			case 'actions.coming_soon': return 'coming soon';
			case 'actions.toll_free': return 'toll free';
			case 'actions.retry': return 'retry';
			case 'others.hour_abbr': return 'hr';
			case 'others.minute_abbr': return 'min';
			case 'others.ooops': return 'ooops!';
			default: return null;
		}
	}
}

