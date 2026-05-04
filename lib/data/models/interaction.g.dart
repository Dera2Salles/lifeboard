// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'interaction.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetInteractionCollection on Isar {
  IsarCollection<Interaction> get interactions => this.collection();
}

const InteractionSchema = CollectionSchema(
  name: r'Interaction',
  id: -715376358968750141,
  properties: {
    r'createdAt': PropertySchema(
      id: 0,
      name: r'createdAt',
      type: IsarType.dateTime,
    ),
    r'date': PropertySchema(
      id: 1,
      name: r'date',
      type: IsarType.dateTime,
    ),
    r'lessonsLearned': PropertySchema(
      id: 2,
      name: r'lessonsLearned',
      type: IsarType.string,
    ),
    r'moodAfter': PropertySchema(
      id: 3,
      name: r'moodAfter',
      type: IsarType.string,
    ),
    r'moodBefore': PropertySchema(
      id: 4,
      name: r'moodBefore',
      type: IsarType.string,
    ),
    r'personId': PropertySchema(
      id: 5,
      name: r'personId',
      type: IsarType.long,
    ),
    r'qualityScore': PropertySchema(
      id: 6,
      name: r'qualityScore',
      type: IsarType.long,
    ),
    r'summary': PropertySchema(
      id: 7,
      name: r'summary',
      type: IsarType.string,
    ),
    r'type': PropertySchema(
      id: 8,
      name: r'type',
      type: IsarType.string,
    )
  },
  estimateSize: _interactionEstimateSize,
  serialize: _interactionSerialize,
  deserialize: _interactionDeserialize,
  deserializeProp: _interactionDeserializeProp,
  idName: r'id',
  indexes: {
    r'qualityScore': IndexSchema(
      id: -8219204903251386876,
      name: r'qualityScore',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'qualityScore',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _interactionGetId,
  getLinks: _interactionGetLinks,
  attach: _interactionAttach,
  version: '3.1.0+1',
);

int _interactionEstimateSize(
  Interaction object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.lessonsLearned;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.moodAfter;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.moodBefore;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.summary.length * 3;
  bytesCount += 3 + object.type.length * 3;
  return bytesCount;
}

void _interactionSerialize(
  Interaction object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDateTime(offsets[0], object.createdAt);
  writer.writeDateTime(offsets[1], object.date);
  writer.writeString(offsets[2], object.lessonsLearned);
  writer.writeString(offsets[3], object.moodAfter);
  writer.writeString(offsets[4], object.moodBefore);
  writer.writeLong(offsets[5], object.personId);
  writer.writeLong(offsets[6], object.qualityScore);
  writer.writeString(offsets[7], object.summary);
  writer.writeString(offsets[8], object.type);
}

Interaction _interactionDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Interaction();
  object.createdAt = reader.readDateTime(offsets[0]);
  object.date = reader.readDateTime(offsets[1]);
  object.id = id;
  object.lessonsLearned = reader.readStringOrNull(offsets[2]);
  object.moodAfter = reader.readStringOrNull(offsets[3]);
  object.moodBefore = reader.readStringOrNull(offsets[4]);
  object.personId = reader.readLong(offsets[5]);
  object.qualityScore = reader.readLong(offsets[6]);
  object.summary = reader.readString(offsets[7]);
  object.type = reader.readString(offsets[8]);
  return object;
}

P _interactionDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDateTime(offset)) as P;
    case 1:
      return (reader.readDateTime(offset)) as P;
    case 2:
      return (reader.readStringOrNull(offset)) as P;
    case 3:
      return (reader.readStringOrNull(offset)) as P;
    case 4:
      return (reader.readStringOrNull(offset)) as P;
    case 5:
      return (reader.readLong(offset)) as P;
    case 6:
      return (reader.readLong(offset)) as P;
    case 7:
      return (reader.readString(offset)) as P;
    case 8:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _interactionGetId(Interaction object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _interactionGetLinks(Interaction object) {
  return [];
}

void _interactionAttach(
    IsarCollection<dynamic> col, Id id, Interaction object) {
  object.id = id;
}

extension InteractionQueryWhereSort
    on QueryBuilder<Interaction, Interaction, QWhere> {
  QueryBuilder<Interaction, Interaction, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<Interaction, Interaction, QAfterWhere> anyQualityScore() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'qualityScore'),
      );
    });
  }
}

