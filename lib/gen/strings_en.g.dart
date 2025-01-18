///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import

part of 'strings.g.dart';

// Path: <root>
typedef TranslationsEn = Translations; // ignore: unused_element
class Translations implements BaseTranslations<AppLocale, Translations> {
	/// Returns the current translations of the given [context].
	///
	/// Usage:
	/// final t = Translations.of(context);
	static Translations of(BuildContext context) => InheritedLocaleData.of<AppLocale, Translations>(context).translations;

	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	Translations({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver})
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
	dynamic operator[](String key) => $meta.getTranslation(key);

	late final Translations _root = this; // ignore: unused_field

	// Translations
	late final TranslationsAppEn app = TranslationsAppEn._(_root);
	late final TranslationsPagesEn pages = TranslationsPagesEn._(_root);
	late final TranslationsMessagesEn messages = TranslationsMessagesEn._(_root);
	late final TranslationsComponentsEn components = TranslationsComponentsEn._(_root);
	late final TranslationsActionsEn actions = TranslationsActionsEn._(_root);
	late final TranslationsOthersEn others = TranslationsOthersEn._(_root);
}

// Path: app
class TranslationsAppEn {
	TranslationsAppEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get name => 'mauritius emergency services';
	String get short_name => 'mes';
}

// Path: pages
class TranslationsPagesEn {
	TranslationsPagesEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final TranslationsPagesWelcomeEn welcome = TranslationsPagesWelcomeEn._(_root);
	late final TranslationsPagesHomeEn home = TranslationsPagesHomeEn._(_root);
	late final TranslationsPagesServicesEn services = TranslationsPagesServicesEn._(_root);
	late final TranslationsPagesCycloneEn cyclone = TranslationsPagesCycloneEn._(_root);
	late final TranslationsPagesVicinityAlertsEn vicinity_alerts = TranslationsPagesVicinityAlertsEn._(_root);
	late final TranslationsPagesPrecallEn precall = TranslationsPagesPrecallEn._(_root);
	late final TranslationsPagesThemeSelectorEn theme_selector = TranslationsPagesThemeSelectorEn._(_root);
	late final TranslationsPagesAboutEn about = TranslationsPagesAboutEn._(_root);
	late final TranslationsPagesSettingsEn settings = TranslationsPagesSettingsEn._(_root);
}

// Path: messages
class TranslationsMessagesEn {
	TranslationsMessagesEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final TranslationsMessagesErrorEn error = TranslationsMessagesErrorEn._(_root);
	late final TranslationsMessagesSuccessEn success = TranslationsMessagesSuccessEn._(_root);
	late final TranslationsMessagesInfoEn info = TranslationsMessagesInfoEn._(_root);
}

// Path: components
class TranslationsComponentsEn {
	TranslationsComponentsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final TranslationsComponentsSearchBarEn search_bar = TranslationsComponentsSearchBarEn._(_root);
}

// Path: actions
class TranslationsActionsEn {
	TranslationsActionsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get proceed => 'proceed';
	String get cancel => 'cancel';
	String get close => 'close';
	String get slide_to_cancel => 'slide to cancel';
	String get get_started => 'get started';
	String get contact_us => 'contact us';
	String get coming_soon => 'coming soon';
	String get toll_free => 'toll free';
	String get retry => 'retry';
}

// Path: others
class TranslationsOthersEn {
	TranslationsOthersEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get hour_abbr => 'hr';
	String get minute_abbr => 'min';
	String get ooops => 'ooops!';
}

// Path: pages.welcome
class TranslationsPagesWelcomeEn {
	TranslationsPagesWelcomeEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'welcome';
	late final TranslationsPagesWelcomeHeaderEn header = TranslationsPagesWelcomeHeaderEn._(_root);
	late final TranslationsPagesWelcomeCarouselEn carousel = TranslationsPagesWelcomeCarouselEn._(_root);
	late final TranslationsPagesWelcomePermissionsDialogEn permissions_dialog = TranslationsPagesWelcomePermissionsDialogEn._(_root);
}

// Path: pages.home
class TranslationsPagesHomeEn {
	TranslationsPagesHomeEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'home';
	String get primary_title => 'emergency help needed?';
	String get primary_subtitle => 'hold the emergency button to call';
	String get secondary_title => 'need other quick emergency actions?';
	String get secondary_subtitle => 'click any one below to call';
}

// Path: pages.services
class TranslationsPagesServicesEn {
	TranslationsPagesServicesEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'services';
}

