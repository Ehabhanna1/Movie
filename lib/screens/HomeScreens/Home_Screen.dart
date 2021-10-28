import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:movi/constants.dart';
import 'package:movi/controller/get_popular.dart';
import 'package:movi/controller/get_topRate.dart';
import 'package:movi/screens/DisScreens/Dis_Screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black,
      appBar: AppBar(
        backgroundColor: black,
        centerTitle: true,
        elevation: 3,
        title: Text(
          "Netflix",
          style: TextStyle(color: primarycolor, fontWeight: FontWeight.bold),
        ),
        actions: [
          Icon(
            Icons.search,
            color: primarycolor,size: 25,
          ),
        ],
      ),
      body: Column(
        children: [
          Consumer(
            builder: (BuildContext context,
                T Function<T>(ProviderBase<Object?, T>) watch, Widget? child) {
              var viewmodeltoprate = watch(getdatatoprate);
              return ( viewmodeltoprate.listDataModel.length==0)?SizedBox(height: 0,) :CarouselSlider.builder(
                options: CarouselOptions(
                  height: MediaQuery.of(context).size.height / 3,
                  aspectRatio: 1.5,
                  viewportFraction: 0.7,
                  initialPage: 0,
                  enableInfiniteScroll: true,
                  reverse: false,
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds: 2),
                  autoPlayAnimationDuration: Duration(milliseconds: 800),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enlargeCenterPage: true,
                  scrollDirection: Axis.horizontal,
                ),
                itemCount: viewmodeltoprate.listDataModel.length,
                itemBuilder: (BuildContext context, int index, int realIndex) {
                  return GridTile(
                    child: Image.network(
                      image_url +
                          viewmodeltoprate.listDataModel[index].poster_path,
                      fit: BoxFit.fill,
                    ),
                    footer: Container(
                        color: Colors.red.withOpacity(0.5),
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(5.0),
                        child: Text(
                          viewmodeltoprate.listDataModel[index].title
                              .toString(),
                          style: TextStyle(
                            color: Colors.white,
                              fontWeight: FontWeight.w800, fontSize: 16),
                        )),
                  );
                },
              );
            },
          ),
          Expanded(
            child: Consumer(
              builder: (BuildContext context,
                  T Function<T>(ProviderBase<Object?, T>) watch,
                  Widget? child) {
                var viewmodelpopular = watch(getdatapopular);
                return StaggeredGridView.countBuilder(
                  crossAxisCount: 2,

                  itemCount: viewmodelpopular.listDataModel.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) { 
                            return DisScreen(id:viewmodelpopular.listDataModel[index].id,
                                title:viewmodelpopular.listDataModel[index].title,
                                overview:viewmodelpopular.listDataModel[index].overview,
                                poster_path:viewmodelpopular.listDataModel[index].poster_path,
                                vote_average:viewmodelpopular.listDataModel[index].vote_average);
                          }));


                        },
                        child: Card(
                          color: primarycolor,


                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Column(

                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Image.network(
                                  image_url +
                                      viewmodelpopular
                                          .listDataModel[index].poster_path,
                                  fit: BoxFit.cover,
                                ),
                                Container(

                                  color: black,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Container(

                                        child: Text(
                                          "${viewmodelpopular.listDataModel[index].title}",
                                          style: TextStyle(color: Colors.white),
                                          textAlign: TextAlign.center,
                                        ),
                                        padding: EdgeInsets.all(5.0),
                                        alignment: Alignment.center,
                                        color:Colors.red.withOpacity(0.5),

                                      ),

                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  staggeredTileBuilder: (int index) => new StaggeredTile.fit(1),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
