import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

// Define a Bug class to hold bug information
class Bug {
  String fileName;
  String bugType;
  String bugPriority;
  String bugDescription;
  String bugStatus;
  DateTime createdAt;

  Bug({
    required this.fileName,
    required this.bugType,
    required this.bugPriority,
    required this.bugDescription,
    required this.bugStatus,
    required this.createdAt,
  });
}

class ChangeStatusScreen extends StatefulWidget {
  @override
  _ChangeStatusScreenState createState() => _ChangeStatusScreenState();
}

class _ChangeStatusScreenState extends State<ChangeStatusScreen> {
  final _formKey = GlobalKey<FormState>();
  String newStatus = '';
  List<Bug> bugs = []; // List to store bugs

  @override
  void initState() {
    super.initState();
    loadBugs(); // Load initial list of bugs
  }

  Future<void> loadBugs() async {
    final directory = await getApplicationDocumentsDirectory();
    List<FileSystemEntity> files = directory.listSync();
    List<Bug> loadedBugs = [];
    files
        .where((file) => file is File && file.path.endsWith('.txt'))
        .forEach((file) {
      String content = File(file.path).readAsStringSync();
      List<String> lines = content.split('\n');
      loadedBugs.add(Bug(
        fileName: file.path.split('/').last,
        bugType: lines[1].substring(lines[1].indexOf(':') + 2),
        bugPriority: lines[2].substring(lines[2].indexOf(':') + 2),
        bugDescription: lines[3].substring(lines[3].indexOf(':') + 2),
        bugStatus: lines[4].substring(lines[4].indexOf(':') + 2),
        createdAt:
            DateTime.parse(lines[5].substring(lines[5].indexOf(':') + 2)),
      ));
    });

    setState(() {
      bugs = loadedBugs;
    });
  }

  Future<void> _updateBugStatus(Bug bug) async {
    final file = File('${await _localPath}/${bug.fileName}');
    if (await file.exists()) {
      String content = await file.readAsString();
      content = content.replaceFirst(
          RegExp(r'Bug Status: .*'), 'Bug Status: $newStatus');
      content = content.replaceFirst(RegExp(r'Last Updated Time: .*'),
          'Last Updated Time: ${DateTime.now()}');
      await file.writeAsString(content);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Bug Status Updated Successfully')),
      );
      Navigator.pop(context); // Close dialog after update
      loadBugs(); // Refresh bug list
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Bug File Not Found')),
      );
    }
  }

  Future<void> _showChangeStatusDialog(Bug bug) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Change Status for ${bug.fileName}',
            style: TextStyle(
              fontFamily: "Sk-Modernist",
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Container(
            constraints:
                BoxConstraints(minHeight: 200), // Adjust minHeight as needed
            padding: EdgeInsets.all(20), // Adjust padding as needed
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Bug Type: ${bug.bugType}',
                  style: TextStyle(
                    fontFamily: "Sk-Modernist",
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 12),
                Text(
                  'Bug Priority: ${bug.bugPriority}',
                  style: TextStyle(
                    fontFamily: "Sk-Modernist",
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 12),
                Text(
                  'Bug Description: ${bug.bugDescription}',
                  style: TextStyle(
                    fontFamily: "Sk-Modernist",
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 20),
                TextFormField(
                  initialValue: bug.bugStatus,
                  decoration: InputDecoration(
                    labelText: 'New Status',
                  ),
                  onChanged: (value) {
                    setState(() {
                      newStatus = value;
                    });
                  },
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog
              },
              child: Text(
                'Cancel',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Sk-Modernist",
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _updateBugStatus(bug);
                }
              },
              child: Text(
                'Update Status',
                style: TextStyle(
                  fontFamily: "Sk-Modernist",
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
          color: Colors.white,
        ),
        title: Text(
          'Change Status of Bug',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontFamily: "Sk-Modernist",
          ),
        ),
        backgroundColor: Colors.black,
      ),
      body: ListView.builder(
        itemCount: bugs.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            tileColor: const Color.fromARGB(221, 24, 24, 24),
            title: Text(
              bugs[index].bugType,
              style: TextStyle(
                  fontFamily: "Sk-Modernist",
                  fontSize: 18,
                  color: Colors.white),
            ),
            subtitle: Text(
              'Created At: ${bugs[index].createdAt}\nPriority: ${bugs[index].bugPriority}',
              style: TextStyle(
                  fontFamily: "Sk-Modernist",
                  fontSize: 15,
                  color: Color.fromARGB(255, 86, 193, 44)),
            ),
            onTap: () {
              _showChangeStatusDialog(bugs[index]);
            },
          );
        },
      ),
    );
  }
}