// Path: pages.cyclone
class TranslationsPagesCycloneEn {
	TranslationsPagesCycloneEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'cyclone report';
	String get no_warning => 'there\'s currently no cyclone warning in Mauritius';
	late final TranslationsPagesCycloneWarningEn warning = TranslationsPagesCycloneWarningEn._(_root);
	late final TranslationsPagesCycloneNamesEn names = TranslationsPagesCycloneNamesEn._(_root);
	late final TranslationsPagesCycloneGuidelinesEn guidelines = TranslationsPagesCycloneGuidelinesEn._(_root);
}

// Path: pages.vicinity_alerts
class TranslationsPagesVicinityAlertsEn {
	TranslationsPagesVicinityAlertsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'vicinity alerts';
}

// Path: pages.precall
class TranslationsPagesPrecallEn {
	TranslationsPagesPrecallEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'starting a call to';
	String get calling_in => 'calling in';
}

// Path: pages.theme_selector
class TranslationsPagesThemeSelectorEn {
	TranslationsPagesThemeSelectorEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'theme preferences';
}

// Path: pages.about
class TranslationsPagesAboutEn {
	TranslationsPagesAboutEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'about';
	late final TranslationsPagesAboutHeaderEn header = TranslationsPagesAboutHeaderEn._(_root);
	late final TranslationsPagesAboutSupportSectionEn support_section = TranslationsPagesAboutSupportSectionEn._(_root);
	late final TranslationsPagesAboutOtherSectionEn other_section = TranslationsPagesAboutOtherSectionEn._(_root);
}

// Path: pages.settings
class TranslationsPagesSettingsEn {
	TranslationsPagesSettingsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'settings';
	late final TranslationsPagesSettingsSectionFeatureEn section_feature = TranslationsPagesSettingsSectionFeatureEn._(_root);
	late final TranslationsPagesSettingsSectionApplicationEn section_application = TranslationsPagesSettingsSectionApplicationEn._(_root);
}

// Path: messages.error
class TranslationsMessagesErrorEn {
	TranslationsMessagesErrorEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get cannot_load_data => 'looks like something went wrong and we couldn\'t load the data.';
	String services_unavailable({required Object app_name_short}) => 'looks like no services are available. Make sure you are connected to the internet the first time for ${app_name_short} to download the services.';
	String get cannot_load_cyclone_report => 'looks like something went wrong and we couldn\'t load the cyclone report.';
	String get cannot_load_cyclone_names => 'an error occurred while fetching the cyclone names.';
	String get cannot_load_cyclone_guidelines => 'an error occurred while fetching the cyclone guidelines.';
}

// Path: messages.success
class TranslationsMessagesSuccessEn {
	TranslationsMessagesSuccessEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
}

// Path: messages.info
class TranslationsMessagesInfoEn {
	TranslationsMessagesInfoEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get loading_component => 'loading...';
	String get unknown_component => 'unknown';
	String get no_match_for_query => 'ooops, your query didn\'t match any services. Try something else?';
	String get other_contacts => 'no other contacts';
	String get no_other_contacts => 'no other contacts';
}

// Path: components.search_bar
class TranslationsComponentsSearchBarEn {
	TranslationsComponentsSearchBarEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String title({required Object app_name_short}) => 'welcome to ${app_name_short}';
	String get subtitle => 'what do you need help with ?';
}

// Path: pages.welcome.header
class TranslationsPagesWelcomeHeaderEn {
	TranslationsPagesWelcomeHeaderEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'welcome to';
}

// Path: pages.welcome.carousel
class TranslationsPagesWelcomeCarouselEn {
	TranslationsPagesWelcomeCarouselEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title_1 => 'services list';
	String get subtitle_1 => 'get a list of all emergency and non-emergency services for Mauritius right in your phone.';
	String get title_2 => 'cyclone alerts';
	String get subtitle_2 => 'get notified of cyclone warnings and read the cyclone guidelines live from your phone.';
	String get title_3 => 'emergency actions';
	String get subtitle_3 => 'get a dedicated corder on your dashboard just for emergency services.';
	String get title_4 => 'sos';
	String get subtitle_4 => 'call for urgent help right from the app using the big red button.';
	String get title_5 => 'offline availability';
	String get subtitle_5 => 'connect once to the internet and get all your services available to you offline.';
}

