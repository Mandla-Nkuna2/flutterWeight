import 'package:flutter/material.dart';
import 'package:flutter_weight_app/models/weight.dart';
import 'package:flutter_weight_app/pages/homepage.dart';

import '../../services/api_service/auth_service.dart';
import '../../services/api_service/weight_service.dart';
import '../../services/ui/uiServ.dart';

class EditWidget extends StatefulWidget {
  EditWidget(this.weight);

  final Weight weight;

  @override
  _EditWidgetState createState() => _EditWidgetState();
}

class _EditWidgetState extends State<EditWidget> {
  _EditWidgetState();

  final ApiService api = ApiService();
  final _addFormKey = GlobalKey<FormState>();
  String weightId = '';
  String timeStamp = '';
  final _valueController = TextEditingController();

  @override
  void initState() {
    weightId = widget.weight.id.toString();
    timeStamp = widget.weight.timeStamp.toString();
    _valueController.text = widget.weight.value.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit weight'),
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
                              Text('Weight value'),
                              TextFormField(
                                controller: _valueController,
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
                                    api.updateWeight(
                                        weightId,
                                        Weight(
                                          value: int.parse(_valueController.text),
                                          timeStamp: timeStamp,
                                        ));
                                    showToast('Weight edited successfully');
                                    Navigator.pushNamed(context, HomePage.id);
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
