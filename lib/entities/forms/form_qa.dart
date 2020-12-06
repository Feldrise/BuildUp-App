class FormQA {
  final String question;
  final String answer;

  FormQA.fromMap(Map<String, dynamic> map) : 
    question = map['question'] as String,
    answer = map['answer'] as String;
}