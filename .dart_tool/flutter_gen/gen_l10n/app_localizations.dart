import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_ur.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'gen_l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('ur')
  ];

  /// No description provided for @about.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get about;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @payout.
  ///
  /// In en, this message translates to:
  /// **'Pay out'**
  String get payout;

  /// No description provided for @totalBalance.
  ///
  /// In en, this message translates to:
  /// **'Total Balance'**
  String get totalBalance;

  /// No description provided for @overview.
  ///
  /// In en, this message translates to:
  /// **'Overview'**
  String get overview;

  /// No description provided for @expense.
  ///
  /// In en, this message translates to:
  /// **'Expenses'**
  String get expense;

  /// No description provided for @income.
  ///
  /// In en, this message translates to:
  /// **'Income'**
  String get income;

  /// No description provided for @widthDrawal.
  ///
  /// In en, this message translates to:
  /// **'Withdrawal'**
  String get widthDrawal;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @editProfile.
  ///
  /// In en, this message translates to:
  /// **'Edit Profile'**
  String get editProfile;

  /// No description provided for @verification.
  ///
  /// In en, this message translates to:
  /// **'Verification'**
  String get verification;

  /// No description provided for @earnings.
  ///
  /// In en, this message translates to:
  /// **'Earnings'**
  String get earnings;

  /// No description provided for @myOrders.
  ///
  /// In en, this message translates to:
  /// **'My Orders'**
  String get myOrders;

  /// No description provided for @officialTeam.
  ///
  /// In en, this message translates to:
  /// **'Official Team'**
  String get officialTeam;

  /// No description provided for @marketingTeam.
  ///
  /// In en, this message translates to:
  /// **'Marketing Team'**
  String get marketingTeam;

  /// No description provided for @postYourVideoShortVideo.
  ///
  /// In en, this message translates to:
  /// **'Post Your Video/Short Video?'**
  String get postYourVideoShortVideo;

  /// No description provided for @forSale.
  ///
  /// In en, this message translates to:
  /// **'For Sale'**
  String get forSale;

  /// No description provided for @viewMore.
  ///
  /// In en, this message translates to:
  /// **'View More'**
  String get viewMore;

  /// No description provided for @residiential.
  ///
  /// In en, this message translates to:
  /// **'Residential'**
  String get residiential;

  /// No description provided for @commercial.
  ///
  /// In en, this message translates to:
  /// **'Commerical'**
  String get commercial;

  /// No description provided for @landscape.
  ///
  /// In en, this message translates to:
  /// **'Landscape'**
  String get landscape;

  /// No description provided for @houseForSale.
  ///
  /// In en, this message translates to:
  /// **'House for Sale'**
  String get houseForSale;

  /// No description provided for @lastBids.
  ///
  /// In en, this message translates to:
  /// **'Last Bid'**
  String get lastBids;

  /// No description provided for @viewDetails.
  ///
  /// In en, this message translates to:
  /// **'View Detail'**
  String get viewDetails;

  /// No description provided for @forRent.
  ///
  /// In en, this message translates to:
  /// **'For rent'**
  String get forRent;

  /// No description provided for @toBuy.
  ///
  /// In en, this message translates to:
  /// **'To Buy'**
  String get toBuy;

  /// No description provided for @plumber.
  ///
  /// In en, this message translates to:
  /// **'Plumber'**
  String get plumber;

  /// No description provided for @electrician.
  ///
  /// In en, this message translates to:
  /// **'Electrician'**
  String get electrician;

  /// No description provided for @acTechnician.
  ///
  /// In en, this message translates to:
  /// **'Ac Technician'**
  String get acTechnician;

  /// No description provided for @gardener.
  ///
  /// In en, this message translates to:
  /// **'Gardener'**
  String get gardener;

  /// No description provided for @carpanter.
  ///
  /// In en, this message translates to:
  /// **'Carpanter'**
  String get carpanter;

  /// No description provided for @painter.
  ///
  /// In en, this message translates to:
  /// **'Painter'**
  String get painter;

  /// No description provided for @shortVideos.
  ///
  /// In en, this message translates to:
  /// **'Short Videos'**
  String get shortVideos;

  /// No description provided for @topSellingServices.
  ///
  /// In en, this message translates to:
  /// **'Top Selling Services'**
  String get topSellingServices;

  /// No description provided for @fixedPriceServices.
  ///
  /// In en, this message translates to:
  /// **'Fixed Price Services'**
  String get fixedPriceServices;

  /// No description provided for @videos.
  ///
  /// In en, this message translates to:
  /// **'Videos'**
  String get videos;

  /// No description provided for @properties.
  ///
  /// In en, this message translates to:
  /// **'Properties'**
  String get properties;

  /// No description provided for @location.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get location;

  /// No description provided for @searchHere.
  ///
  /// In en, this message translates to:
  /// **'Search here ...'**
  String get searchHere;

  /// No description provided for @basicPrice.
  ///
  /// In en, this message translates to:
  /// **'Basic Price : '**
  String get basicPrice;

  /// No description provided for @area.
  ///
  /// In en, this message translates to:
  /// **'Area'**
  String get area;

  /// No description provided for @banglo.
  ///
  /// In en, this message translates to:
  /// **'Banglo'**
  String get banglo;

  /// No description provided for @house.
  ///
  /// In en, this message translates to:
  /// **'House'**
  String get house;

  /// No description provided for @flat.
  ///
  /// In en, this message translates to:
  /// **'Flat'**
  String get flat;

  /// No description provided for @viewDetail.
  ///
  /// In en, this message translates to:
  /// **'View Detail'**
  String get viewDetail;

  /// No description provided for @rental.
  ///
  /// In en, this message translates to:
  /// **'Rental'**
  String get rental;

  /// No description provided for @rent_For_Me.
  ///
  /// In en, this message translates to:
  /// **'Rent For Me'**
  String get rent_For_Me;

  /// No description provided for @material.
  ///
  /// In en, this message translates to:
  /// **'Material'**
  String get material;

  /// No description provided for @sale_detail.
  ///
  /// In en, this message translates to:
  /// **'Sale detail'**
  String get sale_detail;

  /// No description provided for @for_sale.
  ///
  /// In en, this message translates to:
  /// **'For Sale'**
  String get for_sale;

  /// No description provided for @files_for_sale.
  ///
  /// In en, this message translates to:
  /// **'Files For Sale'**
  String get files_for_sale;

  /// No description provided for @post_your_property.
  ///
  /// In en, this message translates to:
  /// **'Post Your Property'**
  String get post_your_property;

  /// No description provided for @facilities.
  ///
  /// In en, this message translates to:
  /// **'Facilities'**
  String get facilities;

  /// No description provided for @develop_satiation.
  ///
  /// In en, this message translates to:
  /// **'Develop Satiation'**
  String get develop_satiation;

  /// No description provided for @recommended_Method.
  ///
  /// In en, this message translates to:
  /// **'Recommended Method(s)'**
  String get recommended_Method;

  /// No description provided for @other_saved_payment_method.
  ///
  /// In en, this message translates to:
  /// **'Other Saved Payment Method'**
  String get other_saved_payment_method;

  /// No description provided for @payment_Method.
  ///
  /// In en, this message translates to:
  /// **'Payment Method(s)'**
  String get payment_Method;

  /// No description provided for @card_number.
  ///
  /// In en, this message translates to:
  /// **'Card Number'**
  String get card_number;

  /// No description provided for @property.
  ///
  /// In en, this message translates to:
  /// **'Property'**
  String get property;

  /// No description provided for @name_card.
  ///
  /// In en, this message translates to:
  /// **'Name on Card'**
  String get name_card;

  /// No description provided for @expiration.
  ///
  /// In en, this message translates to:
  /// **'Expiration(MM/YY)'**
  String get expiration;

  /// No description provided for @congratulation.
  ///
  /// In en, this message translates to:
  /// **'Congratulation!'**
  String get congratulation;

  /// No description provided for @your_amount_is_sended.
  ///
  /// In en, this message translates to:
  /// **'Your Amount is Sended'**
  String get your_amount_is_sended;

  /// No description provided for @dimension.
  ///
  /// In en, this message translates to:
  /// **'Dimension'**
  String get dimension;

  /// No description provided for @detail.
  ///
  /// In en, this message translates to:
  /// **'Detail'**
  String get detail;

  /// No description provided for @talk.
  ///
  /// In en, this message translates to:
  /// **'Talk'**
  String get talk;

  /// No description provided for @description.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get description;

  /// No description provided for @vendor.
  ///
  /// In en, this message translates to:
  /// **'Vendor'**
  String get vendor;

  /// No description provided for @type.
  ///
  /// In en, this message translates to:
  /// **'Type'**
  String get type;

  /// No description provided for @buy.
  ///
  /// In en, this message translates to:
  /// **'Buy'**
  String get buy;

  /// No description provided for @addtoCart.
  ///
  /// In en, this message translates to:
  /// **'Add To Cart'**
  String get addtoCart;

  /// No description provided for @talkToSeller.
  ///
  /// In en, this message translates to:
  /// **'Talk to Seller'**
  String get talkToSeller;

  /// No description provided for @otherFeatures.
  ///
  /// In en, this message translates to:
  /// **'Other Features'**
  String get otherFeatures;

  /// No description provided for @videoTour.
  ///
  /// In en, this message translates to:
  /// **'Video Tour'**
  String get videoTour;

  /// No description provided for @addToFav.
  ///
  /// In en, this message translates to:
  /// **'Add To Favorite'**
  String get addToFav;

  /// No description provided for @nearbyServices.
  ///
  /// In en, this message translates to:
  /// **'Nearby Services'**
  String get nearbyServices;

  /// No description provided for @detailShortVideo.
  ///
  /// In en, this message translates to:
  /// **'Short Video'**
  String get detailShortVideo;

  /// No description provided for @recommenderForYou.
  ///
  /// In en, this message translates to:
  /// **'Recommended for you'**
  String get recommenderForYou;

  /// No description provided for @typeHereByYourSelf.
  ///
  /// In en, this message translates to:
  /// **'Type here by yourself '**
  String get typeHereByYourSelf;

  /// No description provided for @uploadWorkPhoto.
  ///
  /// In en, this message translates to:
  /// **'Upload Your Work Photo.'**
  String get uploadWorkPhoto;

  /// No description provided for @descriptionAboutYourWork.
  ///
  /// In en, this message translates to:
  /// **'Please Write Description About your work.'**
  String get descriptionAboutYourWork;

  /// No description provided for @completeDescriptionABoutYourWork.
  ///
  /// In en, this message translates to:
  /// **'Please Describe complete deception about your work here'**
  String get completeDescriptionABoutYourWork;

  /// No description provided for @servciesSearchNotificationRequestSend.
  ///
  /// In en, this message translates to:
  /// **'Your request has been sent to the Plumbers please wait for Notifications'**
  String get servciesSearchNotificationRequestSend;

  /// No description provided for @accept.
  ///
  /// In en, this message translates to:
  /// **'Accept'**
  String get accept;

  /// No description provided for @reject.
  ///
  /// In en, this message translates to:
  /// **'Reject'**
  String get reject;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @notAnswering.
  ///
  /// In en, this message translates to:
  /// **'not answering'**
  String get notAnswering;

  /// No description provided for @changeDecision.
  ///
  /// In en, this message translates to:
  /// **'Changed decision'**
  String get changeDecision;

  /// No description provided for @orderCompleted.
  ///
  /// In en, this message translates to:
  /// **'Order Completed!'**
  String get orderCompleted;

  /// No description provided for @pleasePay.
  ///
  /// In en, this message translates to:
  /// **'Please pay'**
  String get pleasePay;

  /// No description provided for @to.
  ///
  /// In en, this message translates to:
  /// **'To'**
  String get to;

  /// No description provided for @continues.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continues;

  /// No description provided for @satisfied_withwork.
  ///
  /// In en, this message translates to:
  /// **'Are you satisfied with work?'**
  String get satisfied_withwork;

  /// No description provided for @work_Completed.
  ///
  /// In en, this message translates to:
  /// **'Is your work Completed'**
  String get work_Completed;

  /// No description provided for @receive_work_from_Vendor.
  ///
  /// In en, this message translates to:
  /// **'Did you receive work from Vendor?'**
  String get receive_work_from_Vendor;

  /// No description provided for @experience_with_Vendor.
  ///
  /// In en, this message translates to:
  /// **'How was your experience with Vendor?'**
  String get experience_with_Vendor;

  /// No description provided for @lorem_ipsum.
  ///
  /// In en, this message translates to:
  /// **'Lorem ipsum....'**
  String get lorem_ipsum;

  /// No description provided for @give_Rating_to_Vendor.
  ///
  /// In en, this message translates to:
  /// **'Give Rating to Vendor'**
  String get give_Rating_to_Vendor;

  /// No description provided for @no.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get no;

  /// No description provided for @yes.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get yes;

  /// No description provided for @done.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get done;

  /// No description provided for @price.
  ///
  /// In en, this message translates to:
  /// **'Price'**
  String get price;

  /// No description provided for @seeProfile.
  ///
  /// In en, this message translates to:
  /// **'See Profile'**
  String get seeProfile;

  /// No description provided for @moreDetail.
  ///
  /// In en, this message translates to:
  /// **'More Detail'**
  String get moreDetail;

  /// No description provided for @notReached.
  ///
  /// In en, this message translates to:
  /// **'Not Reached'**
  String get notReached;

  /// No description provided for @privacy.
  ///
  /// In en, this message translates to:
  /// **'Privacy'**
  String get privacy;

  /// No description provided for @privateAccount.
  ///
  /// In en, this message translates to:
  /// **'Private Account'**
  String get privateAccount;

  /// No description provided for @activity.
  ///
  /// In en, this message translates to:
  /// **'Activity'**
  String get activity;

  /// No description provided for @postYouSearchedFor.
  ///
  /// In en, this message translates to:
  /// **'Post You Searched For'**
  String get postYouSearchedFor;

  /// No description provided for @videosYouHaveWatched.
  ///
  /// In en, this message translates to:
  /// **'Videos You Have Watched'**
  String get videosYouHaveWatched;

  /// No description provided for @comments.
  ///
  /// In en, this message translates to:
  /// **'Comments'**
  String get comments;

  /// No description provided for @peopleYouFollowed.
  ///
  /// In en, this message translates to:
  /// **'People You Followed'**
  String get peopleYouFollowed;

  /// No description provided for @yourPost.
  ///
  /// In en, this message translates to:
  /// **'Your Post'**
  String get yourPost;

  /// No description provided for @whatAreYouSearchingFor.
  ///
  /// In en, this message translates to:
  /// **'Post What You are Searching For'**
  String get whatAreYouSearchingFor;

  /// No description provided for @size.
  ///
  /// In en, this message translates to:
  /// **'Size'**
  String get size;

  /// No description provided for @deleteAccount.
  ///
  /// In en, this message translates to:
  /// **'Delete Account'**
  String get deleteAccount;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'ur'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'ur': return AppLocalizationsUr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
