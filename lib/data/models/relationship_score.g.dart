// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'relationship_score.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetRelationshipScoreCollection on Isar {
  IsarCollection<RelationshipScore> get relationshipScores => this.collection();
}

const RelationshipScoreSchema = CollectionSchema(
  name: r'RelationshipScore',
  id: 4968695416065118766,
  properties: {
    r'communicationLevel': PropertySchema(
      id: 0,
      name: r'communicationLevel',
      type: IsarType.double,
    ),
    r'emotionalCloseness': PropertySchema(
      id: 1,
      name: r'emotionalCloseness',
      type: IsarType.double,
    ),
    r'lastEvaluated': PropertySchema(
      id: 2,
      name: r'lastEvaluated',
      type: IsarType.dateTime,
    ),
    r'personId': PropertySchema(
      id: 3,
      name: r'personId',
      type: IsarType.long,
    ),
    r'score': PropertySchema(
      id: 4,
      name: r'score',
      type: IsarType.double,
    ),
    r'trustLevel': PropertySchema(
      id: 5,
      name: r'trustLevel',
      type: IsarType.double,
    )
  },
  estimateSize: _relationshipScoreEstimateSize,
  serialize: _relationshipScoreSerialize,
  deserialize: _relationshipScoreDeserialize,
  deserializeProp: _relationshipScoreDeserializeProp,
  idName: r'id',
  indexes: {
    r'personId': IndexSchema(
      id: 750717629518044662,
      name: r'personId',
      unique: true,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'personId',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _relationshipScoreGetId,
  getLinks: _relationshipScoreGetLinks,
  attach: _relationshipScoreAttach,
  version: '3.1.0+1',
);

int _relationshipScoreEstimateSize(
  RelationshipScore object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  return bytesCount;
}

void _relationshipScoreSerialize(
  RelationshipScore object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDouble(offsets[0], object.communicationLevel);
  writer.writeDouble(offsets[1], object.emotionalCloseness);
  writer.writeDateTime(offsets[2], object.lastEvaluated);
  writer.writeLong(offsets[3], object.personId);
  writer.writeDouble(offsets[4], object.score);
  writer.writeDouble(offsets[5], object.trustLevel);
}

RelationshipScore _relationshipScoreDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = RelationshipScore();
  object.communicationLevel = reader.readDouble(offsets[0]);
  object.emotionalCloseness = reader.readDouble(offsets[1]);
  object.id = id;
  object.lastEvaluated = reader.readDateTime(offsets[2]);
  object.personId = reader.readLong(offsets[3]);
  object.score = reader.readDouble(offsets[4]);
  object.trustLevel = reader.readDouble(offsets[5]);
  return object;
}

P _relationshipScoreDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDouble(offset)) as P;
    case 1:
      return (reader.readDouble(offset)) as P;
    case 2:
      return (reader.readDateTime(offset)) as P;
    case 3:
      return (reader.readLong(offset)) as P;
    case 4:
      return (reader.readDouble(offset)) as P;
    case 5:
      return (reader.readDouble(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _relationshipScoreGetId(RelationshipScore object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _relationshipScoreGetLinks(
    RelationshipScore object) {
  return [];
}

void _relationshipScoreAttach(
    IsarCollection<dynamic> col, Id id, RelationshipScore object) {
  object.id = id;
}

extension RelationshipScoreByIndex on IsarCollection<RelationshipScore> {
  Future<RelationshipScore?> getByPersonId(int personId) {
    return getByIndex(r'personId', [personId]);
  }

  RelationshipScore? getByPersonIdSync(int personId) {
    return getByIndexSync(r'personId', [personId]);
  }

  Future<bool> deleteByPersonId(int personId) {
    return deleteByIndex(r'personId', [personId]);
  }

  bool deleteByPersonIdSync(int personId) {
    return deleteByIndexSync(r'personId', [personId]);
  }

  Future<List<RelationshipScore?>> getAllByPersonId(List<int> personIdValues) {
    final values = personIdValues.map((e) => [e]).toList();
    return getAllByIndex(r'personId', values);
  }

  List<RelationshipScore?> getAllByPersonIdSync(List<int> personIdValues) {
    final values = personIdValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'personId', values);
  }

  Future<int> deleteAllByPersonId(List<int> personIdValues) {
    final values = personIdValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'personId', values);
  }

  int deleteAllByPersonIdSync(List<int> personIdValues) {
    final values = personIdValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'personId', values);
  }

  Future<Id> putByPersonId(RelationshipScore object) {
    return putByIndex(r'personId', object);
  }

  Id putByPersonIdSync(RelationshipScore object, {bool saveLinks = true}) {
    return putByIndexSync(r'personId', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByPersonId(List<RelationshipScore> objects) {
    return putAllByIndex(r'personId', objects);
  }

  List<Id> putAllByPersonIdSync(List<RelationshipScore> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'personId', objects, saveLinks: saveLinks);
  }
}

extension RelationshipScoreQueryWhereSort
    on QueryBuilder<RelationshipScore, RelationshipScore, QWhere> {
  QueryBuilder<RelationshipScore, RelationshipScore, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<RelationshipScore, RelationshipScore, QAfterWhere>
      anyPersonId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'personId'),
      );
    });
  }
}

