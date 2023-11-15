import 'package:youtube_player_flutter/youtube_player_flutter.dart';
enum CarousalMediaType { image, youtubeVideo, vimeoVideo }

CarousalMediaType visibilityCarousalMediaTypeFromString(String value) {
  return CarousalMediaType.values.firstWhere(
      (e) => e.toString().split('.')[1].toUpperCase() == value.toUpperCase());
}

class CarousalItem {
  String imageUrl;
  CarousalMediaType mediaType;
  YoutubePlayerController? controller;
  CarousalItem({
    required this.imageUrl,
    required this.mediaType,
    this.controller
  });
}
