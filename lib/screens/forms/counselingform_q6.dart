//III. Interpersonal

import 'package:flutter/material.dart';
import 'package:cmsystem/screens/forms/counselingform_q7.dart';

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

  @override
  void dispose() {
    // Dispose controllers
    discriminationController.dispose();
    grievingDeathOfController.dispose();
    griefExperienceController.dispose();
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

            // Next Button
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const CounselingFormQ7()),
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
          ],
        ),
      ),
    );
  }
}