extension RelationshipScoreQueryWhere
    on QueryBuilder<RelationshipScore, RelationshipScore, QWhereClause> {
  QueryBuilder<RelationshipScore, RelationshipScore, QAfterWhereClause>
      idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<RelationshipScore, RelationshipScore, QAfterWhereClause>
      idNotEqualTo(Id id) {
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

  QueryBuilder<RelationshipScore, RelationshipScore, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<RelationshipScore, RelationshipScore, QAfterWhereClause>
      idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<RelationshipScore, RelationshipScore, QAfterWhereClause>
      idBetween(
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

  QueryBuilder<RelationshipScore, RelationshipScore, QAfterWhereClause>
      personIdEqualTo(int personId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'personId',
        value: [personId],
      ));
    });
  }

  QueryBuilder<RelationshipScore, RelationshipScore, QAfterWhereClause>
      personIdNotEqualTo(int personId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'personId',
              lower: [],
              upper: [personId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'personId',
              lower: [personId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'personId',
              lower: [personId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'personId',
              lower: [],
              upper: [personId],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<RelationshipScore, RelationshipScore, QAfterWhereClause>
      personIdGreaterThan(
    int personId, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'personId',
        lower: [personId],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<RelationshipScore, RelationshipScore, QAfterWhereClause>
      personIdLessThan(
    int personId, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'personId',
        lower: [],
        upper: [personId],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<RelationshipScore, RelationshipScore, QAfterWhereClause>
      personIdBetween(
    int lowerPersonId,
    int upperPersonId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'personId',
        lower: [lowerPersonId],
        includeLower: includeLower,
        upper: [upperPersonId],
        includeUpper: includeUpper,
      ));
    });
  }
}

extension RelationshipScoreQueryFilter
    on QueryBuilder<RelationshipScore, RelationshipScore, QFilterCondition> {
  QueryBuilder<RelationshipScore, RelationshipScore, QAfterFilterCondition>
      communicationLevelEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'communicationLevel',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<RelationshipScore, RelationshipScore, QAfterFilterCondition>
      communicationLevelGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'communicationLevel',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<RelationshipScore, RelationshipScore, QAfterFilterCondition>
      communicationLevelLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'communicationLevel',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<RelationshipScore, RelationshipScore, QAfterFilterCondition>
      communicationLevelBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'communicationLevel',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<RelationshipScore, RelationshipScore, QAfterFilterCondition>
      emotionalClosenessEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'emotionalCloseness',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<RelationshipScore, RelationshipScore, QAfterFilterCondition>
      emotionalClosenessGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'emotionalCloseness',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<RelationshipScore, RelationshipScore, QAfterFilterCondition>
      emotionalClosenessLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'emotionalCloseness',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<RelationshipScore, RelationshipScore, QAfterFilterCondition>
      emotionalClosenessBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'emotionalCloseness',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<RelationshipScore, RelationshipScore, QAfterFilterCondition>
      idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<RelationshipScore, RelationshipScore, QAfterFilterCondition>
      idGreaterThan(
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

  QueryBuilder<RelationshipScore, RelationshipScore, QAfterFilterCondition>
      idLessThan(
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

  QueryBuilder<RelationshipScore, RelationshipScore, QAfterFilterCondition>
      idBetween(
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

  QueryBuilder<RelationshipScore, RelationshipScore, QAfterFilterCondition>
      lastEvaluatedEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastEvaluated',
        value: value,
      ));
    });
  }

  QueryBuilder<RelationshipScore, RelationshipScore, QAfterFilterCondition>
      lastEvaluatedGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lastEvaluated',
        value: value,
      ));
    });
  }

  QueryBuilder<RelationshipScore, RelationshipScore, QAfterFilterCondition>
      lastEvaluatedLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lastEvaluated',
        value: value,
      ));
    });
  }

  QueryBuilder<RelationshipScore, RelationshipScore, QAfterFilterCondition>
      lastEvaluatedBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lastEvaluated',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<RelationshipScore, RelationshipScore, QAfterFilterCondition>
      personIdEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'personId',
        value: value,
      ));
    });
  }

  QueryBuilder<RelationshipScore, RelationshipScore, QAfterFilterCondition>
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

  QueryBuilder<RelationshipScore, RelationshipScore, QAfterFilterCondition>
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

  QueryBuilder<RelationshipScore, RelationshipScore, QAfterFilterCondition>
      personIdBetween(
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

  QueryBuilder<RelationshipScore, RelationshipScore, QAfterFilterCondition>
      scoreEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'score',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<RelationshipScore, RelationshipScore, QAfterFilterCondition>
      scoreGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'score',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<RelationshipScore, RelationshipScore, QAfterFilterCondition>
      scoreLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'score',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<RelationshipScore, RelationshipScore, QAfterFilterCondition>
      scoreBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'score',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<RelationshipScore, RelationshipScore, QAfterFilterCondition>
      trustLevelEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'trustLevel',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<RelationshipScore, RelationshipScore, QAfterFilterCondition>
      trustLevelGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'trustLevel',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<RelationshipScore, RelationshipScore, QAfterFilterCondition>
      trustLevelLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'trustLevel',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<RelationshipScore, RelationshipScore, QAfterFilterCondition>
      trustLevelBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'trustLevel',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }
}

