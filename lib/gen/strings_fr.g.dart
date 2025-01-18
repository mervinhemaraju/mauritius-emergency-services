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
	@override late final _TranslationsPagesHomeFr home = _TranslationsPagesHomeFr._(_root);
	@override late final _TranslationsPagesAboutFr about = _TranslationsPagesAboutFr._(_root);
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

// Path: actions
class _TranslationsActionsFr implements TranslationsActionsEn {
	_TranslationsActionsFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
}

// Path: others
class _TranslationsOthersFr implements TranslationsOthersEn {
	_TranslationsOthersFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
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

// Path: messages.error
class _TranslationsMessagesErrorFr implements TranslationsMessagesErrorEn {
	_TranslationsMessagesErrorFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get cannot_load_data => 'looks like something went wrong and we couldn\'t load the data.';
	@override String get services_unavailable => 'looks like no services are available. Make sure you are connected to the internet the first time for MES to download the services.';
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

/// Flat map(s) containing all translations.
/// Only for edge cases! For simple maps, use the map function of this library.
extension on TranslationsFr {
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

