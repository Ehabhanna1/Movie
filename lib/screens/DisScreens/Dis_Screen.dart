import 'package:flutter/material.dart';
import 'package:movi/constants.dart';
import 'dart:ui' as ui;
import 'dart:math'as math;
import 'package:flip_card/flip_card.dart';
import 'package:movi/screens/DisScreens/Webview_Screen.dart';

class DisScreen extends StatefulWidget {
  int id;
  num vote_average;
  String title;
  String overview;
  String poster_path;
  DisScreen({
    required this.id, required this.title,required this.overview,
    required this.poster_path,required this.vote_average
  });

  @override
  _DisScreenState createState() => _DisScreenState();
}

class _DisScreenState extends State<DisScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Transform(
              alignment: Alignment.center,
              transform: Matrix4.rotationX(math.pi),
              child: Image.network(image_url+widget.poster_path,fit: BoxFit.cover,)),
          BackdropFilter(filter:ui.ImageFilter.blur(sigmaX: 5.0,sigmaY: 5.0),
            child: Container(color: Colors.red.withOpacity(0.1),),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 20.0),
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height/20,
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: TextButton.icon(onPressed:(){
                      Navigator.pop(context);
                    },

                      icon: Icon(Icons.arrow_back_ios,color: white,size: 30,),
                      label: Text("Back",style: TextStyle(
                        color: white,fontSize: 25,fontWeight: FontWeight.w800,
                      ),),
                    ),
                  ),
                  FlipCard(

                    fill: Fill.fillBack, // Fill the back side of the card to make in the same size as the front.
                    direction: FlipDirection.HORIZONTAL, // default
                    front: Container(
                      alignment: Alignment.center,
                      height: MediaQuery.of(context).size.height/1.6,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(image:NetworkImage(image_url+widget.poster_path,),
                          fit: BoxFit.cover,
                        ),),
                    ),


                    back: Container(
                      alignment: Alignment.center,
                      height: MediaQuery.of(context).size.height/1.6,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(image:NetworkImage(image_url+widget.poster_path,),
                          fit: BoxFit.cover,
                        ),),
                    ),),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 5.0),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 70,
                          child: Text("${widget.title}",style: TextStyle(
                            color: white,fontSize: 25,
                          ),),
                        ),
                        Expanded(
                          flex: 25,
                          child: Text("${widget.vote_average}/10",style: TextStyle(
                            color: white,fontSize: 25,
                          ),),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 5.0),
                    child: Text("${widget.overview}",style: TextStyle(color: white),),
                  ),


                ],
              ),
            ),
          ),

        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
              return WebViewScreen(widget.title);
            } ));
          },
          label:Text("watch on EgyBest",style: TextStyle(
            fontSize: 16,
          ),),
        elevation: 10,
        backgroundColor: blue,
        autofocus: true,

      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

