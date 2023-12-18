import 'dart:convert';
import 'package:movies_app_victor/models/movie.dart';

class Actor {
  int id;
  String name;
  String profilePath;
  String? biography;
  List<Movie> knownFor;

  Actor({
    required this.id,
    required this.name,
    required this.profilePath,
    required this.biography,
    required this.knownFor,
  });

  factory Actor.fromMap(Map<String, dynamic> map) {
    var knownForMovies = (map['known_for'] as List<dynamic>? ?? [])
        .map((movieMap) => Movie.fromMap(movieMap))
        .toList();
    return Actor(
      id: map['id'],
      name: map['name'],
      profilePath: map['profile_path'] ?? '',
      biography: map['biography'],
      knownFor: knownForMovies,
    );
  }

  factory Actor.fromJson(String source) => Actor.fromMap(json.decode(source));

  String getFoto() {
    return profilePath.isNotEmpty
        ? 'https://image.tmdb.org/t/p/w500/$profilePath'
        : 'http://forum.spaceengine.org/styles/se/theme/images/no_avatar.jpg';
  }
}
