import 'package:flutter/material.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/screens/movie_screen.dart';
import 'package:movie_app/widgets/movie_list_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    List<Movie> movies = Movie.movies;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        elevation: 0,
        backgroundColor: Colors.transparent,
        flexibleSpace: ClipPath(
          //appbarı oval şekle getirmek için kullandım altta da classdan cektim
          clipper: _CustomClipper(),
          child: Container(
            height: 150,
            width: MediaQuery.of(context).size.width,
            color: Colors.deepOrange,
            child: Center(
              child: Text(
                'Explore',
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
          ),
        ),
      ),
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        //aşağı kayması
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 150,
                horizontal: 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      style: Theme.of(context).textTheme.titleLarge,
                      children: [
                        TextSpan(
                          text: 'Featured ',
                          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        const TextSpan(text: 'Movies'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  for (final movie in movies)
                    InkWell(
                      //burda diğer sayfaya gidişi sağladım
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MovieScreen(movie: movie),
                            ));
                      },
                      child: MovieListItem(
                        imageUrl: movie.imagePath,
                        name: movie.name,
                        information:
                            '${movie.year} | ${movie.category} | ${movie.duration.inHours}h ${movie.duration.inMinutes.remainder(60)}m',
                      ),
                    )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CustomClipper extends CustomClipper<Path> {
  //Appbardaki ovalliği verdiğim yer
  @override
  getClip(Size size) {
    double height = size.height;
    double width = size.width;
    var path = Path();
    path.lineTo(0, height - 50);
    path.quadraticBezierTo(width / 2, height, width, height - 50);
    path.lineTo(width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper oldClipper) {
    return true;
  }
}
