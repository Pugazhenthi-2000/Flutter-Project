import 'package:flutter/material.dart';
import 'LoginRegisterPage.dart';
import 'HomePage.dart';
import 'Mapping.dart';
import 'Authentication.dart';

void main() 
{
    runApp(new MrTechie());
}


class MrTechie extends StatelessWidget
{
  @override
    Widget build(BuildContext context) 
    {
        return new MaterialApp
        (
          title: "Mr.Techie",

          theme: ThemeData
          (
            primarySwatch: Colors.purple,
            accentColor: Colors.purple,
            cursorColor: Colors.black,
            textTheme:  TextTheme(
              display2: TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 45.0,
                color: Colors.orange,
              ),
              button: TextStyle(
                fontFamily: 'OpenSans',
              ),
              subhead:  TextStyle(fontFamily: 'NotoSans'),
              body1:  TextStyle(fontFamily: 'NotoSans'),
            ),
          
          ),
     
          home: MappingPage( auth: Auth(),),
        
        
          );
        }
      
        
}