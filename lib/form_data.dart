class FormData {
  // Q1 to Q9 data fields
  String? name;
  String? studentId;
  String? modeOfCounseling;
  String? timeSlot;
  String? concernPersonal;
  List<String> personalIssues = [];
  List<String> interpersonalIssues = [];
  String? discriminationReason;
  String? griefPerson;
  String? griefExperience;
  List<String> academicIssues = [];
  String? academicOtherReason;
  List<String> familyIssues = [];
  String? familyOpenUpReason;

  // Add other fields as needed from q1 to q9

  FormData();
}
