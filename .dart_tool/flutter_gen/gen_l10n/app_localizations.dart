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

  /// No description provided for @total_balance.
  ///
  /// In en, this message translates to:
  /// **'Total Balance'**
  String get total_balance;

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

  /// No description provided for @width_draw.
  ///
  /// In en, this message translates to:
  /// **'Withdrawal'**
  String get width_draw;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @edit_profile.
  ///
  /// In en, this message translates to:
  /// **'Edit Profile'**
  String get edit_profile;

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

  /// No description provided for @my_orders.
  ///
  /// In en, this message translates to:
  /// **'My Orders'**
  String get my_orders;

  /// No description provided for @official_team.
  ///
  /// In en, this message translates to:
  /// **'Official Team'**
  String get official_team;

  /// No description provided for @marketing_team.
  ///
  /// In en, this message translates to:
  /// **'Marketing Team'**
  String get marketing_team;

  /// No description provided for @post_your_video_short_video.
  ///
  /// In en, this message translates to:
  /// **'Post Your Video/Short Video?'**
  String get post_your_video_short_video;

  /// No description provided for @view_more.
  ///
  /// In en, this message translates to:
  /// **'View More'**
  String get view_more;

  /// No description provided for @view_less.
  ///
  /// In en, this message translates to:
  /// **'View Less'**
  String get view_less;

  /// No description provided for @residential.
  ///
  /// In en, this message translates to:
  /// **'Residential'**
  String get residential;

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

  /// No description provided for @house_for_sale.
  ///
  /// In en, this message translates to:
  /// **'House for Sale'**
  String get house_for_sale;

  /// No description provided for @last_bids.
  ///
  /// In en, this message translates to:
  /// **'Last Bid'**
  String get last_bids;

  /// No description provided for @view_details.
  ///
  /// In en, this message translates to:
  /// **'View Detail'**
  String get view_details;

  /// No description provided for @for_rent.
  ///
  /// In en, this message translates to:
  /// **'For rent'**
  String get for_rent;

  /// No description provided for @to_buy.
  ///
  /// In en, this message translates to:
  /// **'To Buy'**
  String get to_buy;

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

  /// No description provided for @ac_technician.
  ///
  /// In en, this message translates to:
  /// **'Ac Technician'**
  String get ac_technician;

  /// No description provided for @gardener.
  ///
  /// In en, this message translates to:
  /// **'Gardener'**
  String get gardener;

  /// No description provided for @car_painter.
  ///
  /// In en, this message translates to:
  /// **'Car Painter'**
  String get car_painter;

  /// No description provided for @painter.
  ///
  /// In en, this message translates to:
  /// **'Painter'**
  String get painter;

  /// No description provided for @short_videos.
  ///
  /// In en, this message translates to:
  /// **'Short Videos'**
  String get short_videos;

  /// No description provided for @top_selling_services.
  ///
  /// In en, this message translates to:
  /// **'Top Selling Services'**
  String get top_selling_services;

  /// No description provided for @fixed_price_services.
  ///
  /// In en, this message translates to:
  /// **'Fixed Price Services'**
  String get fixed_price_services;

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

  /// No description provided for @search_here.
  ///
  /// In en, this message translates to:
  /// **'Search here ...'**
  String get search_here;

  /// No description provided for @basic_price.
  ///
  /// In en, this message translates to:
  /// **'Basic Price : '**
  String get basic_price;

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

  /// No description provided for @view_detail.
  ///
  /// In en, this message translates to:
  /// **'View Detail'**
  String get view_detail;

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

  /// No description provided for @recommended_method.
  ///
  /// In en, this message translates to:
  /// **'Recommended Method(s)'**
  String get recommended_method;

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

  /// No description provided for @add_to_cart.
  ///
  /// In en, this message translates to:
  /// **'Add To Cart'**
  String get add_to_cart;

  /// No description provided for @talk_to_seller.
  ///
  /// In en, this message translates to:
  /// **'Talk to Seller'**
  String get talk_to_seller;

  /// No description provided for @other_features.
  ///
  /// In en, this message translates to:
  /// **'Other Features'**
  String get other_features;

  /// No description provided for @video_tour.
  ///
  /// In en, this message translates to:
  /// **'Video Tour'**
  String get video_tour;

  /// No description provided for @add_to_fav.
  ///
  /// In en, this message translates to:
  /// **'Add To Favorite'**
  String get add_to_fav;

  /// No description provided for @near_by_services.
  ///
  /// In en, this message translates to:
  /// **'Nearby Services'**
  String get near_by_services;

  /// No description provided for @detail_short_video.
  ///
  /// In en, this message translates to:
  /// **'Short Video'**
  String get detail_short_video;

  /// No description provided for @recommender_for_you.
  ///
  /// In en, this message translates to:
  /// **'Recommended for you'**
  String get recommender_for_you;

  /// No description provided for @type_here_by_your_self.
  ///
  /// In en, this message translates to:
  /// **'Type here by yourself '**
  String get type_here_by_your_self;

  /// No description provided for @upload_work_photo.
  ///
  /// In en, this message translates to:
  /// **'Upload Your Work Photo.'**
  String get upload_work_photo;

  /// No description provided for @description_about_your_work.
  ///
  /// In en, this message translates to:
  /// **'Please Write Description About your work.'**
  String get description_about_your_work;

  /// No description provided for @complete_description_about_your_work.
  ///
  /// In en, this message translates to:
  /// **'Please Describe complete deception about your work here'**
  String get complete_description_about_your_work;

  /// No description provided for @services_search_notification_request_send.
  ///
  /// In en, this message translates to:
  /// **'Your request has been sent to the Plumbers please wait for Notifications'**
  String get services_search_notification_request_send;

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

  /// No description provided for @not_answering.
  ///
  /// In en, this message translates to:
  /// **'not answering'**
  String get not_answering;

  /// No description provided for @change_decision.
  ///
  /// In en, this message translates to:
  /// **'Changed decision'**
  String get change_decision;

  /// No description provided for @order_completed.
  ///
  /// In en, this message translates to:
  /// **'Order Completed!'**
  String get order_completed;

  /// No description provided for @please_pay.
  ///
  /// In en, this message translates to:
  /// **'Please pay'**
  String get please_pay;

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

  /// No description provided for @satisfied_with_work.
  ///
  /// In en, this message translates to:
  /// **'Are you satisfied with work?'**
  String get satisfied_with_work;

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

  /// No description provided for @rent.
  ///
  /// In en, this message translates to:
  /// **'rent'**
  String get rent;

  /// No description provided for @see_profile.
  ///
  /// In en, this message translates to:
  /// **'See Profile'**
  String get see_profile;

  /// No description provided for @more_detail.
  ///
  /// In en, this message translates to:
  /// **'More Detail'**
  String get more_detail;

  /// No description provided for @not_reached.
  ///
  /// In en, this message translates to:
  /// **'Not Reached'**
  String get not_reached;

  /// No description provided for @privacy.
  ///
  /// In en, this message translates to:
  /// **'Privacy'**
  String get privacy;

  /// No description provided for @private_account.
  ///
  /// In en, this message translates to:
  /// **'Private Account'**
  String get private_account;

  /// No description provided for @activity.
  ///
  /// In en, this message translates to:
  /// **'Activity'**
  String get activity;

  /// No description provided for @videos_you_have_watched.
  ///
  /// In en, this message translates to:
  /// **'Videos You Have Watched'**
  String get videos_you_have_watched;

  /// No description provided for @comments.
  ///
  /// In en, this message translates to:
  /// **'Comments'**
  String get comments;

  /// No description provided for @people_you_followed.
  ///
  /// In en, this message translates to:
  /// **'People You Followed'**
  String get people_you_followed;

  /// No description provided for @your_post.
  ///
  /// In en, this message translates to:
  /// **'Your Post'**
  String get your_post;

  /// No description provided for @what_are_you_searching_for.
  ///
  /// In en, this message translates to:
  /// **'Post What You are Searching For'**
  String get what_are_you_searching_for;

  /// No description provided for @size.
  ///
  /// In en, this message translates to:
  /// **'Size'**
  String get size;

  /// No description provided for @delete_account.
  ///
  /// In en, this message translates to:
  /// **'Delete Account'**
  String get delete_account;

  /// No description provided for @title.
  ///
  /// In en, this message translates to:
  /// **'Title'**
  String get title;

  /// No description provided for @select_country.
  ///
  /// In en, this message translates to:
  /// **'Select Country'**
  String get select_country;

  /// No description provided for @please_enter_title.
  ///
  /// In en, this message translates to:
  /// **'Please Enter Title'**
  String get please_enter_title;

  /// No description provided for @please_enter_description.
  ///
  /// In en, this message translates to:
  /// **'Please enter description'**
  String get please_enter_description;

  /// No description provided for @please_enter_city.
  ///
  /// In en, this message translates to:
  /// **'Please Enter City'**
  String get please_enter_city;

  /// No description provided for @select_currency.
  ///
  /// In en, this message translates to:
  /// **'Select Currency'**
  String get select_currency;

  /// No description provided for @please_enter_price.
  ///
  /// In en, this message translates to:
  /// **'Please Enter Price'**
  String get please_enter_price;

  /// No description provided for @size_area.
  ///
  /// In en, this message translates to:
  /// **'Size/Area'**
  String get size_area;

  /// No description provided for @please_enter_size_area.
  ///
  /// In en, this message translates to:
  /// **'Please Enter Size/Area'**
  String get please_enter_size_area;

  /// No description provided for @please_enter_new_password.
  ///
  /// In en, this message translates to:
  /// **'Please Enter New Password'**
  String get please_enter_new_password;

  /// No description provided for @pick_gallery_images.
  ///
  /// In en, this message translates to:
  /// **'Pick Gallery Images'**
  String get pick_gallery_images;

  /// No description provided for @error.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get error;

  /// No description provided for @title_is_required.
  ///
  /// In en, this message translates to:
  /// **'Title is required'**
  String get title_is_required;

  /// No description provided for @description_is_required.
  ///
  /// In en, this message translates to:
  /// **'Description is required'**
  String get description_is_required;

  /// No description provided for @city_is_required.
  ///
  /// In en, this message translates to:
  /// **'City is required'**
  String get city_is_required;

  /// No description provided for @price_is_required.
  ///
  /// In en, this message translates to:
  /// **'Price is required'**
  String get price_is_required;

  /// No description provided for @size_area_is_required.
  ///
  /// In en, this message translates to:
  /// **'Size/Area is required'**
  String get size_area_is_required;

  /// No description provided for @please_upload_a_thumbnail_image.
  ///
  /// In en, this message translates to:
  /// **'Please upload a Thumbnail Image'**
  String get please_upload_a_thumbnail_image;

  /// No description provided for @post.
  ///
  /// In en, this message translates to:
  /// **'Post'**
  String get post;

  /// No description provided for @dealer.
  ///
  /// In en, this message translates to:
  /// **'Dealer'**
  String get dealer;

  /// No description provided for @post_you_searched_for.
  ///
  /// In en, this message translates to:
  /// **'Post You Searched For'**
  String get post_you_searched_for;

  /// No description provided for @this_month.
  ///
  /// In en, this message translates to:
  /// **'This Month'**
  String get this_month;

  /// No description provided for @this_week.
  ///
  /// In en, this message translates to:
  /// **'This Week'**
  String get this_week;

  /// No description provided for @sale_overview.
  ///
  /// In en, this message translates to:
  /// **'Sale Overview'**
  String get sale_overview;

  /// No description provided for @ads_overview.
  ///
  /// In en, this message translates to:
  /// **'Ads Overview'**
  String get ads_overview;

  /// No description provided for @ads.
  ///
  /// In en, this message translates to:
  /// **'Ads'**
  String get ads;

  /// No description provided for @costs.
  ///
  /// In en, this message translates to:
  /// **'Costs'**
  String get costs;

  /// No description provided for @analytics.
  ///
  /// In en, this message translates to:
  /// **'Analytics'**
  String get analytics;

  /// No description provided for @followers_overview.
  ///
  /// In en, this message translates to:
  /// **'Followers Overview'**
  String get followers_overview;

  /// No description provided for @followers_gain.
  ///
  /// In en, this message translates to:
  /// **'Followers Gain'**
  String get followers_gain;

  /// No description provided for @followers_lost.
  ///
  /// In en, this message translates to:
  /// **'Followers Lost'**
  String get followers_lost;

  /// No description provided for @decline.
  ///
  /// In en, this message translates to:
  /// **'Decline'**
  String get decline;

  /// No description provided for @collect_info.
  ///
  /// In en, this message translates to:
  /// **'Collect Info'**
  String get collect_info;

  /// No description provided for @forgot_password.
  ///
  /// In en, this message translates to:
  /// **'Forgot Password'**
  String get forgot_password;

  /// No description provided for @please_enter_your_email_to_receive_a_verification_code.
  ///
  /// In en, this message translates to:
  /// **'Please Enter Your Email To Receive a Verification Code'**
  String get please_enter_your_email_to_receive_a_verification_code;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @enter_your_email.
  ///
  /// In en, this message translates to:
  /// **'Enter Your Email'**
  String get enter_your_email;

  /// No description provided for @please_enter_valid_email.
  ///
  /// In en, this message translates to:
  /// **'Please enter valid Email'**
  String get please_enter_valid_email;

  /// No description provided for @sign_up.
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get sign_up;

  /// No description provided for @sign_in.
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get sign_in;

  /// No description provided for @sign_out.
  ///
  /// In en, this message translates to:
  /// **'Sign Out'**
  String get sign_out;

  /// No description provided for @dont_have_an_account.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account?'**
  String get dont_have_an_account;

  /// No description provided for @privacy_policy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacy_policy;

  /// No description provided for @enter_email_phone_number.
  ///
  /// In en, this message translates to:
  /// **'Enter Email/Phone Number'**
  String get enter_email_phone_number;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @enter_your_password.
  ///
  /// In en, this message translates to:
  /// **'Enter your Password'**
  String get enter_your_password;

  /// No description provided for @new_password.
  ///
  /// In en, this message translates to:
  /// **'New Password'**
  String get new_password;

  /// No description provided for @oops_we_could_not_find_matching_credentials.
  ///
  /// In en, this message translates to:
  /// **'Oops! we could not find matching credentials.'**
  String get oops_we_could_not_find_matching_credentials;

  /// No description provided for @your_new_password_must_be_different_from_previously_used_password.
  ///
  /// In en, this message translates to:
  /// **'Your new Password must be different from previously used Password.'**
  String get your_new_password_must_be_different_from_previously_used_password;

  /// No description provided for @confirm_password.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get confirm_password;

  /// No description provided for @enter_password_again.
  ///
  /// In en, this message translates to:
  /// **'Enter Password Again'**
  String get enter_password_again;

  /// No description provided for @please_enter_password_again.
  ///
  /// In en, this message translates to:
  /// **'Please Enter Password Again'**
  String get please_enter_password_again;

  /// No description provided for @password_mismatch.
  ///
  /// In en, this message translates to:
  /// **'Password Mismatch'**
  String get password_mismatch;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @sms.
  ///
  /// In en, this message translates to:
  /// **'SMS'**
  String get sms;

  /// No description provided for @dashboard.
  ///
  /// In en, this message translates to:
  /// **'Dashboard'**
  String get dashboard;

  /// No description provided for @account_status.
  ///
  /// In en, this message translates to:
  /// **'Account Status'**
  String get account_status;

  /// No description provided for @change_password.
  ///
  /// In en, this message translates to:
  /// **'Change Password'**
  String get change_password;

  /// No description provided for @request_properties.
  ///
  /// In en, this message translates to:
  /// **'Request Properties'**
  String get request_properties;

  /// No description provided for @policy.
  ///
  /// In en, this message translates to:
  /// **'Policy'**
  String get policy;

  /// No description provided for @support.
  ///
  /// In en, this message translates to:
  /// **'Support'**
  String get support;

  /// No description provided for @wallet.
  ///
  /// In en, this message translates to:
  /// **'Wallet'**
  String get wallet;

  /// No description provided for @less.
  ///
  /// In en, this message translates to:
  /// **'Less'**
  String get less;

  /// No description provided for @more.
  ///
  /// In en, this message translates to:
  /// **'More'**
  String get more;

  /// No description provided for @pkr.
  ///
  /// In en, this message translates to:
  /// **'PKR'**
  String get pkr;

  /// No description provided for @no_data_available.
  ///
  /// In en, this message translates to:
  /// **'No Data Available'**
  String get no_data_available;

  /// No description provided for @rent_for_me.
  ///
  /// In en, this message translates to:
  /// **'Rent For Me'**
  String get rent_for_me;

  /// No description provided for @join_as.
  ///
  /// In en, this message translates to:
  /// **'Join as'**
  String get join_as;

  /// No description provided for @guest.
  ///
  /// In en, this message translates to:
  /// **'Guest'**
  String get guest;

  /// No description provided for @seller.
  ///
  /// In en, this message translates to:
  /// **'Seller'**
  String get seller;

  /// No description provided for @supplier.
  ///
  /// In en, this message translates to:
  /// **'Supplier'**
  String get supplier;

  /// No description provided for @service_provider.
  ///
  /// In en, this message translates to:
  /// **'Service Provider'**
  String get service_provider;

  /// No description provided for @corporate_service.
  ///
  /// In en, this message translates to:
  /// **'Corporate Service'**
  String get corporate_service;

  /// No description provided for @search_language.
  ///
  /// In en, this message translates to:
  /// **'Search Language'**
  String get search_language;

  /// No description provided for @weekly_earning.
  ///
  /// In en, this message translates to:
  /// **'Weekly Earning'**
  String get weekly_earning;

  /// No description provided for @withdrawal_amount.
  ///
  /// In en, this message translates to:
  /// **'Withdrawal Amount'**
  String get withdrawal_amount;

  /// No description provided for @followers.
  ///
  /// In en, this message translates to:
  /// **'Followers'**
  String get followers;

  /// No description provided for @monetization.
  ///
  /// In en, this message translates to:
  /// **'Monetization'**
  String get monetization;

  /// No description provided for @watch_time.
  ///
  /// In en, this message translates to:
  /// **'Watch Time'**
  String get watch_time;

  /// No description provided for @order_id.
  ///
  /// In en, this message translates to:
  /// **'Order ID:'**
  String get order_id;

  /// No description provided for @pending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get pending;

  /// No description provided for @all.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get all;

  /// No description provided for @completed.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get completed;

  /// No description provided for @cancelled.
  ///
  /// In en, this message translates to:
  /// **'Cancelled'**
  String get cancelled;

  /// No description provided for @review_work.
  ///
  /// In en, this message translates to:
  /// **'Review Work'**
  String get review_work;

  /// No description provided for @orders.
  ///
  /// In en, this message translates to:
  /// **'Orders'**
  String get orders;

  /// No description provided for @work_detail.
  ///
  /// In en, this message translates to:
  /// **'Work Detail'**
  String get work_detail;

  /// No description provided for @work_not_submitted_yet.
  ///
  /// In en, this message translates to:
  /// **'Work not submitted yet!'**
  String get work_not_submitted_yet;

  /// No description provided for @extra_price.
  ///
  /// In en, this message translates to:
  /// **'Extra Price'**
  String get extra_price;

  /// No description provided for @order_accepted_successfully.
  ///
  /// In en, this message translates to:
  /// **'Order accepted successfully'**
  String get order_accepted_successfully;

  /// No description provided for @order_rejected_successfully.
  ///
  /// In en, this message translates to:
  /// **'Order rejected successfully'**
  String get order_rejected_successfully;

  /// No description provided for @updates.
  ///
  /// In en, this message translates to:
  /// **'Updates'**
  String get updates;

  /// No description provided for @post_ad.
  ///
  /// In en, this message translates to:
  /// **'Post_Ad'**
  String get post_ad;

  /// No description provided for @services.
  ///
  /// In en, this message translates to:
  /// **'Services'**
  String get services;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @select_service.
  ///
  /// In en, this message translates to:
  /// **'Select Service'**
  String get select_service;

  /// No description provided for @select_an_option.
  ///
  /// In en, this message translates to:
  /// **'Select an option'**
  String get select_an_option;

  /// No description provided for @remove.
  ///
  /// In en, this message translates to:
  /// **'Remove'**
  String get remove;

  /// No description provided for @add_your_service.
  ///
  /// In en, this message translates to:
  /// **'Add Your Service'**
  String get add_your_service;

  /// No description provided for @add.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get add;

  /// No description provided for @no_features_available.
  ///
  /// In en, this message translates to:
  /// **'No features available'**
  String get no_features_available;

  /// No description provided for @property_information.
  ///
  /// In en, this message translates to:
  /// **'Property Information'**
  String get property_information;

  /// No description provided for @bedrooms.
  ///
  /// In en, this message translates to:
  /// **'Bedrooms'**
  String get bedrooms;

  /// No description provided for @select_how_many.
  ///
  /// In en, this message translates to:
  /// **'Select How Many\''**
  String get select_how_many;

  /// No description provided for @bathrooms.
  ///
  /// In en, this message translates to:
  /// **'Bathrooms'**
  String get bathrooms;

  /// No description provided for @floors.
  ///
  /// In en, this message translates to:
  /// **'Floors'**
  String get floors;

  /// No description provided for @thumbnail.
  ///
  /// In en, this message translates to:
  /// **'Thumbnail'**
  String get thumbnail;

  /// No description provided for @upload_thumbnail_image.
  ///
  /// In en, this message translates to:
  /// **'Upload Thumbnail Image'**
  String get upload_thumbnail_image;

  /// No description provided for @upload_short_video.
  ///
  /// In en, this message translates to:
  /// **'Upload Short Video'**
  String get upload_short_video;

  /// No description provided for @upload_video.
  ///
  /// In en, this message translates to:
  /// **'Upload Video'**
  String get upload_video;

  /// No description provided for @past_video_url_here.
  ///
  /// In en, this message translates to:
  /// **'Past Video Url here'**
  String get past_video_url_here;

  /// No description provided for @upload_video_less_than_25MB.
  ///
  /// In en, this message translates to:
  /// **'Upload Video Less Then 25MB'**
  String get upload_video_less_than_25MB;

  /// No description provided for @area_type.
  ///
  /// In en, this message translates to:
  /// **'Area type'**
  String get area_type;

  /// No description provided for @select_area_type.
  ///
  /// In en, this message translates to:
  /// **'Select Area type'**
  String get select_area_type;

  /// No description provided for @property_type.
  ///
  /// In en, this message translates to:
  /// **'Property Type'**
  String get property_type;

  /// No description provided for @select_property_type.
  ///
  /// In en, this message translates to:
  /// **'Select PropertyType'**
  String get select_property_type;

  /// No description provided for @area_unit.
  ///
  /// In en, this message translates to:
  /// **'Area Unit'**
  String get area_unit;

  /// No description provided for @select_area_unit.
  ///
  /// In en, this message translates to:
  /// **'Select Area Unit'**
  String get select_area_unit;

  /// No description provided for @uploading_property.
  ///
  /// In en, this message translates to:
  /// **'Uploading Property'**
  String get uploading_property;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @please_take_photo_of_your_in_corporate_text_document.
  ///
  /// In en, this message translates to:
  /// **'Please Take photo of your In Corporate Text Document'**
  String get please_take_photo_of_your_in_corporate_text_document;

  /// No description provided for @confirm_verification.
  ///
  /// In en, this message translates to:
  /// **'Confirm Verification'**
  String get confirm_verification;

  /// No description provided for @number.
  ///
  /// In en, this message translates to:
  /// **'Number'**
  String get number;

  /// No description provided for @id_card.
  ///
  /// In en, this message translates to:
  /// **'ID Card'**
  String get id_card;

  /// No description provided for @face_verification.
  ///
  /// In en, this message translates to:
  /// **'Face Verification'**
  String get face_verification;

  /// No description provided for @email_verification_in_progress.
  ///
  /// In en, this message translates to:
  /// **'Email Verification in Progress'**
  String get email_verification_in_progress;

  /// No description provided for @your_email_is_already_verified.
  ///
  /// In en, this message translates to:
  /// **'Your Email is Already Verified'**
  String get your_email_is_already_verified;

  /// No description provided for @phone_number_verification_in_progress.
  ///
  /// In en, this message translates to:
  /// **'Phone Number Verification in Progress'**
  String get phone_number_verification_in_progress;

  /// No description provided for @your_phone_number_is_already_verified.
  ///
  /// In en, this message translates to:
  /// **'Your Phone Number is Already Verified'**
  String get your_phone_number_is_already_verified;

  /// No description provided for @id_card_verification_in_progress.
  ///
  /// In en, this message translates to:
  /// **'Your Phone Number is Already Verified'**
  String get id_card_verification_in_progress;

  /// No description provided for @your_id_card_is_already_verified.
  ///
  /// In en, this message translates to:
  /// **'Your ID Card is Already Verified'**
  String get your_id_card_is_already_verified;

  /// No description provided for @submit.
  ///
  /// In en, this message translates to:
  /// **'Submit'**
  String get submit;

  /// No description provided for @face_Verification_in_progress.
  ///
  /// In en, this message translates to:
  /// **'Face Verification in Progress'**
  String get face_Verification_in_progress;

  /// No description provided for @your_face_is_already_verified.
  ///
  /// In en, this message translates to:
  /// **'Your Face is Already Verified'**
  String get your_face_is_already_verified;

  /// No description provided for @add_award.
  ///
  /// In en, this message translates to:
  /// **'Add Award'**
  String get add_award;

  /// No description provided for @add_award_information.
  ///
  /// In en, this message translates to:
  /// **'Add Award Information'**
  String get add_award_information;

  /// No description provided for @please_upload_your_information_for_propertier_account.
  ///
  /// In en, this message translates to:
  /// **'Please Upload your information for propertier account.'**
  String get please_upload_your_information_for_propertier_account;

  /// No description provided for @please_select_award_date_and_time.
  ///
  /// In en, this message translates to:
  /// **'Please select award date and time'**
  String get please_select_award_date_and_time;

  /// No description provided for @select.
  ///
  /// In en, this message translates to:
  /// **'Select'**
  String get select;

  /// No description provided for @current_password.
  ///
  /// In en, this message translates to:
  /// **'Current Password'**
  String get current_password;

  /// No description provided for @enter_current_password.
  ///
  /// In en, this message translates to:
  /// **'Enter Current Password'**
  String get enter_current_password;

  /// No description provided for @please_enter_your_current_password.
  ///
  /// In en, this message translates to:
  /// **'Please Enter Your Current Password'**
  String get please_enter_your_current_password;

  /// No description provided for @enter_new_password.
  ///
  /// In en, this message translates to:
  /// **'Enter New Password'**
  String get enter_new_password;

  /// No description provided for @please_enter_your_new_password.
  ///
  /// In en, this message translates to:
  /// **'Please Enter Your New Password'**
  String get please_enter_your_new_password;

  /// No description provided for @confirm_new_password.
  ///
  /// In en, this message translates to:
  /// **'Confirm New Password'**
  String get confirm_new_password;

  /// No description provided for @re_enter_new_password.
  ///
  /// In en, this message translates to:
  /// **'Re-Enter New Password'**
  String get re_enter_new_password;

  /// No description provided for @team.
  ///
  /// In en, this message translates to:
  /// **'Team'**
  String get team;

  /// No description provided for @sales.
  ///
  /// In en, this message translates to:
  /// **'Sales'**
  String get sales;

  /// No description provided for @following.
  ///
  /// In en, this message translates to:
  /// **'Following'**
  String get following;

  /// No description provided for @phone_number.
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get phone_number;

  /// No description provided for @address.
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get address;

  /// No description provided for @since.
  ///
  /// In en, this message translates to:
  /// **'Since'**
  String get since;

  /// No description provided for @post_here.
  ///
  /// In en, this message translates to:
  /// **'Post Here'**
  String get post_here;

  /// No description provided for @chat.
  ///
  /// In en, this message translates to:
  /// **'Chat'**
  String get chat;

  /// No description provided for @awards.
  ///
  /// In en, this message translates to:
  /// **'Awards'**
  String get awards;

  /// No description provided for @no_awards.
  ///
  /// In en, this message translates to:
  /// **'No Awards'**
  String get no_awards;

  /// No description provided for @top_search.
  ///
  /// In en, this message translates to:
  /// **'Top Search'**
  String get top_search;

  /// No description provided for @top_sale.
  ///
  /// In en, this message translates to:
  /// **'Top Sale'**
  String get top_sale;

  /// No description provided for @no_data.
  ///
  /// In en, this message translates to:
  /// **'No Data'**
  String get no_data;

  /// No description provided for @error_generating_thumbnail.
  ///
  /// In en, this message translates to:
  /// **'Error generating thumbnail'**
  String get error_generating_thumbnail;

  /// No description provided for @click_to_feature_ad.
  ///
  /// In en, this message translates to:
  /// **'Click to Feature Ad'**
  String get click_to_feature_ad;

  /// No description provided for @confirm_deletion.
  ///
  /// In en, this message translates to:
  /// **'Confirm Deletion'**
  String get confirm_deletion;

  /// No description provided for @are_you_sure_you_want_to_delete_this_property.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this property?'**
  String get are_you_sure_you_want_to_delete_this_property;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @please_enter_full_name.
  ///
  /// In en, this message translates to:
  /// **'Please enter Full Name'**
  String get please_enter_full_name;

  /// No description provided for @please_enter_your_email.
  ///
  /// In en, this message translates to:
  /// **'Please enter Your Email'**
  String get please_enter_your_email;

  /// No description provided for @please_enter_your_password.
  ///
  /// In en, this message translates to:
  /// **'Please Enter Your Password'**
  String get please_enter_your_password;

  /// No description provided for @enter_your_phone_number.
  ///
  /// In en, this message translates to:
  /// **'Enter Your Phone Number'**
  String get enter_your_phone_number;

  /// No description provided for @please_enter_your_address.
  ///
  /// In en, this message translates to:
  /// **'Please Enter Your Address'**
  String get please_enter_your_address;

  /// No description provided for @click_here.
  ///
  /// In en, this message translates to:
  /// **'Click here'**
  String get click_here;

  /// No description provided for @get_your_ad_featured.
  ///
  /// In en, this message translates to:
  /// **'Get your Ad Featured:'**
  String get get_your_ad_featured;

  /// No description provided for @reach_up_to_10x_more_buyers.
  ///
  /// In en, this message translates to:
  /// **'Reach up to 10x more buyers.'**
  String get reach_up_to_10x_more_buyers;

  /// No description provided for @show_your_ad_in_top_position.
  ///
  /// In en, this message translates to:
  /// **'Show your Ad in top position.'**
  String get show_your_ad_in_top_position;

  /// No description provided for @get_noticed_with_a_feature_ad_tag.
  ///
  /// In en, this message translates to:
  /// **'Get noticed with a Feature Ad tag.'**
  String get get_noticed_with_a_feature_ad_tag;

  /// No description provided for @all_types.
  ///
  /// In en, this message translates to:
  /// **'All Types'**
  String get all_types;

  /// No description provided for @call.
  ///
  /// In en, this message translates to:
  /// **'Call'**
  String get call;

  /// No description provided for @sorry_no_data_available.
  ///
  /// In en, this message translates to:
  /// **'Sorry! \\nNo data Available'**
  String get sorry_no_data_available;

  /// No description provided for @provide_description.
  ///
  /// In en, this message translates to:
  /// **'Provide Description'**
  String get provide_description;

  /// No description provided for @inspection_report.
  ///
  /// In en, this message translates to:
  /// **'Inspection Report'**
  String get inspection_report;

  /// No description provided for @near_by_propertire_office.
  ///
  /// In en, this message translates to:
  /// **'Near By Propertire Office'**
  String get near_by_propertire_office;

  /// No description provided for @upload_pdf_file_or_images.
  ///
  /// In en, this message translates to:
  /// **'Upload PDf File / Images'**
  String get upload_pdf_file_or_images;

  /// No description provided for @review.
  ///
  /// In en, this message translates to:
  /// **'Review'**
  String get review;

  /// No description provided for @customer_reviews.
  ///
  /// In en, this message translates to:
  /// **'Customer Reviews'**
  String get customer_reviews;

  /// No description provided for @no_data_search_yet.
  ///
  /// In en, this message translates to:
  /// **'No Data Search Yet'**
  String get no_data_search_yet;

  /// No description provided for @please_select_a_category.
  ///
  /// In en, this message translates to:
  /// **'Please Select a Category'**
  String get please_select_a_category;

  /// No description provided for @please_wait.
  ///
  /// In en, this message translates to:
  /// **'Please Wait...'**
  String get please_wait;

  /// No description provided for @switch_to_vendor.
  ///
  /// In en, this message translates to:
  /// **'Switch to Vendor'**
  String get switch_to_vendor;

  /// No description provided for @what_are_you_looking_for.
  ///
  /// In en, this message translates to:
  /// **'What are you looking for'**
  String get what_are_you_looking_for;

  /// No description provided for @other.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get other;

  /// No description provided for @nearest_services.
  ///
  /// In en, this message translates to:
  /// **'Nearest Services'**
  String get nearest_services;

  /// No description provided for @other_services.
  ///
  /// In en, this message translates to:
  /// **'Other Services'**
  String get other_services;

  /// No description provided for @on_the_way.
  ///
  /// In en, this message translates to:
  /// **'On the way'**
  String get on_the_way;

  /// No description provided for @select_services_you_want.
  ///
  /// In en, this message translates to:
  /// **'Select Services You Want'**
  String get select_services_you_want;

  /// No description provided for @we_re_sorry_to_see_you_go.
  ///
  /// In en, this message translates to:
  /// **'We\\\'re sorry to see you go'**
  String get we_re_sorry_to_see_you_go;

  /// No description provided for @before_you_proceed_with_deleting_your_account_please_note.
  ///
  /// In en, this message translates to:
  /// **'Before you proceed with deleting your account, please note:'**
  String get before_you_proceed_with_deleting_your_account_please_note;

  /// No description provided for @all_your_personal_information_and_data_will_be_permanently_removed.
  ///
  /// In en, this message translates to:
  /// **'Before you proceed with deleting your account, please note:'**
  String get all_your_personal_information_and_data_will_be_permanently_removed;

  /// No description provided for @your_profile_saved_preferences_and_history_will_be_erased.
  ///
  /// In en, this message translates to:
  /// **'Your profile, saved preferences, and history will be erased.'**
  String get your_profile_saved_preferences_and_history_will_be_erased;

  /// No description provided for @this_action_cannot_be_undone.
  ///
  /// In en, this message translates to:
  /// **'This action cannot be undone.'**
  String get this_action_cannot_be_undone;

  /// No description provided for @if_you_re_sure_you_want_to_delete_your_account_please_click_the_button_below.
  ///
  /// In en, this message translates to:
  /// **'If you\\\'re sure you want to delete your account, please click the button below. Otherwise, you can simply close this screen to keep your account active.'**
  String get if_you_re_sure_you_want_to_delete_your_account_please_click_the_button_below;

  /// No description provided for @delete_my_account.
  ///
  /// In en, this message translates to:
  /// **'Delete My Account'**
  String get delete_my_account;

  /// No description provided for @thank_you_for_being_a_part_of_our_community.
  ///
  /// In en, this message translates to:
  /// **'Thank you for being a part of our community.'**
  String get thank_you_for_being_a_part_of_our_community;

  /// No description provided for @confirm_account_deletion.
  ///
  /// In en, this message translates to:
  /// **'Confirm Account Deletion'**
  String get confirm_account_deletion;

  /// No description provided for @are_you_absolutely_sure_you_want_to_delete_your_account_This_action_cannot_be_undone.
  ///
  /// In en, this message translates to:
  /// **'Are you absolutely sure you want to delete your account? This action cannot be undone.'**
  String get are_you_absolutely_sure_you_want_to_delete_your_account_This_action_cannot_be_undone;

  /// No description provided for @no_service_available.
  ///
  /// In en, this message translates to:
  /// **'No Service Available'**
  String get no_service_available;

  /// No description provided for @water_provider.
  ///
  /// In en, this message translates to:
  /// **'Water Provider'**
  String get water_provider;

  /// No description provided for @property_related_service.
  ///
  /// In en, this message translates to:
  /// **'Property Related Service'**
  String get property_related_service;

  /// No description provided for @kitchen_expert.
  ///
  /// In en, this message translates to:
  /// **'Kitchen Expert'**
  String get kitchen_expert;

  /// No description provided for @to_see_support_visit_propertier_website.
  ///
  /// In en, this message translates to:
  /// **'To See Support visit \\nPropertier Website.'**
  String get to_see_support_visit_propertier_website;

  /// No description provided for @visit_propertier_website.
  ///
  /// In en, this message translates to:
  /// **'Visit Propertier website?'**
  String get visit_propertier_website;

  /// No description provided for @team_earning.
  ///
  /// In en, this message translates to:
  /// **'Team Earning'**
  String get team_earning;

  /// No description provided for @criteria.
  ///
  /// In en, this message translates to:
  /// **'Criteria'**
  String get criteria;

  /// No description provided for @time_watch.
  ///
  /// In en, this message translates to:
  /// **'Time Watch'**
  String get time_watch;

  /// No description provided for @all_time.
  ///
  /// In en, this message translates to:
  /// **'All Time'**
  String get all_time;

  /// No description provided for @followers_gained.
  ///
  /// In en, this message translates to:
  /// **'Followers Gained'**
  String get followers_gained;

  /// No description provided for @using_more_features_kindly_login_first.
  ///
  /// In en, this message translates to:
  /// **'Using more features kindly\\nlogin first'**
  String get using_more_features_kindly_login_first;

  /// No description provided for @price_range.
  ///
  /// In en, this message translates to:
  /// **'Price Range'**
  String get price_range;

  /// No description provided for @please_select_location.
  ///
  /// In en, this message translates to:
  /// **'Please Select Location'**
  String get please_select_location;

  /// No description provided for @apply.
  ///
  /// In en, this message translates to:
  /// **'Apply'**
  String get apply;

  /// No description provided for @clear_all.
  ///
  /// In en, this message translates to:
  /// **'Clear All'**
  String get clear_all;

  /// No description provided for @additional_details.
  ///
  /// In en, this message translates to:
  /// **'Additional Details'**
  String get additional_details;

  /// No description provided for @name.
  ///
  /// In en, this message translates to:
  /// **'Name:'**
  String get name;

  /// No description provided for @enter_custom_size.
  ///
  /// In en, this message translates to:
  /// **'Enter Custom Size:'**
  String get enter_custom_size;

  /// No description provided for @add_custom.
  ///
  /// In en, this message translates to:
  /// **'Add Custom'**
  String get add_custom;

  /// No description provided for @detail_here.
  ///
  /// In en, this message translates to:
  /// **'Detail here...'**
  String get detail_here;

  /// No description provided for @set_location.
  ///
  /// In en, this message translates to:
  /// **'Set Location'**
  String get set_location;

  /// No description provided for @map.
  ///
  /// In en, this message translates to:
  /// **'Map'**
  String get map;

  /// No description provided for @current_locations.
  ///
  /// In en, this message translates to:
  /// **'Current Locations:'**
  String get current_locations;

  /// No description provided for @selected.
  ///
  /// In en, this message translates to:
  /// **'Selected:'**
  String get selected;

  /// No description provided for @locations.
  ///
  /// In en, this message translates to:
  /// **'Locations:'**
  String get locations;

  /// No description provided for @confirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirm;

  /// No description provided for @search_country_region.
  ///
  /// In en, this message translates to:
  /// **'Search Country/Region'**
  String get search_country_region;

  /// No description provided for @no_title.
  ///
  /// In en, this message translates to:
  /// **'No Title'**
  String get no_title;

  /// No description provided for @rs.
  ///
  /// In en, this message translates to:
  /// **'Rs'**
  String get rs;

  /// No description provided for @price_not_available.
  ///
  /// In en, this message translates to:
  /// **'Price Not Available'**
  String get price_not_available;

  /// No description provided for @are_you_sure.
  ///
  /// In en, this message translates to:
  /// **'Are you sure'**
  String get are_you_sure;

  /// No description provided for @do_you_want_to_go_back.
  ///
  /// In en, this message translates to:
  /// **'Do you want to go back!'**
  String get do_you_want_to_go_back;

  /// No description provided for @back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// No description provided for @no_address.
  ///
  /// In en, this message translates to:
  /// **'No Address'**
  String get no_address;

  /// No description provided for @added_recently.
  ///
  /// In en, this message translates to:
  /// **'Added Recently'**
  String get added_recently;

  /// No description provided for @get_service.
  ///
  /// In en, this message translates to:
  /// **'Get Service'**
  String get get_service;

  /// No description provided for @wallet_balance.
  ///
  /// In en, this message translates to:
  /// **'Wallet Balance'**
  String get wallet_balance;

  /// No description provided for @enter_amount.
  ///
  /// In en, this message translates to:
  /// **'Enter Amount'**
  String get enter_amount;

  /// No description provided for @amount.
  ///
  /// In en, this message translates to:
  /// **'Amount'**
  String get amount;

  /// No description provided for @please_enter_amount.
  ///
  /// In en, this message translates to:
  /// **'Please enter amount'**
  String get please_enter_amount;

  /// No description provided for @please_enter_a_valid_number.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid Number'**
  String get please_enter_a_valid_number;
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
