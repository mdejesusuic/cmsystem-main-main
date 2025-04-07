//Select mode of counseling

import 'package:flutter/material.dart';
import 'package:cmsystem/screens/forms/counselingform_q4.dart';
import 'package:cmsystem/screens/forms/counselingform_q10.dart';

class CounselingFormQ3 extends StatefulWidget {
  const CounselingFormQ3({super.key});

  @override
  State<CounselingFormQ3> createState() => _CounselingFormQ3State();
}

class _CounselingFormQ3State extends State<CounselingFormQ3> {
  String selectedMode = '';

  void _navigateToNext() {
    if (selectedMode.isNotEmpty) {
      Widget nextScreen = selectedMode == 'Referral'
          ? CounselingFormQ10()
          : const CounselingFormQ4();

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => nextScreen),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a mode of counseling.')),
      );
    }
  }

  Widget _buildModeButton(String title, String description) {
    bool isSelected = selectedMode == title;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedMode = title;
        });
      },
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(vertical: 10),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(
              color: isSelected ? Colors.pink.shade700 : Colors.grey),
          borderRadius: BorderRadius.circular(12),
          color: isSelected ? Colors.pink.shade50 : Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: isSelected ? Colors.pink.shade700 : Colors.black,
              ),
            ),
            const SizedBox(height: 4),
            Text(description,
                style: const TextStyle(fontSize: 13, color: Colors.grey)),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Initial/Routine Interview',
            style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.pink.shade100,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Select mode of counseling',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            const SizedBox(height: 20),

            // Mode Options
            _buildModeButton('Walk-in',
                'Students take the initiative to go to the counseling office directly.'),
            _buildModeButton('Referral',
                'Faculty members refer students who they believe need counseling by completing and sending a referral form to the counseling office.'),
            _buildModeButton('Online',
                'A student chooses to have a counseling session conducted online rather than in person.'),

            const Spacer(),

            // Next Button
            Center(
              child: ElevatedButton(
                onPressed: _navigateToNext,
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 80, vertical: 16),
                  backgroundColor: Colors.pink.shade700,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  'Next',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
