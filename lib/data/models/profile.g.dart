// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetProfileCollection on Isar {
  IsarCollection<Profile> get profiles => this.collection();
}

const ProfileSchema = CollectionSchema(
  name: r'Profile',
  id: 1266279811925214857,
  properties: {
    r'desires': PropertySchema(
      id: 0,
      name: r'desires',
      type: IsarType.stringList,
    ),
    r'dislikes': PropertySchema(
      id: 1,
      name: r'dislikes',
      type: IsarType.stringList,
    ),
    r'dreams': PropertySchema(
      id: 2,
      name: r'dreams',
      type: IsarType.stringList,
    ),
    r'fears': PropertySchema(
      id: 3,
      name: r'fears',
      type: IsarType.stringList,
    ),
    r'loveLanguage': PropertySchema(
      id: 4,
      name: r'loveLanguage',
      type: IsarType.string,
    ),
    r'loves': PropertySchema(
      id: 5,
      name: r'loves',
      type: IsarType.stringList,
    ),
    r'notes': PropertySchema(
      id: 6,
      name: r'notes',
      type: IsarType.string,
    ),
    r'personId': PropertySchema(
      id: 7,
      name: r'personId',
      type: IsarType.long,
    ),
    r'personalityType': PropertySchema(
      id: 8,
      name: r'personalityType',
      type: IsarType.string,
    ),
    r'updatedAt': PropertySchema(
      id: 9,
      name: r'updatedAt',
      type: IsarType.dateTime,
    ),
    r'values': PropertySchema(
      id: 10,
      name: r'values',
      type: IsarType.stringList,
    )
  },
  estimateSize: _profileEstimateSize,
  serialize: _profileSerialize,
  deserialize: _profileDeserialize,
  deserializeProp: _profileDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _profileGetId,
  getLinks: _profileGetLinks,
  attach: _profileAttach,
  version: '3.1.0+1',
);

