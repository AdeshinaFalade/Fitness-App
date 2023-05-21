import 'dart:convert';
import 'dart:core';
import 'package:flutter_practice/data/session.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SPHelper{
  static late SharedPreferences prefs;

  Future init() async {
    prefs = await SharedPreferences.getInstance();
  }

  Future writeSession(Session session) async {
    prefs.setString(session.id.toString(), jsonEncode(session.toJson()));
  }

  List<Session> getSessions(){
    List<Session> sessions = [];
    Set<String> keys = prefs.getKeys();
    for (String key in keys) {
      if (key != 'counter') {
        Session session = Session.fromJson(
            json.decode(prefs.getString(key) ?? ''));
        sessions.add(session);
      }
    }
    return sessions;
  }

  Future setCounter() async {
    var counter = prefs.getInt('counter') ?? 0;
    counter++;
    await prefs.setInt('counter', counter);
  }

  int getCounter(){
    return prefs.getInt('counter') ?? 0;
  }

  Future deleteSession(int id) async {
    prefs.remove(id.toString());
  }
}