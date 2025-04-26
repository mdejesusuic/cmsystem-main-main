//I. Getting to Know You: Thoughts,\nRelationships, and Well-Being

import 'package:flutter/material.dart';
import 'package:cmsystem/screens/forms/counselingform_q6.dart';

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

  // Variables from Q5
  bool confident = false;
  bool time = false;
  bool stress = false;
  bool emotion = false;
  bool decision = false;
  bool sleeping = false;
  bool mood = false;
  bool worry = false;
  bool engagement = false;
  bool selfHarm = false;
  bool suicide = false;

  TextEditingController usageController = TextEditingController();
  TextEditingController disorderController = TextEditingController();
  TextEditingController drugController = TextEditingController();

  bool abusePhysical = false;
  bool abuseEmotional = false;
  bool abuseVerbal = false;
  bool abusePsychological = false;
  bool abuseSexual = false;

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
            const Text("II. Personal",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF601C4F))),
            const SizedBox(height: 10),
            const Text(
              "Instruction: Check only the box of the statement/s you consider your concern for the past four (4) weeks.",
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 20),
            CheckboxListTile(
              value: confident,
              onChanged: (val) => setState(() => confident = val!),
              title: const Text("I do not feel confident about myself."),
              controlAffinity: ListTileControlAffinity.leading,
            ),
            const Text("I struggle to manage my:"),
            Row(
              children: [
                Expanded(
                  child: CheckboxListTile(
                    value: time,
                    onChanged: (val) => setState(() => time = val!),
                    title: const Text("Time"),
                    controlAffinity: ListTileControlAffinity.leading,
                  ),
                ),
                Expanded(
                  child: CheckboxListTile(
                    value: stress,
                    onChanged: (val) => setState(() => stress = val!),
                    title: const Text("Stress"),
                    controlAffinity: ListTileControlAffinity.leading,
                  ),
                ),
                Expanded(
                  child: CheckboxListTile(
                    value: emotion,
                    onChanged: (val) => setState(() => emotion = val!),
                    title: const Text("Emotion"),
                    controlAffinity: ListTileControlAffinity.leading,
                  ),
                ),
              ],
            ),
            CheckboxListTile(
              value: decision,
              onChanged: (val) => setState(() => decision = val!),
              title: const Text("I have a hard time making decisions."),
              controlAffinity: ListTileControlAffinity.leading,
            ),
            CheckboxListTile(
              value: sleeping,
              onChanged: (val) => setState(() => sleeping = val!),
              title: const Text("I have a problem with sleeping."),
              controlAffinity: ListTileControlAffinity.leading,
            ),
            CheckboxListTile(
              value: mood,
              onChanged: (val) => setState(() => mood = val!),
              title: const Text("I have noticed that my mood is not stable."),
              controlAffinity: ListTileControlAffinity.leading,
            ),
            CheckboxListTile(
              value: worry,
              onChanged: (val) => setState(() => worry = val!),
              title: const Text("I easily get worried or overthink."),
              controlAffinity: ListTileControlAffinity.leading,
            ),
            CheckboxListTile(
              value: engagement,
              onChanged: (val) => setState(() => engagement = val!),
              title: const Text("I have too much engagement."),
              controlAffinity: ListTileControlAffinity.leading,
            ),
            const Text("I cannot stop myself from using or doing:"),
            TextField(
              controller: usageController,
              maxLines: 4,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
            CheckboxListTile(
              value: selfHarm,
              onChanged: (val) => setState(() => selfHarm = val!),
              title: const Text("I am committing to self-harming activities."),
              controlAffinity: ListTileControlAffinity.leading,
            ),
            CheckboxListTile(
              value: suicide,
              onChanged: (val) => setState(() => suicide = val!),
              title: const Text("I think about committing suicide."),
              controlAffinity: ListTileControlAffinity.leading,
            ),
            const Text("I am diagnosed with a mental/behavioral disorder"),
            TextField(
              controller: disorderController,
              maxLines: 4,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 4),
              child: Text("(Please specify)", style: TextStyle(fontSize: 12)),
            ),
            const SizedBox(height: 10),
            const SizedBox(height: 10),
            const Text("My drug prescription is / are:"),
            TextField(
              controller: drugController,
              maxLines: 4,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            const Text("I have experienced abuse"),
            Wrap(
              spacing: 10,
              children: [
                FilterChip(
                  label: const Text("Physical"),
                  selected: abusePhysical,
                  onSelected: (val) => setState(() => abusePhysical = val),
                ),
                FilterChip(
                  label: const Text("Emotional"),
                  selected: abuseEmotional,
                  onSelected: (val) => setState(() => abuseEmotional = val),
                ),
                FilterChip(
                  label: const Text("Verbal"),
                  selected: abuseVerbal,
                  onSelected: (val) => setState(() => abuseVerbal = val),
                ),
                FilterChip(
                  label: const Text("Psychological"),
                  selected: abusePsychological,
                  onSelected: (val) => setState(() => abusePsychological = val),
                ),
                FilterChip(
                  label: const Text("Sexual"),
                  selected: abuseSexual,
                  onSelected: (val) => setState(() => abuseSexual = val),
                ),
              ],
            ),
            const SizedBox(height: 30),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const CounselingFormQ6()),
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
