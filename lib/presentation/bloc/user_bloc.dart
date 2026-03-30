import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zenith_architecture/domain/usecases/sync_user_data.dart';
import 'user_event.dart';
import 'user_state.dart';
import '../../domain/usecases/get_user_profile.dart';
import '../../core/error/failures.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final GetUserProfile getUserProfile;
  final SyncUserData syncUserData;

  UserBloc({required this.getUserProfile, required this.syncUserData,}) : super(UserInitial()) {
    on<GetUserProfileEvent>(_onGetUserProfile);
    on<SyncUserDataEvent>(_onSyncUserData);
    on<RefreshUserProfileEvent>(_onRefreshUserProfile);
  }

  void _onGetUserProfile(GetUserProfileEvent event, Emitter<UserState> emit) async {
      emit(UserLoading());

      final result = await getUserProfile(UserParams(id: event.id));

      result.fold(
        (failure) => emit(UserError(message: _mapFailureToMessage(failure))),
        (user) => emit(UserLoaded(user: user)),
      );
  }

  void _onRefreshUserProfile(RefreshUserProfileEvent event, Emitter<UserState> emit) async {
  emit(UserLoading()); // Trigger the Shimmer
  final result = await getUserProfile(UserParams(id: event.id));
  
  result.fold(
    (failure) => emit(UserError(message: _mapFailureToMessage(failure))),
    (user) => emit(UserLoaded(user: user)),
  );
}

  Future<void> _onSyncUserData(
    SyncUserDataEvent event, 
    Emitter<UserState> emit
  ) async {
    // Optionally emit a "Syncing" state if the UI needs to show a spinner
    final result = await syncUserData(event.user);

   await result.fold(
      (failure) async=> emit(UserError(message: 'Sync failed: ${_mapFailureToMessage(failure)}')),
      (syncedUser) async{
        add(GetUserProfileEvent(event.user.id.toString()));
      },
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure) {
      case ServerFailure _:
        return 'Server Error: Please try again later.';
      case CacheFailure _:
        return 'Cache Error: No local data found.';
      default:
        return 'Unexpected Error';
    }
  }
}