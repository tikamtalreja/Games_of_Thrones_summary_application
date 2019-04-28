import 'package:flutter/material.dart';
import 'package:got_application/got.dart';

class EposidesPage extends StatelessWidget {

 final List<Episodes> episodes;
  MyImage myImage;
  BuildContext  _context;

  EposidesPage({this.episodes,this.myImage });

  showSummary(String summary){
    showDialog(context: _context,builder: (context)=> Center(
    
   child: Padding(
     padding: const EdgeInsets.all(12.0),
     child: Card(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Text(summary),
        ),
      ),
   )));
  }

  Widget myBody(){
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.0
      ),
      itemCount: episodes.length,
      itemBuilder: (context,index)=>InkWell(
          onTap: (){
            showSummary(episodes[index].summary);
          },                            
    child: Card(
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
              Image.network(episodes[index].image.original,
              colorBlendMode: BlendMode.colorDodge,
              fit: BoxFit.cover,
              ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Text(episodes[index].name,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
                ),

              ],
            ),
          ),
          Positioned(
            left: 0.0,
            top: 0.0,
            child: Container(
              color: Colors.blueGrey[300],
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text("${episodes[index].season}-${episodes[index].number}"
                ,style: TextStyle(color: Colors.white,
                fontWeight: FontWeight.bold),
                ),
              ),
            ),
          )
        ],
        ),
        ),
    ),);
  }
  @override
  Widget build(BuildContext context) {
    _context = context;
    return Scaffold(
      appBar: AppBar(title: Row(
        children: <Widget>[
          Hero(tag: "g1",
                      child: CircleAvatar(
              backgroundImage: NetworkImage(myImage.medium),
            ),
          ),
          SizedBox(width: 10.0,),
          Text("All Episodes")
        ],
      ),),

      body: myBody(),
    
    );
  }
}