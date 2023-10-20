import 'package:cinemapedia/domain/datasources/movies_datasource.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/domain/repositories/movies_repository.dart';

class MovieRepositoryImpl extends MoviesRepository {
  final MoviesDatasource datasource;

  MovieRepositoryImpl(this.datasource);

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) {
    return datasource.getNowPlaying(page: page);
  }
}

/*
* En moviedb_datasource no hemos añadido _impl porque es claro, por
* el nombre movieDB que indica que es una implementación.
*
* Lo que nosotros tenemos que hacer aquí en nuestra implementación es
* mandar a llamar el Datasource para que llame este "getNowPlaying".
*
* ¿Para qué estamos haciendo toodo eso? Para que yo fácilmente pueda
* cambiar los orígenes de datos pero caundo yo esté con mis Providers
* de Riverpod simplemente llamo esta implementación MovieRepositoryImpl
* y esa implementación ya va a tener el Datasource y fácilmente puedo
* mandar a llamar toodo el mecanismo de funcionalidad.
* */
