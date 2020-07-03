import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:money_manager/user_data.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final _moneyController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  UserData data = UserData();
  String date = '${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return Scaffold(
                  appBar: AppBar(
                    title: Text('New Entry'),
                  ),
                  body: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Form(
                      key: _formKey,
                      child: Column(children: <Widget>[
                        TextFormField(
                          validator: (value) {
                            if(value.isEmpty){
                              return 'Please enter amount value';
                            }
                            return null;
                          },
                          controller: _moneyController,
                          decoration: InputDecoration(
                              labelText: 'Enter amounts here',
                              border: OutlineInputBorder()),
                          keyboardType: TextInputType.number,
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          controller: _descriptionController,
                          decoration: InputDecoration(
                              labelText: 'Enter description here',
                              border: OutlineInputBorder()),
                        ),
                        SizedBox(height: 10),
                        RaisedButton(
                          child: Text('ADD ENTRY', style: TextStyle(color: Colors.white)),
                          onPressed: () {
                            if(_formKey.currentState.validate()) {
                              setState(() {
                                data.money.add(_moneyController.text);
                                _descriptionController.text == '' ? data.description.add('no description') : data.description.add(_descriptionController.text);
                                _moneyController.text = '';
                                _descriptionController.text = '';
                                Navigator.pop(context);
                              });
                            }
                            print(data.money);
                            print(data.description);
                          },
                          color: Colors.blue,
                        )
                      ]),
                    ),
                  ));
            }));
            print(data.description);
          },
        ),
        appBar: AppBar(
          title: Text('Money Manager'),
        ),
        body: ListView.builder(
          itemCount: data.money.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: <Widget>[
                  Text(date),
                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('Rp. ${data.money[index].toString()}', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      Text(data.description[index])
                    ],
                  )
                ],
              ),
            );
          },
        ));
  }
}