// ignore_for_file: curly_braces_in_flow_control_structures

import 'dart:convert';

import '../ui/uiServ.dart';
import '/models/weight.dart';
import 'package:http/http.dart';

const String iosUrl = "http://10.0.2.2:5000";
const String andUrl = "http://10.0.2.2:8081";
const bUrl = "http://localhost:8081";

class ApiService {
  Future<List<Weight>> getWeights() async {
    Response resp = await get(Uri.parse('$andUrl/get_weight_history'));

    if (resp.statusCode == 200) {
      List<dynamic> body = jsonDecode(resp.body);
      List<Weight> weights =
          body.map((dynamic item) => Weight.fromJson(item)).toList();
      return weights;
    } else {
      print('getWeights error reponse: ' + resp.body);
      throw "Failed to load weights list";
    }
  }

  Future<Weight> createWeight(Weight weight) async {
    Map data = {
      '_id': weight.id,
      'value': weight.value,
      'timeStamp': weight.timeStamp,
    };

    final Response resp = await post(
      Uri.parse('$andUrl/save_weight'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(data),
    );

    if (resp.statusCode == 201)
      return Weight.fromJson(json.decode(resp.body));
    else {
      print(resp.body);
      throw Exception('Failed to post weights');
    }
  }

  Future<Weight> updateWeight(String id, Weight weight) async {
    Map data = {
      '_id': weight.id,
      'value': weight.value,
      'timeStamp': weight.timeStamp,
    };

    final Response resp = await put(
      Uri.parse('$andUrl/update_weight/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(data),
    );

    if (resp.statusCode == 201) {
      return Weight.fromJson(json.decode(resp.body));
    } else {
      print(resp.body);
      throw Exception('Failed to update a weight');
    }
  }

  Future<void> deleteWeight(String id) async {
    Response resp = await delete(Uri.parse('$andUrl/delete_weight/$id'));

    if (resp.statusCode == 201)
      showToast('Weight deleted successfully');
    else {
      print(resp.body);
      throw "Failed to delete a weight";
    }
  }
}
