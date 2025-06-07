import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:news_app/core/widget/empty_data_widget.dart';
import 'package:news_app/core/widget/loading_widget.dart';
import 'package:news_app/features/articles/presenter/bloc/article_bloc.dart';
import 'package:news_app/features/articles/presenter/widget/app_bar_widget.dart';

import '../../../../core/router/navigation_route.dart';
import '../bloc/article_event.dart';
import '../bloc/article_state.dart';
import '../widget/article_item_widget.dart';

class ArticlePage extends StatelessWidget {
  final String id;
  final String name;
  final String description;

  const ArticlePage({
    super.key,
    required this.id,
    required this.name,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    context.read<ArticleBloc>().add(GetArticles(id));
    return Scaffold(
      body: Column(
        children: [
          AppBarWidget(
            title: name,
            desc: description,
            navigateBack: () {
              context.pop();
            },
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                context.read<ArticleBloc>().add(GetArticles(id));
              },
              child: BlocBuilder<ArticleBloc, ArticleState>(
                builder: (context, state) {
                  if (state is ArticleLoading) {
                    return LoadingWidget();
                  } else if (state is ArticleLoaded) {
                    if (state.articles.isEmpty) {
                      return const EmptyDataWidget(message: 'Data is Empty');
                    } else {
                      return ListView.builder(
                        itemCount: state.articles.length,
                        itemBuilder: (context, index) {
                          final article = state.articles[index];
                          return ArticleItemWidget(
                            article: article,
                            navigateToDetail: () {
                              context.push(
                                NavigationRoute.detailPage,
                                extra: article,
                              );
                            },
                          );
                        },
                      );
                    }
                  } else if (state is ArticleError) {
                    return EmptyDataWidget(message: state.message);
                  }
                  return const SizedBox();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
