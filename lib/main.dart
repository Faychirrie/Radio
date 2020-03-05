import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<List<radio>> getRadio()
  async{
     var data = await http.get("http://192.168.0.108:5000/api/v1/resources/stations/all");
     var jsonData = json.decode(data.body);
     List <radio> radios = [];
     for(var r in jsonData)
       {
         radio Radio = radio(r["name"], r["streaming_url"]);
         radios.add(Radio);
       }
     print(radios.length);

  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.white),
      child: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height-500,
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(120))
                ),

              ),
              Text("Hello I am trying to use github"),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
              RaisedButton(
                 onPressed:()
                 {
                   FutureBuilder(
                     future: getRadio(),
                     builder: (BuildContext context,AsyncSnapshot snapshot)
                     {
                       if(snapshot.data==null)
                       {
                         return Container(
                           child: Center(
                             child: Text("Loading....."),
                           ),
                         );
                       }
                       else {
                         return ListView.builder(
                             itemCount: snapshot.data.length,
                             itemBuilder: (BuildContext context, int index) {
                               return ListTile(
                                 title: Text(snapshot.data[index].name),
                               );
                             }
                         );
                       }

                     }


                   );
                 },
////                 async{
////                  await FutureBuilder<Post>(
////                     future: post,
////                     builder: (context, snapshot) {
////                       if (snapshot.hasData) {
////                         return Text(snapshot.data.radio_station_name);
////                       } else if (snapshot.hasError) {
////                         return Text("${snapshot.error}");
////                       }
////
////                       // By default, show a loading spinner.
////                       return CircularProgressIndicator();
////                     },
////                   );
//                 },
                 textColor: Colors.white,
                 color: Colors.red,
                 padding: const EdgeInsets.all(8.0),
                  child: new Text(
                    "Countries",
                    ),
              ),
                  SizedBox(width: 3,),

                  RaisedButton(
                    onPressed: null,
                    textColor: Colors.white,
                    color: Colors.red,
                    padding: const EdgeInsets.all(8.0),
                    child: new Text(
                      "Stations",
                    ),

                  ),
                  SizedBox(width: 3,),
                  RaisedButton(
                    onPressed: null,
                    textColor: Colors.white,
                    color: Colors.red,
                    padding: const EdgeInsets.all(8.0),
                    child: new Text(
                      "Podcasts",
                    ),

                  ),
                ],
              ),
                    FutureBuilder(
                    future: getRadio(),
    builder: (BuildContext context,AsyncSnapshot snapshot)
    {
    if(snapshot.data==null)
    {
    return Container(
    child: Center(
    child: Text("Loading....."),
    ),
    );
    }
    else {
    return ListView.builder(
    itemCount: snapshot.data.length,
    itemBuilder: (BuildContext context, int index) {
    return ListTile(
    title: Text(snapshot.data[index].name),
    );
    }
    );
    }

    }


    ),

            ],
          )


        ],
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class radio {
  final String radio_name, streaming_url;
  radio(this.radio_name,this.streaming_url);
}
//import 'package:flutter/material.dart';
//import 'dart:async';
//import 'package:http/http.dart' as http;
//import 'dart:convert';
//
//void main() => runApp(new MyApp());
//
//class MyApp extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return new MaterialApp(
//      title: 'Flutter Demo',
//      theme: new ThemeData(
//        primarySwatch: Colors.blue,
//      ),
//      home: new MyHomePage(title: 'Users'),
//    );
//  }
//}
//
//class MyHomePage extends StatefulWidget {
//  MyHomePage({Key key, this.title}) : super(key: key);
//
//  final String title;
//
//  @override
//  _MyHomePageState createState() => new _MyHomePageState();
//}
//
//class _MyHomePageState extends State<MyHomePage> {
//
//  Future<List<User>> _getUsers() async {
//
//    var data = await http.get("http://www.json-generator.com/api/json/get/cfwZmvEBbC?indent=2");
//
//    var jsonData = json.decode(data.body);
//
//    List<User> users = [];
//
//    for(var u in jsonData){
//
//      User user = User(u["index"], u["about"], u["name"], u["email"], u["picture"]);
//
//      users.add(user);
//
//    }
//
//    print(users.length);
//
//    return users;
//
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return new Scaffold(
//      appBar: new AppBar(
//        title: new Text(widget.title),
//      ),
//      body: Container(
//        child: FutureBuilder(
//          future: _getUsers(),
//          builder: (BuildContext context, AsyncSnapshot snapshot){
//            print(snapshot.data);
//            if(snapshot.data == null){
//              return Container(
//                  child: Center(
//                      child: Text("Loading...")
//                  )
//              );
//            } else {
//              return ListView.builder(
//                itemCount: snapshot.data.length,
//                itemBuilder: (BuildContext context, int index) {
//                  return ListTile(
//                    leading: CircleAvatar(
//                      backgroundImage: NetworkImage(
//                          snapshot.data[index].picture
//                      ),
//                    ),
//                    title: Text(snapshot.data[index].name),
//                    subtitle: Text(snapshot.data[index].email),
//                    onTap: (){
//
//                      Navigator.push(context,
//                          new MaterialPageRoute(builder: (context) => DetailPage(snapshot.data[index]))
//                      );
//
//                    },
//                  );
//                },
//              );
//            }
//          },
//        ),
//      ),
//    );
//  }
//}
//
//class DetailPage extends StatelessWidget {
//
//  final User user;
//
//  DetailPage(this.user);
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//        appBar: AppBar(
//          title: Text(user.name),
//        )
//    );
//  }
//}
//
//
//class User {
//  final int index;
//  final String about;
//  final String name;
//  final String email;
//  final String picture;
//
//  User(this.index, this.about, this.name, this.email, this.picture);
//
//}

