import 'package:bugs_bunny/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class CreateBugScreen extends StatefulWidget {
  @override
  _CreateBugScreenState createState() => _CreateBugScreenState();
}

class _CreateBugScreenState extends State<CreateBugScreen> {
  final _formKey = GlobalKey<FormState>();
  String userName = '';
  String bugType = '';
  String bugPriority = '';
  String bugDescription = '';
  String bugStatus = '';

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> _localFile(int id) async {
    final path = await _localPath;
    return File('$path/bugfile$id.txt');
  }

  Future<void> _writeBugFile() async {
  final path = await _localPath;
  
  // Generate a unique filename using current timestamp
  String fileName = 'bugfile_${DateTime.now().millisecondsSinceEpoch}.txt';
  final file = File('$path/$fileName');

  try {
    String content = 'Bug Filed by User: $userName\n'
        'Bug Type: $bugType\n'
        'Bug Priority: $bugPriority\n'
        'Bug Description: $bugDescription\n'
        'Bug Status: $bugStatus\n'
        'Creation Time: ${DateTime.now()}';

    await file.writeAsString(content);
    
    // Optionally, you can show a success message or handle post-write actions
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Bug Created Successfully')),
    );
    Navigator.pop(context); // Example of navigation after success
  } catch (e) {
    // Handle errors, e.g., file writing error
    print('Error writing bug file: $e');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Failed to create bug. Please try again later.')),
    );
  }
}


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
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
              'Create New Bug',
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
                        fontSize: 19),
                    decoration: InputDecoration(
                      labelText: 'Your Name',
                      contentPadding: EdgeInsets.all(22),
                      labelStyle: TextStyle(
                          color: Colors.white,
                          fontFamily: "Sk-Modernist",
                          fontSize: 19),
                      filled: true,
                      fillColor: Colors.black,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: BorderSide(color: Colors.white, width: 2),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 86, 193, 44), width: 2),
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        userName = value;
                      });
                    },
                  ),
                  SizedBox(height: 45),
                  TextFormField(
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: "Sk-Modernist",
                        fontSize: 19),
                    decoration: InputDecoration(
                      labelText: 'Bug Type',
                      contentPadding: EdgeInsets.all(22),
                      labelStyle: TextStyle(
                          color: Colors.white,
                          fontFamily: "Sk-Modernist",
                          fontSize: 19),
                      filled: true,
                      fillColor: Colors.black,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: BorderSide(color: Colors.white, width: 2),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 86, 193, 44), width: 2),
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        bugType = value;
                      });
                    },
                  ),
                  SizedBox(height: 45),
                  TextFormField(
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: "Sk-Modernist",
                        fontSize: 19),
                    decoration: InputDecoration(
                      labelText: 'Bug Priority',
                      contentPadding: EdgeInsets.all(22),
                      labelStyle: TextStyle(
                          color: Colors.white,
                          fontFamily: "Sk-Modernist",
                          fontSize: 19),
                      filled: true,
                      fillColor: Colors.black,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: BorderSide(color: Colors.white, width: 2),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 86, 193, 44), width: 2),
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        bugPriority = value;
                      });
                    },
                  ),
                  SizedBox(height: 45),
                  TextFormField(
                    maxLines: null,
                     minLines: 5,
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: "Sk-Modernist",
                        fontSize: 19),
                    decoration: InputDecoration(
                      labelText: 'Bug Description',
                      contentPadding: EdgeInsets.all(22),
                      labelStyle: TextStyle(
                          color: Colors.white,
                          fontFamily: "Sk-Modernist",
                          fontSize: 19),
                      filled: true,
                      fillColor: Colors.black,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: BorderSide(color: Colors.white, width: 2),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 86, 193, 44), width: 2),
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        bugDescription = value;
                      });
                    },
                  ),
                  SizedBox(height: 45),
                  TextFormField(
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: "Sk-Modernist",
                        fontSize: 19),
                    decoration: InputDecoration(
                      labelText: 'Bug Status',
                      contentPadding: EdgeInsets.all(22),
                      labelStyle: TextStyle(
                          color: Colors.white,
                          fontFamily: "Sk-Modernist",
                          fontSize: 19),
                      filled: true,
                      fillColor: Colors.black,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: BorderSide(color: Colors.white, width: 2),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 86, 193, 44), width: 2),
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        bugStatus = value;
                      });
                    },
                  ),
                  SizedBox(height: 45),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _writeBugFile();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Bug Created Successfully')),
                        );
                        Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => HomeScreen()),
                    );
                      }
                    },
                    style: ButtonStyle(
                      fixedSize: WidgetStateProperty.all(Size(410, 60)),
                    ),
                    child: Text(
                      'Create Bug',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: "Sk-Modernist",
                      ),
                    ),
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
