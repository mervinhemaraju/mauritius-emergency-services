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
	late final TranslationsPagesEn pages = TranslationsPagesEn._(_root);
	late final TranslationsActionsEn actions = TranslationsActionsEn._(_root);
	late final TranslationsOthersEn others = TranslationsOthersEn._(_root);
}

// Path: pages
class TranslationsPagesEn {
	TranslationsPagesEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final TranslationsPagesHomeEn home = TranslationsPagesHomeEn._(_root);
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
	String get primary_title => 'emergency help needed?';
	String get primary_subtitle => 'hold the emergency button to call';
	String get secondary_title => 'need other quick emergency actions?';
	String get secondary_subtitle => 'click any one below to call';
}

/// Flat map(s) containing all translations.
/// Only for edge cases! For simple maps, use the map function of this library.
extension on Translations {
	dynamic _flatMapFunction(String path) {
		switch (path) {
			case 'pages.home.primary_title': return 'emergency help needed?';
			case 'pages.home.primary_subtitle': return 'hold the emergency button to call';
			case 'pages.home.secondary_title': return 'need other quick emergency actions?';
			case 'pages.home.secondary_subtitle': return 'click any one below to call';
			default: return null;
		}
	}
}

