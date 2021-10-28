 class Movie{

  int id;
  num vote_average;
  String title;
  String overview;
  String poster_path;
  Movie({
    required this.id, required this.title,required this.overview,
    required this.poster_path,required this.vote_average
  });
factory Movie.fromMap(Map<String,dynamic>map){
  return Movie(
      id:map["id"], title:map["title"],
      overview:map["overview"], poster_path:map["poster_path"],
      vote_average:map["vote_average"]);
}
   Map<String,dynamic>toMap(){
  return {
    "id":this.id,
    "title":this.title,
    "overview":this.overview,
    "poster_path":this.poster_path,
    "vote_average":this.vote_average,
  };
   }
 }