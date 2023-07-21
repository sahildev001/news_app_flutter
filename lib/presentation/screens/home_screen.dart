// lib/presentation/screens/home_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newa_app_test/data/repository/news_repository.dart';
import 'package:newa_app_test/utils/constants.dart';

import '../../widgets/news_list.dart';
import '../../widgets/news_swiper.dart';
import '../bloc/news_cubit.dart';

// lib/presentation/screens/home_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newa_app_test/data/repository/news_repository.dart';
import 'package:newa_app_test/utils/constants.dart';

import '../../widgets/news_list.dart';
import '../../widgets/news_swiper.dart';
import '../bloc/news_cubit.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final NewsRepository newsRepository = NewsRepository();

  bool openList = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<NewsCubit>().fetchLatestNews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Latest News'),
        actions: [
          BlocBuilder<NewsCubit, NewsState>(
            builder: (context, state) {
              return IconButton(
                onPressed: () {
                  setState(() {
                    openList = !openList;
                  });
                },
                icon: Icon(openList ? Icons.view_carousel : Icons.view_list),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [

         openList?  Container(
            height: 50,
            margin: EdgeInsets.only(left: 15, right: 15,top: 15),
            child: TextField(
              onChanged: (query) {
                context.read<NewsCubit>().searchNews(query);
              },
              decoration: InputDecoration(
                hintText: 'Search news',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: BorderSide(),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: BorderSide(color: Colors.blue),
                ),
              ),
            ),

         ):SizedBox.shrink(),
          Expanded(
            child: BlocBuilder<NewsCubit, NewsState>(
              builder: (context, state) {
                if (state is NewsLoading) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is NewsLoaded) {
                  if (openList) {
                    if (state.news.isEmpty) {
                      return Center(
                        child: Text("No news found"),
                      );
                    } else {
                      return NewsList(news: state.news);
                    }
                  } else {
                    print("open News Swiper");
                    if (state.news.isEmpty) {
                      return Center(
                        child: Text("No news found"),
                      );
                    } else {
                      return NewsSwiper(news: state.news);
                    }
                  }
                } else if (state is NewsError) {
                  return Center(
                    child: Text(state.errorMessage),
                  );
                }

                // Initial state or unknown state
                return SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    );
  }
}
