import 'package:flutter/material.dart';
import 'package:flutter/src/painting/image_provider.dart';

import 'artist.dart';

class Album {
  int id;
  bool isCompilation;
  String name;
  String? cover;
  Artist artist;
  int playCount = 0;

  ImageProvider? _image;

  Album(this.artist, this.id, this.name, this.cover, this.isCompilation);

  factory Album.fromJson(Map<String, dynamic> json, Artist artist) {
    return Album(
      artist,
      json['id'],
      json['name'],
      json['cover'],
      json['is_compilation'],
    );
  }

  ImageProvider get image {
    if (_image == null) {
      _image = cover == null
          ? AssetImage('assets/images/unknown-album.png')
          : NetworkImage(this.cover!) as ImageProvider;
    }

    return _image!;
  }
}
