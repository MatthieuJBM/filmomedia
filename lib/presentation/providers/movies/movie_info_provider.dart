import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/providers/movies/movies_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final movieInfoProvider = StateNotifierProvider<MovieMapNotifier, Map<String, Movie>>((ref) {

  final movieRepository = ref.watch(movieRepositoryProvider);

  return MovieMapNotifier(getMovie: movieRepository.getMovieById);
});

typedef GetMovieCallback = Future<Movie> Function(String movieId);

class MovieMapNotifier extends StateNotifier<Map<String, Movie>> {

  final GetMovieCallback getMovie;

  MovieMapNotifier({required this.getMovie}): super({});

  Future<void> loadMovie(String movieId) async {
    if(state[movieId] != null) return;
    print("Realizando petición http");
    final movie = await getMovie(movieId);
    state = {...state, movieId: movie};

  }

}

/*
* Como vamos a esperar una función que específicamente regrese algo,
* podemos crearnos un nuevo "typedef". Va a ser una función que tiene
* que regresarme una película.
*
* Clonamos el estado utilizando toodo el spread del estado anterior.
*
* */