import 'package:flutter/material.dart';

import '../../../domain/entities/movie.dart';

class MovieHorizontalListview extends StatelessWidget {

  final List<Movie> movies;
  final String? title;
  final String? subTitle;
  final VoidCallback? loadNextPage;

  const MovieHorizontalListview({super.key, required this.movies, this.title, this.subTitle, this.loadNextPage});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
