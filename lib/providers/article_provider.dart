import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/article.dart';

class ArticleProvider with ChangeNotifier {
  List<Article> _articles = [];
  int _page = 1;
  bool _isLoading = false;
  String? _searchKeyword;

  List<Article> get articles => _articles;

  bool get isLoading => _isLoading;

  Future<void> fetchArticles({String? keyword}) async {
    if (_isLoading) return;
    _isLoading = true;
    notifyListeners();

    if (keyword != _searchKeyword) {
      _articles = [];
      _page = 1;
      _searchKeyword = keyword;
    }

    final url = keyword == null || keyword.isEmpty
        ? 'https://api.spaceflightnewsapi.net/v4/articles/?_limit=10&_start=${(_page - 1) * 10}'
        : 'https://api.spaceflightnewsapi.net/v4/articles/?title_contains=$keyword&_limit=10&_start=${(_page - 1) * 10}';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body)['results'];
        _articles.addAll(data.map((json) => Article.fromJson(json)).toList());
        _page++;
      } else {
        throw Exception('Failed to load articles');
      }
    } catch (error) {
      throw error;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
