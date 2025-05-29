import 'package:flutter/material.dart';

class ArtistCard extends StatelessWidget {
  final String name;
  final String? imageUrl;
  final VoidCallback? onTap;

  const ArtistCard({
    super.key,
    required this.name,
    this.imageUrl,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        child: Column(
          children: [
            CircleAvatar(
              radius: 48,
              backgroundImage:
                  imageUrl != null ? NetworkImage(imageUrl!) : null,
              child:
                  imageUrl == null ? const Icon(Icons.person, size: 48) : null,
            ),
            const SizedBox(height: 8),
            Text(
              name,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const Text('Artist', style: TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}
