import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:simple_key/src/core/widget/menu_widget.dart';
import 'package:simple_key/src/feautures/auth/data/controller/provider/provider.dart';

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        leading: const MenuWidget(),
      ),
    );
  }
}

class Notifications extends StatelessWidget {
  const Notifications({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        leading: const MenuWidget(),
      ),
    );
  }
}

class LogOut extends StatefulHookConsumerWidget {
  const LogOut({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LogOutState();
}

class _LogOutState extends ConsumerState<LogOut> {
  Future<void> signOut() async {
    ref.read(authNotifierProvider.notifier).signOut();
    final authRepo = ref.watch(authNotifierProvider);
    // !authRepo.isLoading;
  }

  // @override
  // void initState() {
  //   signOut();

  //   super.initState();
  // }
  @override
  void didChangeDependencies() {
    signOut();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
