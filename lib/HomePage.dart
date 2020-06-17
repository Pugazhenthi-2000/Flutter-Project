
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'Authentication.dart';
import 'PhotoUpload.dart';
import 'Posts.dart';
import 'ProfilePage.dart';


class HomePage extends StatefulWidget
{
  HomePage
  ({
    this.auth,
    this.onSignedOut,
  });
     final AuthImplementation auth;
     final VoidCallback onSignedOut;


  @override
  State<StatefulWidget> createState() {
    
    return HomePageState();
  
  }  
}

class HomePageState extends State<HomePage>
{
    final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
    List<Posts> postsList = [];
    
   
     
   @override
  void initState()
   {
    
    super.initState();

    DatabaseReference postsRef = FirebaseDatabase.instance.reference().child("Posts");

    postsRef.once().then((DataSnapshot snap)
    {
     var KEYS = snap.value.keys;
     var DATA = snap.value;

     postsList.clear();

     for(var individualKey in KEYS)
     {
       Posts posts = new Posts
       (
         DATA[individualKey] ['image'], 
         DATA[individualKey] ['description'],
         DATA[individualKey] ['date'],
         DATA[individualKey] ['time'],
     
       );

       postsList.add(posts);
     }

     setState(() 
     {
      print('Length : $postsList.length');
     });
    });
  }
 
  void _logoutUser() async
  {
    try
    {
        await widget.auth.signOut();
        widget.onSignedOut();
    }
    catch(e)
    {
      print(e.toString());
    }
    
  }



  @override
  Widget build(BuildContext context) 
  {
    return new Scaffold
    (
      key: _scaffoldKey,
      drawer: new Drawer(
        elevation:25.0,
        child: ListView(
          padding: EdgeInsets.zero,
        children: <Widget>[
          new Container
          (
            height: 100,
             decoration: new BoxDecoration(
      color: Colors.purple,
      boxShadow: [
        new BoxShadow(blurRadius: 40.0)
      ],
      borderRadius: new BorderRadius.vertical(
          bottom: new Radius.elliptical(
              MediaQuery.of(context).size.width, 100.0)
              ),
    ),
          
        
            child: Text
            (
              "About Us",
              
            style: TextStyle(fontSize: 30.0,fontWeight: FontWeight.bold,color: Colors.white),
            textAlign: TextAlign.center,
            
            ),
         
            ),
             new  CircleAvatar
                 (
                   backgroundColor: Colors.transparent,
                   radius: 90.0,
                   child: Image.asset('assets/image/pug.png'),        
                 ),
          
            SizedBox(height: 10.0,),
            new Text("Hi i am pugazhenthi",
                style: TextStyle(fontSize:16.0,fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
              ),
              SizedBox(height: 15.0,),
  
              new Text(" I am a Engineering Student,And this is my miniproject.Many engineering students are laged in technical knowledge .So i Developed this Mr.techie application because in this application they can post the technical contents and know some technical news and knowledge.  And this application  is created in  Flutter framework and Dart programming with Firebase realtime database.",
                style: TextStyle(fontSize:14.0,fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
              )
  
        
          ],
        ),
      ),
      appBar: new AppBar
      (
        
        title: new Text("Home"),
         centerTitle: true,
         leading:  new IconButton
         (
           icon:  new Icon(Icons.menu),
           onPressed: () => _scaffoldKey.currentState.openDrawer()
         ),
         
      ),


      body:  new Container
      (
       child: postsList.length == 0 ? new Text("No Blog Post available") : new ListView.builder
       (
         itemCount: postsList.length,
         itemBuilder: (_, index)
         {
           return  PostsUI(postsList[index].image, postsList[index].description, postsList[index].date, postsList[index].time, postsList[index].like);
         }
                  ),
      ),
      
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton
              (
              
                child: new Icon(Icons.add,color:Colors.white,),

                  backgroundColor: Colors.purple,
                  
               onPressed: ()
               {
                 Navigator.push
                 (context, 
                 MaterialPageRoute(builder: (context)
                 {
                   return new UploadPhotoPage();
                 })
                 );
               },
             ),

    bottomNavigationBar:  BottomAppBar
        (
          shape: CircularNotchedRectangle(),
           color: Colors.purple,
          
          child:  new Row
          (
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,

            children: <Widget>
            [
              new IconButton
              (icon: new Icon(Icons.exit_to_app),
               onPressed: _logoutUser,
               iconSize: 30.0,
               color: Colors.white,
               ),
             new IconButton
             (
               icon: new Icon(Icons.person),
               iconSize: 30.0,
               color: Colors.white,
              onPressed: ()
              {
                Navigator.push
                (
                  context,
                  MaterialPageRoute(builder: (context)
                  {
                    return new ProfilePage();
                  })
                );
              }
              ),
        
            
            ],
        

        

        ),
        ),
    );
  
  }

  Widget  PostsUI(String image, String description, String date, String time)
  
    return new Card
    (
      elevation: 10.0,
      margin: EdgeInsets.all(15.0),

      child:  new Container
      (
        padding: new EdgeInsets.all(14.0),

        child:  new Column
        (
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>
          [
           new Row
           (
             mainAxisAlignment: MainAxisAlignment.spaceAround,

             children: <Widget>
             [
                new Text
            (
              date,
              style: Theme.of(context).textTheme.subtitle,
              textAlign: TextAlign.center,
            ),

             new Text
            (
              time,
              style: Theme.of(context).textTheme.subtitle,
              textAlign: TextAlign.center,
            )
             ],
             
           ),

           SizedBox(height: 10.0,),

           new Image.network(image,fit:BoxFit.cover),

           SizedBox(height: 10.0,),

            new Text
            (
            description,
              style: Theme.of(context).textTheme.subtitle,
              textAlign: TextAlign.center,
            ),
           
           
            
        

          ],
           
        

        ),
        
      ),
    );
  }
}