import 'package:cinemapedia/infrastructure/datasources/isar_datasource.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../infrastructure/repositories/local_storage_repository_impl.dart';

final localStorageRepositoryProvider = Provider((ref) {
  return LocalStorageRepositoryImpl(IsarDatasource());
});

/*
* Este LocalStorageRepositoryProvider me va a permitir a mí simplemente
* tener un provider de Riverpod en el cual va a estar esta instancia creada.
* Esta instancia de nuestro repositorio, el cual simplemente va a tener
* todos los métodos que ocupamos para poder llegar a él.
* */