import 'package:app/constants/constants.dart';
import 'package:app/models/models.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

enum ThumbnailSize { sm, md, lg, xl }

class ArtistThumbnail extends StatelessWidget {
  final Artist artist;
  final ThumbnailSize size;
  final bool asHero;

  const ArtistThumbnail({
    Key? key,
    required this.artist,
    this.size = ThumbnailSize.sm,
    this.asHero = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final imageUrl = artist.imageUrl;

    Widget image = imageUrl == null
        ? Image.asset(
            'assets/images/unknown-album.png',
            fit: BoxFit.cover,
            width: width,
            height: height,
          )
        : CachedNetworkImage(
            fit: BoxFit.cover,
            width: width,
            height: height,
            placeholder: (_, __) => defaultImage,
            errorWidget: (_, __, ___) => defaultImage,
            imageUrl: imageUrl,
          );

    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: asHero
          ? Hero(
              tag: 'artist-hero-${artist.id}',
              child: image,
            )
          : image,
    );
  }

  double get width {
    switch (size) {
      case ThumbnailSize.lg:
        return 192;
      case ThumbnailSize.md:
        return 144;
      case ThumbnailSize.xl:
        return 256;
      default:
        return 40;
    }
  }

  double get borderRadius {
    switch (size) {
      case ThumbnailSize.md:
        return 12;
      case ThumbnailSize.lg:
        return 16;
      case ThumbnailSize.xl:
        return 20;
      default:
        return 20; // rounded for sm size
    }
  }

  double get height => width;
}
