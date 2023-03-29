import 'package:app/providers/providers.dart';
import 'package:app/ui/screens/data_loading.dart';
import 'package:app/ui/screens/login.dart';
import 'package:app/ui/widgets/spinner.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InitialScreen extends StatefulWidget {
  static const routeName = '/';

  const InitialScreen({Key? key}) : super(key: key);

  @override
  _InitialScreenState createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  @override
  void initState() {
    super.initState();
    _resolveAuthenticatedUser();
  }

  Future<void> _resolveAuthenticatedUser() async {
    try {
      final user = await context.read<AuthProvider>().tryGetAuthUser();
      Navigator.of(context).pushReplacement(PageRouteBuilder(
        pageBuilder: (_, __, ___) =>
            user == null ? const LoginScreen() : const DataLoadingScreen(),
        transitionDuration: Duration.zero,
      ));
    } catch (e) {
      await Navigator.of(context, rootNavigator: true).pushReplacementNamed(
        LoginScreen.routeName,
      );
    }
  }

  @override
  Widget build(BuildContext context) => const ContainerWithSpinner();
}
