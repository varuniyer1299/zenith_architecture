import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zenith_architecture/injection_container.dart';
import 'package:zenith_architecture/presentation/bloc/user_bloc.dart';
import 'package:zenith_architecture/presentation/bloc/user_event.dart';
import 'package:zenith_architecture/presentation/pages/user_profile_view.dart';

class UserProfilePage extends StatelessWidget {
  const UserProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<UserBloc>()..add(const GetUserProfileEvent('1')),
      child: const UserProfileView(),
    );
  }
}