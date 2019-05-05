import 'package:events/views/Loading.dart';
import 'package:flutter/widgets.dart';
import 'package:rxdart/rxdart.dart';

abstract class StreamWidget<T> extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: stream(),
        builder: (context, AsyncSnapshot<T> snapshot) {
          debugPrint("snapshot :: $snapshot");
          if (snapshot.hasData) {
            return showData(snapshot);
          } else if (snapshot.hasError) {
            return showError(snapshot.error);
          } else {
            return showLoading();
          }
        });
  }

  Widget showData(AsyncSnapshot<T> snapshot);

  Widget showError(Object error) {
    return Text(error.toString());
  }

  Observable<T> stream();

  Widget showLoading() {
    return Loading();
  }
}
