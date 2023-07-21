import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:newa_app_test/presentation/bloc/news_cubit.dart';
import 'package:newa_app_test/presentation/screens/splash_screen.dart';

import 'data/repository/news_repository.dart';



void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GlobalLoaderOverlay(
      child: MultiBlocProvider(
        providers: [
          BlocProvider<NewsCubit>(
            create: (context) => NewsCubit(newsRepository: NewsRepository()),
          ),
        ],
        child: MaterialApp(
          title: 'Sahil News Application test.',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: SplashScreen(),
        ),
      ),
    );
  }
}