int _profileEstimateSize(
  Profile object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.desires.length * 3;
  {
    for (var i = 0; i < object.desires.length; i++) {
      final value = object.desires[i];
      bytesCount += value.length * 3;
    }
  }
  bytesCount += 3 + object.dislikes.length * 3;
  {
    for (var i = 0; i < object.dislikes.length; i++) {
      final value = object.dislikes[i];
      bytesCount += value.length * 3;
    }
  }
  bytesCount += 3 + object.dreams.length * 3;
  {
    for (var i = 0; i < object.dreams.length; i++) {
      final value = object.dreams[i];
      bytesCount += value.length * 3;
    }
  }
  bytesCount += 3 + object.fears.length * 3;
  {
    for (var i = 0; i < object.fears.length; i++) {
      final value = object.fears[i];
      bytesCount += value.length * 3;
    }
  }
  {
    final value = object.loveLanguage;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.loves.length * 3;
  {
    for (var i = 0; i < object.loves.length; i++) {
      final value = object.loves[i];
      bytesCount += value.length * 3;
    }
  }
  {
    final value = object.notes;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.personalityType;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.values.length * 3;
  {
    for (var i = 0; i < object.values.length; i++) {
      final value = object.values[i];
      bytesCount += value.length * 3;
    }
  }
  return bytesCount;
}

void _profileSerialize(
  Profile object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeStringList(offsets[0], object.desires);
  writer.writeStringList(offsets[1], object.dislikes);
  writer.writeStringList(offsets[2], object.dreams);
  writer.writeStringList(offsets[3], object.fears);
  writer.writeString(offsets[4], object.loveLanguage);
  writer.writeStringList(offsets[5], object.loves);
  writer.writeString(offsets[6], object.notes);
  writer.writeLong(offsets[7], object.personId);
  writer.writeString(offsets[8], object.personalityType);
  writer.writeDateTime(offsets[9], object.updatedAt);
  writer.writeStringList(offsets[10], object.values);
}

Profile _profileDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Profile();
  object.desires = reader.readStringList(offsets[0]) ?? [];
  object.dislikes = reader.readStringList(offsets[1]) ?? [];
  object.dreams = reader.readStringList(offsets[2]) ?? [];
  object.fears = reader.readStringList(offsets[3]) ?? [];
  object.id = id;
  object.loveLanguage = reader.readStringOrNull(offsets[4]);
  object.loves = reader.readStringList(offsets[5]) ?? [];
  object.notes = reader.readStringOrNull(offsets[6]);
  object.personId = reader.readLong(offsets[7]);
  object.personalityType = reader.readStringOrNull(offsets[8]);
  object.updatedAt = reader.readDateTime(offsets[9]);
  object.values = reader.readStringList(offsets[10]) ?? [];
  return object;
}

P _profileDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringList(offset) ?? []) as P;
    case 1:
      return (reader.readStringList(offset) ?? []) as P;
    case 2:
      return (reader.readStringList(offset) ?? []) as P;
    case 3:
      return (reader.readStringList(offset) ?? []) as P;
    case 4:
      return (reader.readStringOrNull(offset)) as P;
    case 5:
      return (reader.readStringList(offset) ?? []) as P;
    case 6:
      return (reader.readStringOrNull(offset)) as P;
    case 7:
      return (reader.readLong(offset)) as P;
    case 8:
      return (reader.readStringOrNull(offset)) as P;
    case 9:
      return (reader.readDateTime(offset)) as P;
    case 10:
      return (reader.readStringList(offset) ?? []) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _profileGetId(Profile object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _profileGetLinks(Profile object) {
  return [];
}

void _profileAttach(IsarCollection<dynamic> col, Id id, Profile object) {
  object.id = id;
}

extension ProfileQueryWhereSort on QueryBuilder<Profile, Profile, QWhere> {
  QueryBuilder<Profile, Profile, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension ProfileQueryWhere on QueryBuilder<Profile, Profile, QWhereClause> {
  QueryBuilder<Profile, Profile, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<Profile, Profile, QAfterWhereClause> idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<Profile, Profile, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<Profile, Profile, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<Profile, Profile, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension ProfileQueryFilter
    on QueryBuilder<Profile, Profile, QFilterCondition> {
  QueryBuilder<Profile, Profile, QAfterFilterCondition> desiresElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'desires',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Profile, Profile, QAfterFilterCondition>
      desiresElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'desires',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Profile, Profile, QAfterFilterCondition> desiresElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'desires',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Profile, Profile, QAfterFilterCondition> desiresElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'desires',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Profile, Profile, QAfterFilterCondition>
      desiresElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'desires',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Profile, Profile, QAfterFilterCondition> desiresElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'desires',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Profile, Profile, QAfterFilterCondition> desiresElementContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'desires',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Profile, Profile, QAfterFilterCondition> desiresElementMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'desires',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Profile, Profile, QAfterFilterCondition>
      desiresElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'desires',
        value: '',
      ));
    });
  }

  QueryBuilder<Profile, Profile, QAfterFilterCondition>
      desiresElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'desires',
        value: '',
      ));
    });
  }

  QueryBuilder<Profile, Profile, QAfterFilterCondition> desiresLengthEqualTo(
      int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'desires',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<Profile, Profile, QAfterFilterCondition> desiresIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'desires',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<Profile, Profile, QAfterFilterCondition> desiresIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'desires',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Profile, Profile, QAfterFilterCondition> desiresLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'desires',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<Profile, Profile, QAfterFilterCondition>
      desiresLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'desires',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Profile, Profile, QAfterFilterCondition> desiresLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'desires',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<Profile, Profile, QAfterFilterCondition> dislikesElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dislikes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Profile, Profile, QAfterFilterCondition>
      dislikesElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'dislikes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Profile, Profile, QAfterFilterCondition> dislikesElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'dislikes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Profile, Profile, QAfterFilterCondition> dislikesElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'dislikes',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Profile, Profile, QAfterFilterCondition>
      dislikesElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'dislikes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Profile, Profile, QAfterFilterCondition> dislikesElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'dislikes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Profile, Profile, QAfterFilterCondition> dislikesElementContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'dislikes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Profile, Profile, QAfterFilterCondition> dislikesElementMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'dislikes',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Profile, Profile, QAfterFilterCondition>
      dislikesElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dislikes',
        value: '',
      ));
    });
  }

  QueryBuilder<Profile, Profile, QAfterFilterCondition>
      dislikesElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'dislikes',
        value: '',
      ));
    });
  }

  QueryBuilder<Profile, Profile, QAfterFilterCondition> dislikesLengthEqualTo(
      int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'dislikes',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<Profile, Profile, QAfterFilterCondition> dislikesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'dislikes',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<Profile, Profile, QAfterFilterCondition> dislikesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'dislikes',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Profile, Profile, QAfterFilterCondition> dislikesLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'dislikes',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<Profile, Profile, QAfterFilterCondition>
      dislikesLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'dislikes',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Profile, Profile, QAfterFilterCondition> dislikesLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'dislikes',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<Profile, Profile, QAfterFilterCondition> dreamsElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dreams',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Profile, Profile, QAfterFilterCondition>
      dreamsElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'dreams',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Profile, Profile, QAfterFilterCondition> dreamsElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'dreams',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Profile, Profile, QAfterFilterCondition> dreamsElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'dreams',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Profile, Profile, QAfterFilterCondition> dreamsElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'dreams',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Profile, Profile, QAfterFilterCondition> dreamsElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'dreams',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Profile, Profile, QAfterFilterCondition> dreamsElementContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'dreams',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Profile, Profile, QAfterFilterCondition> dreamsElementMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'dreams',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Profile, Profile, QAfterFilterCondition> dreamsElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dreams',
        value: '',
      ));
    });
  }

  QueryBuilder<Profile, Profile, QAfterFilterCondition>
      dreamsElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'dreams',
        value: '',
      ));
    });
  }

  QueryBuilder<Profile, Profile, QAfterFilterCondition> dreamsLengthEqualTo(
      int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'dreams',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<Profile, Profile, QAfterFilterCondition> dreamsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'dreams',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<Profile, Profile, QAfterFilterCondition> dreamsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'dreams',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Profile, Profile, QAfterFilterCondition> dreamsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'dreams',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<Profile, Profile, QAfterFilterCondition> dreamsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'dreams',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Profile, Profile, QAfterFilterCondition> dreamsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'dreams',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<Profile, Profile, QAfterFilterCondition> fearsElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fears',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Profile, Profile, QAfterFilterCondition> fearsElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'fears',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Profile, Profile, QAfterFilterCondition> fearsElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'fears',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Profile, Profile, QAfterFilterCondition> fearsElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'fears',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Profile, Profile, QAfterFilterCondition> fearsElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'fears',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Profile, Profile, QAfterFilterCondition> fearsElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'fears',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Profile, Profile, QAfterFilterCondition> fearsElementContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'fears',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Profile, Profile, QAfterFilterCondition> fearsElementMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'fears',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Profile, Profile, QAfterFilterCondition> fearsElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fears',
        value: '',
      ));
    });
  }

  QueryBuilder<Profile, Profile, QAfterFilterCondition>
      fearsElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'fears',
        value: '',
      ));
    });
  }

  QueryBuilder<Profile, Profile, QAfterFilterCondition> fearsLengthEqualTo(
      int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'fears',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<Profile, Profile, QAfterFilterCondition> fearsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'fears',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<Profile, Profile, QAfterFilterCondition> fearsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'fears',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Profile, Profile, QAfterFilterCondition> fearsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'fears',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<Profile, Profile, QAfterFilterCondition> fearsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'fears',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Profile, Profile, QAfterFilterCondition> fearsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'fears',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<Profile, Profile, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Profile, Profile, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Profile, Profile, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Profile, Profile, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Profile, Profile, QAfterFilterCondition> loveLanguageIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'loveLanguage',
      ));
    });
  }

  QueryBuilder<Profile, Profile, QAfterFilterCondition>
      loveLanguageIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'loveLanguage',
      ));
    });
  }

  QueryBuilder<Profile, Profile, QAfterFilterCondition> loveLanguageEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'loveLanguage',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Profile, Profile, QAfterFilterCondition> loveLanguageGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'loveLanguage',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Profile, Profile, QAfterFilterCondition> loveLanguageLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'loveLanguage',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Profile, Profile, QAfterFilterCondition> loveLanguageBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'loveLanguage',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Profile, Profile, QAfterFilterCondition> loveLanguageStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'loveLanguage',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Profile, Profile, QAfterFilterCondition> loveLanguageEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'loveLanguage',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Profile, Profile, QAfterFilterCondition> loveLanguageContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'loveLanguage',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Profile, Profile, QAfterFilterCondition> loveLanguageMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'loveLanguage',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Profile, Profile, QAfterFilterCondition> loveLanguageIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'loveLanguage',
        value: '',
      ));
    });
  }

  QueryBuilder<Profile, Profile, QAfterFilterCondition>
      loveLanguageIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'loveLanguage',
        value: '',
      ));
    });
  }

  QueryBuilder<Profile, Profile, QAfterFilterCondition> lovesElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'loves',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Profile, Profile, QAfterFilterCondition> lovesElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'loves',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Profile, Profile, QAfterFilterCondition> lovesElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'loves',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Profile, Profile, QAfterFilterCondition> lovesElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'loves',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Profile, Profile, QAfterFilterCondition> lovesElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'loves',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Profile, Profile, QAfterFilterCondition> lovesElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'loves',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Profile, Profile, QAfterFilterCondition> lovesElementContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'loves',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Profile, Profile, QAfterFilterCondition> lovesElementMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'loves',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Profile, Profile, QAfterFilterCondition> lovesElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'loves',
        value: '',
      ));
    });
  }

  QueryBuilder<Profile, Profile, QAfterFilterCondition>
      lovesElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'loves',
        value: '',
      ));
    });
  }

  QueryBuilder<Profile, Profile, QAfterFilterCondition> lovesLengthEqualTo(
      int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'loves',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<Profile, Profile, QAfterFilterCondition> lovesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'loves',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<Profile, Profile, QAfterFilterCondition> lovesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'loves',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Profile, Profile, QAfterFilterCondition> lovesLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'loves',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<Profile, Profile, QAfterFilterCondition> lovesLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'loves',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Profile, Profile, QAfterFilterCondition> lovesLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'loves',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<Profile, Profile, QAfterFilterCondition> notesIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'notes',
      ));
    });
  }

  QueryBuilder<Profile, Profile, QAfterFilterCondition> notesIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'notes',
      ));
    });
  }

  QueryBuilder<Profile, Profile, QAfterFilterCondition> notesEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'notes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Profile, Profile, QAfterFilterCondition> notesGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'notes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Profile, Profile, QAfterFilterCondition> notesLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'notes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Profile, Profile, QAfterFilterCondition> notesBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'notes',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Profile, Profile, QAfterFilterCondition> notesStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'notes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Profile, Profile, QAfterFilterCondition> notesEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'notes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Profile, Profile, QAfterFilterCondition> notesContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'notes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Profile, Profile, QAfterFilterCondition> notesMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'notes',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Profile, Profile, QAfterFilterCondition> notesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'notes',
        value: '',
      ));
    });
  }

  QueryBuilder<Profile, Profile, QAfterFilterCondition> notesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'notes',
        value: '',
      ));
    });
  }

  QueryBuilder<Profile, Profile, QAfterFilterCondition> personIdEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'personId',
        value: value,
      ));
    });
  }

  QueryBuilder<Profile, Profile, QAfterFilterCondition> personIdGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'personId',
        value: value,
      ));
    });
  }

  QueryBuilder<Profile, Profile, QAfterFilterCondition> personIdLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'personId',
        value: value,
      ));
    });
  }

  QueryBuilder<Profile, Profile, QAfterFilterCondition> personIdBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'personId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Profile, Profile, QAfterFilterCondition>
      personalityTypeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'personalityType',
      ));
    });
  }

  QueryBuilder<Profile, Profile, QAfterFilterCondition>
      personalityTypeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'personalityType',
      ));
    });
  }

  QueryBuilder<Profile, Profile, QAfterFilterCondition> personalityTypeEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'personalityType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Profile, Profile, QAfterFilterCondition>
      personalityTypeGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'personalityType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Profile, Profile, QAfterFilterCondition> personalityTypeLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'personalityType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Profile, Profile, QAfterFilterCondition> personalityTypeBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'personalityType',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Profile, Profile, QAfterFilterCondition>
      personalityTypeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'personalityType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Profile, Profile, QAfterFilterCondition> personalityTypeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'personalityType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Profile, Profile, QAfterFilterCondition> personalityTypeContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'personalityType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Profile, Profile, QAfterFilterCondition> personalityTypeMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'personalityType',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Profile, Profile, QAfterFilterCondition>
      personalityTypeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'personalityType',
        value: '',
      ));
    });
  }

  QueryBuilder<Profile, Profile, QAfterFilterCondition>
      personalityTypeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'personalityType',
        value: '',
      ));
    });
  }

  QueryBuilder<Profile, Profile, QAfterFilterCondition> updatedAtEqualTo(
      DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<Profile, Profile, QAfterFilterCondition> updatedAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<Profile, Profile, QAfterFilterCondition> updatedAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<Profile, Profile, QAfterFilterCondition> updatedAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'updatedAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Profile, Profile, QAfterFilterCondition> valuesElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'values',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Profile, Profile, QAfterFilterCondition>
      valuesElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'values',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Profile, Profile, QAfterFilterCondition> valuesElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'values',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Profile, Profile, QAfterFilterCondition> valuesElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'values',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Profile, Profile, QAfterFilterCondition> valuesElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'values',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Profile, Profile, QAfterFilterCondition> valuesElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'values',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Profile, Profile, QAfterFilterCondition> valuesElementContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'values',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Profile, Profile, QAfterFilterCondition> valuesElementMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'values',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Profile, Profile, QAfterFilterCondition> valuesElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'values',
        value: '',
      ));
    });
  }

  QueryBuilder<Profile, Profile, QAfterFilterCondition>
      valuesElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'values',
        value: '',
      ));
    });
  }

  QueryBuilder<Profile, Profile, QAfterFilterCondition> valuesLengthEqualTo(
      int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'values',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<Profile, Profile, QAfterFilterCondition> valuesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'values',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<Profile, Profile, QAfterFilterCondition> valuesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'values',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Profile, Profile, QAfterFilterCondition> valuesLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'values',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<Profile, Profile, QAfterFilterCondition> valuesLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'values',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Profile, Profile, QAfterFilterCondition> valuesLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'values',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }
}

