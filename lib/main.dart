import 'package:flutter/material.dart';
import 'package:call_log/call_log.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<CallLogEntry> _callLog = [];

  @override
  void initState() {
    super.initState();
    _getCallLog();
  }

  Future<void> _getCallLog() async {
    try {
      Iterable<CallLogEntry> entries = await CallLog.get();
      setState(() {
        _callLog = entries.toList();
      });
    } catch (e) {
      print("Error fetching call log: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Call Log Access App'),
      ),
      body: _buildCallLogList(),
    );
  }

  Widget _buildCallLogList() {
    return ListView.builder(
      itemCount: _callLog.length,
      itemBuilder: (context, index) {
        CallLogEntry entry = _callLog[index];

        return ListTile(
          title: Text(entry.name ?? 'Unknown'),
          subtitle: Text('Number: ${entry.number}\n ${entry.callType}\nDuration(seconds) : ${entry.duration}\nTimeStamp: ${entry.timestamp}'),
        );
      },
    );
  }
}
