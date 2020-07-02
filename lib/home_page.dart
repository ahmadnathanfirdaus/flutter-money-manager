import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final _moneyController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  List<int> money = [];
  List<String> description = [];
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
                                money.add(int.parse(_moneyController.text));
                                _descriptionController.text == '' ? description.add('no description') : description.add(_descriptionController.text);
                                _moneyController.text = '';
                                _descriptionController.text = '';
                                Navigator.pop(context);
                              });
                            }
                            print(money);
                            print(description);
                          },
                          color: Colors.blue,
                        )
                      ]),
                    ),
                  ));
            }));
            print(description);
          },
        ),
        appBar: AppBar(
          title: Text('Money Manager'),
        ),
        body: ListView.builder(
          itemCount: money.length,
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
                      Text('Rp. ${money[index].toString()}', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      Text(description[index])
                    ],
                  )
                ],
              ),
            );
          },
        ));
  }
}