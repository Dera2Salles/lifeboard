import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/user.dart';
import '../../data/repositories/user_repository.dart';

final userRepositoryProvider = Provider((ref) => UserRepository());

/// The single source of truth for the User profile.
/// Watching this provider will trigger a rebuild whenever the user is saved.
final userProvider = AsyncNotifierProvider<UserNotifier, User>(UserNotifier.new);

class UserNotifier extends AsyncNotifier<User> {
  @override
  Future<User> build() async {
    final repo = ref.watch(userRepositoryProvider);
    return await repo.getOrCreateUser();
  }

  Future<void> saveUser(User user) async {
    // We update the local state immediately for a responsive UI
    state = AsyncData(user);
    // Then we persist to Isar
    await ref.read(userRepositoryProvider).saveUser(user);
    // Invalidate is not strictly needed if we updated state, 
    // but ensures consistency with potential DB side-effects.
    ref.invalidateSelf();
  }
}

// Keep a reference to the update provider for compatibility with existing code,
// but point it to the same logic.
final userUpdateProvider = userProvider;
