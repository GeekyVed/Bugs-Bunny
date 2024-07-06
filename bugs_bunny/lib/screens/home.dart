import 'package:bugs_bunny/models/btn_desc.dart';
import 'package:flutter/material.dart';
import 'package:bugs_bunny/screens/create_bug.dart';
import 'package:bugs_bunny/screens/change_status.dart';
import 'package:bugs_bunny/screens/report_bug.dart';

class HomeScreen extends StatelessWidget {
  final List<ButtonDescription> buttonDescriptions = [
    ButtonDescription(
      buttonText: 'Create New',
      description: 'File a new bug report with details.',
      screen: CreateBugScreen(),
    ),
    ButtonDescription(
      buttonText: 'Change Status',
      description: 'Update the status of an existing bug.',
      screen: ChangeStatusScreen(),
    ),
    ButtonDescription(
      buttonText: 'Report Bug',
      description: 'View details of an existing bug report.',
      screen: ReportBugScreen(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.fromLTRB(8.0, 8.0, 0, 0),
          child: Text(
            'Bug Tracking System',
            style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: "Sk-Modernist"),
          ),
        ),
        backgroundColor: Colors.black,
      ),
      backgroundColor:
          Colors.black, // Set background color to black for dark theme
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(height: 25),
            Hero(
              tag: "num",
              child: Image.asset(
                'assets/logo.png',
                width: 330,
                height: 330,
              ),
            ),
            SizedBox(height: 25),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: buttonDescriptions.map((buttonDesc) {
                return _buildButtonWithDescription(context, buttonDesc);
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButtonWithDescription(
      BuildContext context, ButtonDescription buttonDesc) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.4,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  buttonDesc.description,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontFamily: "Sk-Modernist"),
                ),
              ),
            ),
            SizedBox(
              width: 16,
            ),
            VerticalDivider(
              color: Colors.white,
              thickness: 2,
            ),
            SizedBox(
              width: 16,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.4,
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => buttonDesc.screen),
                    );
                  },
                  child: Text(
                    buttonDesc.buttonText,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Sk-Modernist"),
                  ),
                ),
            
            ),
          ],
        ),
        SizedBox(
          height: 20,
        )
      ],
    );
  }
}
