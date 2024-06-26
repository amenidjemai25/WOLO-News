import 'package:flutter/material.dart';
import '../models/article.dart';
import '../screens/article_detail_screen.dart';

class ArticleItem extends StatelessWidget {
  final Article article;

  ArticleItem({required this.article});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.network(article.imageUrl),
      title: Text(article.title),
      subtitle: Text(article.newsSite),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ArticleDetailScreen(article: article),
          ),
        );
      },
    );
  }
}
