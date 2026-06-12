///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import
// dart format off

part of 'strings.g.dart';

// Path: <root>
typedef TranslationsEn = Translations; // ignore: unused_element
class Translations with BaseTranslations<AppLocale, Translations> {
	/// Returns the current translations of the given [context].
	///
	/// Usage:
	/// final t = Translations.of(context);
	static Translations of(BuildContext context) => InheritedLocaleData.of<AppLocale, Translations>(context).translations;

	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	Translations({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = meta ?? TranslationMetadata(
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

	Translations $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => Translations(meta: meta ?? this.$meta);

	// Translations
	late final Translations$app$en app = Translations$app$en.internal(_root);
	late final Translations$navigation$en navigation = Translations$navigation$en.internal(_root);
	late final Translations$onboarding$en onboarding = Translations$onboarding$en.internal(_root);
	late final Translations$paywall$en paywall = Translations$paywall$en.internal(_root);
	late final Translations$home$en home = Translations$home$en.internal(_root);
	late final Translations$errors$en errors = Translations$errors$en.internal(_root);
}

// Path: app
class Translations$app$en {
	Translations$app$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'AI Paywall Demo'
	String get title => 'AI Paywall Demo';

	/// en: 'Preparing your subscription'
	String get loading => 'Preparing your subscription';
}

// Path: navigation
class Translations$navigation$en {
	Translations$navigation$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Page not found'
	String get notFoundTitle => 'Page not found';

	/// en: 'This screen is not available in the demo.'
	String get notFoundBody => 'This screen is not available in the demo.';

	/// en: 'Back to start'
	String get backToStart => 'Back to start';
}

// Path: onboarding
class Translations$onboarding$en {
	Translations$onboarding$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Build premium access locally'
	String get title => 'Build premium access locally';

	/// en: 'A compact demo of onboarding, a paywall, entitlement storage, and protected content.'
	String get subtitle => 'A compact demo of onboarding, a paywall, entitlement storage, and protected content.';

	/// en: 'Local billing simulation'
	String get screenOneTitle => 'Local billing simulation';

	/// en: 'Plans, purchases, receipts, and entitlement validation are modeled without a store SDK.'
	String get screenOneBody => 'Plans, purchases, receipts, and entitlement validation are modeled without a store SDK.';

	/// en: 'Secure entitlement state'
	String get screenTwoTitle => 'Secure entitlement state';

	/// en: 'The subscription receipt is stored in secure storage and checked again at launch.'
	String get screenTwoBody => 'The subscription receipt is stored in secure storage and checked again at launch.';

	/// en: 'Continue'
	String get continueButton => 'Continue';
}

// Path: paywall
class Translations$paywall$en {
	Translations$paywall$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Unlock the premium demo'
	String get title => 'Unlock the premium demo';

	/// en: 'Choose a local subscription plan. Purchases are emulated and saved only on this device.'
	String get subtitle => 'Choose a local subscription plan. Purchases are emulated and saved only on this device.';

	/// en: 'Monthly'
	String get monthlyTitle => 'Monthly';

	/// en: 'Flexible access for a focused review.'
	String get monthlyDescription => 'Flexible access for a focused review.';

	/// en: '4.99 USD'
	String get monthlyPrice => '4.99 USD';

	/// en: 'per month'
	String get monthlyPeriod => 'per month';

	/// en: 'Yearly'
	String get yearlyTitle => 'Yearly';

	/// en: 'Best value for long-running demo access.'
	String get yearlyDescription => 'Best value for long-running demo access.';

	/// en: '39.99 USD'
	String get yearlyPrice => '39.99 USD';

	/// en: 'per year'
	String get yearlyPeriod => 'per year';

	/// en: 'Best value - save 33%'
	String get yearlyBadge => 'Best value - save 33%';

	/// en: 'Continue'
	String get continueButton => 'Continue';

	/// en: 'Creating local receipt...'
	String get purchaseLoading => 'Creating local receipt...';

	/// en: 'Could not load subscription plans.'
	String get loadFailure => 'Could not load subscription plans.';

	/// en: 'Purchase could not be completed.'
	String get purchaseFailure => 'Purchase could not be completed.';

	/// en: 'Demo billing only. No App Store or Google Play charge is made.'
	String get legal => 'Demo billing only. No App Store or Google Play charge is made.';
}

// Path: home
class Translations$home$en {
	Translations$home$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Premium Home'
	String get title => 'Premium Home';

	/// en: 'Your local entitlement is active. This screen is protected by the billing domain.'
	String get welcome => 'Your local entitlement is active. This screen is protected by the billing domain.';

	/// en: 'Subscription'
	String get subscription => 'Subscription';

	/// en: 'Expires'
	String get expires => 'Expires';

	/// en: 'Receipt'
	String get receipt => 'Receipt';

	/// en: 'Included in this demo'
	String get featuresTitle => 'Included in this demo';

	/// en: 'Protected launch routing'
	String get featureOne => 'Protected launch routing';

	/// en: 'Secure entitlement persistence'
	String get featureTwo => 'Secure entitlement persistence';

	/// en: 'Receipt and expiration validation'
	String get featureThree => 'Receipt and expiration validation';

	/// en: 'Clean billing repository boundary'
	String get featureFour => 'Clean billing repository boundary';

	/// en: 'Local reset for assignment review'
	String get featureFive => 'Local reset for assignment review';

	/// en: 'Reset demo state'
	String get resetButton => 'Reset demo state';

	/// en: 'Reset demo state?'
	String get resetDialogTitle => 'Reset demo state?';

	/// en: 'This clears the secure entitlement and onboarding flag on this device.'
	String get resetDialogBody => 'This clears the secure entitlement and onboarding flag on this device.';

	/// en: 'Cancel'
	String get cancel => 'Cancel';

	/// en: 'Reset'
	String get reset => 'Reset';
}

// Path: errors
class Translations$errors$en {
	Translations$errors$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Something went wrong.'
	String get unknown => 'Something went wrong.';

	/// en: 'App configuration is invalid.'
	String get invalidConfig => 'App configuration is invalid.';

	/// en: 'Stored entitlement is invalid.'
	String get invalidEntitlement => 'Stored entitlement is invalid.';
}

/// The flat map containing all translations for locale <en>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on Translations {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'app.title' => 'AI Paywall Demo',
			'app.loading' => 'Preparing your subscription',
			'navigation.notFoundTitle' => 'Page not found',
			'navigation.notFoundBody' => 'This screen is not available in the demo.',
			'navigation.backToStart' => 'Back to start',
			'onboarding.title' => 'Build premium access locally',
			'onboarding.subtitle' => 'A compact demo of onboarding, a paywall, entitlement storage, and protected content.',
			'onboarding.screenOneTitle' => 'Local billing simulation',
			'onboarding.screenOneBody' => 'Plans, purchases, receipts, and entitlement validation are modeled without a store SDK.',
			'onboarding.screenTwoTitle' => 'Secure entitlement state',
			'onboarding.screenTwoBody' => 'The subscription receipt is stored in secure storage and checked again at launch.',
			'onboarding.continueButton' => 'Continue',
			'paywall.title' => 'Unlock the premium demo',
			'paywall.subtitle' => 'Choose a local subscription plan. Purchases are emulated and saved only on this device.',
			'paywall.monthlyTitle' => 'Monthly',
			'paywall.monthlyDescription' => 'Flexible access for a focused review.',
			'paywall.monthlyPrice' => '4.99 USD',
			'paywall.monthlyPeriod' => 'per month',
			'paywall.yearlyTitle' => 'Yearly',
			'paywall.yearlyDescription' => 'Best value for long-running demo access.',
			'paywall.yearlyPrice' => '39.99 USD',
			'paywall.yearlyPeriod' => 'per year',
			'paywall.yearlyBadge' => 'Best value - save 33%',
			'paywall.continueButton' => 'Continue',
			'paywall.purchaseLoading' => 'Creating local receipt...',
			'paywall.loadFailure' => 'Could not load subscription plans.',
			'paywall.purchaseFailure' => 'Purchase could not be completed.',
			'paywall.legal' => 'Demo billing only. No App Store or Google Play charge is made.',
			'home.title' => 'Premium Home',
			'home.welcome' => 'Your local entitlement is active. This screen is protected by the billing domain.',
			'home.subscription' => 'Subscription',
			'home.expires' => 'Expires',
			'home.receipt' => 'Receipt',
			'home.featuresTitle' => 'Included in this demo',
			'home.featureOne' => 'Protected launch routing',
			'home.featureTwo' => 'Secure entitlement persistence',
			'home.featureThree' => 'Receipt and expiration validation',
			'home.featureFour' => 'Clean billing repository boundary',
			'home.featureFive' => 'Local reset for assignment review',
			'home.resetButton' => 'Reset demo state',
			'home.resetDialogTitle' => 'Reset demo state?',
			'home.resetDialogBody' => 'This clears the secure entitlement and onboarding flag on this device.',
			'home.cancel' => 'Cancel',
			'home.reset' => 'Reset',
			'errors.unknown' => 'Something went wrong.',
			'errors.invalidConfig' => 'App configuration is invalid.',
			'errors.invalidEntitlement' => 'Stored entitlement is invalid.',
			_ => null,
		};
	}
}
