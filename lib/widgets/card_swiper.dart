import 'package:cinemapedia_flutter_app/models/models.dart';
import 'package:flutter/material.dart';

import 'package:card_swiper/card_swiper.dart';

class CardSwiper extends StatelessWidget {
  const CardSwiper({super.key, required this.movies});

  final List<Movie> movies;

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    if (movies.isEmpty) {
      SizedBox(
        width: double.infinity,
        height: deviceSize.height * 0.5,
        child: const Center(
          child: CircularProgressIndicator.adaptive(),
        ),
      );
    }

    return SizedBox(
      width: double.infinity,
      height: deviceSize.height * 0.5,
      child: Swiper(
        itemCount: movies.length,
        layout: SwiperLayout.STACK,
        itemWidth: deviceSize.width * 0.6,
        itemHeight: deviceSize.height * 0.45,
        itemBuilder: (_, index) {
          final movie = movies[index];

          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(
                context,
                'details',
                arguments: movies,
              );
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FadeInImage(
                placeholder: const AssetImage('assets/images/loading.gif'),
                image: NetworkImage(movie.getFullPosterImg),
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      ),
    );
  }
}
