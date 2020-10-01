import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  GlobalKey<FormState> _state = GlobalKey<FormState>();

  final _dateFormat = DateFormat("dd/MM/yyyy HH:mm");
  final _nameController = TextEditingController();
  
  DateTime _date;
  TimeOfDay _time;

  List reserves = [];

  Widget _gradient() => Container(
    decoration: BoxDecoration(
      gradient: LinearGradient(
          colors: [Colors.grey, Colors.black],
          begin: Alignment.topRight,
          end: Alignment.bottomLeft
      )
    ),
  );

  void clear() {
    _nameController.text = '';
    _date = null;
    _time = null;
  }

  String formatDate() {
    if(_date != null && _time != null){
      final dt = DateTime(_date.year, _date.month, _date.day, _time.hour, _time.minute);
      return _dateFormat.format(dt);
    }else return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Reserva',
          style: TextStyle(color: Colors.white, fontSize: 20.0),
        ),
        backgroundColor: Colors.grey,
        centerTitle: true,
        actions: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 20.0),
            child: Row(
              children: <Widget>[
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    '${reserves.length}',
                    style: TextStyle(color: Colors.white,fontSize: 20.0),),
                ),
                Icon(Icons.people, color: Colors.white,size: 20.0,)
              ],
            ),
          )
        ],
      ),
      body: Stack(
        children: <Widget>[
          _gradient(),
          SingleChildScrollView(
            child: Padding(
                padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 0.0),
                child:Form(
                    key: _state,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        TextFormField(
                          decoration: InputDecoration(
                              labelText: 'Nome',
                              labelStyle: TextStyle(color: Colors.white, fontSize: 15.0)
                          ),
                          controller: _nameController,
                          style: TextStyle(color: Colors.white),
                          validator: (value){
                            if(value.isEmpty) return 'O campo deve ser preenchido';
                          },
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            FlatButton(
                                onPressed: (){
                                  showDatePicker(
                                      context: context,
                                      initialDate: _date != null ? _date.toUtc() : DateTime.now(),
                                      firstDate: DateTime.now(),
                                      lastDate: DateTime(2021)
                                  ).then((date){
                                    setState(() {
                                      _date = date;
                                    });
                                  });
                                },
                                child: Icon(
                                  Icons.calendar_today,
                                  color: Colors.white,
                                  size: 20.0,
                                )
                            ),
                            FlatButton(
                                onPressed: (){
                                  showTimePicker(
                                      context: context,
                                      initialTime: _time != null ? _time : TimeOfDay.now()
                                  ).then((time){
                                    setState(() {
                                      _time = time;
                                    });
                                  });
                                },
                                child: Icon(
                                  Icons.watch_later,
                                  color: Colors.white,
                                  size: 20.0,
                                )
                            )
                          ],
                        ),
                        Container(
                          height: 50.0,
                          child: RaisedButton(
                            onPressed: (){
                              if(_state.currentState.validate() && formatDate() != null){
                                setState(() {
                                  reserves.add(_nameController.text);
                                  clear();
                                });
                              }
                            },
                            child: Text(
                              'Submeter',
                              style: TextStyle(color: Colors.white, fontSize: 20.0),
                            ),
                          ),
                        ),
                      ],
                    ),
                )
            ),
          )
        ],
      ),
    );
  }
}
