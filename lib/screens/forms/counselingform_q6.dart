//III. Interpersonal

import 'package:flutter/material.dart';
import 'package:cmsystem/screens/forms/counselingform_q9.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CounselingFormQ6 extends StatefulWidget {
  const CounselingFormQ6({super.key});

  @override
  State<CounselingFormQ6> createState() => _CounselingFormQ6State();
}

class _CounselingFormQ6State extends State<CounselingFormQ6> {
  // III. Interpersonal Checkbox states
  bool isBullied = false;
  bool cannotHandlePressure = false;
  bool difficultyGettingAlong = false;
  bool cannotExpressFeelings = false;

  // III. Interpersonal Text controllers
  final TextEditingController discriminationController =
      TextEditingController();

  // IV. Grief/Bereavement Text controllers
  final TextEditingController grievingDeathOfController =
      TextEditingController();
  final TextEditingController griefExperienceController =
      TextEditingController();

  // Add state variables for all checkboxes and text fields
  bool familyGenderPreference = false;
  bool familyMemberIllness = false;
  bool physicalViolence = false;
  bool emotionalViolence = false;
  bool psychologicalViolence = false;
  bool verbalViolence = false;

  final TextEditingController familyOpeningUpController = TextEditingController();

  @override
  void dispose() {
    // Dispose controllers
    discriminationController.dispose();
    grievingDeathOfController.dispose();
    griefExperienceController.dispose();
    familyOpeningUpController.dispose();
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
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // III. Interpersonal Section
            const Text(
              'III. Interpersonal',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF6B0F1A),
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "Instruction: Check only the box of the statement/s you consider your concern for the past four (4) weeks.",
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 20),
            CheckboxListTile(
              title: const Text("I am being bullied."),
              value: isBullied,
              onChanged: (bool? value) {
                setState(() {
                  isBullied = value ?? false;
                });
              },
            ),
            CheckboxListTile(
              title: const Text("I cannot handle peer pressure."),
              value: cannotHandlePressure,
              onChanged: (bool? value) {
                setState(() {
                  cannotHandlePressure = value ?? false;
                });
              },
            ),
            CheckboxListTile(
              title: const Text("I have difficulty getting along with others."),
              value: difficultyGettingAlong,
              onChanged: (bool? value) {
                setState(() {
                  difficultyGettingAlong = value ?? false;
                });
              },
            ),
            CheckboxListTile(
              title: const Text(
                  "I can't express my feelings and thoughts to others."),
              value: cannotExpressFeelings,
              onChanged: (bool? value) {
                setState(() {
                  cannotExpressFeelings = value ?? false;
                });
              },
            ),
            const SizedBox(height: 10),
            const Text("I feel like others discriminate against me because of"),
            const SizedBox(height: 8),
            TextField(
              controller: discriminationController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: '',
              ),
            ),
            const SizedBox(height: 30),

            // IV. Grief/Bereavement Section
            const Text(
              'IV. Grief/Bereavement',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF6B0D1D),
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Instruction: Check only the box of the statement/s you consider your concern for the past four (4) weeks.',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 24),
            const Text('I am grieving the death of my'),
            const SizedBox(height: 8),
            TextField(
              controller: grievingDeathOfController,
              decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              ),
            ),
            const SizedBox(height: 16),
            const Text('Because of the grief/bereavement, I am experiencing'),
            const SizedBox(height: 8),
            TextField(
              controller: griefExperienceController,
              decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              ),
            ),
            const SizedBox(height: 30),

            // V. Academics Section
            const Text(
              'V. Academics',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF6B0F1A),
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "Instruction: Check only the box of the statement/s you consider your concern for the past four (4) weeks.",
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 20),
            CheckboxListTile(
              title: const Text("I am overly worried about my academic performance."),
              value: false, // Replace with a state variable if needed
              onChanged: (bool? value) {
                // Handle state change
              },
            ),
            const Text("I am not motivated to study because of"),
            CheckboxListTile(
              title: const Text("Homesickness"),
              value: false, // Replace with a state variable if needed
              onChanged: (bool? value) {
                // Handle state change
              },
            ),
            CheckboxListTile(
              title: const Text("An issue with a teacher"),
              value: false, // Replace with a state variable if needed
              onChanged: (bool? value) {
                // Handle state change
              },
            ),
            CheckboxListTile(
              title: const Text("Not being prepared/interested in school"),
              value: false, // Replace with a state variable if needed
              onChanged: (bool? value) {
                // Handle state change
              },
            ),
            CheckboxListTile(
              title: const Text("Not being happy/interested in the course/school I am currently enrolling in"),
              value: false, // Replace with a state variable if needed
              onChanged: (bool? value) {
                // Handle state change
              },
            ),
            const SizedBox(height: 8),
            TextField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: '(Others, please specify)',
              ),
            ),
            const SizedBox(height: 20),
            CheckboxListTile(
              title: const Text("I have a problem being on time in class."),
              value: false, // Replace with a state variable if needed
              onChanged: (bool? value) {
                // Handle state change
              },
            ),
            CheckboxListTile(
              title: const Text("I have difficulty understanding the class lesson/s."),
              value: false, // Replace with a state variable if needed
              onChanged: (bool? value) {
                // Handle state change
              },
            ),
            const SizedBox(height: 30),

            // VI. Family Section
            const Text(
              'VI. Family',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF6B0F1A),
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "Instruction: Check only the box of the statement/s you consider your concern for the past four (4) weeks.",
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 20),
            CheckboxListTile(
              title: const Text("I cannot accept that my parents are separated."),
              value: false, // Replace with a state variable if needed
              onChanged: (bool? value) {
                // Handle state change
              },
            ),
            CheckboxListTile(
              title: const Text("I have a hard time dealing with my parents/guardian's expectations and demands."),
              value: false, // Replace with a state variable if needed
              onChanged: (bool? value) {
                // Handle state change
              },
            ),
            CheckboxListTile(
              title: const Text("I have experienced frequent argument/s with family member/s or relatives."),
              value: false, // Replace with a state variable if needed
              onChanged: (bool? value) {
                // Handle state change
              },
            ),
            CheckboxListTile(
              title: const Text("Our family is having financial concerns."),
              value: false, // Replace with a state variable if needed
              onChanged: (bool? value) {
                // Handle state change
              },
            ),
            const SizedBox(height: 30),

            // Additional Family Concerns Section
            CheckboxListTile(
              title: const Text(
                  "I have a hard time telling my family about my gender preference (e.g., Gay/Lesbian/LGBTQ)."),
              value: familyGenderPreference,
              onChanged: (bool? value) {
                setState(() {
                  familyGenderPreference = value ?? false;
                });
              },
            ),
            CheckboxListTile(
              title: const Text(
                  "I am worried/troubled by a family member's illness."),
              value: familyMemberIllness,
              onChanged: (bool? value) {
                setState(() {
                  familyMemberIllness = value ?? false;
                });
              },
            ),
            const SizedBox(height: 8),
            const Text(
                "I have difficulty opening up to family member/s. (Please specify)"),
            const SizedBox(height: 8),
            TextField(
              controller: familyOpeningUpController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: '',
              ),
            ),
            const SizedBox(height: 16),
            const Text("I have experienced frequent violence with family member/s:"),
            Row(
              children: [
                Expanded(
                  child: CheckboxListTile(
                    title: const Text("Physical"),
                    value: physicalViolence,
                    onChanged: (bool? value) {
                      setState(() {
                        physicalViolence = value ?? false;
                      });
                    },
                  ),
                ),
                Expanded(
                  child: CheckboxListTile(
                    title: const Text("Emotional"),
                    value: emotionalViolence,
                    onChanged: (bool? value) {
                      setState(() {
                        emotionalViolence = value ?? false;
                      });
                    },
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: CheckboxListTile(
                    title: const Text("Psychological"),
                    value: psychologicalViolence,
                    onChanged: (bool? value) {
                      setState(() {
                        psychologicalViolence = value ?? false;
                      });
                    },
                  ),
                ),
                Expanded(
                  child: CheckboxListTile(
                    title: const Text("Verbal"),
                    value: verbalViolence,
                    onChanged: (bool? value) {
                      setState(() {
                        verbalViolence = value ?? false;
                      });
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),

            // Submit Button
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  // Collect data from the form
                  final data = {
                    // III. Interpersonal
                    'isBullied': isBullied,
                    'cannotHandlePressure': cannotHandlePressure,
                    'difficultyGettingAlong': difficultyGettingAlong,
                    'cannotExpressFeelings': cannotExpressFeelings,
                    'discriminationReason': discriminationController.text,

                    // IV. Grief/Bereavement
                    'grievingDeathOf': grievingDeathOfController.text,
                    'griefExperience': griefExperienceController.text,

                    // V. Academics
                    'overlyWorriedAboutPerformance': false, // Add state variable if needed
                    'homesickness': false, // Add state variable if needed
                    'issueWithTeacher': false, // Add state variable if needed
                    'notPreparedOrInterested': false, // Add state variable if needed
                    'notHappyWithCourse': false, // Add state variable if needed
                    'academicOthers': '', // Add TextEditingController if needed
                    'problemBeingOnTime': false, // Add state variable if needed
                    'difficultyUnderstandingLessons': false, // Add state variable if needed

                    // VI. Family
                    'cannotAcceptParentsSeparation': false, // Add state variable if needed
                    'hardTimeWithParentsExpectations': false, // Add state variable if needed
                    'frequentArgumentsWithFamily': false, // Add state variable if needed
                    'familyFinancialConcerns': false, // Add state variable if needed
                    'familyGenderPreference': familyGenderPreference,
                    'familyMemberIllness': familyMemberIllness,
                    'difficultyOpeningUpToFamily': familyOpeningUpController.text,
                    'physicalViolence': physicalViolence,
                    'emotionalViolence': emotionalViolence,
                    'psychologicalViolence': psychologicalViolence,
                    'verbalViolence': verbalViolence,
                  };

                  try {
                    // Save data to Firestore
                    await FirebaseFirestore.instance.collection('counseling_forms').add(data);

                    // Navigate to CounselingFormQ9
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const CounselingFormQ9()),
                    );
                  } catch (e) {
                    // Handle Firestore errors
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Error saving data: $e'),
                        backgroundColor: Colors.red,
                      ),
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
