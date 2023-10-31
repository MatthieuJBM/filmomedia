import 'package:flutter/material.dart';

class MovieScreen extends StatelessWidget {
  static const name = 'movie-screen';

  final String movieId;

  const MovieScreen({super.key, required this.movieId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MovieID: $movieId'),
      ),
    );
  }
}

/*
* Recibimos solamentee un movieId por varias razones.
* Puede que no haya un objeto de tipo Movie en algún momento,
* por eso es mejor recibir aquí solamente el movieId.
* */
