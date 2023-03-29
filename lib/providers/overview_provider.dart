import 'package:app/models/models.dart';
import 'package:app/providers/providers.dart';
import 'package:app/utils/api_request.dart';
import 'package:flutter/foundation.dart';

class OverviewProvider with ChangeNotifier {
  final SongProvider _songProvider;
  final AlbumProvider _albumProvider;
  final ArtistProvider _artistProvider;

  final mostPlayedSongs = <Song>[];
  final recentlyAddedSongs = <Song>[];
  final recentlyPlayedSongs = <Song>[];
  final recentlyAddedAlbums = <Album>[];
  final mostPlayedAlbums = <Album>[];
  final mostPlayedArtists = <Artist>[];

  OverviewProvider({
    required songProvider,
    required albumProvider,
    required artistProvider,
  })  : _songProvider = songProvider,
        _albumProvider = albumProvider,
        _artistProvider = artistProvider;

  Future<void> refresh() async {
    final Map<String, dynamic> response = await get('overview');

    mostPlayedSongs
      ..clear()
      ..addAll(parseSongsFromJson(response['most_played_songs']));

    recentlyAddedSongs
      ..clear()
      ..addAll(parseSongsFromJson(response['recently_added_songs']));

    recentlyPlayedSongs
      ..clear()
      ..addAll(parseSongsFromJson(response['recently_played_songs']));

    final _mostPlayedAlbums = response['most_played_albums']
        .map<Album>((j) => Album.fromJson(j))
        .toList();

    mostPlayedAlbums
      ..clear()
      ..addAll(_albumProvider.syncWithVault(_mostPlayedAlbums));

    final _mostPlayedArtist = response['most_played_artists']
        .map<Artist>((j) => Artist.fromJson(j))
        .toList();

    mostPlayedArtists
      ..clear()
      ..addAll(_artistProvider.syncWithVault(_mostPlayedArtist));

    notifyListeners();
  }

  List<Song> parseSongsFromJson(dynamic json) {
    return _songProvider
        .syncWithVault(json.map<Song>((j) => Song.fromJson(j)).toList());
  }
}
