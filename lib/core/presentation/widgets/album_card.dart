import 'package:castor_exam/features/favorites/presentation/pages/favorite_button.dart';
import 'package:flutter/material.dart';

class AlbumCard extends StatelessWidget {
  final String name;
  final String artist;
  final String? imageUrl;
  final VoidCallback? onTap;
  final String id;

  const AlbumCard({
    super.key,
    required this.name,
    required this.artist,
    this.imageUrl,
    this.onTap,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 2,
        margin: const EdgeInsets.symmetric(horizontal: 8),
        child: SizedBox(
          width: 140,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Album Image
              ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(16)),
                child: imageUrl != null
                    ? Image.network(
                        imageUrl!,
                        width: double.infinity,
                        height: 120,
                        fit: BoxFit.cover,
                      )
                    : Container(
                        height: 120,
                        width: double.infinity,
                        color: Colors.grey[300],
                        child: const Icon(Icons.album, size: 40),
                      ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0, right: 8.0, left: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      artist,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: Colors.grey[600], fontSize: 13),
                    ),
                  ],
                ),
              ),
              FavoriteButton(id: id, isAlbum: true),
            ],
          ),
        ),
      ),
    );
  }
}
