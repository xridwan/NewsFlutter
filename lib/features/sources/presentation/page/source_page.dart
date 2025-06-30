import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:news_app/core/router/navigation_route.dart';
import 'package:news_app/core/widget/loading_widget.dart';
import 'package:news_app/features/sources/presentation/bloc/source_bloc.dart';
import 'package:news_app/features/sources/presentation/bloc/source_state.dart';
import 'package:news_app/features/sources/presentation/widget/app_bar_widget.dart';
import 'package:news_app/features/sources/presentation/widget/source_item_widget.dart';

import '../../../../core/widget/empty_data_widget.dart';
import '../bloc/source_event.dart';
import '../widget/bloc/search/search_visibility_bloc.dart';
import '../widget/bloc/search/search_visibility_event.dart';
import '../widget/bloc/search/search_visibility_state.dart';

class SourcePage extends StatefulWidget {
  const SourcePage({super.key});

  @override
  State<SourcePage> createState() => _SourcePageState();
}

class _SourcePageState extends State<SourcePage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          AppBarWidget(
            navigateToBookmark: () {
              context.push(NavigationRoute.bookmarkPage);
            },
            navigateToSettings: () {
              context.push(NavigationRoute.settingsPage);
            },
            onSearch: () async {
              context.read<SearchVisibilyBloc>().add(ToggleSearchVisibility());
            },
          ),
          const SizedBox(height: 16),
          BlocBuilder<SearchVisibilyBloc, SearchVisibilityState>(
            builder: (context, state) {
              final isVisible = state is SearchVisibilityShown;
              return AnimatedSwitcher(
                duration: Duration(milliseconds: 300),
                transitionBuilder: (child, animation) {
                  return SizeTransition(sizeFactor: animation, child: child);
                },
                child: isVisible
                    ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: TextField(
                          controller: _searchController,
                          onChanged: (value) async {
                            context.read<SourceBloc>().add(
                              SearchSources(_searchController.text),
                            );
                          },
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.black87,
                          ),
                          decoration: InputDecoration(
                            hintText: 'Searching...',
                            prefixIcon: Icon(Icons.search),
                            suffixIcon: IconButton(
                              icon: Icon(Icons.clear),
                              onPressed: () {
                                _searchController.clear();
                                context.read<SourceBloc>().add(
                                  SearchSources(''),
                                );
                              },
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                        ),
                      )
                    : const SizedBox(),
              );
            },
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                context.read<SourceBloc>().add(GetSources());
              },
              child: _buildSourceList(context),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSourceList(BuildContext context) {
    return BlocBuilder<SourceBloc, SourceState>(
      builder: (context, state) {
        if (state is SourceLoading) {
          return LoadingWidget();
        } else if (state is SourceLoaded) {
          if (state.sources.isEmpty) {
            return const EmptyDataWidget(message: 'Data is Empty');
          } else {
            return ListView.builder(
              itemCount: state.sources.length,
              itemBuilder: (context, index) {
                final source = state.sources[index];
                return SourceItemWidget(
                  source: source,
                  navigateToArticle: () {
                    context.push(
                      NavigationRoute.articlePage,
                      extra: {
                        'id': source.id,
                        'name': source.name,
                        'desc': source.description,
                      },
                    );
                  },
                );
              },
            );
          }
        } else if (state is SourceError) {
          return EmptyDataWidget(message: state.message);
        }
        return const SizedBox();
      },
    );
  }
}
