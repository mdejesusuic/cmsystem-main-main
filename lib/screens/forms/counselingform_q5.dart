//II. Personal

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:open_file/open_file.dart';
import 'package:cmsystem/screens/forms/counselingform_q6.dart';

class CounselingFormQ5 extends StatefulWidget {
  const CounselingFormQ5({super.key});

  @override
  State<CounselingFormQ5> createState() => _CounselingFormQ5State();
}

class _CounselingFormQ5State extends State<CounselingFormQ5> {
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

  String? selectedFileName;

  Future<void> _pickAndOpenFile() async {
    final result = await FilePicker.platform.pickFiles();

    if (result != null && result.files.single.path != null) {
      final path = result.files.single.path!;
      setState(() {
        selectedFileName = result.files.single.name;
      });
      await OpenFile.open(path);
    }
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
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
              child: Text("(Please specify and attach a Medical Certificate)",
                  style: TextStyle(fontSize: 12)),
            ),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: _pickAndOpenFile,
              icon: const Icon(Icons.attach_file),
              label: const Text("Attach a file"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.pink.shade100,
                foregroundColor: Colors.black,
              ),
            ),
            if (selectedFileName != null) ...[
              const SizedBox(height: 8),
              Text("Selected File: $selectedFileName"),
            ],
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
}
