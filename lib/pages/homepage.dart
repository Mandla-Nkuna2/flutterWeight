// ignore_for_file: curly_braces_in_flow_control_structures, prefer_conditional_assignment, avoid_unnecessary_containers, unnecessary_new
import 'package:flutter/material.dart';

import '../models/weight.dart';
import '../services/api_service/weight_service.dart';
import 'weight_widgets/addweightwidget.dart';
import 'weight_widgets/weightList.dart';

class HomePage extends StatefulWidget {
  static const String id = "HomePage";
  const HomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<Weight> weightsList;
  final ApiService api = ApiService();

  @override
  void initState() {
    super.initState();
    weightsList = [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new Container(
        child: new Center(
            child: new FutureBuilder(
          future: loadList(),
          builder: (context, snapshot) {
            if (weightsList.isNotEmpty) {
              return new WeightList(weightsList);
            } else if (snapshot.hasError) {
              return new Center(
                  child: new Text('${snapshot.error}',
                      style: Theme.of(context).textTheme.titleMedium));
            }
            return new Center(
                child: new Text('No data found, tap plus button to add!',
                    style: Theme.of(context).textTheme.titleMedium));
          },
        )),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _navigateToAddScreen(context);
        },
        tooltip: 'Add new weight',
        child: const Icon(Icons.add),
      ),
    );
  }

  Future loadList() {
    Future<List<Weight>> futureWeight = api.getWeights();
    futureWeight.then((weightsList) {
      setState(() {
        this.weightsList = weightsList;
      });
    });
    return futureWeight;
  }

  _navigateToAddScreen(BuildContext context) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddWeightWidget()),
    );
  }
}
