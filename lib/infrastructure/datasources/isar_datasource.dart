import 'package:cinemapedia/domain/datasources/local_storage_datasource.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class IsarDatasource extends LocalStorageDatasource {
  late Future<Isar> db;

  IsarDatasource() {
    db = openDB();
  }

  Future<Isar> openDB() async {
    final dir = await getApplicationDocumentsDirectory();
    if (Isar.instanceNames.isEmpty) {
      return await Isar.open(
        [MovieSchema],
        inspector: true,
        directory: dir.path,
      );
    }
    return Future.value(Isar.getInstance());
  }

  @override
  Future<bool> isMovieFavorite(int movieId) async {
    final isar = await db;

    final Movie? isFavoriteMovie =
        await isar.movies.filter().idEqualTo(movieId).findFirst();

    return isFavoriteMovie != null;
  }

  @override
  Future<void> toggleFavorite(Movie movie) async {
    final isar = await db;

    final favoriteMovie =
        await isar.movies.filter().idEqualTo(movie.id).findFirst();

    if (favoriteMovie != null) {
      // Borrar
      isar.writeTxnSync(() => isar.movies.deleteSync(favoriteMovie.isarId!));
      return;
    }

    // Insertar
    isar.writeTxnSync(() => isar.movies.putSync(movie));
  }

  @override
  Future<List<Movie>> loadMovies({int limit = 10, offset = 0}) async {
    final isar = await db;
    return isar.movies.where().offset(offset).limit(limit).findAll();
  }
}

/*
* ¿Por qué "late" y "Future<Isar>"? Porque la apertura de la base de datos
* no es una tarea síncrona. Por lo cual nosotros vamos a tener que esperar
* antes de poder realizar cualquier tipo de trabajo tenemos que esperar
* a que la base de datos esté lista para aceptar conexiones y podemos
* hacer eso.
*
* El inspector me va a permitir a mí poder tener un servicio y
* automáticamente "Isar" lo va a levantar para que yo pueda analizar
* cómo está la base de datps local en el dispositivo.
*
* La palabra isar es la que ocupamos para empezar a disparar todos
* nuestros queries e interacciones con la base de datos. Simplemente
* isar.(lo que queremos hacer).
* */
