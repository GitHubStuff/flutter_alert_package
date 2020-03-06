import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_alert_package/flutter_alert_package.dart' as Alert;
import 'package:flutter_theme_package/flutter_theme_package.dart';
import 'package:flutter_tracers/trace.dart' as Log;

void main() => runApp(AlertDriverApp());

class AlertDriverApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ModeTheme(
      data: (brightness) => (brightness == Brightness.light) ? ModeThemeData.bright() : ModeThemeData.dark(),
      defaultBrightness: Brightness.light,
      themedWidgetBuilder: (context, theme) {
        return MaterialApp(
          home: AlertDriver(),
          initialRoute: '/',
          routes: {
            AlertDriver.route: (context) => AlertDriverApp(),
          },
          theme: theme,
          title: 'AlertDriverApp Demo',
        );
      },
    );
  }
}

///-------------------------------------------------------------------------------------
class AlertDriver extends StatefulWidget {
  const AlertDriver({Key key}) : super(key: key);
  static const route = '/alertDriver';

  @override
  _AlertDriver createState() => _AlertDriver();
}

///-------------------------------------------------------------------------------------
class _AlertDriver extends State<AlertDriver> with WidgetsBindingObserver, AfterLayoutMixin<AlertDriver> {
  bool hideSpinner = true;

  // ignore: non_constant_identifier_names
  Size get ScreenSize => MediaQuery.of(context).size;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    Log.t('alertDriver initState()');
  }

  @override
  void afterFirstLayout(BuildContext context) {
    Log.t('alertDriver afterFirstLayout()');
  }

  @override
  didChangeDependencies() {
    super.didChangeDependencies();
    Log.t('alertDriver didChangeDependencies()');
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    Log.t('alertDriver didChangeAppLifecycleState ${state.toString()}');
  }

  @override
  void didChangePlatformBrightness() {
    final Brightness brightness = WidgetsBinding.instance.window.platformBrightness;
    ModeTheme.of(context).setBrightness(brightness);
    Log.t('alertDriver didChangePlatformBrightness ${brightness.toString()}');
  }

  @override
  Widget build(BuildContext context) {
    Log.t('alertDriver build()');
    return HudScaffold.progressText(
      context,
      hide: hideSpinner,
      indicatorColors: Swatch(bright: Colors.purpleAccent, dark: Colors.greenAccent),
      progressText: 'AlertDriver Showable spinner',
      scaffold: Scaffold(
        appBar: AppBar(
          title: Text('Title: alertDriver'),
        ),
        body: body(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              hideSpinner = false;
              Future.delayed(Duration(seconds: 3), () {
                setState(() {
                  hideSpinner = true;
                });
              });
            });
          },
          tooltip: 'Increment',
          child: Icon(Icons.add),
        ),
      ),
    );
  }

  @override
  void didUpdateWidget(Widget oldWidget) {
    Log.t('alertDriver didUpdateWidget()');
    super.didUpdateWidget(oldWidget);
  }

  @override
  void deactivate() {
    Log.t('alertDriver deactivate()');
    super.deactivate();
  }

  @override
  void dispose() {
    Log.t('alertDriver dispose()');
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  /// Scaffold body
  Widget body() {
    Log.t('alertDriver body()');
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('AlertDriver Template', style: Theme.of(context).textTheme.display1),
          RaisedButton(
            child: Text('Toggle Mode'),
            onPressed: () {
              ModeTheme.of(context).toggleBrightness();
            },
          ),
          RaisedButton(
            child: Text('Next Screen'),
            onPressed: () {
              Alert.showAlert(
                title: 'Title',
                content: 'Content',
                buildContext: context,
                alertCallback: () {
                  Log.t('Callback');
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
