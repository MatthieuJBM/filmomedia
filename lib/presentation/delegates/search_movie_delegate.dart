import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:cinemapedia/config/helpers/human_formats.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/movie.dart';

typedef SearchMoviesCallback = Future<List<Movie>> Function(String query);

class SearchMovieDelegate extends SearchDelegate<Movie?> {
  final SearchMoviesCallback searchMovies;
  List<Movie> initialMovies;

  StreamController<List<Movie>> debouncedMovies = StreamController.broadcast();
  StreamController<bool> isLoadingStream = StreamController.broadcast();

  Timer? _debounceTimer;

  SearchMovieDelegate({
    required this.searchMovies,
    required this.initialMovies,
  }) : super(
          searchFieldLabel: 'Buscar película',
          textInputAction: TextInputAction.done,
        );

  void clearStreams() {
    debouncedMovies.close();
  }

  void _onQueryChanged(String query) {
    isLoadingStream.add(true);

    if (_debounceTimer?.isActive ?? false) _debounceTimer!.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 500), () async {
      // if (query.isEmpty) {
      //   debouncedMovies.add([]);
      //   return;
      // }

      final movies = await searchMovies(query);
      initialMovies = movies; // Con esto evitamos el doble posteo de http
      debouncedMovies.add(movies);
      isLoadingStream.add(false);
    });
  }

  Widget buildResultsAndSuggestions() {
    return StreamBuilder(
      initialData: initialMovies,
      stream: debouncedMovies.stream,
      builder: (context, snapshot) {
        final movies = snapshot.data ?? [];
        return ListView.builder(
          itemCount: movies.length,
          itemBuilder: (context, index) => _MovieItem(
            movie: movies[index],
            onMovieSelected: (context, movie) {
              clearStreams();
              close(context, movie);
            },
          ),
        );
      },
    );
  }

  // @override
  // String get searchFieldLabel => 'Buscar película';

  // Para construir las acciones.
  @override
  List<Widget>? buildActions(BuildContext context) {
    print('query: $query');
    return [
      StreamBuilder(
        initialData: false,
        stream: isLoadingStream.stream,
        builder: (context, snapshot) {
          if (snapshot.data ?? false) {
            return SpinPerfect(
              duration: const Duration(seconds: 20),
              spins: 10,
              infinite: true,
              child: FadeIn(
                animate: query.isNotEmpty,
                child: IconButton(
                  onPressed: () => query = '',
                  icon: const Icon(Icons.refresh_rounded),
                ),
              ),
            );
          }
          return FadeIn(
            animate: query.isNotEmpty,
            child: IconButton(
              onPressed: () => query = '',
              icon: const Icon(Icons.clear),
            ),
          );
        },
      ),
    ];
  }

  // Para construir un ícono o la parte de aquí al inicio.
  @override
  Widget? buildLeading(BuildContext context) {
    // null porque la persona no seloccionó ninguna película
    return IconButton(
      onPressed: () {
        clearStreams();
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back_ios_new_rounded),
    );
  }

  // Los resultados que van a aparecer cuando la persona presione "Enter".
  @override
  Widget buildResults(BuildContext context) {
    return buildResultsAndSuggestions();
  }

  // Cuando la persona está escribiendo, qué es lo que quiero hacer.
  @override
  Widget buildSuggestions(BuildContext context) {
    _onQueryChanged(
        query); // Aquí llamamos onQueryChanged para aplicar nuestro debouncer.
    return buildResultsAndSuggestions();
  }
}

class _MovieItem extends StatelessWidget {
  final Movie movie;
  final Function onMovieSelected;

  const _MovieItem(
      {super.key, required this.movie, required this.onMovieSelected});

  @override
  Widget build(BuildContext context) {
    final textStyles = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        onMovieSelected(context, movie);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Row(
          children: [
            // Image
            SizedBox(
              width: size.width * 0.2,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  movie.posterPath,
                  loadingBuilder: (context, child, loadingProgress) =>
                      FadeIn(child: child),
                ),
              ),
            ),

            const SizedBox(width: 10),

            // Description
            SizedBox(
              width: size.width * 0.7,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(movie.title, style: textStyles.titleMedium),
                  (movie.overview.length > 100)
                      ? Text('${movie.overview.substring(0, 100)}...')
                      : Text(movie.overview),
                  Row(
                    children: [
                      Icon(
                        Icons.star_half_rounded,
                        color: Colors.yellow.shade800,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        HumanFormats.number(movie.voteAverage, 1),
                        style: textStyles.bodyMedium!
                            .copyWith(color: Colors.yellow.shade900),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/*
* El query es una palabra reservada en este "SearchDelegate", que ya no
* lo ofrece este "SearchDelegate". Si cambiamos este valor, vamos a cambiar
* ese valor de manera física. Es decir, cuando yo toque ese botón, quiero
* que el query, que es lo que tengo aquí en la barra de búsqueda, sea igual
* a un String vacío.
*
* Cuántas peticiones se disparan escribiendo, lo podemos controlar con
* debounce.
*
* typedef SearchMoviesCallback = Future<List<Movie>> Function(String query);
* Tiene que ser una función que cumpla esta firma. Esto es lo que estoy
* esperando. Estoy esperando un "Future<List<Movie>>".  Cualquier
* implementación que cumpla la firma que estoy definiendo aquí esp está
* bien.
*
* StreamController debounceMovies = StreamController.broadcast();
* si hacemos el Stream sin .broadcast() solo va a poder tener un listener.
* Pero puede ser que haya varios lugares en los cuales se esté esuchando
* este Stream. Si sabemos que sólo va a haber un solo widget que esté
* escuchando lo podemos dejar sin .broadcast, pero si no lo sabemos
* es mejor siempre añadir .broadcast.
*
* */