extension ProfileQueryObject
    on QueryBuilder<Profile, Profile, QFilterCondition> {}

extension ProfileQueryLinks
    on QueryBuilder<Profile, Profile, QFilterCondition> {}

extension ProfileQuerySortBy on QueryBuilder<Profile, Profile, QSortBy> {
  QueryBuilder<Profile, Profile, QAfterSortBy> sortByLoveLanguage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'loveLanguage', Sort.asc);
    });
  }

  QueryBuilder<Profile, Profile, QAfterSortBy> sortByLoveLanguageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'loveLanguage', Sort.desc);
    });
  }

  QueryBuilder<Profile, Profile, QAfterSortBy> sortByNotes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notes', Sort.asc);
    });
  }

  QueryBuilder<Profile, Profile, QAfterSortBy> sortByNotesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notes', Sort.desc);
    });
  }

  QueryBuilder<Profile, Profile, QAfterSortBy> sortByPersonId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'personId', Sort.asc);
    });
  }

  QueryBuilder<Profile, Profile, QAfterSortBy> sortByPersonIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'personId', Sort.desc);
    });
  }

  QueryBuilder<Profile, Profile, QAfterSortBy> sortByPersonalityType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'personalityType', Sort.asc);
    });
  }

  QueryBuilder<Profile, Profile, QAfterSortBy> sortByPersonalityTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'personalityType', Sort.desc);
    });
  }

  QueryBuilder<Profile, Profile, QAfterSortBy> sortByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<Profile, Profile, QAfterSortBy> sortByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }
}

