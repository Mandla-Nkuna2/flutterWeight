// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:flutter_weight_app/models/weight.dart';
import 'package:flutter_weight_app/services/api_service/auth_service.dart';

import 'detailwidget.dart';

class WeightList extends StatelessWidget {
  final List<Weight> weights;
  WeightList(this.weights);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('List'), actions: <Widget>[
          IconButton(
              icon: Icon(Icons.logout),
              onPressed: () {
                signOut(context);
              }),
        ]),
        body: ListView.builder(
            itemCount: weights == null ? 0 : weights.length,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                  child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DetailWidget(weights[index])),
                  );
                },
                child: ListTile(
                  title: Text(weights[index].value.toString()),
                  subtitle: Text(weights[index].timeStamp.toString()),
                ),
              ));
            }));
  }
}