extension InteractionQueryWhere
    on QueryBuilder<Interaction, Interaction, QWhereClause> {
  QueryBuilder<Interaction, Interaction, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<Interaction, Interaction, QAfterWhereClause> idNotEqualTo(
      Id id) {
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

  QueryBuilder<Interaction, Interaction, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<Interaction, Interaction, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<Interaction, Interaction, QAfterWhereClause> idBetween(
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

  QueryBuilder<Interaction, Interaction, QAfterWhereClause> qualityScoreEqualTo(
      int qualityScore) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'qualityScore',
        value: [qualityScore],
      ));
    });
  }

  QueryBuilder<Interaction, Interaction, QAfterWhereClause>
      qualityScoreNotEqualTo(int qualityScore) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'qualityScore',
              lower: [],
              upper: [qualityScore],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'qualityScore',
              lower: [qualityScore],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'qualityScore',
              lower: [qualityScore],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'qualityScore',
              lower: [],
              upper: [qualityScore],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<Interaction, Interaction, QAfterWhereClause>
      qualityScoreGreaterThan(
    int qualityScore, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'qualityScore',
        lower: [qualityScore],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<Interaction, Interaction, QAfterWhereClause>
      qualityScoreLessThan(
    int qualityScore, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'qualityScore',
        lower: [],
        upper: [qualityScore],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<Interaction, Interaction, QAfterWhereClause> qualityScoreBetween(
    int lowerQualityScore,
    int upperQualityScore, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'qualityScore',
        lower: [lowerQualityScore],
        includeLower: includeLower,
        upper: [upperQualityScore],
        includeUpper: includeUpper,
      ));
    });
  }
}

