import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:rxdart/rxdart.dart';
import 'package:taskify/bloc/base/base_bloc.dart';
import '../../data/common/variables.dart';

class AiBloc extends BaseBloc {

  final _aiDescriptionSubject = BehaviorSubject<String>();
  Stream<String> get aiDescriptionResponse => _aiDescriptionSubject.stream;
  void generateAIDescription({
    required String description
      }) async {
    final GenerativeModel model = GenerativeModel(
      model: 'gemini-1.5-flash-latest',
      apiKey: Variables.geminiKey,
    );
    try {
      toggleProgress(true);
      final prompt = '$description \n\nUsing the description above In no more than 30 words for each task, using simple everyday english vocabulary,'
          ' Generate a project name and a list of tasks, put it in a string and separate them with a "|". '
          'Ensure the project name you have generated always comes first';
      final content = [Content.text(prompt)];
      await model.generateContent(content).then((response) {
        _aiDescriptionSubject.sink.add(response.text ??'');
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