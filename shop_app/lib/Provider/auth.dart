import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'package:shop_app/Models/http_exception.dart';

class Auth with ChangeNotifier {
  String? _token;
  DateTime? _expiryDate;
  String? _userId;
  Timer? _authTimer;

  bool get isAuth {
    return token != null;
  }

  String? get token {
    if (_token != null && _expiryDate != null) {
      if (_expiryDate!.isAfter(DateTime.now())) {
        return _token;
      }
    }
    return null;
  }

  String? get userId {
    return _userId;
  }

  Future<void> _authenticateUser(
      String email, String password, String method) async {
    final url = Uri.parse(
        "https://identitytoolkit.googleapis.com/v1/accounts:$method?key=AIzaSyAgANKf_lQGnspbhn-tqaEsF-ZijxsWVHo");
    try {
      final res = await http.post(url,
          body: json.encode({
            'email': email,
            'password': password,
            'returnSecureToken': true
          }));
      final resBody = json.decode(res.body);
      if (resBody['error'] != null) {
        throw httpException(message: resBody['error']['message']);
      }
      print("response");
      _token = resBody['idToken'];
      _userId = resBody['localId'];
      _expiryDate = DateTime.now().add(
        Duration(
          seconds: int.parse(
            resBody['expiresIn'],
          ),
        ),
      );
      _autoLogOut();
      notifyListeners();
      final prefers = await SharedPreferences.getInstance();
      final userData = json.encode({
        'token': _token,
        'userId': _userId,
        'expiryDate': _expiryDate!.toIso8601String()
      });
      prefers.setString('userData', userData);
    } catch (e) {
      throw e;
    }
  }

  Future<bool> tryAutoLogIn() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData')) {
      return false;
    }

    final extractedUserData =
        json.decode(prefs.getString('userData')!) as Map<String, dynamic>;
    final expiryDate =
        DateTime.parse(extractedUserData['expiryDate'] as String);

    if (expiryDate.isBefore(DateTime.now())) {
      return false;
    }

    _token = extractedUserData['token'] as String;
    _userId = extractedUserData['userId'] as String;
    _expiryDate = expiryDate;
    notifyListeners();
    _autoLogOut();
    return true;
  }

  Future<void> authSingUp(String email, String password) {
    return _authenticateUser(email, password, "signUp");
  }

  Future<void> authSingIn(String email, String password) {
    return _authenticateUser(email, password, "signInWithPassword");
  }

  Future<void> logOut() async {
    _token = null;
    _expiryDate = null;
    _userId = null;
    if (_authTimer != null) {
      _authTimer!.cancel();
      _authTimer = null;
    }

    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  void _autoLogOut() {
    if (_authTimer != null) {
      _authTimer!.cancel();
    }
    var timeToExpire = 0;
    if (_expiryDate != null) {
      timeToExpire = _expiryDate!.difference(DateTime.now()).inSeconds;
    }
    _authTimer = Timer(Duration(seconds: timeToExpire), logOut);
  }
}
