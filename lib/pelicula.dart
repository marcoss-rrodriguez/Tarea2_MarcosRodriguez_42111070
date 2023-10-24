import 'dart:convert';
import 'package:http/http.dart' as http;

class Movie {
  final String title;
  final String overview;
  final String releaseDate;

  Movie(
      {required this.title, required this.overview, required this.releaseDate});

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      title: json['title'],
      overview: json['overview'],
      releaseDate: json['release_date'],
    );
  }
}

Future<List<Movie>> fetchMovies() async {
  final response = await http.get(Uri.parse(
      'https://api.themoviedb.org/3/movie/popular?api_key=0f8f858234b87388d89f0f23938f24ab&language=es-ES&page=1'));

  if (response.statusCode == 200) {
    var jsonResponse = jsonDecode(response.body);
    var moviesMap = jsonResponse['results'];
    return moviesMap.map<Movie>((json) => Movie.fromJson(json)).toList();
  } else {
    throw Exception('Error al obtener las películas');
  }
}

void main() async {
  var peliculas = await fetchMovies();
  peliculas.forEach((pelicula) {
    print('Titulo: ${pelicula.title}');
    print('Resumen: ${pelicula.overview}');
    print('Fecha de lanzamiento: ${pelicula.releaseDate}');
    print('------------------------');
  });
}
