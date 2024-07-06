import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class ReportBugScreen extends StatefulWidget {
  @override
  _ReportBugScreenState createState() => _ReportBugScreenState();
}

class _ReportBugScreenState extends State<ReportBugScreen> {
  final _formKey = GlobalKey<FormState>();
  String bugFileName = '';
  String bugContent = '';
  List<String> bugFiles = [];
  Map<String, String> bugContents = {};

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<void> _loadBugFiles() async {
    final path = await _localPath;
    final directory = Directory(path);
    final files = directory.listSync();
    List<String> bugFileNames = [];
    Map<String, String> bugFileContents = {};

    for (var file in files) {
      if (file is File && file.path.endsWith('.txt')) {
        String fileName = file.path.split('/').last;
        String content = await file.readAsString();
        bugFileNames.add(fileName);
        bugFileContents[fileName] = content;
      }
    }

    setState(() {
      bugFiles = bugFileNames;
      bugContents = bugFileContents;
    });
  }

  Future<File> _localFile(String fileName) async {
    final path = await _localPath;
    return File('$path/$fileName');
  }

  Future<void> _readBugFile() async {
    final file = await _localFile(bugFileName);
    if (await file.exists()) {
      String content = await file.readAsString();
      setState(() {
        bugContent = content;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Bug File Not Found')),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _loadBugFiles();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back),
            color: Colors.white,
          ),
          title: const Padding(
            padding: EdgeInsets.fromLTRB(8.0, 8.0, 0, 0),
            child: Text(
              'Report a Bug',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: "Sk-Modernist",
              ),
            ),
          ),
          backgroundColor: Colors.black,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: "Sk-Modernist",
                      fontSize: 19,
                    ),
                    decoration: InputDecoration(
                      labelText: 'Bug File Name',
                      contentPadding: EdgeInsets.all(22),
                      labelStyle: TextStyle(
                        color: Colors.white,
                        fontFamily: "Sk-Modernist",
                        fontSize: 19,
                      ),
                      filled: true,
                      fillColor: Colors.black,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: BorderSide(color: Colors.white, width: 2),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: BorderSide(
                          color: Color.fromARGB(255, 86, 193, 44),
                          width: 2,
                        ),
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        bugFileName = value;
                      });
                    },
                  ),
                  SizedBox(height: 45),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _readBugFile();
                      }
                    },
                    style: ButtonStyle(
                      backgroundColor:
                          WidgetStateProperty.all(Color.fromARGB(255, 86, 193, 44)),
                      fixedSize: WidgetStateProperty.all(Size(410, 60)),
                    ),
                    child: Text(
                      'Report Bug',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: "Sk-Modernist",
                      ),
                    ),
                  ),
                  SizedBox(height: 45),
                  Text(
                    bugContent,
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: "Sk-Modernist",
                      fontSize: 19,
                    ),
                  ),
                  SizedBox(height: 45),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: bugFiles.length,
                    itemBuilder: (context, index) {
                      return Card(
                        color: Colors.black,
                        child: ListTile(
                          title: Text(
                            bugFiles[index],
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: "Sk-Modernist",
                              fontSize: 19,
                            ),
                          ),
                          subtitle: Text(
                            bugContents[bugFiles[index]] ?? '',
                            style: TextStyle(
                              color: Colors.white70,
                              fontFamily: "Sk-Modernist",
                              fontSize: 17,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
