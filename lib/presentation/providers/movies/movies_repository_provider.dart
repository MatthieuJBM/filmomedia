import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cinemapedia/infrastructure/repositories/movie_repository_impl.dart';
import 'package:cinemapedia/infrastructure/datasources/moviedb_datasource.dart';

// Este repositorio es inmutable. Su objetivo es básicamente
// proporcionar a todos los demás providers que tengo ahí
// dentro la información necesaria para que puedan consultar
// la información de este "RepositoryImpl", para que puedan
// consultar toodo lo que estoy proporcionando aquí.
final movieRepositoryProvider = Provider((ref) {
  return MovieRepositoryImpl(MovieDbDatasource());
});

/*
* Este nueve archivo va a ser quien va a crear la instancia de ese
* "MovieRepositoryImpl" y le voy a poner "movies_repository_provider"
* porque quiero proveer mi repositorio. Como esto va a ser  un archivo
* que yo no lo voy a cambiar, es decir una vez lo creo, ya no va a ser
* modificado nunca más en su existencia, entonces puede ser un provider
* únicamente de lectura.
*
* Toodo el objetivo de esta clase va a ser que nosotros proporcionemos
* nuestro "MovieRepositoryImpl" de manera global para que en cualquier
* otro provider yo tenga acceso a esa información.
*
* Como este provider nunca va a cambiar. Entiéndase, "nunca va a cambiar"
* en el aspecto de que la data que contiene no cambia. Los providers que
* les voy a enseñar a continuación que ya hemos visto son de solo lectura.
*
* Riverpod ofrece diferentes providers. Ofrece el "StateNotifierProvider",
* el "Provider" normal, el "StreamProvider", "FutureProvider". Todos están
* destinados a algún tipo de data en particular, pero con los que hemos
* visto hasta el momento tenemos más que suficiente por ahora.
* */
