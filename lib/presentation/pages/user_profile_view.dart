import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart'; // Add this package
import '../../domain/entities/user_entity.dart';
import '../bloc/user_bloc.dart';
import '../bloc/user_event.dart';
import '../bloc/user_state.dart';

class UserProfileView extends StatelessWidget {
  const UserProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Zenith User Profile'),
        actions: [
          // Visual indicator for offline status
          BlocBuilder<UserBloc, UserState>(
            builder: (context, state) {
              if (state is UserLoaded && !state.user.isOfflineSynced) {
                return const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(Icons.cloud_off, color: Colors.orange),
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          context.read<UserBloc>().add(const GetUserProfileEvent('1'));
        },
        child: BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            final isLoading = state is UserLoading;
            
            // If error, show a custom error widget with a retry button
            if (state is UserError) {
              return SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.8,
                  child: Center(child: Text(state.message, style: const TextStyle(color: Colors.red))),
                ),
              );
            }

            // Use Skeletonizer for a modern loading experience
            return Skeletonizer(
              enabled: isLoading,
              child: _buildProfileData(
                context, 
                state is UserLoaded ? state.user : UserEntity.placeholder(),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildProfileData(BuildContext context, UserEntity user) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        CircleAvatar(
          radius: 50,
          backgroundImage: user.profilePictureUrl != null 
              ? NetworkImage(user.profilePictureUrl!) 
              : null,
          child: user.profilePictureUrl == null ? const Icon(Icons.person, size: 50) : null,
        ),
        const SizedBox(height: 20),
        ListTile(
          title: Text(user.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
          subtitle: Text(user.email),
          leading: const Icon(Icons.badge),
        ),
        const Divider(),
        const SizedBox(height: 40),
        ElevatedButton.icon(
          onPressed: user.id == 0 ? null : () { 
            context.read<UserBloc>().add(SyncUserDataEvent(user));
          },
          icon: const Icon(Icons.sync),
          label: const Text('Sync with Server'),
          style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 50)),
        ),
      ],
    );
  }
}