extension ProfileQuerySortThenBy
    on QueryBuilder<Profile, Profile, QSortThenBy> {
  QueryBuilder<Profile, Profile, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Profile, Profile, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<Profile, Profile, QAfterSortBy> thenByLoveLanguage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'loveLanguage', Sort.asc);
    });
  }

  QueryBuilder<Profile, Profile, QAfterSortBy> thenByLoveLanguageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'loveLanguage', Sort.desc);
    });
  }

  QueryBuilder<Profile, Profile, QAfterSortBy> thenByNotes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notes', Sort.asc);
    });
  }

  QueryBuilder<Profile, Profile, QAfterSortBy> thenByNotesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notes', Sort.desc);
    });
  }

  QueryBuilder<Profile, Profile, QAfterSortBy> thenByPersonId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'personId', Sort.asc);
    });
  }

  QueryBuilder<Profile, Profile, QAfterSortBy> thenByPersonIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'personId', Sort.desc);
    });
  }

  QueryBuilder<Profile, Profile, QAfterSortBy> thenByPersonalityType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'personalityType', Sort.asc);
    });
  }

  QueryBuilder<Profile, Profile, QAfterSortBy> thenByPersonalityTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'personalityType', Sort.desc);
    });
  }

  QueryBuilder<Profile, Profile, QAfterSortBy> thenByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<Profile, Profile, QAfterSortBy> thenByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }
}

