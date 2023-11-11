import 'package:cinemapedia/domain/entities/movie.dart';

abstract class MoviesDatasource {

  Future<List<Movie>> getNowPlaying({int page = 1});

  Future<List<Movie>> getPopular({int page = 1});

  Future<List<Movie>> getUpcoming({int page = 1});

  Future<List<Movie>> getTopRated({int page = 1});

  Future<Movie> getMovieById(String id);

  //Implementando la búsqueda
  Future<List<Movie>> searchMovies(String query);

}

/*
* Aquí en el Datasource vamos a definir como lucen los orígenes de datos
* que pueden traer películas. Puede ser de "TheMovieDB", de "IMDb". Puede
* ser de cualquier lado, puede ser de mi API propia.
* Este Datasource, esta clase va a definir los métodos que estas Clases
* van a tener o que vamos a poder llamar para traer esta data.
*
* Por ejemplo, yo sé que voy a tener algo como por ejemplo llamado
* "getNowPlaying()". Es decir que me traiga las películas que están
* actualmente en carelera, pero no voy a implementar el método.
* Simplemente voy a decir "lo necesito". Necesito que me espicifique
* la página, porque toodo esto va a ser paginado. No estamos definiendo
* cuál es el origen de datos, simplemente estamos definiendo cómo queremos
* que sea esto.
* Future<List<Movie>> getNowPlaying({int page = 1});
*
* Datasource es nuestro orígen de datos y el repositorio es quien va a llamar
* a datasource. Nosotrs vamos a llamar el Datasource y el Datasource no lo
* llamamos de manera directa. Lo llamamos através del repositorio.
* El repositorio es quien me va a permitir a cambiar el Datasource.
*
* Vamos a poder cambiar el orígen de datos fácilmente y su código no debería
* cambiar. Únicamente el Repositorio es el que va a cambiar el Datasource.
*
*
*
*
* */