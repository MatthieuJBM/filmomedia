import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/providers/movies/movies_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final nowPlayingMoviesProvider =
    StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
  final fetchMoreMovies = ref.watch(movieRepositoryProvider).getNowPlaying;

  return MoviesNotifier(
    fetchMoreMovies: fetchMoreMovies,
  );
});

typedef MovieCallback = Future<List<Movie>> Function({int page});

class MoviesNotifier extends StateNotifier<List<Movie>> {
  int currentPage = 0;
  MovieCallback fetchMoreMovies;

  MoviesNotifier({
    required this.fetchMoreMovies,
  }) : super([]);

  Future<void> loadNextPage() async {
    currentPage++;
    final List<Movie> movies = await fetchMoreMovies(page: currentPage);
    state = [...state, ...movies];
  }
}

/*
* typedef MovieCallback = Future<List<Movie>> Function({int page});
* ¿Cuál es el objetivo de esto?
* Simplemente definir el caso de uso. Que mi "MoviesNotifier", para
* cargar las siguientes películas simplemente va a recibir esta
* función.
* Nuevamente defino que tipo de "callback" es el que espero que
* tiene que cumplir esta firma porque así quiero que funcione esta
* función, valga la redundancia.
* Cada vez que yo mande a llamar este "state". O sea, cada vez que
* yo lo cambio de esta manera o de cualquier manera que yo le diga
* "state" va a ser igual a otra cosa entonces Riverpod se va
* a encargar de notificarlo porque es un StateNotifier.
* Cuando el estado cambia, notifica.
*
* */
