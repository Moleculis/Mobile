import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:moleculis/widgets/flexible_scrollbar.dart';

class ErrorScreen extends StatelessWidget {
  final FlutterErrorDetails details;
  final bool showStacktrace;

  final ScrollController stackTraceController = ScrollController();

  ErrorScreen({Key key, this.details, this.showStacktrace})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String title = 'app_error'.tr();

    String description = 'app_error_recovered'.tr();
    if (showStacktrace) {
      description += ' ${'details_below'.tr()}.';
    }

    return Scaffold(
      body: Container(
        margin: EdgeInsets.all(20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.announcement,
                color: Colors.red,
                size: 40,
              ),
              Text(
                title,
                style: TextStyle(color: Colors.black, fontSize: 25),
                textAlign: TextAlign.center,
              ),
              Padding(
                padding: EdgeInsets.only(top: 10),
              ),
              Text(
                description,
                textAlign: TextAlign.center,
              ),
              Padding(
                padding: EdgeInsets.only(top: 10),
              ),
              _getStackTraceWidget()
            ],
          ),
        ),
      ),
    );
  }

  Widget _getStackTraceWidget() {
    if (showStacktrace) {
      final List<String> stackTrace = details.stack.toString().split('\n');
      return SizedBox(
        height: 200.0,
        child: FlexibleScrollbar(
          key: GlobalKey(),
          controller: stackTraceController,
          child: ListView.builder(
            controller: stackTraceController,
            padding: EdgeInsets.all(8.0),
            itemCount: stackTrace.length,
            itemBuilder: (BuildContext context, int index) {
              final String line = stackTrace[index];
              if (line?.isNotEmpty == true) {
                return Text(line);
              } else {
                return SizedBox();
              }
            },
          ),
        ),
      );
    } else {
      return Container();
    }
  }
}
