import 'dart:async';
import 'package:flutter/material.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';

import 'package:pm_client_01/l10n/messages_all.dart';

class PMLocalizations {
  static Future<PMLocalizations> load(Locale locale) {
    
    final String name =
        locale.countryCode.isEmpty ? locale.languageCode : locale.toString();
    final String localeName = Intl.canonicalizedLocale(name);
    debugPrint("Locale name " +localeName);
    return initializeMessages(localeName).then((bool _) {
      Intl.defaultLocale = localeName;
      return new PMLocalizations();
    });
  }

  static PMLocalizations of(BuildContext context) {
    return Localizations.of<PMLocalizations>(context, PMLocalizations);
  }

  String get title {
    return Intl.message(
      'hi',
      name: 'title',
      desc: 'Title for the Demo application',
    );
  }

  String get pgLoginTitle {
    return Intl.message(
      'Welcome to Promise Me',
      name: 'pgLoginTitle',
      desc: 'title ',
    );
  }

  String get pgLoginTxtSelectUser {
    return Intl.message(
      'Select User to Login',
      name: 'pgLoginTxtSelectUser',
      desc: '',
    );
  }

  String get pgLoginBtnLogin {
    return Intl.message(
      'Login',
      name: 'pgLoginBtnLogin',
      desc: '',
    );
  }
  String get pgListTitle {
    return Intl.message(
      'Promise List',
      name: 'pgListTitle',
      desc: '',
    );
  }
  String get pgListTabAll {
    return Intl.message(
      'ALL',
      name: 'pgListTabAll',
      desc: '',
    );
  }
   String get pgListTabMy {
    return Intl.message(
      'My Promise',
      name: 'pgListTabMy',
      desc: '',
    );
  }
   String get pgListTabHis {
    return Intl.message(
      'His Promise',
      name: 'pgListTabHis',
      desc: '',
    );
  }
   String get pgNavPromise {
    return Intl.message(
      'Promise',
      name: 'pgNavPromise',
      desc: '',
    );
  }
   String get pgNavWallet {
    return Intl.message(
      'Wallet',
      name: 'pgNavWallet',
      desc: '',
    );
  }
   String get pgNavStat {
    return Intl.message(
      'Stat',
      name: 'pgNavStat',
      desc: '',
    );
  }
   String get pgDetailTitle {
    return Intl.message(
      'Promise Detail',
      name: 'pgDetailTitle',
      desc: '',
    );
  }
    String get pgDetailTxtComments {
    return Intl.message(
      'Comments',
      name: 'pgDetailTxtComments',
      desc: '',
    );
  }
   String get pgDetailTxtCommentHint {
    return Intl.message(
      'Please input your comments',
      name: 'pgDetailTxtCommentHint',
      desc: '',
    );
  }
   String get pgDetailBtnGood {
    return Intl.message(
      'GOOD',
      name: 'pgDetailBtnGood',
      desc: '',
    );
  }
   String get pgDetailBtnBad {
    return Intl.message(
      'BAD',
      name: 'pgDetailBtnBad',
      desc: '',
    );
  }
   String get pgDetailBtnPass {
    return Intl.message(
      'PASS',
      name: 'pgDetailBtnPass',
      desc: '',
    );
  }
  String get pgNewTitle {
    return Intl.message(
      'New Promise',
      name: 'pgNewTitle',
      desc: '',
    );
  }
   String get pgNewInputPromise {
    return Intl.message(
      'Promise',
      name: 'pgNewInputPromise',
      desc: '',
    );
  }
  String get pgNewInputExpireDate {
    return Intl.message(
      'Expire Date',
      name: 'pgNewInputExpireDate',
      desc: '',
    );
  }
   String get pgNewInputBonus {
    return Intl.message(
      'Bonus',
      name: 'pgNewInputBonus',
      desc: '',
    );
  }
  String get pgNewInputBonusHint {
    return Intl.message(
      'Select Bonus',
      name: 'pgNewInputBonusHint',
      desc: '',
    );
  }
  String get pgNewInputComments {
    return Intl.message(
      'Comments',
      name: 'pgNewInputComments',
      desc: '',
    );
  }
  String get pgNewTxtLove {
    return Intl.message(
      'Love',
      name: 'pgNewTxtLove',
      desc: '',
    );
  }
  String get pgNewTabGive {
    return Intl.message(
      'Give',
      name: 'pgNewTabGive',
      desc: '',
    );
  }
  String get pgNewTabRequest {
    return Intl.message(
      'Request',
      name: 'pgNewTabRequest',
      desc: '',
    );
  }

  
}

class PMLocalizationsDelegate extends LocalizationsDelegate<PMLocalizations> {
  const PMLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'zh'].contains(locale.languageCode);

  @override
  Future<PMLocalizations> load(Locale locale) {
    // Returning a SynchronousFuture here because an async "load" operation
    // isn't needed to produce an instance of PMLocalizations.
    //return new SynchronousFuture<PMLocalizations>(new PMLocalizations(locale));
    return PMLocalizations.load(locale);
  }

  @override
  bool shouldReload(PMLocalizationsDelegate old) => false;
}
