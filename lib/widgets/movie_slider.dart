import 'package:cinemapedia_flutter_app/models/movie.dart';
import 'package:flutter/material.dart';

class MovieSlider extends StatefulWidget {
  const MovieSlider({
    super.key,
    required this.popularMovies,
    this.title,
    required this.onNextPage,
  });

  final List<Movie> popularMovies;
  final String? title;
  final Function onNextPage;

  @override
  State<MovieSlider> createState() => _MovieSliderState();
}

class _MovieSliderState extends State<MovieSlider> {
  final ScrollController scrollMovieSliderControler = ScrollController();

  @override
  void initState() {
    super.initState();

    scrollMovieSliderControler.addListener(() {
      if (scrollMovieSliderControler.position.pixels >=
          scrollMovieSliderControler.position.maxScrollExtent - 500) {
        widget.onNextPage();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 260,
      // color: Colors.red,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.title != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                widget.title!,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            )
          else
            Container(height: 23),
          const SizedBox(
            height: 5,
          ),
          Expanded(
            child: ListView.builder(
                controller: scrollMovieSliderControler,
                scrollDirection: Axis.horizontal,
                itemCount: widget.popularMovies.length,
                itemBuilder: (_, int index) {
                  final movies = widget.popularMovies[index];

                  return _MoviePoster(movies);
                }),
          ),
        ],
      ),
    );
  }
}

class _MoviePoster extends StatelessWidget {
  const _MoviePoster(this.movie);

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      width: 130,
      // color: Colors.green,s
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          GestureDetector(
            onTap: () => Navigator.pushNamed(
              context,
              'details',
              arguments: movie,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FadeInImage(
                placeholder: const AssetImage('assets/images/loading.gif'),
                // image: NetworkImage('http://via.placeholder.com/300x400'),
                image: NetworkImage(movie.getFullPosterImg),
                fit: BoxFit.cover,
                height: 180,
                width: 130,
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            movie.title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