extension RelationshipScoreQueryObject
    on QueryBuilder<RelationshipScore, RelationshipScore, QFilterCondition> {}

extension RelationshipScoreQueryLinks
    on QueryBuilder<RelationshipScore, RelationshipScore, QFilterCondition> {}

extension RelationshipScoreQuerySortBy
    on QueryBuilder<RelationshipScore, RelationshipScore, QSortBy> {
  QueryBuilder<RelationshipScore, RelationshipScore, QAfterSortBy>
      sortByCommunicationLevel() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'communicationLevel', Sort.asc);
    });
  }

  QueryBuilder<RelationshipScore, RelationshipScore, QAfterSortBy>
      sortByCommunicationLevelDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'communicationLevel', Sort.desc);
    });
  }

  QueryBuilder<RelationshipScore, RelationshipScore, QAfterSortBy>
      sortByEmotionalCloseness() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'emotionalCloseness', Sort.asc);
    });
  }

  QueryBuilder<RelationshipScore, RelationshipScore, QAfterSortBy>
      sortByEmotionalClosenessDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'emotionalCloseness', Sort.desc);
    });
  }

  QueryBuilder<RelationshipScore, RelationshipScore, QAfterSortBy>
      sortByLastEvaluated() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastEvaluated', Sort.asc);
    });
  }

  QueryBuilder<RelationshipScore, RelationshipScore, QAfterSortBy>
      sortByLastEvaluatedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastEvaluated', Sort.desc);
    });
  }

  QueryBuilder<RelationshipScore, RelationshipScore, QAfterSortBy>
      sortByPersonId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'personId', Sort.asc);
    });
  }

  QueryBuilder<RelationshipScore, RelationshipScore, QAfterSortBy>
      sortByPersonIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'personId', Sort.desc);
    });
  }

  QueryBuilder<RelationshipScore, RelationshipScore, QAfterSortBy>
      sortByScore() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'score', Sort.asc);
    });
  }

  QueryBuilder<RelationshipScore, RelationshipScore, QAfterSortBy>
      sortByScoreDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'score', Sort.desc);
    });
  }

  QueryBuilder<RelationshipScore, RelationshipScore, QAfterSortBy>
      sortByTrustLevel() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'trustLevel', Sort.asc);
    });
  }

  QueryBuilder<RelationshipScore, RelationshipScore, QAfterSortBy>
      sortByTrustLevelDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'trustLevel', Sort.desc);
    });
  }
}