// Path: pages.welcome.permissions_dialog
class TranslationsPagesWelcomePermissionsDialogEn {
	TranslationsPagesWelcomePermissionsDialogEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String primary_text({required Object app_name_short}) => '${app_name_short} needs permission to proceed';
	String get secondary_text => 'to provide the best experience, the app requires permission to perform phone calls for you, as this is its main feature.';
	String get tertiary_text => 'we also request notification access to keep you informed and up to date.';
	String get quaternary_text => 'please grant these permissions to continue using the app seamlessly. If it doesn\'t work, then you\'ll need to do it manually in the settings.';
}

// Path: pages.cyclone.warning
class TranslationsPagesCycloneWarningEn {
	TranslationsPagesCycloneWarningEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Mauritius is currently in';
	String subtitle({required Object level}) => 'class ${level}';
	String get next_bulletin_title => 'next bulletin';
	String get latest_news_title => 'latest news';
}

// Path: pages.cyclone.names
class TranslationsPagesCycloneNamesEn {
	TranslationsPagesCycloneNamesEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'cyclone names';
	String get table_header_name => 'name';
	String get table_header_gender => 'gender';
	String get table_header_provided_by => 'provided by';
}

// Path: pages.cyclone.guidelines
class TranslationsPagesCycloneGuidelinesEn {
	TranslationsPagesCycloneGuidelinesEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String title({required Object level}) => 'guidelines for class ${level}';
	String get header_precautions_title => 'precautions';
}

// Path: pages.about.header
class TranslationsPagesAboutHeaderEn {
	TranslationsPagesAboutHeaderEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'about';
	String get developer_name => 'mervin hemaraju';
	String get developer_title => 'lead developer & designer';
	String get designer_name => 'nick foo kune';
	String get designer_title => 'playstore banner & images';
	String get caption => 'developed with ❤ in 🇲🇺';
}

// Path: pages.about.support_section
class TranslationsPagesAboutSupportSectionEn {
	TranslationsPagesAboutSupportSectionEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'support';
	String rate_app_title({required Object app_name_short}) => 'rate ${app_name_short}';
	String get rate_app_subtitle => 'if you love the app, let us know in the Google Play Store and we can make it even better.';
	String share_app_title({required Object app_name_short}) => 'share ${app_name_short}';
	String share_app_subtitle({required Object app_name_short}) => 'do not forget to share ${app_name_short} with your friends and families.';
}

// Path: pages.about.other_section
class TranslationsPagesAboutOtherSectionEn {
	TranslationsPagesAboutOtherSectionEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'other';
	String about_app_title({required Object app_name_short}) => 'about ${app_name_short}';
	String get about_app_subtitle => 'check us out on our official website.';
	String get developer_api_title => 'developer API';
	String developer_api_subtitle({required Object app_name_short}) => 'Application Program Interface (API) used in ${app_name_short}.';
	String get privacy_policy_title => 'privacy policy';
	String privacy_policy_subtitle({required Object app_name_short}) => 'view the privacy policy for ${app_name_short}.';
	String get version_title => 'version';
}

// Path: pages.settings.section_feature
class TranslationsPagesSettingsSectionFeatureEn {
	TranslationsPagesSettingsSectionFeatureEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'feature';
	late final TranslationsPagesSettingsSectionFeatureEmergencyButtonActionEn emergency_button_action = TranslationsPagesSettingsSectionFeatureEmergencyButtonActionEn._(_root);
}

// Path: pages.settings.section_application
class TranslationsPagesSettingsSectionApplicationEn {
	TranslationsPagesSettingsSectionApplicationEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'application';
	late final TranslationsPagesSettingsSectionApplicationChangeLanguageEn change_language = TranslationsPagesSettingsSectionApplicationChangeLanguageEn._(_root);
}

// Path: pages.settings.section_feature.emergency_button_action
class TranslationsPagesSettingsSectionFeatureEmergencyButtonActionEn {
	TranslationsPagesSettingsSectionFeatureEmergencyButtonActionEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get sheet_title => 'choose Emergency Action';
	String get tile_title => 'emergency button action';
	String get tile_subtitle => 'set an emergency service for the red button';
}

// Path: pages.settings.section_application.change_language
class TranslationsPagesSettingsSectionApplicationChangeLanguageEn {
	TranslationsPagesSettingsSectionApplicationChangeLanguageEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get sheet_title => 'choose language';
	String get tile_title => 'change language';
	String get tile_subtitle => 'change your app\'s language';
}

/// Flat map(s) containing all translations.
/// Only for edge cases! For simple maps, use the map function of this library.
extension on Translations {
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

