import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:cinemapedia_flutter_app/models/models.dart';

class MoviesProvider extends ChangeNotifier {
  final String _baseUrl = 'api.themoviedb.org';
  final String _apiKey = 'f0961dd8d2d041fed216572e143f8051';
  final String _language = 'es-ES';

  List<Movie> onDisplayMovies = [];
  List<Movie> onDisplayPopularMovies = [];

  int _popularPage = 0;

  MoviesProvider() {
    print('Movies-provider: started');
    getOnDisplayMovies();
    getOnDisplayPopularMovies();
  }

  Future<String> _getResponseData(String endPoint, [int page = 1]) async {
    var url = Uri.http(_baseUrl, '3/movie/now_playing', {
      'api_key': _apiKey,
      'language': _language,
      'page': '$page',
    });

    final response = await http.get(url);
    return response.body;
  }

  getOnDisplayMovies() async {
    final jsonData = await _getResponseData('3/movie/now_playing');
    final nowPlayingResults = NowPlayingResponse.fromJson(jsonData);

    //Imprimir el titulo de la primera pelicula del stack
    // print(nowPlayingResults.results[0].title);
    onDisplayMovies = nowPlayingResults.results;

    notifyListeners();
  }

  getOnDisplayPopularMovies() async {
    _popularPage++;

    final jsonData = await _getResponseData('3/movie/popular', _popularPage);
    final popularMoviesResults = PopularMoviesResponse.fromJson(jsonData);

    onDisplayPopularMovies = [
      ...onDisplayPopularMovies,
      ...popularMoviesResults.results
    ];

    notifyListeners();
  }
}
