import 'package:coronavirus_rest_api_flutter_course/app/services/api.dart';
import 'package:coronavirus_rest_api_flutter_course/app/services/api_service.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _accessToken = '';
  int _cases;
  int _deaths;

  void _updateAccessToken() async {
    final apiService = APIService(API.sandbox());
    final accessToken = await apiService.getAccessToken();
    final cases = await apiService.getEndpointData(
      accessToken: accessToken,
      endpoint: Endpoint.cases,
    );
    final deaths = await apiService.getEndpointData(
      accessToken: accessToken,
      endpoint: Endpoint.deaths,
    );
    setState(() {
      _accessToken = accessToken;
      _cases = cases;
      _deaths = deaths;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_accessToken',
              style: Theme.of(context).textTheme.bodyText1,
            ),
            if (_cases != null)
              Text(
                'cases: $_cases',
                style: Theme.of(context).textTheme.bodyText1,
              ),
            if (_deaths != null)
              Text(
                'deaths: $_deaths',
                style: Theme.of(context).textTheme.bodyText1,
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _updateAccessToken,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
