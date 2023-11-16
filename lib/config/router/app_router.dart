import 'package:cinemapedia/presentation/screens/screens.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(
  initialLocation: '/home/0',
  routes: [
    GoRoute(
      path: '/home/:page',
      name: HomeScreen.name,
      builder: (context, state) {
        final pageIndex = int.parse(state.pathParameters['page'] ?? '0');
        return HomeScreen(pageIndex: pageIndex);
      },
      routes: [
        GoRoute(
          path: 'movie/:id',
          name: MovieScreen.name,
          builder: (context, state) {
            final movieId = state.pathParameters['id'] ?? 'no-id';
            return MovieScreen(movieId: movieId);
          },
        ),
      ],
    ),
    GoRoute(
      path: '/',
      redirect: (_, state) => '/home/0',
    ),
  ],
);

/*
* /:id es el argumento.
* Los ids que recibamos aquí siempre van a ser los strings.
* path: 'movie/:id' - El slash delante de movie no es necesario,
* porque nos lo está dando el padre.
*
* Es bien común que cuando no necesitamos un argumento, pero lo tenemos
* que proporcionar a la fuerza, le podemos poner un "_" para decir
* "no me interesa".
* "__" El doble guión bajo es un nombre de variables. Es como tener en
* vez de _ a y en vez de __ b. Es una costumbre en Dart para decir que
* no necesito ninguno de estos dos argumentos.
*
* */
