import 'package:http/http.dart' as http;
import 'package:kong/kong.dart';
import 'dart:convert';

const ACCOUNTS_ENDPOINT = "accounts";
const LOGIN_ENDPOINT = "login";
const Map<String, String> jsonHeaders = {
  'Content-Type': 'application/json; charset=UTF-8',
};


class KongAPIKonfig {
  KongAPIKonfig({this.apiHost, this.accountsEndpoint, this.loginEndpoint, this.authCookieName});
  final String? apiHost;
  final String? accountsEndpoint;
  final String? loginEndpoint;
  final String? authCookieName;
}

/// Kong API
class KongAPI {
  KongAPI({required this.konfig});
  final KongAPIKonfig konfig;

  /// Kpassport token obtained from cookie after login
  Map<String, String> kpassport = {};

  /// Create new account
  Future create(AccountCreationInput input) async {
    var accountsEndpoint = ACCOUNTS_ENDPOINT;

    if (konfig.accountsEndpoint != null) {
      accountsEndpoint = konfig.accountsEndpoint!;
    }

    // TODO: validate input

    final response = await http.post(
      Uri.parse("${konfig.apiHost}$accountsEndpoint"),
      headers: jsonHeaders,
      body: jsonEncode(input.toJson()),
    );

    switch (response.statusCode) {
      case 201:
        // return Public account data
        return PublicAccount.fromJson(jsonDecode(response.body));
      case 400:
        KongError.incorrectAccountInput;
        break;
      case 401:
        KongError.incorrectAccountInput;
        break;
      case 500:
        KongError.internalServerError;
    }
  }

  /// Account login
  Future login(
    AccountLoginInput input,
  ) async {
    var loginEndpoint = LOGIN_ENDPOINT;

    if (konfig.loginEndpoint != null) {
      loginEndpoint = konfig.loginEndpoint!;
    }

    final response = await http.post(
      Uri.parse("${konfig.apiHost}$loginEndpoint"),
      headers: jsonHeaders,
      body: jsonEncode(input.toJson()),
    );

    switch (response.statusCode) {
      case 200:
        // login successfull
        updateKpassport(response);
        break;
      case 400:
        KongError.incorrectLoginInput;
        break;
      case 401:
        KongError.incorrectLoginInput;
        break;
      case 404:
        KongError.userAccountNotFound;
        break;
      case 500:
        KongError.internalServerError;
    }
  }

  void updateKpassport(http.Response response) {
    String? rawCookie = response.headers['set-cookie'];
    if (rawCookie != null) {
      int index = rawCookie.indexOf(';');
      kpassport['cookie'] =
      (index == -1) ? rawCookie : rawCookie.substring(0, index);
    }
  }
}
