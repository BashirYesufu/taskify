import 'package:rxdart/rxdart.dart';
import 'package:taskify/data/models/reponse/user.dart';
import 'package:taskify/util/persistor/data_persistor.dart';
import '../base/base_bloc.dart';

class AuthBloc extends BaseBloc {

  final _loginSubject = PublishSubject<User>();
  Stream<User> get loginResponse => _loginSubject.stream;
  void login({required String? email, required String? password}) async {
    if(email == null || email.isEmpty){
      _loginSubject.sink.addError('Kindly enter a valid email address');
      return;
    }
    if (password == null || password.isEmpty){
      _loginSubject.sink.addError('Kindly enter a valid password');
      return;
    }
    try {
      toggleProgress(true);
      await Future.delayed(Duration(milliseconds: 3500)).then((response) {
        User user = User(id: '', email: email, password: password);
        _loginSubject.sink.add(user);
        DataPersistor.saveUser(user);
        toggleProgress(false);
      }, onError: (e) {
        _loginSubject.sink.addError(e);
        toggleProgress(false);
      });
    } catch (e) {
      _loginSubject.sink.addError(e);
    }
  }

  final _registerSubject = PublishSubject<User>();
  Stream<User> get registerResponse => _registerSubject.stream;
  void register({required String? email, required String? password, required String? passwordConfirmation, required bool isValidPassword}) async {
    if(email == null || email.isEmpty){
      _registerSubject.sink.addError('Kindly enter a valid email address');
      return;
    }
    if (password == null || password.isEmpty || !isValidPassword){
      _registerSubject.sink.addError('Kindly enter a valid password');
      return;
    }
    if (password != passwordConfirmation){
      _registerSubject.sink.addError('Kindly enter matching passwords');
      return;
    }
    try {
      toggleProgress(true);
      await Future.delayed(Duration(milliseconds: 3500)).then((response) {
        User user = User(id: '', email: email, password: password);
        _registerSubject.sink.add(user);
        DataPersistor.saveUser(user);
        toggleProgress(false);
      }, onError: (e) {
        _registerSubject.sink.addError(e);
        toggleProgress(false);
      });
    } catch (e) {
      _registerSubject.sink.addError(e);
    }
  }

}