import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:virtoustackdemo/home_screen/bloc/bloc.dart';
import 'package:virtoustackdemo/home_screen/model/model.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  /*
  * Global Instance of PageController Variable
  * */
  PageController pageController;

  /*
  * Global Instance of Integer Variable
  * */
  int selectedIndex = 0;

  /*
  * Global Instance of Double Variable
  * */
  double offset = 0.0;

  @override
  void initState() {
    /*
    * Fetch HomeScreen Data
    * */
    pathsDataBloc.fetchDevicesData(context);

    /*
    * Listen to PageController
    * */
    pageController = new PageController()
    ..addListener((){
      setState(() {
        offset= pageController.offset;
      });
    });
    super.initState();
  }
  @override
  void dispose() {
    /*
    * Dispose PageController when screen is not active
    * */
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: StreamBuilder(
              stream: pathsDataBloc.devicesData,
              builder: (context, AsyncSnapshot<PathsModel> snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.connectionState == ConnectionState.active) {
                    return loadPathsData(context, snapshot.data.pathsDataList);
                  }
                } else if (snapshot.hasError)
                  return Text(
                    'Something went wrong!',
                    style: TextStyle(fontFamily: 'ProductSans', fontSize: 26.0),
                  );

                return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                      CircularProgressIndicator(),
                      SizedBox(
                      height: 4.0,
                      ),
                      Text(
                        'Loading...',
                        style:
                          TextStyle(fontFamily: 'ProductSans', fontSize: 26.0),
                    ),
                  ],
                ));
              },
            ),
          ),
        ),
      ),
    );
  }

  /*
  * Method to display PathsData
  * */
  Widget loadPathsData(BuildContext context, List<PathsData> pathsDataList) {

    /*
    * Local Variable of List<SubPathsData>
    * */
    List<SubPathsData> subPathData = [];

    return Container(
      color: Colors.black54,
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.symmetric(vertical: 16.0),
            child: Text(
              "Dog's Path",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: 'productsans',
                  fontSize: 18.0,
                  color: Colors.white),
            ),
          ),
          ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: pathsDataList.length,
              itemBuilder: (BuildContext context, int index) {
                print("Id" +
                    pathsDataList[index].id.toString() +
                    "   Title" +
                    pathsDataList[index].title.toString() +
                    "   createdAt" +
                    pathsDataList[index].createdAt.toString() +
                    "   avatar" +
                    pathsDataList[index].avatar.toString());

                if(pathsDataList[index].subPathsDataList != null)
                  {
                    for(int i = 0; i < pathsDataList[index].subPathsDataList.length; i++)
                    {
                      subPathData.add(pathsDataList[index].subPathsDataList[i]);
                    }
                  }

                return pathsDataList.isEmpty
                    ? Center(
                        child: Text(
                        'Data Not Found..!',
                        style: TextStyle(fontSize: 22.0, color: Colors.black),
                      ))
                    : Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 22.0, right: 12.0, top: 12.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    pathsDataList[index].title == null
                                        ? Container()
                                        : Text(
                                            pathsDataList[index].title,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontFamily: 'productsans',
                                                fontSize: 20.0,
                                                color: Colors.white),
                                          ),
                                    pathsDataList[index].name == null
                                        ? Container()
                                        : Text(
                                      pathsDataList[index].name,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontFamily: 'productsans',
                                          fontSize: 20.0,
                                          color: Colors.white),
                                    ),

                                    /*Text(
                                            pathsDataList[index].subPathsDataList.length.toString()+" Sub Paths" ,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontFamily: 'productsans',
                                                fontSize: 14.0,
                                                color: Colors.white),
                                          ),*/
                                  ],
                                ),
                                SizedBox(
                                  height: 26.0,
                                  child: FlatButton(
                                    child: Text('Open Path',
                                        style: TextStyle(
                                            fontFamily: 'productsans',
                                            fontSize: 12.0,
                                            color: Colors.blue[100])),
                                    color: Colors.black,
                                    textColor: Colors.white,
                                    onPressed: () {},
                                  ),
                                ),
                              ],
                            ),
                          ),
                          loadSubPathData(context, subPathData),
                        ],
                      );
              }),
        ],
      ),
    );
  }

  /*
  * Method to display SubPathsData
  * */
  Widget loadSubPathData(BuildContext context, List<SubPathsData> subPathsDataList) {
    return Column(
      children: <Widget>[
        Container(
          height: 206.0,
          child: PageView.builder(
            controller: pageController,
              itemCount: subPathsDataList.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
                return subPathsDataList.isEmpty
                    ? Container()
                    : Container(
                        margin: EdgeInsets.only(top: 6.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            subPathsDataList[index]
                                        .imageUrl ==
                                    null
                                ? Container()
                                : Image.network(
                                    subPathsDataList[index]
                                        .imageUrl,
                                    height: 200.0,
                                    width: MediaQuery.of(context).size.width,
                                    fit: BoxFit.fill,
                                  ),
                            /*pathsDataList[index].avatar == null
                                ? Container()
                                : Image.network(
                                    pathsDataList[index].avatar,
                                    height: 200.0,
                                    width: MediaQuery.of(context).size.width,
                                    fit: BoxFit.fill,
                                  ),*/
                          ],
                        ),
                      );
              }),
        ),
        Container(
          height: 50.0,
          color: Colors.black,
          child: ListView.builder(
              shrinkWrap: true,
              physics: AlwaysScrollableScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: subPathsDataList.length,
              itemBuilder: (BuildContext context, int index) {
                return subPathsDataList[index].title == null
                    ? Container()
                    : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Material(
                          child: InkWell(
                            child: Text(
                                subPathsDataList[index].title + "  ->  ",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontFamily: 'productsans',
                                    fontSize: 16.0,
                                    color: selectedIndex == index
                                        ? Colors.white
                                        : Colors.blue[100]),
                              ),
                            onTap: (){
                              /*setState(()
                              {
                                for(int i = 0; i <pathsDataList[index].subPathsDataList.length; i++)
                                {
                                  if(i == index)
                                    {
                                      selectedIndex = index;
                                    }
                                }
                              });*/
                              setState(() {
                                selectedIndex = index;
                              });
                              pageController.animateToPage(selectedIndex, duration: Duration(milliseconds: 100), curve: Curves.ease);
                            },
                            splashColor: Colors.blue,
                          ),
                          color: Colors.transparent,
                        ),
                      ],
                    );
              }),
        ),
      ],
    );
  }

  /*
  * Method to listen to PageController
  * */
  void pageChanged(int index, List<PathsData> pathsDataList)
  {
    if(selectedIndex == index)
      {
        setState(() {
          selectedIndex = index;
        });
      }

  }
}
