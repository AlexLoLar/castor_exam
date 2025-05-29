import 'package:castor_exam/config/routes/app_routes.dart';
import 'package:castor_exam/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:castor_exam/features/favorites/presentation/bloc/favorites_bloc.dart';
import 'package:castor_exam/features/libreries/presentation/bloc/library_bloc.dart';
import 'package:castor_exam/features/player/presentation/bloc/player_bloc.dart';
import 'package:castor_exam/features/search/presentation/bloc/search_bloc.dart';
import 'package:castor_exam/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'injection_container.dart' as di;

void main() async {
  // Asegúrate de que Flutter esté inicializado
  WidgetsFlutterBinding.ensureInitialized();

  await di.setupDependencies();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => getIt<AuthBloc>(),
        ),
        BlocProvider<SearchBloc>(
          create: (context) => getIt<SearchBloc>(),
        ),
        BlocProvider<PlayerBloc>(
          create: (context) => getIt<PlayerBloc>(),
        ),
        BlocProvider<LibraryBloc>(
          create: (context) => getIt<LibraryBloc>(),
        ),
        BlocProvider<FavoritesBloc>(
          create: (context) => getIt<FavoritesBloc>(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Spotify Clone',
      initialRoute: AppRoutes.login,
      routes: AppRoutes.getRoutes(),
    );
  }
}
