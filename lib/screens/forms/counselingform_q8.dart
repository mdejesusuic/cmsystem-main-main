//Preview & Submit

import 'package:cmsystem/screens/forms/counselingform_q9.dart';
import 'package:flutter/material.dart';

class CounselingFormQ8 extends StatelessWidget {
  const CounselingFormQ8({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink.shade100,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Preview & Submit',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Please review your answers before submitting:',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 20),

            // Preview sections
            _buildPreviewSection(
                'Q1: Mode of Counseling', 'Walk-in / Referral / Online'),
            _buildPreviewSection(
                'Q2: Personal Information', 'Full Name, Age, Gender, etc.'),
            _buildPreviewSection(
                'Q3: Personal Concerns', 'Checked items + text field inputs'),
            _buildPreviewSection('Q4: Interpersonal Issues',
                'Checked items + text field inputs'),
            _buildPreviewSection(
                'Q5: Grief/Bereavement', 'Text field responses'),
            _buildPreviewSection(
                'Q6: Academics', 'Checked items + others text'),
            _buildPreviewSection(
                'Q7: Family Concerns', 'Checkbox selections + text inputs'),
            _buildPreviewSection('Q8: Other Issues', 'Summary of responses'),
            _buildPreviewSection('Q9: Gender & Identity',
                'Checked options + additional concerns'),

            const SizedBox(height: 30),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const CounselingFormQ9()));
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
                  'Submit',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPreviewSection(String title, String content) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.pink[50],
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 5,
            offset: const Offset(0, 3),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
              color: Color(0xFF7B1F3A),
            ),
          ),
          const SizedBox(height: 5),
          Text(
            content,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}
