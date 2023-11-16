import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/infrastructure/models/moviedb/movie_moviedb.dart';

import '../models/moviedb/movie_details.dart';

class MovieMapper {
  static Movie movieDBToEntity(MovieMovieDB moviedb) => Movie(
        adult: moviedb.adult,
        backdropPath: (moviedb.backdropPath != '')
            ? 'https://image.tmdb.org/t/p/w500${moviedb.backdropPath}'
            : 'https://sd.keepcalms.com/i-w600/keep-calm-poster-not-found.jpg',
        genreIds: moviedb.genreIds.map((e) => e.toString()).toList(),
        id: moviedb.id,
        originalLanguage: moviedb.originalLanguage,
        originalTitle: moviedb.originalTitle,
        overview: moviedb.overview,
        popularity: moviedb.popularity,
        posterPath: (moviedb.posterPath != '')
            ? 'https://image.tmdb.org/t/p/w500${moviedb.posterPath}'
            : 'https://static.vecteezy.com/system/resources/thumbnails/022/014/063/small/missing-picture-page-for-website-design-or-mobile-app-design-no-image-available-icon-vector.jpg',
        releaseDate: moviedb.releaseDate != null ? moviedb.releaseDate! : DateTime.now(),
        //test: moviedb.title,
        test2: 2.5,
        //test2: moviedb.title,
        title: moviedb.title,
        video: moviedb.video,
        voteAverage: moviedb.voteAverage,
        voteCount: moviedb.voteCount,
      );

  static Movie movieDetailsToEntity(MovieDetails moviedb) => Movie(
        adult: moviedb.adult,
        backdropPath: (moviedb.backdropPath != '')
            ? 'https://image.tmdb.org/t/p/w500${moviedb.backdropPath}'
            : 'https://sd.keepcalms.com/i-w600/keep-calm-poster-not-found.jpg',
        genreIds: moviedb.genres.map((e) => e.name).toList(),
        id: moviedb.id,
        originalLanguage: moviedb.originalLanguage,
        originalTitle: moviedb.originalTitle,
        overview: moviedb.overview,
        popularity: moviedb.popularity,
        posterPath: (moviedb.posterPath != '')
            ? 'https://image.tmdb.org/t/p/w500${moviedb.posterPath}'
            : 'no-poster',
        releaseDate: moviedb.releaseDate,
        //test: moviedb.title,
        test2: 2.3,
        //test2: moviedb.title,
        title: moviedb.title,
        video: moviedb.video,
        voteAverage: moviedb.voteAverage,
        voteCount: moviedb.voteCount,
      );
}

/*
* El mapper va a tener como única misión leer diferentes
* modelos y crear mi entidad.
* El objetivo de mapper es tomar la implementación específica de
* TheMovieDB y que me sirva a mí para transformarlo a mi entidad.
* Esta capa, es una capa de protección del API que viene de afuera
* con nuestra aplicación.
* */

/*
* Si necesitamos otro tipo de objeto entonces perfectamente podemos
* crearnos otra entidad o un objeto que extienda de la entidad o un
* objeto que reciba los argumentos que en este MovieDetails nosotros
* vamos a tener, que no disponemos en nuestro objeto original.
* El hecho no es tratar de implementar directamente lo que viene del API.
* Nosotros tenemos que aplicar algún tipo de capa que nos proteja de
*  cambios innecesarios. Si API cambia, nosotros solo deberíamos cambiar
* este lugar y no toda la aplicación. Ése es el objetivo de lo que estamos
*  haciendo aquí.
*
* */