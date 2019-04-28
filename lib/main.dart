import 'package:flutter/material.dart';
import 'package:got_application/got.dart';
import "package:http/http.dart" as http;
import 'dart:convert';
import './eposides_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blueGrey
      ),
      home: HomePage(),
      
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String url = "http://api.tvmaze.com/singlesearch/shows?q=game-of-thrones&embed=episodes";

  GOT got;
  Widget myCard(){
    return Card(
      
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Hero(
              tag: "g1",
                          child: CircleAvatar(
                radius: 100.0,
                backgroundImage: NetworkImage(got.image.original),
              ),
            ),
            Text(got.name,style: TextStyle(fontSize: 25.0,fontWeight: FontWeight.bold),),
            Text(got.summary),
            RaisedButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(
                  builder: (context)=> new EposidesPage(
                    episodes: got.eEmbedded.episodes,myImage: got.image,
                  )
                ));
              },
              color: Colors.blueGrey[300],
              child: Text("All Eposide"),
            )
          ],
        ),
      ),
    );
  }
  Widget myBody(){
    return got==null?Center(child: CircularProgressIndicator(),):myCard();
  }

@override
  void initState() {
    super.initState();
    fetchEposides();
  }
  fetchEposides() async{
    var res = await http.get(url);
    var decodedres = jsonDecode(res.body);
    print(decodedres);
    got = GOT.fromJson(decodedres);
    setState(() {
      
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      title:Text("Games Of Thrones"),
      ),
      body: myBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          fetchEposides();
        },
        child: Icon(Icons.refresh),
      ),
      
    );
  }
}