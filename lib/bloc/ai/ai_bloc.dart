import 'dart:convert';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:rxdart/rxdart.dart';
import 'package:taskify/bloc/base/base_bloc.dart';
import 'package:taskify/data/models/reponse/ai_project.dart';
import '../../data/common/variables.dart';

class AiBloc extends BaseBloc {

  final _aiDescriptionSubject = BehaviorSubject<AiProject>();
  Stream<AiProject> get aiDescriptionResponse => _aiDescriptionSubject.stream;
  void generateAIDescription({
    required String description
      }) async {
    final GenerativeModel model = GenerativeModel(
      model: 'gemini-1.5-flash-latest',
      apiKey: Variables.geminiKey,
    );
    try {
      toggleProgress(true);
      final prompt = '$description \n\nUsing the description above In no more than 50 words for each task, using simple everyday english vocabulary,'
          ' Generate a project name and a list of tasks, put it in a json string "name" as the project name, "description" as a detailed description and "tasks" as a list of string using this format "{"name" : "", "description": "", "tasks" : [""]}", ensure the "tasks field always contains a list of strings and never a list of json objects."';
      final content = [Content.text(prompt)];
      await model.generateContent(content).then((response) {
        print(response.text);
        AiProject aiProject = AiProject.fromJson(jsonDecode(response.text?.replaceAll('```json', '').replaceAll('```', '') ?? ''));
        _aiDescriptionSubject.sink.add(aiProject);
        toggleProgress(false);
      }, onError: (e) {
        _aiDescriptionSubject.sink.addError(e);
        toggleProgress(false);
      });
    } catch (e) {
      toggleProgress(false);
      _aiDescriptionSubject.sink.addError('Error generating description, please try again later.');
    }
  }

}