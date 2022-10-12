


class Movie{

  final String title;
  final int id;
  final String overview;
  final String release_date;
  final String poster_path;
  final String  vote_average;


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
       poster_path: 'https://image.tmdb.org/t/p/w600_and_h900_bestv2/${json['poster_path']}',
       overview: json['overview'],
       vote_average: '${json['vote_average']}',
       release_date: json['release_date']
   );

}





}