extension InteractionQueryFilter
    on QueryBuilder<Interaction, Interaction, QFilterCondition> {
  QueryBuilder<Interaction, Interaction, QAfterFilterCondition>
      createdAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<Interaction, Interaction, QAfterFilterCondition>
      createdAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<Interaction, Interaction, QAfterFilterCondition>
      createdAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<Interaction, Interaction, QAfterFilterCondition>
      createdAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'createdAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Interaction, Interaction, QAfterFilterCondition> dateEqualTo(
      DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'date',
        value: value,
      ));
    });
  }

  QueryBuilder<Interaction, Interaction, QAfterFilterCondition> dateGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'date',
        value: value,
      ));
    });
  }

  QueryBuilder<Interaction, Interaction, QAfterFilterCondition> dateLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'date',
        value: value,
      ));
    });
  }

  QueryBuilder<Interaction, Interaction, QAfterFilterCondition> dateBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'date',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Interaction, Interaction, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Interaction, Interaction, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<Interaction, Interaction, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<Interaction, Interaction, QAfterFilterCondition> idBetween(
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

  QueryBuilder<Interaction, Interaction, QAfterFilterCondition>
      lessonsLearnedIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'lessonsLearned',
      ));
    });
  }

  QueryBuilder<Interaction, Interaction, QAfterFilterCondition>
      lessonsLearnedIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'lessonsLearned',
      ));
    });
  }

  QueryBuilder<Interaction, Interaction, QAfterFilterCondition>
      lessonsLearnedEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lessonsLearned',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Interaction, Interaction, QAfterFilterCondition>
      lessonsLearnedGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lessonsLearned',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Interaction, Interaction, QAfterFilterCondition>
      lessonsLearnedLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lessonsLearned',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Interaction, Interaction, QAfterFilterCondition>
      lessonsLearnedBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lessonsLearned',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Interaction, Interaction, QAfterFilterCondition>
      lessonsLearnedStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'lessonsLearned',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Interaction, Interaction, QAfterFilterCondition>
      lessonsLearnedEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'lessonsLearned',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Interaction, Interaction, QAfterFilterCondition>
      lessonsLearnedContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'lessonsLearned',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Interaction, Interaction, QAfterFilterCondition>
      lessonsLearnedMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'lessonsLearned',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Interaction, Interaction, QAfterFilterCondition>
      lessonsLearnedIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lessonsLearned',
        value: '',
      ));
    });
  }

  QueryBuilder<Interaction, Interaction, QAfterFilterCondition>
      lessonsLearnedIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'lessonsLearned',
        value: '',
      ));
    });
  }

  QueryBuilder<Interaction, Interaction, QAfterFilterCondition>
      moodAfterIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'moodAfter',
      ));
    });
  }

  QueryBuilder<Interaction, Interaction, QAfterFilterCondition>
      moodAfterIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'moodAfter',
      ));
    });
  }

  QueryBuilder<Interaction, Interaction, QAfterFilterCondition>
      moodAfterEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'moodAfter',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Interaction, Interaction, QAfterFilterCondition>
      moodAfterGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'moodAfter',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Interaction, Interaction, QAfterFilterCondition>
      moodAfterLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'moodAfter',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Interaction, Interaction, QAfterFilterCondition>
      moodAfterBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'moodAfter',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Interaction, Interaction, QAfterFilterCondition>
      moodAfterStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'moodAfter',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Interaction, Interaction, QAfterFilterCondition>
      moodAfterEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'moodAfter',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Interaction, Interaction, QAfterFilterCondition>
      moodAfterContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'moodAfter',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Interaction, Interaction, QAfterFilterCondition>
      moodAfterMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'moodAfter',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Interaction, Interaction, QAfterFilterCondition>
      moodAfterIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'moodAfter',
        value: '',
      ));
    });
  }

  QueryBuilder<Interaction, Interaction, QAfterFilterCondition>
      moodAfterIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'moodAfter',
        value: '',
      ));
    });
  }

  QueryBuilder<Interaction, Interaction, QAfterFilterCondition>
      moodBeforeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'moodBefore',
      ));
    });
  }

  QueryBuilder<Interaction, Interaction, QAfterFilterCondition>
      moodBeforeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'moodBefore',
      ));
    });
  }

  QueryBuilder<Interaction, Interaction, QAfterFilterCondition>
      moodBeforeEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'moodBefore',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Interaction, Interaction, QAfterFilterCondition>
      moodBeforeGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'moodBefore',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Interaction, Interaction, QAfterFilterCondition>
      moodBeforeLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'moodBefore',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Interaction, Interaction, QAfterFilterCondition>
      moodBeforeBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'moodBefore',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Interaction, Interaction, QAfterFilterCondition>
      moodBeforeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'moodBefore',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Interaction, Interaction, QAfterFilterCondition>
      moodBeforeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'moodBefore',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Interaction, Interaction, QAfterFilterCondition>
      moodBeforeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'moodBefore',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Interaction, Interaction, QAfterFilterCondition>
      moodBeforeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'moodBefore',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Interaction, Interaction, QAfterFilterCondition>
      moodBeforeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'moodBefore',
        value: '',
      ));
    });
  }

  QueryBuilder<Interaction, Interaction, QAfterFilterCondition>
      moodBeforeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'moodBefore',
        value: '',
      ));
    });
  }

  QueryBuilder<Interaction, Interaction, QAfterFilterCondition> personIdEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'personId',
        value: value,
      ));
    });
  }

  QueryBuilder<Interaction, Interaction, QAfterFilterCondition>
      personIdGreaterThan(
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

  QueryBuilder<Interaction, Interaction, QAfterFilterCondition>
      personIdLessThan(
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

  QueryBuilder<Interaction, Interaction, QAfterFilterCondition> personIdBetween(
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

  QueryBuilder<Interaction, Interaction, QAfterFilterCondition>
      qualityScoreEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'qualityScore',
        value: value,
      ));
    });
  }

  QueryBuilder<Interaction, Interaction, QAfterFilterCondition>
      qualityScoreGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'qualityScore',
        value: value,
      ));
    });
  }

  QueryBuilder<Interaction, Interaction, QAfterFilterCondition>
      qualityScoreLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'qualityScore',
        value: value,
      ));
    });
  }

  QueryBuilder<Interaction, Interaction, QAfterFilterCondition>
      qualityScoreBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'qualityScore',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Interaction, Interaction, QAfterFilterCondition> summaryEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'summary',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Interaction, Interaction, QAfterFilterCondition>
      summaryGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'summary',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Interaction, Interaction, QAfterFilterCondition> summaryLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'summary',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Interaction, Interaction, QAfterFilterCondition> summaryBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'summary',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Interaction, Interaction, QAfterFilterCondition>
      summaryStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'summary',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Interaction, Interaction, QAfterFilterCondition> summaryEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'summary',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Interaction, Interaction, QAfterFilterCondition> summaryContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'summary',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Interaction, Interaction, QAfterFilterCondition> summaryMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'summary',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Interaction, Interaction, QAfterFilterCondition>
      summaryIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'summary',
        value: '',
      ));
    });
  }

  QueryBuilder<Interaction, Interaction, QAfterFilterCondition>
      summaryIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'summary',
        value: '',
      ));
    });
  }

  QueryBuilder<Interaction, Interaction, QAfterFilterCondition> typeEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Interaction, Interaction, QAfterFilterCondition> typeGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Interaction, Interaction, QAfterFilterCondition> typeLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Interaction, Interaction, QAfterFilterCondition> typeBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'type',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Interaction, Interaction, QAfterFilterCondition> typeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Interaction, Interaction, QAfterFilterCondition> typeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Interaction, Interaction, QAfterFilterCondition> typeContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Interaction, Interaction, QAfterFilterCondition> typeMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'type',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Interaction, Interaction, QAfterFilterCondition> typeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'type',
        value: '',
      ));
    });
  }

  QueryBuilder<Interaction, Interaction, QAfterFilterCondition>
      typeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'type',
        value: '',
      ));
    });
  }
}

