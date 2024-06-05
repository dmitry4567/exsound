import 'package:exstudio/backend/api_requests/api_calls.dart';
import 'package:exstudio/flutter_flow/flutter_flow_util.dart';
import 'package:exstudio/home/model.dart';
import 'package:exstudio/home/widgets/card.dart';
import 'package:flutter/material.dart';
import '../../flutter_flow/custom_functions.dart' as functions;

class HomeWidget extends StatefulWidget {
  const HomeWidget({super.key});

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  Future<dynamic> getData() async {
    final response =
        await GetAllProject.call(token: FFAppState().userAuthToken);

    if (functions.resultCodeSuccess(getJsonField(
      (response.jsonBody ?? ''),
      r'''$.status''',
    ))) {
      var projects = getJsonField(response.jsonBody ?? '', r'''$.data''');

      return projects.map((project) => Project.fromJson(project)).toList();
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: FutureBuilder<dynamic>(
          future: getData(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                  child: CircularProgressIndicator(color: Color(0xFFFFA000)));
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              return ListView.builder(
                itemCount: snapshot.data.length,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return CardProject(data: snapshot.data[index]);
                },
              );
            }
          },
        ),
      ),
    );
  }
}
