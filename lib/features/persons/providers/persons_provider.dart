import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/models/person.dart';
import '../../../data/models/profile.dart';
import '../../../data/models/relationship_score.dart';
import '../../../data/repositories/person_repository.dart';

final personRepositoryProvider = Provider<PersonRepository>((ref) {
  return PersonRepository();
});

final personsProvider = AsyncNotifierProvider<PersonsNotifier, List<Person>>(
  PersonsNotifier.new,
);

class PersonsNotifier extends AsyncNotifier<List<Person>> {
  PersonRepository get _repo => ref.read(personRepositoryProvider);

  @override
  Future<List<Person>> build() async {
    return await _repo.getAllPersons();
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _repo.getAllPersons());
  }

  Future<int> addPerson(Person person) async {
    final id = await _repo.savePerson(person);
    await refresh();
    return id;
  }

  Future<void> updatePerson(Person person) async {
    await _repo.savePerson(person);
    await refresh();
  }

  Future<void> deletePerson(int id) async {
    await _repo.deletePerson(id);
    await refresh();
  }
}

final personDetailProvider = FutureProvider.family<Person?, int>((ref, id) async {
  final repo = ref.read(personRepositoryProvider);
  return repo.getPersonById(id);
});

final personProfileProvider = FutureProvider.family<Profile?, int>((ref, personId) async {
  final repo = ref.read(personRepositoryProvider);
  return repo.getProfileByPersonId(personId);
});

final personScoreProvider = FutureProvider.family<RelationshipScore, int>((ref, personId) async {
  final repo = ref.read(personRepositoryProvider);
  return repo.getOrCreateScore(personId);
});

final filteredPersonsProvider = FutureProvider.family<List<Person>, RelationType?>((ref, type) async {
  final repo = ref.read(personRepositoryProvider);
  if (type == null) return repo.getAllPersons();
  return repo.getPersonsByRelationType(type);
});
