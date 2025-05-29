import 'package:flutter/material.dart';

class TrackTile extends StatelessWidget {
  final String name;
  final String artists;
  final String? imageUrl;
  final bool isPlaying;
  final VoidCallback onTap;

  const TrackTile({
    super.key,
    required this.name,
    required this.artists,
    required this.onTap,
    this.imageUrl,
    this.isPlaying = false,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: imageUrl != null
          ? Image.network(imageUrl!)
          : const Icon(Icons.music_note),
      title: Text(name),
      subtitle: Text(artists),
      trailing: Icon(
        isPlaying ? Icons.pause_circle_filled : Icons.play_circle_fill,
        color: Colors.deepPurple,
      ),
    );
  }
}
