import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

/// 全局状态，对应 React 版本的 AppContext
class AppState extends ChangeNotifier {
  // ---------- 用户设置 ----------
  String _language = 'en';
  String _level = 'beginner';
  int _dailyGoal = 15;
  bool _isOnboarded = false;

  // ---------- 学习统计 ----------
  int _streak = 0;
  int _totalDays = 0;
  int _totalHours = 0;
  int _masteredWords = 68;
  int _masteredSentences = 42;
  int _masteredAdvanced = 15;

  // ---------- 今日学习时长 ----------
  int _learningTime = 0;
  bool _showGoalPopup = false;

  // ---------- 收藏 ----------
  Set<String> _favorites = {};

  // ---------- Getters ----------
  String get language => _language;
  String get level => _level;
  int get dailyGoal => _dailyGoal;
  bool get isOnboarded => _isOnboarded;
  int get streak => _streak;
  int get totalDays => _totalDays;
  int get totalHours => _totalHours;
  int get masteredWords => _masteredWords;
  int get masteredSentences => _masteredSentences;
  int get masteredAdvanced => _masteredAdvanced;
  int get learningTime => _learningTime;
  bool get showGoalPopup => _showGoalPopup;
  Set<String> get favorites => _favorites;

  // ---------- 初始化（从 SharedPreferences 读取） ----------
  Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    _language = prefs.getString('language') ?? 'en';
    _level = prefs.getString('level') ?? 'beginner';
    _dailyGoal = prefs.getInt('dailyGoal') ?? 15;
    _isOnboarded = prefs.getBool('isOnboarded') ?? false;
    _streak = prefs.getInt('streak') ?? 0;
    _totalDays = prefs.getInt('totalDays') ?? 0;
    _totalHours = prefs.getInt('totalHours') ?? 0;
    _masteredWords = prefs.getInt('masteredWords') ?? 68;
    _masteredSentences = prefs.getInt('masteredSentences') ?? 42;
    _masteredAdvanced = prefs.getInt('masteredAdvanced') ?? 15;
    _learningTime = prefs.getInt('todayLearningTime') ?? 0;
    final favJson = prefs.getString('favorites');
    if (favJson != null) {
      final List list = jsonDecode(favJson);
      _favorites = list.cast<String>().toSet();
    }
  }

  Future<void> _save(Future<void> Function(SharedPreferences) fn) async {
    final prefs = await SharedPreferences.getInstance();
    await fn(prefs);
  }

  void setLanguage(String lang) {
    _language = lang;
    _save((p) async => p.setString('language', lang));
    notifyListeners();
  }

  void setLevel(String lvl) {
    _level = lvl;
    _save((p) async => p.setString('level', lvl));
    notifyListeners();
  }

  void setDailyGoal(int goal) {
    _dailyGoal = goal;
    _save((p) async => p.setInt('dailyGoal', goal));
    notifyListeners();
  }

  void setIsOnboarded(bool value) {
    _isOnboarded = value;
    _save((p) async => p.setBool('isOnboarded', value));
    notifyListeners();
  }

  void toggleFavorite(String item) {
    final newSet = Set<String>.from(_favorites);
    if (newSet.contains(item)) {
      newSet.remove(item);
    } else {
      newSet.add(item);
    }
    _favorites = newSet;
    _save((p) async => p.setString('favorites', jsonEncode(newSet.toList())));
    notifyListeners();
  }

  void setShowGoalPopup(bool show) {
    _showGoalPopup = show;
    notifyListeners();
  }

  void addLearningTime(int minutes) {
    final prev = _learningTime;
    _learningTime += minutes;
    if (prev < _dailyGoal && _learningTime >= _dailyGoal) {
      _showGoalPopup = true;
      _streak++;
      _totalDays++;
      _totalHours += (_learningTime ~/ 60);
      _save((p) async {
        p.setInt('streak', _streak);
        p.setInt('totalDays', _totalDays);
        p.setInt('totalHours', _totalHours);
      });
    }
    _save((p) async => p.setInt('todayLearningTime', _learningTime));
    notifyListeners();
  }
}
