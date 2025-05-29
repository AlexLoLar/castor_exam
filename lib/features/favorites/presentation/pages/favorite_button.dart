import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:castor_exam/features/favorites/presentation/bloc/favorites_bloc.dart';

class FavoriteButton extends StatelessWidget {
  final String id;
  final bool isAlbum;

  const FavoriteButton({
    super.key,
    required this.id,
    this.isAlbum = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 28,
      child: IconButton(
        icon: const Icon(Icons.star_border, color: Colors.amber),
        tooltip: 'Añadir a favoritos',
        onPressed: () {
          final bloc = context.read<FavoritesBloc>();
          if (isAlbum) {
            bloc.add(AddAlbumToFavoritesEvent(id));
          } else {
            bloc.add(AddTrackToFavoritesEvent(id));
          }
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Agregado a favoritos')),
          );
        },
      ),
    );
  }
}
