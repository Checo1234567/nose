import 'package:cinemapedia_flutter_app/providers/movies_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:cinemapedia_flutter_app/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final moviesProvider = Provider.of<MoviesProvider>(context);

    print(moviesProvider.onDisplayMovies);

    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('Películas en cines'),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
          ),
        ],
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.menu),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            //Tarjetas principales
            CardSwiper(movies: moviesProvider.onDisplayMovies),
            //Separacion para los dos widgets
            const SizedBox(
              height: 30,
            ),
            //Slider de peliculas
            MovieSlider(
              popularMovies: moviesProvider.onDisplayPopularMovies,
              title: 'Populares!',
              onNextPage: () => moviesProvider.getOnDisplayPopularMovies(),
            )
          ],
        ),
      ),
    );
  }
}
