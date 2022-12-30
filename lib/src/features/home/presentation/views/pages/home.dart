import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kyahaal/src/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:kyahaal/src/features/authentication/presentation/bloc/auth_event.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            onPressed: () {
              context.read<AuthenticationBloc>().add(Logout());
            },
            icon: const Icon(Icons.logout_sharp),
          )
        ],
      ),
      body: Container(),
    );
  }
}
