import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/user.dart';
import '../../data/repositories/user_repository.dart';

final userRepositoryProvider = Provider((ref) => UserRepository());

final userProvider = FutureProvider<User>((ref) async {
  final repo = ref.watch(userRepositoryProvider);
  return await repo.getOrCreateUser();
});

class UserNotifier extends FamilyAsyncNotifier<User, void> {
  @override
  Future<User> build(void arg) async {
    return await ref.watch(userRepositoryProvider).getOrCreateUser();
  }

  Future<void> updateUser(User user) async {
    await ref.read(userRepositoryProvider).saveUser(user);
    ref.invalidateSelf();
  }
}

// Alternatively, a simpler notifier if needed
final userUpdateProvider = AsyncNotifierProvider<UserNotifierSimple, User>(() => UserNotifierSimple());

class UserNotifierSimple extends AsyncNotifier<User> {
  @override
  Future<User> build() async {
    return await ref.watch(userRepositoryProvider).getOrCreateUser();
  }

  Future<void> saveUser(User user) async {
    state = const AsyncValue.loading();
    await ref.read(userRepositoryProvider).saveUser(user);
    state = AsyncValue.data(user);
  }
}
