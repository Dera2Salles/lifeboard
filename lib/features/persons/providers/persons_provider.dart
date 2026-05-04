import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/models/person.dart';
import '../../../data/models/profile.dart';
import '../../../data/models/relationship_score.dart';
import '../../../data/models/context_entry.dart';
import '../../../data/models/emotion_log.dart';
import '../../../data/models/interaction.dart';
import '../../../data/repositories/person_repository.dart';
import '../../../data/repositories/context_repository.dart';
import '../../../data/repositories/emotion_repository.dart';
import '../../../data/repositories/interaction_repository.dart';

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
    if (state.hasValue) {
      state = AsyncValue.data(state.value!.where((p) => p.id != id).toList());
    }
    await _repo.deletePerson(id);
  }
}

final personDetailProvider = FutureProvider.family<Person?, int>((ref, id) async {
  final repo = ref.read(personRepositoryProvider);
  return repo.getPersonById(id);
});

final personProfileProvider = AsyncNotifierProvider.family<PersonProfileNotifier, Profile?, int>(
  PersonProfileNotifier.new,
);

class PersonProfileNotifier extends FamilyAsyncNotifier<Profile?, int> {
  PersonRepository get _repo => ref.read(personRepositoryProvider);

  @override
  Future<Profile?> build(int arg) async {
    return await _repo.getProfileByPersonId(arg);
  }

  Future<void> saveProfile(Profile profile) async {
    await _repo.saveProfile(profile);
    state = AsyncData(profile);
  }
}

final personScoreProvider = AsyncNotifierProvider.family<PersonScoreNotifier, RelationshipScore, int>(
  PersonScoreNotifier.new,
);

class PersonScoreNotifier extends FamilyAsyncNotifier<RelationshipScore, int> {
  PersonRepository get _repo => ref.read(personRepositoryProvider);

  @override
  Future<RelationshipScore> build(int arg) async {
    return await _repo.getOrCreateScore(arg);
  }

  Future<void> updateScore(RelationshipScore score) async {
    await _repo.saveScore(score);
    state = AsyncData(score);
  }
}

final filteredPersonsProvider = FutureProvider.family<List<Person>, RelationType?>((ref, type) async {
  final repo = ref.read(personRepositoryProvider);
  if (type == null) return repo.getAllPersons();
  return repo.getPersonsByRelationType(type);
});

final personContextsProvider = AsyncNotifierProvider.family<PersonContextsNotifier, List<ContextEntry>, int>(
  PersonContextsNotifier.new,
);

class PersonContextsNotifier extends FamilyAsyncNotifier<List<ContextEntry>, int> {
  @override
  Future<List<ContextEntry>> build(int arg) async {
    return await ContextRepository().getContextsForPerson(arg);
  }

  Future<void> addContext(ContextEntry entry) async {
    await ContextRepository().saveContext(entry);
    ref.invalidateSelf();
  }

  Future<void> deleteContext(int id) async {
    if (state.hasValue) {
      state = AsyncValue.data(state.value!.where((c) => c.id != id).toList());
    }
    await ContextRepository().deleteContext(id);
  }
}

final personEmotionsProvider = AsyncNotifierProvider.family<PersonEmotionsNotifier, List<EmotionLog>, int>(
  PersonEmotionsNotifier.new,
);

class PersonEmotionsNotifier extends FamilyAsyncNotifier<List<EmotionLog>, int> {
  @override
  Future<List<EmotionLog>> build(int arg) async {
    return await EmotionRepository().getRecentEmotions(arg, limit: 50);
  }

  Future<void> addEmotion(EmotionLog log) async {
    await EmotionRepository().saveEmotion(log);
    ref.invalidateSelf();
  }

  Future<void> deleteEmotion(int id) async {
    if (state.hasValue) {
      state = AsyncValue.data(state.value!.where((e) => e.id != id).toList());
    }
    await EmotionRepository().deleteEmotion(id);
  }
}

final personInteractionsProvider = AsyncNotifierProvider.family<PersonInteractionsNotifier, List<Interaction>, int>(
  PersonInteractionsNotifier.new,
);

class PersonInteractionsNotifier extends FamilyAsyncNotifier<List<Interaction>, int> {
  @override
  Future<List<Interaction>> build(int arg) async {
    return await InteractionRepository().getInteractionsForPerson(arg);
  }

  Future<void> addInteraction(Interaction interaction) async {
    await InteractionRepository().saveInteraction(interaction);
    ref.invalidateSelf();
  }

  Future<void> deleteInteraction(int id) async {
    if (state.hasValue) {
      state = AsyncValue.data(state.value!.where((i) => i.id != id).toList());
    }
    await InteractionRepository().deleteInteraction(id);
  }
}