extension RelationshipScoreQuerySortThenBy
    on QueryBuilder<RelationshipScore, RelationshipScore, QSortThenBy> {
  QueryBuilder<RelationshipScore, RelationshipScore, QAfterSortBy>
      thenByCommunicationLevel() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'communicationLevel', Sort.asc);
    });
  }

  QueryBuilder<RelationshipScore, RelationshipScore, QAfterSortBy>
      thenByCommunicationLevelDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'communicationLevel', Sort.desc);
    });
  }

  QueryBuilder<RelationshipScore, RelationshipScore, QAfterSortBy>
      thenByEmotionalCloseness() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'emotionalCloseness', Sort.asc);
    });
  }

  QueryBuilder<RelationshipScore, RelationshipScore, QAfterSortBy>
      thenByEmotionalClosenessDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'emotionalCloseness', Sort.desc);
    });
  }

  QueryBuilder<RelationshipScore, RelationshipScore, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<RelationshipScore, RelationshipScore, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<RelationshipScore, RelationshipScore, QAfterSortBy>
      thenByLastEvaluated() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastEvaluated', Sort.asc);
    });
  }

  QueryBuilder<RelationshipScore, RelationshipScore, QAfterSortBy>
      thenByLastEvaluatedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastEvaluated', Sort.desc);
    });
  }

  QueryBuilder<RelationshipScore, RelationshipScore, QAfterSortBy>
      thenByPersonId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'personId', Sort.asc);
    });
  }

  QueryBuilder<RelationshipScore, RelationshipScore, QAfterSortBy>
      thenByPersonIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'personId', Sort.desc);
    });
  }

  QueryBuilder<RelationshipScore, RelationshipScore, QAfterSortBy>
      thenByScore() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'score', Sort.asc);
    });
  }

  QueryBuilder<RelationshipScore, RelationshipScore, QAfterSortBy>
      thenByScoreDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'score', Sort.desc);
    });
  }

  QueryBuilder<RelationshipScore, RelationshipScore, QAfterSortBy>
      thenByTrustLevel() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'trustLevel', Sort.asc);
    });
  }

  QueryBuilder<RelationshipScore, RelationshipScore, QAfterSortBy>
      thenByTrustLevelDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'trustLevel', Sort.desc);
    });
  }
}

extension RelationshipScoreQueryWhereDistinct
    on QueryBuilder<RelationshipScore, RelationshipScore, QDistinct> {
  QueryBuilder<RelationshipScore, RelationshipScore, QDistinct>
      distinctByCommunicationLevel() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'communicationLevel');
    });
  }

  QueryBuilder<RelationshipScore, RelationshipScore, QDistinct>
      distinctByEmotionalCloseness() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'emotionalCloseness');
    });
  }

  QueryBuilder<RelationshipScore, RelationshipScore, QDistinct>
      distinctByLastEvaluated() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lastEvaluated');
    });
  }

  QueryBuilder<RelationshipScore, RelationshipScore, QDistinct>
      distinctByPersonId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'personId');
    });
  }

  QueryBuilder<RelationshipScore, RelationshipScore, QDistinct>
      distinctByScore() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'score');
    });
  }

  QueryBuilder<RelationshipScore, RelationshipScore, QDistinct>
      distinctByTrustLevel() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'trustLevel');
    });
  }
}

extension RelationshipScoreQueryProperty
    on QueryBuilder<RelationshipScore, RelationshipScore, QQueryProperty> {
  QueryBuilder<RelationshipScore, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<RelationshipScore, double, QQueryOperations>
      communicationLevelProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'communicationLevel');
    });
  }

  QueryBuilder<RelationshipScore, double, QQueryOperations>
      emotionalClosenessProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'emotionalCloseness');
    });
  }

  QueryBuilder<RelationshipScore, DateTime, QQueryOperations>
      lastEvaluatedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastEvaluated');
    });
  }

  QueryBuilder<RelationshipScore, int, QQueryOperations> personIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'personId');
    });
  }

  QueryBuilder<RelationshipScore, double, QQueryOperations> scoreProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'score');
    });
  }

  QueryBuilder<RelationshipScore, double, QQueryOperations>
      trustLevelProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'trustLevel');
    });
  }
}
