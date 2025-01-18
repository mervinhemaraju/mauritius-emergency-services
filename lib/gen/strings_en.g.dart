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
	late final TranslationsPagesHomeEn home = TranslationsPagesHomeEn._(_root);
	late final TranslationsPagesAboutEn about = TranslationsPagesAboutEn._(_root);
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

// Path: actions
class TranslationsActionsEn {
	TranslationsActionsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
}

// Path: others
class TranslationsOthersEn {
	TranslationsOthersEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
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

// Path: messages.error
class TranslationsMessagesErrorEn {
	TranslationsMessagesErrorEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get cannot_load_data => 'looks like something went wrong and we couldn\'t load the data.';
	String get services_unavailable => 'looks like no services are available. Make sure you are connected to the internet the first time for MES to download the services.';
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

/// Flat map(s) containing all translations.
/// Only for edge cases! For simple maps, use the map function of this library.
extension on Translations {
	dynamic _flatMapFunction(String path) {
		switch (path) {
			case 'app.name': return 'mauritius emergency services';
			case 'app.short_name': return 'mes';
			case 'pages.home.title': return 'home';
			case 'pages.home.primary_title': return 'emergency help needed?';
			case 'pages.home.primary_subtitle': return 'hold the emergency button to call';
			case 'pages.home.secondary_title': return 'need other quick emergency actions?';
			case 'pages.home.secondary_subtitle': return 'click any one below to call';
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
			case 'messages.error.cannot_load_data': return 'looks like something went wrong and we couldn\'t load the data.';
			case 'messages.error.services_unavailable': return 'looks like no services are available. Make sure you are connected to the internet the first time for MES to download the services.';
			case 'messages.info.loading_component': return 'loading...';
			case 'messages.info.unknown_component': return 'unknown';
			default: return null;
		}
	}
}

