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
	@override late final _TranslationsPagesFr pages = _TranslationsPagesFr._(_root);
	@override late final _TranslationsActionsFr actions = _TranslationsActionsFr._(_root);
	@override late final _TranslationsOthersFr others = _TranslationsOthersFr._(_root);
}

// Path: pages
class _TranslationsPagesFr implements TranslationsPagesEn {
	_TranslationsPagesFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsPagesHomeFr home = _TranslationsPagesHomeFr._(_root);
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
	@override String get primary_title => 'urgence help needed?';
	@override String get primary_subtitle => 'hold the emergency button to call';
	@override String get secondary_title => 'need other quick emergency actions?';
	@override String get secondary_subtitle => 'click any one below to call';
}

/// Flat map(s) containing all translations.
/// Only for edge cases! For simple maps, use the map function of this library.
extension on TranslationsFr {
	dynamic _flatMapFunction(String path) {
		switch (path) {
			case 'pages.home.primary_title': return 'urgence help needed?';
			case 'pages.home.primary_subtitle': return 'hold the emergency button to call';
			case 'pages.home.secondary_title': return 'need other quick emergency actions?';
			case 'pages.home.secondary_subtitle': return 'click any one below to call';
			default: return null;
		}
	}
}

