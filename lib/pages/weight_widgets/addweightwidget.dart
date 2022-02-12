import 'package:flutter/material.dart';
import '../../models/weight.dart';
import '../../services/api_service/auth_service.dart';
import '../../services/api_service/weight_service.dart';
import '../../services/ui/uiServ.dart';

class AddWeightWidget extends StatefulWidget {
  AddWeightWidget();

  @override
  _AddWeightWidgetState createState() => _AddWeightWidgetState();
}

class _AddWeightWidgetState extends State<AddWeightWidget> {
  _AddWeightWidgetState();

  final ApiService api = ApiService();
  final _addFormKey = GlobalKey<FormState>();
  final _wValueController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add weight'),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.logout),
              onPressed: () {
                signOut(context);
              }),
        ]
      ),
      body: Form(
        key: _addFormKey,
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(20.0),
            child: Card(
                child: Container(
                    padding: EdgeInsets.all(10.0),
                    width: 440,
                    child: Column(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                          child: Column(
                            children: <Widget>[
                              Text('Weight'),
                              TextFormField(
                                controller: _wValueController,
                                decoration: const InputDecoration(
                                  hintText: 'Weight value',
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter weight value';
                                  }
                                  return null;
                                },
                                onChanged: (value) {},
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                          child: Column(
                            children: <Widget>[
                              RaisedButton(
                                splashColor: Colors.red,
                                onPressed: () {
                                  if (_addFormKey.currentState!.validate()) {
                                    _addFormKey.currentState!.save();
                                    var timeStamp = DateTime.now();
                                          api.createWeight(Weight(
                                        value: int.parse(_wValueController.text),
                                        timeStamp: timeStamp.toString()));
                                    showToast('Weight added successfully');
                                    Navigator.pop(context);
                                  }
                                },
                                child: Text('Save',
                                    style: TextStyle(color: Colors.white)),
                                color: Colors.blue,
                              )
                            ],
                          ),
                        ),
                      ],
                    ))),
          ),
        ),
      ),
    );
  }
}
