//V. Academics

import 'package:flutter/material.dart';
import 'package:cmsystem/screens/forms/counselingform_q9.dart'; // Ensure this path is correct
import 'package:cloud_firestore/cloud_firestore.dart';

class CounselingFormQ7 extends StatefulWidget {
  const CounselingFormQ7({super.key});

  @override
  State<CounselingFormQ7> createState() => _CounselingFormQ7State();
}

class _CounselingFormQ7State extends State<CounselingFormQ7> {
  // V. Academics Checkbox states
  bool academicPerformance = false;
  bool homesickness = false;
  bool teacherIssue = false;
  bool notInterested = false;
  bool notHappy = false;
  bool lateInClass = false;
  bool lessonDifficulty = false;

  final TextEditingController courseField = TextEditingController();

  // VI. Family Checkbox states
  bool parentsSeparated = false;
  bool hardTimeWithParents = false;
  bool familyArguments = false;
  bool financialConcerns = false;
  bool genderPreference = false;
  bool familyIllness = false;

  final TextEditingController familySpecifyField = TextEditingController();
  final List<bool> familyViolence = [
    false,
    false,
    false,
    false
  ]; // Physical, Emotional, Psychological, Verbal

  @override
  void dispose() {
    // Dispose controllers
    courseField.dispose();
    familySpecifyField.dispose();
    super.dispose();
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // V. Academics Section
            const Text("V. Academics",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF6B0D1D))),
            const SizedBox(height: 10),
            const Text(
              "Instruction: Check only the box of the statement/s you consider your concern for the past four (4) weeks.",
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 20),
            CheckboxListTile(
              value: academicPerformance,
              onChanged: (val) => setState(() => academicPerformance = val!),
              title: const Text(
                  "I am overly worried about my academic performance."),
              controlAffinity: ListTileControlAffinity.leading,
            ),
            const SizedBox(height: 10),
            const Text("I am not motivated to study because of"),
            CheckboxListTile(
              value: homesickness,
              onChanged: (val) => setState(() => homesickness = val!),
              title: const Text("Homesickness"),
              controlAffinity: ListTileControlAffinity.leading,
            ),
            CheckboxListTile(
              value: teacherIssue,
              onChanged: (val) => setState(() => teacherIssue = val!),
              title: const Text("An issue with a teacher"),
              controlAffinity: ListTileControlAffinity.leading,
            ),
            CheckboxListTile(
              value: notInterested,
              onChanged: (val) => setState(() => notInterested = val!),
              title: const Text("Not being prepared/interested in school"),
              controlAffinity: ListTileControlAffinity.leading,
            ),
            CheckboxListTile(
              value: notHappy,
              onChanged: (val) => setState(() => notHappy = val!),
              title: const Text(
                  "Not being happy/interested in the course/school I am currently enrolling in"),
              controlAffinity: ListTileControlAffinity.leading,
            ),
            const SizedBox(height: 10),
            TextField(
              controller: courseField,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "(Others, please specify)",
              ),
            ),
            const SizedBox(height: 10),
            CheckboxListTile(
              value: lateInClass,
              onChanged: (val) => setState(() => lateInClass = val!),
              title: const Text("I have a problem being on time in class."),
              controlAffinity: ListTileControlAffinity.leading,
            ),
            CheckboxListTile(
              value: lessonDifficulty,
              onChanged: (val) => setState(() => lessonDifficulty = val!),
              title: const Text(
                  "I have difficulty understanding the class lesson/s."),
              controlAffinity: ListTileControlAffinity.leading,
            ),
            const SizedBox(height: 30),

            // VI. Family Section
            const Text("VI. Family",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF6B0D1D))),
            const SizedBox(height: 10),
            const Text(
              "Instruction: Check only the box of the statement/s you consider your concern for the past four (4) weeks.",
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 20),
            CheckboxListTile(
              value: parentsSeparated,
              onChanged: (val) => setState(() => parentsSeparated = val!),
              title:
                  const Text("I cannot accept that my parents are separated."),
              controlAffinity: ListTileControlAffinity.leading,
            ),
            CheckboxListTile(
              value: hardTimeWithParents,
              onChanged: (val) => setState(() => hardTimeWithParents = val!),
              title: const Text(
                  "I have a hard time dealing with my parents/guardian's expectations and demands."),
              controlAffinity: ListTileControlAffinity.leading,
            ),
            CheckboxListTile(
              value: familyArguments,
              onChanged: (val) => setState(() => familyArguments = val!),
              title: const Text(
                  "I have experienced frequent argument/s with family member/s or relatives."),
              controlAffinity: ListTileControlAffinity.leading,
            ),
            CheckboxListTile(
              value: financialConcerns,
              onChanged: (val) => setState(() => financialConcerns = val!),
              title: const Text("Our family is having financial concerns."),
              controlAffinity: ListTileControlAffinity.leading,
            ),
            CheckboxListTile(
              value: genderPreference,
              onChanged: (val) => setState(() => genderPreference = val!),
              title: const Text(
                  "I have a hard time telling my family about my gender preference (e.g., Gay/Lesbian/LGBTQ)."),
              controlAffinity: ListTileControlAffinity.leading,
            ),
            CheckboxListTile(
              value: familyIllness,
              onChanged: (val) => setState(() => familyIllness = val!),
              title: const Text(
                  "I am worried/troubled by a family member's illness."),
              controlAffinity: ListTileControlAffinity.leading,
            ),
            const SizedBox(height: 10),
            TextField(
              controller: familySpecifyField,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText:
                    "I have difficulty opening up to family member/s. (Please specify)",
              ),
            ),
            const SizedBox(height: 10),
            const Text(
                "I have experienced frequent violence with family member/s:"),
            Row(
              children: [
                Checkbox(
                  value: familyViolence[0],
                  onChanged: (val) => setState(() => familyViolence[0] = val!),
                ),
                const Text("Physical"),
                Checkbox(
                  value: familyViolence[1],
                  onChanged: (val) => setState(() => familyViolence[1] = val!),
                ),
                const Text("Emotional"),
                Checkbox(
                  value: familyViolence[2],
                  onChanged: (val) => setState(() => familyViolence[2] = val!),
                ),
                const Text("Psychological"),
                Checkbox(
                  value: familyViolence[3],
                  onChanged: (val) => setState(() => familyViolence[3] = val!),
                ),
                const Text("Verbal"),
              ],
            ),
            const SizedBox(height: 30),

            // Next Button
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  try {
                    // Collect form data
                    final formData = {
                      'academicPerformance': academicPerformance,
                      'homesickness': homesickness,
                      'teacherIssue': teacherIssue,
                      'notInterested': notInterested,
                      'notHappy': notHappy,
                      'lateInClass': lateInClass,
                      'lessonDifficulty': lessonDifficulty,
                      'courseField': courseField.text,
                      'parentsSeparated': parentsSeparated,
                      'hardTimeWithParents': hardTimeWithParents,
                      'familyArguments': familyArguments,
                      'financialConcerns': financialConcerns,
                      'genderPreference': genderPreference,
                      'familyIllness': familyIllness,
                      'familySpecifyField': familySpecifyField.text,
                      'familyViolence': familyViolence,
                      'timestamp': FieldValue.serverTimestamp(), // Add a timestamp
                    };

                    // Save to Firestore
                    await FirebaseFirestore.instance
                        .collection('counseling_forms') // Firestore collection name
                        .add(formData);

                    // Show success message
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Form submitted successfully!')),
                    );

                    // Navigate to the next screen
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => const CounselingFormQ9()),
                    );
                  } catch (e) {
                    // Handle errors
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Error: $e')),
                    );
                  }
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
}
