import 'package:flutter/material.dart';

class ProfilePage extends  StatefulWidget
{
 

  @override
  State<StatefulWidget> createState() {
    return _ProfilePageState();
  }
}

class _ProfilePageState extends State<ProfilePage>
{
  @override
  Widget build(BuildContext context) {
    
    return new Scaffold
    (
      appBar: new AppBar
      (
        title: new Text("Profile Page"),
        centerTitle: true,
      ),
    );
  }



}

