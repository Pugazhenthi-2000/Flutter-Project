import 'package:flutter/material.dart';
import 'HomePage.dart';
import 'LoginRegisterPage.dart';
import 'Authentication.dart';

class MappingPage extends StatefulWidget
{
  final AuthImplementation auth;

  MappingPage
  ({
    this.auth
     });

 State<StatefulWidget> createState()
  {
    return  _MappingState();   
  }
}

enum AuthStatus
{
  notSignedIn,
  signedIn,
}

class _MappingState extends State<MappingPage>
{
  AuthStatus authStatus = AuthStatus.notSignedIn;



 @override
  void initState() 
  {
  
    super.initState();

    widget.auth.getCurrentUser().then((firbaseUserId)
    {
        
    setState(() {
            
        authStatus = (firbaseUserId == null ?  AuthStatus.notSignedIn : AuthStatus.signedIn);
    });
    });

  }


  void _signedIn()
  {
    setState(() {
      authStatus = AuthStatus.signedIn;
    });
  }


   void  _signedOut()
  {
    setState(() {
      authStatus = AuthStatus.notSignedIn;
    });
  }
 
 
 
  @override
  Widget build(BuildContext context)
   {
     switch(authStatus)
     {
       case AuthStatus.notSignedIn:
       return  new LoginRegisterPage
       (
         auth: widget.auth,
         onSignedIn: _signedIn,
       );

       case AuthStatus.signedIn:
       return  new HomePage
       (
         auth: widget.auth,
         onSignedOut: _signedOut,
       );

       case AuthStatus.signedIn:
    
         break;
     }
    return null;
  }
}