///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import

part of 'strings.g.dart';

// Path: <root>
typedef TranslationsEn = Translations; // ignore: unused_element
class Translations implements BaseTranslations<AppLocale, Translations> {
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
	String get appName => 'Calculator';
	String get history => 'History';
	String get about => 'About';
	String get undefined => 'Undefined';
	String get malformedExpression => 'Malformed Expression';
	String get emptyHistory => 'No History';
	String get clearHistory => 'Clear History';
	String get clearHistoryDescription => 'All calculations will be deleted. This action cannot be undone.';
}

/// Flat map(s) containing all translations.
/// Only for edge cases! For simple maps, use the map function of this library.
extension on Translations {
	dynamic _flatMapFunction(String path) {
		switch (path) {
			case 'appName': return 'Calculator';
			case 'history': return 'History';
			case 'about': return 'About';
			case 'undefined': return 'Undefined';
			case 'malformedExpression': return 'Malformed Expression';
			case 'emptyHistory': return 'No History';
			case 'clearHistory': return 'Clear History';
			case 'clearHistoryDescription': return 'All calculations will be deleted. This action cannot be undone.';
			default: return null;
		}
	}
}

