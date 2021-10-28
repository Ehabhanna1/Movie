import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:movi/model/Movie.dart';
final getdatatoprate=ChangeNotifierProvider.autoDispose<Gettoprate>((ref)=>Gettoprate());
class Gettoprate extends ChangeNotifier{
  List<Movie>listDataModel=[];

  Gettoprate(){
    getData();
  }

  Future getData() async {
    listDataModel=[];
    try{
      String apiKey="8b473af1978325ec534dfc56c1984dfd";
      var url=Uri.parse("https://api.themoviedb.org/3/movie/top_rated?api_key=$apiKey");
      print(url);
      var response=await http.get(url);
      var responsebody=jsonDecode(response.body)["results"];
      print("responsebody:$responsebody");
      for(int i=0;i<responsebody.length;i++){
        listDataModel.add(Movie.fromMap(responsebody[i]));
      }


    }catch(e){
      print("e===>$e");
    }
    notifyListeners();
  }
}