extension InteractionQueryObject
    on QueryBuilder<Interaction, Interaction, QFilterCondition> {}

extension InteractionQueryLinks
    on QueryBuilder<Interaction, Interaction, QFilterCondition> {}

extension InteractionQuerySortBy
    on QueryBuilder<Interaction, Interaction, QSortBy> {
  QueryBuilder<Interaction, Interaction, QAfterSortBy> sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<Interaction, Interaction, QAfterSortBy> sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<Interaction, Interaction, QAfterSortBy> sortByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.asc);
    });
  }

  QueryBuilder<Interaction, Interaction, QAfterSortBy> sortByDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.desc);
    });
  }

  QueryBuilder<Interaction, Interaction, QAfterSortBy> sortByLessonsLearned() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lessonsLearned', Sort.asc);
    });
  }

  QueryBuilder<Interaction, Interaction, QAfterSortBy>
      sortByLessonsLearnedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lessonsLearned', Sort.desc);
    });
  }

  QueryBuilder<Interaction, Interaction, QAfterSortBy> sortByMoodAfter() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'moodAfter', Sort.asc);
    });
  }

  QueryBuilder<Interaction, Interaction, QAfterSortBy> sortByMoodAfterDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'moodAfter', Sort.desc);
    });
  }

  QueryBuilder<Interaction, Interaction, QAfterSortBy> sortByMoodBefore() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'moodBefore', Sort.asc);
    });
  }

  QueryBuilder<Interaction, Interaction, QAfterSortBy> sortByMoodBeforeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'moodBefore', Sort.desc);
    });
  }

  QueryBuilder<Interaction, Interaction, QAfterSortBy> sortByPersonId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'personId', Sort.asc);
    });
  }

  QueryBuilder<Interaction, Interaction, QAfterSortBy> sortByPersonIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'personId', Sort.desc);
    });
  }

  QueryBuilder<Interaction, Interaction, QAfterSortBy> sortByQualityScore() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'qualityScore', Sort.asc);
    });
  }

  QueryBuilder<Interaction, Interaction, QAfterSortBy>
      sortByQualityScoreDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'qualityScore', Sort.desc);
    });
  }

  QueryBuilder<Interaction, Interaction, QAfterSortBy> sortBySummary() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'summary', Sort.asc);
    });
  }

  QueryBuilder<Interaction, Interaction, QAfterSortBy> sortBySummaryDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'summary', Sort.desc);
    });
  }

  QueryBuilder<Interaction, Interaction, QAfterSortBy> sortByType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.asc);
    });
  }

  QueryBuilder<Interaction, Interaction, QAfterSortBy> sortByTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.desc);
    });
  }
}