extension ProfileQueryWhereDistinct
    on QueryBuilder<Profile, Profile, QDistinct> {
  QueryBuilder<Profile, Profile, QDistinct> distinctByDesires() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'desires');
    });
  }

  QueryBuilder<Profile, Profile, QDistinct> distinctByDislikes() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'dislikes');
    });
  }

  QueryBuilder<Profile, Profile, QDistinct> distinctByDreams() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'dreams');
    });
  }

  QueryBuilder<Profile, Profile, QDistinct> distinctByFears() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'fears');
    });
  }

  QueryBuilder<Profile, Profile, QDistinct> distinctByLoveLanguage(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'loveLanguage', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Profile, Profile, QDistinct> distinctByLoves() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'loves');
    });
  }

  QueryBuilder<Profile, Profile, QDistinct> distinctByNotes(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'notes', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Profile, Profile, QDistinct> distinctByPersonId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'personId');
    });
  }

  QueryBuilder<Profile, Profile, QDistinct> distinctByPersonalityType(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'personalityType',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Profile, Profile, QDistinct> distinctByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'updatedAt');
    });
  }

  QueryBuilder<Profile, Profile, QDistinct> distinctByValues() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'values');
    });
  }
}

extension ProfileQueryProperty
    on QueryBuilder<Profile, Profile, QQueryProperty> {
  QueryBuilder<Profile, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Profile, List<String>, QQueryOperations> desiresProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'desires');
    });
  }

  QueryBuilder<Profile, List<String>, QQueryOperations> dislikesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'dislikes');
    });
  }

  QueryBuilder<Profile, List<String>, QQueryOperations> dreamsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'dreams');
    });
  }

  QueryBuilder<Profile, List<String>, QQueryOperations> fearsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'fears');
    });
  }

  QueryBuilder<Profile, String?, QQueryOperations> loveLanguageProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'loveLanguage');
    });
  }

  QueryBuilder<Profile, List<String>, QQueryOperations> lovesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'loves');
    });
  }

  QueryBuilder<Profile, String?, QQueryOperations> notesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'notes');
    });
  }

  QueryBuilder<Profile, int, QQueryOperations> personIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'personId');
    });
  }

  QueryBuilder<Profile, String?, QQueryOperations> personalityTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'personalityType');
    });
  }

  QueryBuilder<Profile, DateTime, QQueryOperations> updatedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'updatedAt');
    });
  }

  QueryBuilder<Profile, List<String>, QQueryOperations> valuesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'values');
    });
  }
}
