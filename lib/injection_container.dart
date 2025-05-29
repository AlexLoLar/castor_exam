import 'package:castor_exam/features/favorites/data/datasources/remote/favorites_remote_data_source.dart';
import 'package:castor_exam/features/favorites/data/repository/favorites_repository_impl.dart';
import 'package:castor_exam/features/favorites/domain/repository/favorites_repository.dart';
import 'package:castor_exam/features/favorites/domain/usecases/add_album_to_favorites.dart';
import 'package:castor_exam/features/favorites/domain/usecases/add_track_to_favorites.dart';
import 'package:castor_exam/features/favorites/presentation/bloc/favorites_bloc.dart';
import 'package:castor_exam/features/libreries/data/datasources/remote/library_remote_data_source.dart';
import 'package:castor_exam/features/libreries/data/repository/library_repository_impl.dart';
import 'package:castor_exam/features/libreries/domain/repository/library_repository.dart';
import 'package:castor_exam/features/libreries/domain/usecases/get_user_albums.dart';
import 'package:castor_exam/features/libreries/domain/usecases/get_user_tracks.dart';
import 'package:castor_exam/features/libreries/presentation/bloc/library_bloc.dart';
import 'package:castor_exam/features/player/data/datasources/local/audio_player_manager.dart';
import 'package:castor_exam/features/player/presentation/bloc/player_bloc.dart';
import 'package:castor_exam/features/search/data/datasources/remote/spotify_search_remote_data_source.dart';
import 'package:castor_exam/features/search/data/repository/search_repository_impl.dart';
import 'package:castor_exam/features/search/domain/repository/search_repository.dart';
import 'package:castor_exam/features/search/domain/usecases/search_items.dart';
import 'package:castor_exam/features/search/presentation/bloc/search_bloc.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:castor_exam/features/authentication/data/datasources/local/auth_local_data_source.dart';
import 'package:castor_exam/features/authentication/domain/usecases/is_login_spotify.dart';
import 'package:castor_exam/features/authentication/domain/usecases/logout_spotify.dart';
import 'package:castor_exam/features/authentication/data/datasources/remote/spotify_auth_remote_data_source.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'features/authentication/data/repository/auth_repository_impl.dart';
import 'features/authentication/domain/repository/auth_repository.dart';
import 'features/authentication/domain/usecases/login_with_spotify.dart';
import 'features/authentication/presentation/bloc/auth_bloc.dart';

final getIt = GetIt.instance;

Future<void> setupDependencies() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerLazySingleton(() => sharedPreferences);

  getIt.registerLazySingleton(() => Dio());

  // Data sources
  getIt.registerLazySingleton<SpotifyAuthRemoteDataSource>(
    () => SpotifyAuthRemoteDataSource(),
  );

  getIt.registerLazySingleton<AuthLocalDataSource>(
    () => AuthLocalDataSource(prefs: getIt<SharedPreferences>()),
  );

  // Repository
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      remoteDataSource: getIt(),
      localDataSource: getIt(),
    ),
  );

  // Use cases
  getIt.registerLazySingleton(
    () => LoginWithSpotify(repository: getIt<AuthRepository>()),
  );

  getIt.registerLazySingleton(
    () => IsLoginSpotify(repository: getIt<AuthRepository>()),
  );

  getIt.registerLazySingleton(
    () => LogoutSpotify(repository: getIt<AuthRepository>()),
  );

  // En injection_container.dart
  getIt.registerLazySingleton(
    () => AuthBloc(
      loginWithSpotify: getIt(),
      logoutSpotify: getIt(),
      isLoginSpotify: getIt(),
      repository: getIt(),
    ),
  );
  // Albums: Use case
  getIt.registerLazySingleton(() => SearchItemsUseCase(getIt()));

  getIt.registerLazySingleton<SpotifySearchRemoteDataSource>(
    () => SpotifySearchRemoteDataSource(
      authLocalDataSource: getIt(),
      dio: getIt(),
    ),
  );

  getIt.registerLazySingleton<SearchRepository>(
    () => SearchRepositoryImpl(getIt()),
  );

  getIt.registerLazySingleton(() => SearchBloc(getIt()));

  // Player: Audio manager
  getIt.registerLazySingleton(() => AudioPlayerManager());

// PlayerBloc
  getIt.registerLazySingleton(() => PlayerBloc(getIt<AudioPlayerManager>()));

  getIt.registerLazySingleton<LibraryRemoteDataSource>(
    () => LibraryRemoteDataSource(
      dio: getIt(),
      authLocalDataSource: getIt(),
    ),
  );

  // Library Repository
  getIt.registerLazySingleton<LibraryRepository>(
    () => LibraryRepositoryImpl(getIt()),
  );

  // Library Use Cases
  getIt.registerLazySingleton(
    () => GetUserTracksUseCase(getIt()),
  );

  getIt.registerLazySingleton(
    () => GetUserAlbumsUseCase(getIt()),
  );

  // Library Bloc
  getIt.registerFactory(
    () => LibraryBloc(
      getUserTracksUseCase: getIt(),
      getUserAlbumsUseCase: getIt(),
    ),
  );

  // Favorites: Remote Data Source
  getIt.registerLazySingleton<FavoritesRemoteDataSource>(
    () => FavoritesRemoteDataSource(
      dio: getIt(),
      authLocalDataSource: getIt(),
    ),
  );

// Favorites: Repository
  getIt.registerLazySingleton<FavoritesRepository>(
    () => FavoritesRepositoryImpl(
      remoteDataSource: getIt(),
    ),
  );

// Favorites: Use Cases
  getIt.registerLazySingleton(() => AddTrackToFavoritesUseCase(getIt()));
  getIt.registerLazySingleton(() => AddAlbumToFavoritesUseCase(getIt()));

// Favorites: Bloc
  getIt.registerFactory(() => FavoritesBloc(
        addTrackToFavorites: getIt(),
        addAlbumToFavorites: getIt(),
      ));
}
