import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/article_provider.dart';
import 'article_item.dart';

class ArticleList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ArticleProvider>(
      builder: (context, articleProvider, child) {
        return ListView.builder(
          itemCount: articleProvider.articles.length,
          itemBuilder: (context, index) {
            return ArticleItem(article: articleProvider.articles[index]);
          },
        );
      },
    );
  }
}
