import 'dart:async';
import 'package:flutter/material.dart';

//import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';
//import 'dart:async';
import 'package:pm_client_01/l10n/messages_all.dart';


class PMLocalizations {
  
  static Future<PMLocalizations> load(Locale locale) {
    debugPrint("Locale " + locale.toString());
    final String name = locale.countryCode.isEmpty ? locale.languageCode : locale.toString();
    final String localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((bool  _) {
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