extension InteractionQuerySortThenBy
    on QueryBuilder<Interaction, Interaction, QSortThenBy> {
  QueryBuilder<Interaction, Interaction, QAfterSortBy> thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<Interaction, Interaction, QAfterSortBy> thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<Interaction, Interaction, QAfterSortBy> thenByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.asc);
    });
  }

  QueryBuilder<Interaction, Interaction, QAfterSortBy> thenByDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.desc);
    });
  }

  QueryBuilder<Interaction, Interaction, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Interaction, Interaction, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<Interaction, Interaction, QAfterSortBy> thenByLessonsLearned() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lessonsLearned', Sort.asc);
    });
  }

  QueryBuilder<Interaction, Interaction, QAfterSortBy>
      thenByLessonsLearnedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lessonsLearned', Sort.desc);
    });
  }

  QueryBuilder<Interaction, Interaction, QAfterSortBy> thenByMoodAfter() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'moodAfter', Sort.asc);
    });
  }

  QueryBuilder<Interaction, Interaction, QAfterSortBy> thenByMoodAfterDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'moodAfter', Sort.desc);
    });
  }

  QueryBuilder<Interaction, Interaction, QAfterSortBy> thenByMoodBefore() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'moodBefore', Sort.asc);
    });
  }

  QueryBuilder<Interaction, Interaction, QAfterSortBy> thenByMoodBeforeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'moodBefore', Sort.desc);
    });
  }

  QueryBuilder<Interaction, Interaction, QAfterSortBy> thenByPersonId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'personId', Sort.asc);
    });
  }

  QueryBuilder<Interaction, Interaction, QAfterSortBy> thenByPersonIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'personId', Sort.desc);
    });
  }

  QueryBuilder<Interaction, Interaction, QAfterSortBy> thenByQualityScore() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'qualityScore', Sort.asc);
    });
  }

  QueryBuilder<Interaction, Interaction, QAfterSortBy>
      thenByQualityScoreDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'qualityScore', Sort.desc);
    });
  }

  QueryBuilder<Interaction, Interaction, QAfterSortBy> thenBySummary() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'summary', Sort.asc);
    });
  }

  QueryBuilder<Interaction, Interaction, QAfterSortBy> thenBySummaryDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'summary', Sort.desc);
    });
  }

  QueryBuilder<Interaction, Interaction, QAfterSortBy> thenByType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.asc);
    });
  }

  QueryBuilder<Interaction, Interaction, QAfterSortBy> thenByTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.desc);
    });
  }
}

extension InteractionQueryWhereDistinct
    on QueryBuilder<Interaction, Interaction, QDistinct> {
  QueryBuilder<Interaction, Interaction, QDistinct> distinctByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAt');
    });
  }

  QueryBuilder<Interaction, Interaction, QDistinct> distinctByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'date');
    });
  }

  QueryBuilder<Interaction, Interaction, QDistinct> distinctByLessonsLearned(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lessonsLearned',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Interaction, Interaction, QDistinct> distinctByMoodAfter(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'moodAfter', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Interaction, Interaction, QDistinct> distinctByMoodBefore(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'moodBefore', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Interaction, Interaction, QDistinct> distinctByPersonId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'personId');
    });
  }

  QueryBuilder<Interaction, Interaction, QDistinct> distinctByQualityScore() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'qualityScore');
    });
  }

  QueryBuilder<Interaction, Interaction, QDistinct> distinctBySummary(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'summary', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Interaction, Interaction, QDistinct> distinctByType(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'type', caseSensitive: caseSensitive);
    });
  }
}

extension InteractionQueryProperty
    on QueryBuilder<Interaction, Interaction, QQueryProperty> {
  QueryBuilder<Interaction, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Interaction, DateTime, QQueryOperations> createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAt');
    });
  }

  QueryBuilder<Interaction, DateTime, QQueryOperations> dateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'date');
    });
  }

  QueryBuilder<Interaction, String?, QQueryOperations>
      lessonsLearnedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lessonsLearned');
    });
  }

  QueryBuilder<Interaction, String?, QQueryOperations> moodAfterProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'moodAfter');
    });
  }

  QueryBuilder<Interaction, String?, QQueryOperations> moodBeforeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'moodBefore');
    });
  }

  QueryBuilder<Interaction, int, QQueryOperations> personIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'personId');
    });
  }

  QueryBuilder<Interaction, int, QQueryOperations> qualityScoreProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'qualityScore');
    });
  }

  QueryBuilder<Interaction, String, QQueryOperations> summaryProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'summary');
    });
  }

  QueryBuilder<Interaction, String, QQueryOperations> typeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'type');
    });
  }
}
