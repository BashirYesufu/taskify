import 'package:rxdart/rxdart.dart';

class DashboardBloc {

  static final DashboardBloc sharedInstance = DashboardBloc();

  final _dashboardNavSubject = PublishSubject<int>();
  Stream<int> get dashboardNavResponse => _dashboardNavSubject.stream;
  void navigateToTab(int index) {
    _dashboardNavSubject.sink.add(index);
  }

}