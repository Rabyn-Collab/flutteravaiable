


class Movie{

  final String title;
  final int id;
  final String overview;
  final String release_date;
  final String poster_path;
  final double  vote_average;


  Movie({
 required this.title,
 required this.id,
 required this.poster_path,
 required this.overview,
 required this.vote_average,
 required this.release_date
 });



factory  Movie.fromJson(Map<String, dynamic> json){
   return Movie(
       title: json['title'] ?? 'no-title',
       id: json['id'],
       poster_path: json['poster_path'],
       overview: json['overview'],
       vote_average: json['vote_average'],
       release_date: json['release_date']
   );

}





}