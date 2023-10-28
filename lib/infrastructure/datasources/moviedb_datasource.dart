import 'package:cinemapedia/config/constants/environment.dart';
import 'package:cinemapedia/domain/datasources/movies_datasource.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/infrastructure/mappers/movie_mapper.dart';
import '../models/moviedb/moviedb_response.dart';

import 'package:dio/dio.dart';

class MovieDbDatasource extends MoviesDatasource {
  // baseUrl quiere decir que cuando voy a utilizar esta instancia dio
  // todas las peticiones van a tener esa base del URL precargada
  // o preconfigurada.
  final dio = Dio(
      BaseOptions(baseUrl: 'https://api.themoviedb.org/3', queryParameters: {
    'api_key': Environment.theMovieDbKey,
    'language': 'es-MX',
  }));

  List<Movie> _jsonToMovies(Map<String, dynamic> json) {
    final movieDBResponse = MovieDbResponse.fromJson(json);
    final List<Movie> movies = movieDBResponse.results
    .where((moviedb) => moviedb.posterPath != 'no-poster')
    .map((moviedb) => MovieMapper.movieDBToEntity(moviedb))
    .toList();
    return movies;
  }

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) async {
    final response = await dio.get(
      '/movie/now_playing',
      queryParameters: {
        'page': page,
      },
    );

    // final movieDBResponse = MovieDbResponse.fromJson(response.data);
    //
    // final List<Movie> movies = movieDBResponse.results
    //     .where((moviedb) => moviedb.posterPath != 'no-poster')
    //     .map((moviedb) => MovieMapper.movieDBToEntity(moviedb))
    //     .toList();
    //
    // return movies;

    return _jsonToMovies(response.data);
  }

  @override
  Future<List<Movie>> getPopular({int page = 1}) async {
    final response = await dio.get(
      '/movie/popular',
      queryParameters: {
        'page': page,
      },
    );

    return _jsonToMovies(response.data);
  }

  @override
  Future<List<Movie>> getUpcoming({int page = 1}) async {
    final response = await dio.get(
      '/movie/upcoming',
      queryParameters: {
        'page': page,
      }
    );
    return _jsonToMovies(response.data);
  }

  @override
  Future<List<Movie>> getTopRated({int page = 1}) async {
    final response = await dio.get(
      '/movie/top_rated',
      queryParameters: {
        'page': page,
      }
    );
    return _jsonToMovies(response.data);
  }


}

/*
* Si no viene el póster, no me interesa esa película. No la quiero
* mostrar ahí. ¿Cómo hacemos este filtro? Una de las maneras más
* sencillas es que, como es una lista, la podemos pasar por el método
* "where()". Esto se como un filtro. Si la condición es "true",
* lo deja pasar. Si no, entonces simplemente filtra ese resultado.
*
* */
