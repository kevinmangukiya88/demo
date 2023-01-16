import 'package:demo/View/HomeScreen/news_details_screen.dart';
import 'package:demo/ViewModel/get_news_view_model.dart';
import 'package:demo/apiModel/api_services/api_response.dart';
import 'package:demo/apiModel/model/ResponseModel/get_news_response_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  GetNewsViewModel _getNewsViewModel = Get.put(GetNewsViewModel());
  TabController? _tabController;
  double _page = 0;
  int? pageee=0;
  final _controller = PageController(

    // viewportFraction: 0.5,
  );
  @override
  void initState() {
    _tabController = TabController(length: 13, vsync: this);

    getAll();
    super.initState();
    _controller.addListener(() => setState(() {
      _page = _controller.page!;
    }));
  }

  getAll() async {
    await _getNewsViewModel.getAllSportTypeViewModel(type: 'national');
  }
  List<Color> dataS=[
    Colors.yellow,
    Colors.red,
    Colors.grey,
    Colors.pink,
    Colors.orange,

  ];

  int sel = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black.withOpacity(0.5),
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.all(5),
              color: Colors.white,
              width: Get.width,
              child: TabBar(
                onTap: (val) {
                  setState(() {
                  sel=val;
                    print('index==${sel}');
                  });
                  if (val == 1) {
                    _getNewsViewModel.getAllSportTypeViewModel(
                        type: 'all');
                  } else if (val == 2) {
                    _getNewsViewModel.getAllSportTypeViewModel(
                        type: 'business');
                  } else if (val == 3) {
                    _getNewsViewModel.getAllSportTypeViewModel(type: 'sport');
                  } else if (val == 4) {
                    _getNewsViewModel.getAllSportTypeViewModel(type: 'world');
                  } else if (val == 5) {
                    _getNewsViewModel.getAllSportTypeViewModel(
                        type: 'politics');
                  } else if (val == 6) {
                    _getNewsViewModel.getAllSportTypeViewModel(
                        type: 'technology');
                  } else if (val == 7) {
                    _getNewsViewModel.getAllSportTypeViewModel(type: 'startup');
                  } else if (val == 8) {
                    _getNewsViewModel.getAllSportTypeViewModel(
                        type: 'entertainment');
                  } else if (val == 9) {
                    _getNewsViewModel.getAllSportTypeViewModel(
                        type: 'miscellaneous');
                  } else if (val == 10) {
                    _getNewsViewModel.getAllSportTypeViewModel(type: 'hatke');
                  } else if (val == 11) {
                    _getNewsViewModel.getAllSportTypeViewModel(type: 'science');
                  } else if (val == 12) {
                    _getNewsViewModel.getAllSportTypeViewModel(
                        type: 'automobile');
                  } else {
                    _getNewsViewModel.getAllSportTypeViewModel(type: 'national');
                  }
                },
                unselectedLabelColor: Colors.black,
                labelColor: Colors.white,
                indicatorColor: Color(0xFF828282),
                controller: _tabController,
                indicator: BoxDecoration(
                    color: Colors.black,
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(8)),
                isScrollable: true,
                tabs: [
                  Tab(
                    text: "national",
                  ),
                  Tab(
                    text: "all",
                  ),
                  Tab(
                    text: "business",
                  ),
                  Tab(
                    text: "sport",
                  ),
                  Tab(
                    text: "world",
                  ),
                  Tab(
                    text: "politics",
                  ),
                  Tab(
                    text: "technology",
                  ),
                  Tab(
                    text: "startup",
                  ),
                  Tab(
                    text: "entertainment",
                  ),
                  Tab(
                    text: "miscellaneous",
                  ),
                  Tab(
                    text: "hatke",
                  ),
                  Tab(
                    text: "science",
                  ),
                  Tab(
                    text: "automobile",
                  ),
                ],
              ),
            ),
            Expanded(
              child: GetBuilder<GetNewsViewModel>(
                builder: (controller) {
                  if (controller.getNewsApiResponse.status == Status.COMPLETE) {
                    GetNewsResponseModel data =
                        controller.getNewsApiResponse.data;
                    pageee=data.data!.length;
                    print('dfdfdf==${pageee}');
                    return TabBarView(
                      physics: NeverScrollableScrollPhysics(),
                      controller: _tabController,
                      children: [
                        sel==0? PageView.builder(
                          controller: _controller,
                          scrollDirection: Axis.vertical,
                          itemCount: data.data!.length,
                          itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            onTap: (){
                              Get.to(NewsDetailsScreen(
                                                    title: '${data.data![index].title}',
                                                    content:
                                                        '${data.data![index].content}',
                                                    time: '${data.data![index].time}',
                                                    imageUrl:
                                                        '${data.data![index].imageUrl}',
                                                    readMoreUrl:
                                                        '${data.data![index].readMoreUrl}',
                                                  ));
                            },
                            child: Stack(
                              children: [
                                Container(
                                  height: Get.height*0.60,
                                  width: Get.width,
                                  // color:dataS[index],
                                  child: Image.network(
                                                                '${data.data![index].imageUrl}'
                                                              ),
                                ),
                              Positioned(
                                bottom: 20,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Container(
                                        width: Get.width,
                                        child: Text(
                                                                      '${data.data![index].title}',

                                                                      style: TextStyle(
                                                                        fontSize: 18,
                                                                          color: Colors.white,
                                                                          overflow: TextOverflow
                                                                              .ellipsis),
                                        maxLines: 2,),
                                      ), Container(
                                        width: Get.width,
                                        child: Text(
                                                                      '${data.data![index].time}',

                                                                      style: TextStyle(
                                                                        fontSize: 18,
                                                                          color: Colors.white,
                                                                          overflow: TextOverflow
                                                                              .ellipsis),
                                        maxLines: 2,),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                              ],
                            ),
                          );
                        },):SizedBox(),
                        sel==1? PageView.builder(
                          controller: _controller,
                          scrollDirection: Axis.vertical,
                          itemCount: data.data!.length,
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: (){
                                Get.to(NewsDetailsScreen(
                                  title: '${data.data![index].title}',
                                  content:
                                  '${data.data![index].content}',
                                  time: '${data.data![index].time}',
                                  imageUrl:
                                  '${data.data![index].imageUrl}',
                                  readMoreUrl:
                                  '${data.data![index].readMoreUrl}',
                                ));
                              },
                              child: Stack(
                                children: [
                                  Container(
                                    height: Get.height*0.60,
                                    width: Get.width,
                                    // color:dataS[index],
                                    child: Image.network(
                                        '${data.data![index].imageUrl}'
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 20,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          Container(
                                            width: Get.width,
                                            child: Text(
                                              '${data.data![index].title}',

                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.white,
                                                  overflow: TextOverflow
                                                      .ellipsis),
                                              maxLines: 2,),
                                          ), Container(
                                            width: Get.width,
                                            child: Text(
                                              '${data.data![index].time}',

                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.white,
                                                  overflow: TextOverflow
                                                      .ellipsis),
                                              maxLines: 2,),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            );
                          },):SizedBox(),
                        sel==2? PageView.builder(
                          controller: _controller,
                          scrollDirection: Axis.vertical,
                          itemCount: data.data!.length,
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: (){
                                Get.to(NewsDetailsScreen(
                                  title: '${data.data![index].title}',
                                  content:
                                  '${data.data![index].content}',
                                  time: '${data.data![index].time}',
                                  imageUrl:
                                  '${data.data![index].imageUrl}',
                                  readMoreUrl:
                                  '${data.data![index].readMoreUrl}',
                                ));
                              },
                              child: Stack(
                                children: [
                                  Container(
                                    height: Get.height*0.60,
                                    width: Get.width,
                                    // color:dataS[index],
                                    child: Image.network(
                                        '${data.data![index].imageUrl}'
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 20,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          Container(
                                            width: Get.width,
                                            child: Text(
                                              '${data.data![index].title}',

                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.white,
                                                  overflow: TextOverflow
                                                      .ellipsis),
                                              maxLines: 2,),
                                          ), Container(
                                            width: Get.width,
                                            child: Text(
                                              '${data.data![index].time}',

                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.white,
                                                  overflow: TextOverflow
                                                      .ellipsis),
                                              maxLines: 2,),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            );
                          },):SizedBox(),
                        sel==3? PageView.builder(
                          controller: _controller,
                          scrollDirection: Axis.vertical,
                          itemCount: data.data!.length,
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: (){
                                Get.to(NewsDetailsScreen(
                                  title: '${data.data![index].title}',
                                  content:
                                  '${data.data![index].content}',
                                  time: '${data.data![index].time}',
                                  imageUrl:
                                  '${data.data![index].imageUrl}',
                                  readMoreUrl:
                                  '${data.data![index].readMoreUrl}',
                                ));
                              },
                              child: Stack(
                                children: [
                                  Container(
                                    height: Get.height*0.60,
                                    width: Get.width,
                                    // color:dataS[index],
                                    child: Image.network(
                                        '${data.data![index].imageUrl}'
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 20,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          Container(
                                            width: Get.width,
                                            child: Text(
                                              '${data.data![index].title}',

                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.white,
                                                  overflow: TextOverflow
                                                      .ellipsis),
                                              maxLines: 2,),
                                          ), Container(
                                            width: Get.width,
                                            child: Text(
                                              '${data.data![index].time}',

                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.white,
                                                  overflow: TextOverflow
                                                      .ellipsis),
                                              maxLines: 2,),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            );
                          },):SizedBox(),
                        sel==4? PageView.builder(
                          controller: _controller,
                          scrollDirection: Axis.vertical,
                          itemCount: data.data!.length,
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: (){
                                Get.to(NewsDetailsScreen(
                                  title: '${data.data![index].title}',
                                  content:
                                  '${data.data![index].content}',
                                  time: '${data.data![index].time}',
                                  imageUrl:
                                  '${data.data![index].imageUrl}',
                                  readMoreUrl:
                                  '${data.data![index].readMoreUrl}',
                                ));
                              },
                              child: Stack(
                                children: [
                                  Container(
                                    height: Get.height*0.60,
                                    width: Get.width,
                                    // color:dataS[index],
                                    child: Image.network(
                                        '${data.data![index].imageUrl}'
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 20,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          Container(
                                            width: Get.width,
                                            child: Text(
                                              '${data.data![index].title}',

                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.white,
                                                  overflow: TextOverflow
                                                      .ellipsis),
                                              maxLines: 2,),
                                          ), Container(
                                            width: Get.width,
                                            child: Text(
                                              '${data.data![index].time}',

                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.white,
                                                  overflow: TextOverflow
                                                      .ellipsis),
                                              maxLines: 2,),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            );
                          },):SizedBox(),
                        sel==5? PageView.builder(
                          controller: _controller,
                          scrollDirection: Axis.vertical,
                          itemCount: data.data!.length,
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: (){
                                Get.to(NewsDetailsScreen(
                                  title: '${data.data![index].title}',
                                  content:
                                  '${data.data![index].content}',
                                  time: '${data.data![index].time}',
                                  imageUrl:
                                  '${data.data![index].imageUrl}',
                                  readMoreUrl:
                                  '${data.data![index].readMoreUrl}',
                                ));
                              },
                              child: Stack(
                                children: [
                                  Container(
                                    height: Get.height*0.60,
                                    width: Get.width,
                                    // color:dataS[index],
                                    child: Image.network(
                                        '${data.data![index].imageUrl}'
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 20,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          Container(
                                            width: Get.width,
                                            child: Text(
                                              '${data.data![index].title}',

                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.white,
                                                  overflow: TextOverflow
                                                      .ellipsis),
                                              maxLines: 2,),
                                          ), Container(
                                            width: Get.width,
                                            child: Text(
                                              '${data.data![index].time}',

                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.white,
                                                  overflow: TextOverflow
                                                      .ellipsis),
                                              maxLines: 2,),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            );
                          },):SizedBox(),
                        sel==6? PageView.builder(
                          controller: _controller,
                          scrollDirection: Axis.vertical,
                          itemCount: data.data!.length,
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: (){
                                Get.to(NewsDetailsScreen(
                                  title: '${data.data![index].title}',
                                  content:
                                  '${data.data![index].content}',
                                  time: '${data.data![index].time}',
                                  imageUrl:
                                  '${data.data![index].imageUrl}',
                                  readMoreUrl:
                                  '${data.data![index].readMoreUrl}',
                                ));
                              },
                              child: Stack(
                                children: [
                                  Container(
                                    height: Get.height*0.60,
                                    width: Get.width,
                                    // color:dataS[index],
                                    child: Image.network(
                                        '${data.data![index].imageUrl}'
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 20,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          Container(
                                            width: Get.width,
                                            child: Text(
                                              '${data.data![index].title}',

                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.white,
                                                  overflow: TextOverflow
                                                      .ellipsis),
                                              maxLines: 2,),
                                          ), Container(
                                            width: Get.width,
                                            child: Text(
                                              '${data.data![index].time}',

                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.white,
                                                  overflow: TextOverflow
                                                      .ellipsis),
                                              maxLines: 2,),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            );
                          },):SizedBox(),
                        sel==7? PageView.builder(
                          controller: _controller,
                          scrollDirection: Axis.vertical,
                          itemCount: data.data!.length,
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: (){
                                Get.to(NewsDetailsScreen(
                                  title: '${data.data![index].title}',
                                  content:
                                  '${data.data![index].content}',
                                  time: '${data.data![index].time}',
                                  imageUrl:
                                  '${data.data![index].imageUrl}',
                                  readMoreUrl:
                                  '${data.data![index].readMoreUrl}',
                                ));
                              },
                              child: Stack(
                                children: [
                                  Container(
                                    height: Get.height*0.60,
                                    width: Get.width,
                                    // color:dataS[index],
                                    child: Image.network(
                                        '${data.data![index].imageUrl}'
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 20,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          Container(
                                            width: Get.width,
                                            child: Text(
                                              '${data.data![index].title}',

                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.white,
                                                  overflow: TextOverflow
                                                      .ellipsis),
                                              maxLines: 2,),
                                          ), Container(
                                            width: Get.width,
                                            child: Text(
                                              '${data.data![index].time}',

                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.white,
                                                  overflow: TextOverflow
                                                      .ellipsis),
                                              maxLines: 2,),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            );
                          },):SizedBox(),
                        sel==8? PageView.builder(
                          controller: _controller,
                          scrollDirection: Axis.vertical,
                          itemCount: data.data!.length,
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: (){
                                Get.to(NewsDetailsScreen(
                                  title: '${data.data![index].title}',
                                  content:
                                  '${data.data![index].content}',
                                  time: '${data.data![index].time}',
                                  imageUrl:
                                  '${data.data![index].imageUrl}',
                                  readMoreUrl:
                                  '${data.data![index].readMoreUrl}',
                                ));
                              },
                              child: Stack(
                                children: [
                                  Container(
                                    height: Get.height*0.60,
                                    width: Get.width,
                                    // color:dataS[index],
                                    child: Image.network(
                                        '${data.data![index].imageUrl}'
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 20,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          Container(
                                            width: Get.width,
                                            child: Text(
                                              '${data.data![index].title}',

                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.white,
                                                  overflow: TextOverflow
                                                      .ellipsis),
                                              maxLines: 2,),
                                          ), Container(
                                            width: Get.width,
                                            child: Text(
                                              '${data.data![index].time}',

                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.white,
                                                  overflow: TextOverflow
                                                      .ellipsis),
                                              maxLines: 2,),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            );
                          },):SizedBox(),
                        sel==9? PageView.builder(
                          controller: _controller,
                          scrollDirection: Axis.vertical,
                          itemCount: data.data!.length,
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: (){
                                Get.to(NewsDetailsScreen(
                                  title: '${data.data![index].title}',
                                  content:
                                  '${data.data![index].content}',
                                  time: '${data.data![index].time}',
                                  imageUrl:
                                  '${data.data![index].imageUrl}',
                                  readMoreUrl:
                                  '${data.data![index].readMoreUrl}',
                                ));
                              },
                              child: Stack(
                                children: [
                                  Container(
                                    height: Get.height*0.60,
                                    width: Get.width,
                                    // color:dataS[index],
                                    child: Image.network(
                                        '${data.data![index].imageUrl}'
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 20,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          Container(
                                            width: Get.width,
                                            child: Text(
                                              '${data.data![index].title}',

                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.white,
                                                  overflow: TextOverflow
                                                      .ellipsis),
                                              maxLines: 2,),
                                          ), Container(
                                            width: Get.width,
                                            child: Text(
                                              '${data.data![index].time}',

                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.white,
                                                  overflow: TextOverflow
                                                      .ellipsis),
                                              maxLines: 2,),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            );
                          },):SizedBox(),
                        sel==10? PageView.builder(
                          controller: _controller,
                          scrollDirection: Axis.vertical,
                          itemCount: data.data!.length,
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: (){
                                Get.to(NewsDetailsScreen(
                                  title: '${data.data![index].title}',
                                  content:
                                  '${data.data![index].content}',
                                  time: '${data.data![index].time}',
                                  imageUrl:
                                  '${data.data![index].imageUrl}',
                                  readMoreUrl:
                                  '${data.data![index].readMoreUrl}',
                                ));
                              },
                              child: Stack(
                                children: [
                                  Container(
                                    height: Get.height*0.60,
                                    width: Get.width,
                                    // color:dataS[index],
                                    child: Image.network(
                                        '${data.data![index].imageUrl}'
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 20,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          Container(
                                            width: Get.width,
                                            child: Text(
                                              '${data.data![index].title}',

                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.white,
                                                  overflow: TextOverflow
                                                      .ellipsis),
                                              maxLines: 2,),
                                          ), Container(
                                            width: Get.width,
                                            child: Text(
                                              '${data.data![index].time}',

                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.white,
                                                  overflow: TextOverflow
                                                      .ellipsis),
                                              maxLines: 2,),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            );
                          },):SizedBox(),
                        sel==11? PageView.builder(
                          controller: _controller,
                          scrollDirection: Axis.vertical,
                          itemCount: data.data!.length,
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: (){
                                Get.to(NewsDetailsScreen(
                                  title: '${data.data![index].title}',
                                  content:
                                  '${data.data![index].content}',
                                  time: '${data.data![index].time}',
                                  imageUrl:
                                  '${data.data![index].imageUrl}',
                                  readMoreUrl:
                                  '${data.data![index].readMoreUrl}',
                                ));
                              },
                              child: Stack(
                                children: [
                                  Container(
                                    height: Get.height*0.60,
                                    width: Get.width,
                                    // color:dataS[index],
                                    child: Image.network(
                                        '${data.data![index].imageUrl}'
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 20,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          Container(
                                            width: Get.width,
                                            child: Text(
                                              '${data.data![index].title}',

                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.white,
                                                  overflow: TextOverflow
                                                      .ellipsis),
                                              maxLines: 2,),
                                          ), Container(
                                            width: Get.width,
                                            child: Text(
                                              '${data.data![index].time}',

                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.white,
                                                  overflow: TextOverflow
                                                      .ellipsis),
                                              maxLines: 2,),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            );
                          },):SizedBox(),
                        sel==12? PageView.builder(
                          controller: _controller,
                          scrollDirection: Axis.vertical,
                          itemCount: data.data!.length,
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: (){
                                Get.to(NewsDetailsScreen(
                                  title: '${data.data![index].title}',
                                  content:
                                  '${data.data![index].content}',
                                  time: '${data.data![index].time}',
                                  imageUrl:
                                  '${data.data![index].imageUrl}',
                                  readMoreUrl:
                                  '${data.data![index].readMoreUrl}',
                                ));
                              },
                              child: Stack(
                                children: [
                                  Container(
                                    height: Get.height*0.60,
                                    width: Get.width,
                                    // color:dataS[index],
                                    child: Image.network(
                                        '${data.data![index].imageUrl}'
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 20,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          Container(
                                            width: Get.width,
                                            child: Text(
                                              '${data.data![index].title}',

                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.white,
                                                  overflow: TextOverflow
                                                      .ellipsis),
                                              maxLines: 2,),
                                          ), Container(
                                            width: Get.width,
                                            child: Text(
                                              '${data.data![index].time}',

                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.white,
                                                  overflow: TextOverflow
                                                      .ellipsis),
                                              maxLines: 2,),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            );
                          },):SizedBox(),

                        // ...List.generate(
                        //     13,
                        //     (index) => ListView.builder(
                        //           itemCount: data.data!.length,
                        //           shrinkWrap: true,
                        //           itemBuilder: (context, index1) {
                        //             return GestureDetector(
                        //               onTap: () {
                        //                 Get.to(NewsDetailsScreen(
                        //                   title: '${data.data![index1].title}',
                        //                   content:
                        //                       '${data.data![index1].content}',
                        //                   time: '${data.data![index1].time}',
                        //                   imageUrl:
                        //                       '${data.data![index1].imageUrl}',
                        //                   readMoreUrl:
                        //                       '${data.data![index1].readMoreUrl}',
                        //                 ));
                        //               },
                        //               child: Padding(
                        //                 padding: const EdgeInsets.all(8.0),
                        //                 child: Container(
                        //                   child: Row(
                        //                     children: [
                        //                       Container(
                        //                         height: Get.height * 0.10,
                        //                         width: Get.height * 0.10,
                        //                         child: ClipRRect(
                        //                           borderRadius:
                        //                               BorderRadius.circular(10),
                        //                           child: Image.network(
                        //                             '${data.data![index1].imageUrl}',
                        //                             fit: BoxFit.fill,
                        //                           ),
                        //                         ),
                        //                       ),
                        //                       SizedBox(
                        //                         width: 10,
                        //                       ),
                        //                       Flexible(
                        //                         child: Column(
                        //                           crossAxisAlignment:
                        //                               CrossAxisAlignment.start,
                        //                           mainAxisAlignment:
                        //                               MainAxisAlignment.start,
                        //                           children: [
                        //                             Text(
                        //                               '${data.data![index1].title}',
                        //                               style: TextStyle(
                        //                                   color: Colors.white,
                        //                                   overflow: TextOverflow
                        //                                       .ellipsis),
                        //                             ),
                        //                             SizedBox(
                        //                               height: 10,
                        //                             ),
                        //                             Text(
                        //                               '${data.data![index1].author}',
                        //                               style: TextStyle(
                        //                                   color: Colors.white,
                        //                                   overflow: TextOverflow
                        //                                       .ellipsis),
                        //                             ),
                        //                             SizedBox(
                        //                               height: 10,
                        //                             ),
                        //                             Text(
                        //                               '${data.data![index1].time}',
                        //                               style: TextStyle(
                        //                                   color: Colors.white,
                        //                                   overflow: TextOverflow
                        //                                       .ellipsis),
                        //                             ),
                        //                           ],
                        //                         ),
                        //                       ),
                        //                     ],
                        //                   ),
                        //                 ),
                        //               ),
                        //             );
                        //           },
                        //         )),
                      ],
                    );
                  } else {
                    if (controller.getNewsApiResponse.status == Status.ERROR) {
                      return Center(
                        child: Text('Something Went Wrong'),
                      );
                    }
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),

          ],
        ),
      ),
    );
  }
}
