import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  var _sentence = 'Counter of People';
  var _people = 0;

  Widget _gradient() => Container(
    decoration: BoxDecoration(
      gradient: LinearGradient(
          colors: [Colors.blue, Colors.red],
          begin: Alignment.topRight,
          end: Alignment.bottomLeft
      )
    ),
  );

  void updateValue(int value){
    setState(() {
      _people += value;
      if(_people < 0){
        _people = 0;
      }else if(_people < 20){
        var places = 20 - _people;
        _sentence = 'There are $places free seats';
      }else {
        _sentence = 'Crowded Establishment';
        _people = 20;
      };
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        _gradient(),
        Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                _sentence,
                style: TextStyle(fontSize: 18.0, color: Colors.white),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  FlatButton(
                      onPressed: (){updateValue(1);},
                      child: Text(
                        '+1',
                        style: TextStyle(fontSize: 18.0, color: Colors.white),
                      ),
                  ),
                  FlatButton(
                      onPressed: (){updateValue(-1);},
                      child: Text(
                        '-1',
                        style: TextStyle(fontSize: 18.0, color: Colors.white),
                      )
                  ),
                ],
              ),
              Text(
                'Total of 20 seats',
                style: TextStyle(fontSize: 18.0, color: Colors.white),
              )
            ],
          ),
        )
      ],
    );
  }
}
