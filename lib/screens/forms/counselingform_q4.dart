//I. Getting to Know You: Thoughts,\nRelationships, and Well-Being

import 'package:flutter/material.dart';
import 'package:cmsystem/screens/forms/counselingform_q5.dart';

class CounselingFormQ4 extends StatefulWidget {
  const CounselingFormQ4({super.key});

  @override
  State<CounselingFormQ4> createState() => _CounselingFormQ4State();
}

class _CounselingFormQ4State extends State<CounselingFormQ4> {
  final TextEditingController _q1Controller = TextEditingController();
  final TextEditingController _q2Controller = TextEditingController();
  final TextEditingController _q3Controller = TextEditingController();
  final TextEditingController _q4Controller = TextEditingController();
  final TextEditingController _q5Controller = TextEditingController();
  final TextEditingController _q6Controller = TextEditingController();
  final TextEditingController _q7Controller = TextEditingController();

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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'I. Getting to Know You: Thoughts,\nRelationships, and Well-Being',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Color(0xFF55182C),
              ),
            ),
            const SizedBox(height: 20),
            _buildQuestion(
              'What do you think of yourself? How do you describe yourself?',
              _q1Controller,
            ),
            _buildQuestion(
              'What are the most important things to you?',
              _q2Controller,
            ),
            _buildQuestion(
              'Tell me about your friends. What are the things you like or dislike doing with them?',
              _q3Controller,
            ),
            _buildQuestion(
              'What do you like or dislike about your class? Describe your participation in class activities.',
              _q4Controller,
            ),
            _buildQuestion(
              'Tell me about your family. How is your relationship with each member of the family? Who do you like or dislike among them? Why?',
              _q5Controller,
            ),
            _buildQuestion(
              'To whom do you feel comfortable sharing your problems? Why?',
              _q6Controller,
            ),
            _buildQuestion(
              'Is there anything I haven’t asked that you like to tell me?',
              _q7Controller,
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const CounselingFormQ5()),
                  );
                },
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

  Widget _buildQuestion(String question, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(question),
          const SizedBox(height: 5),
          TextField(
            controller: controller,
            maxLines: 3,
            decoration: InputDecoration(
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              contentPadding: const EdgeInsets.all(12),
            ),
          ),
        ],
      ),
    );
  }
}
