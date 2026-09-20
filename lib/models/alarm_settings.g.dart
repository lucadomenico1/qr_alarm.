// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'alarm_settings.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetAlarmSettingsCollection on Isar {
  IsarCollection<AlarmSettings> get alarmSettings => this.collection();
}

const AlarmSettingsSchema = CollectionSchema(
  name: r'AlarmSettings',
  id: 7281991431771899583,
  properties: {
    r'audioUri': PropertySchema(
      id: 0,
      name: r'audioUri',
      type: IsarType.string,
    ),
    r'orario': PropertySchema(
      id: 1,
      name: r'orario',
      type: IsarType.dateTime,
    ),
    r'secretQrCodeString': PropertySchema(
      id: 2,
      name: r'secretQrCodeString',
      type: IsarType.string,
    )
  },
  estimateSize: _alarmSettingsEstimateSize,
  serialize: _alarmSettingsSerialize,
  deserialize: _alarmSettingsDeserialize,
  deserializeProp: _alarmSettingsDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _alarmSettingsGetId,
  getLinks: _alarmSettingsGetLinks,
  attach: _alarmSettingsAttach,
  version: '3.1.0+1',
);

int _alarmSettingsEstimateSize(
  AlarmSettings object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.audioUri;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.secretQrCodeString;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _alarmSettingsSerialize(
  AlarmSettings object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.audioUri);
  writer.writeDateTime(offsets[1], object.orario);
  writer.writeString(offsets[2], object.secretQrCodeString);
}

AlarmSettings _alarmSettingsDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = AlarmSettings();
  object.audioUri = reader.readStringOrNull(offsets[0]);
  object.id = id;
  object.orario = reader.readDateTimeOrNull(offsets[1]);
  object.secretQrCodeString = reader.readStringOrNull(offsets[2]);
  return object;
}

P _alarmSettingsDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 2:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _alarmSettingsGetId(AlarmSettings object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _alarmSettingsGetLinks(AlarmSettings object) {
  return [];
}

void _alarmSettingsAttach(
    IsarCollection<dynamic> col, Id id, AlarmSettings object) {
  object.id = id;
}

extension AlarmSettingsQueryWhereSort
    on QueryBuilder<AlarmSettings, AlarmSettings, QWhere> {
  QueryBuilder<AlarmSettings, AlarmSettings, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension AlarmSettingsQueryWhere
    on QueryBuilder<AlarmSettings, AlarmSettings, QWhereClause> {
  QueryBuilder<AlarmSettings, AlarmSettings, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<AlarmSettings, AlarmSettings, QAfterWhereClause> idNotEqualTo(
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

  QueryBuilder<AlarmSettings, AlarmSettings, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<AlarmSettings, AlarmSettings, QAfterWhereClause> idLessThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<AlarmSettings, AlarmSettings, QAfterWhereClause> idBetween(
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

extension AlarmSettingsQueryFilter
    on QueryBuilder<AlarmSettings, AlarmSettings, QFilterCondition> {
  QueryBuilder<AlarmSettings, AlarmSettings, QAfterFilterCondition>
      audioUriIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'audioUri',
      ));
    });
  }

  QueryBuilder<AlarmSettings, AlarmSettings, QAfterFilterCondition>
      audioUriIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'audioUri',
      ));
    });
  }

  QueryBuilder<AlarmSettings, AlarmSettings, QAfterFilterCondition>
      audioUriEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'audioUri',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AlarmSettings, AlarmSettings, QAfterFilterCondition>
      audioUriGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'audioUri',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AlarmSettings, AlarmSettings, QAfterFilterCondition>
      audioUriLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'audioUri',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AlarmSettings, AlarmSettings, QAfterFilterCondition>
      audioUriBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'audioUri',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AlarmSettings, AlarmSettings, QAfterFilterCondition>
      audioUriStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'audioUri',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AlarmSettings, AlarmSettings, QAfterFilterCondition>
      audioUriEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'audioUri',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AlarmSettings, AlarmSettings, QAfterFilterCondition>
      audioUriContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'audioUri',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AlarmSettings, AlarmSettings, QAfterFilterCondition>
      audioUriMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'audioUri',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AlarmSettings, AlarmSettings, QAfterFilterCondition>
      audioUriIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'audioUri',
        value: '',
      ));
    });
  }

  QueryBuilder<AlarmSettings, AlarmSettings, QAfterFilterCondition>
      audioUriIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'audioUri',
        value: '',
      ));
    });
  }

  QueryBuilder<AlarmSettings, AlarmSettings, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<AlarmSettings, AlarmSettings, QAfterFilterCondition>
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

  QueryBuilder<AlarmSettings, AlarmSettings, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<AlarmSettings, AlarmSettings, QAfterFilterCondition> idBetween(
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

  QueryBuilder<AlarmSettings, AlarmSettings, QAfterFilterCondition>
      orarioIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'orario',
      ));
    });
  }

  QueryBuilder<AlarmSettings, AlarmSettings, QAfterFilterCondition>
      orarioIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'orario',
      ));
    });
  }

  QueryBuilder<AlarmSettings, AlarmSettings, QAfterFilterCondition>
      orarioEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'orario',
        value: value,
      ));
    });
  }

  QueryBuilder<AlarmSettings, AlarmSettings, QAfterFilterCondition>
      orarioGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'orario',
        value: value,
      ));
    });
  }

  QueryBuilder<AlarmSettings, AlarmSettings, QAfterFilterCondition>
      orarioLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'orario',
        value: value,
      ));
    });
  }

  QueryBuilder<AlarmSettings, AlarmSettings, QAfterFilterCondition>
      orarioBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'orario',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<AlarmSettings, AlarmSettings, QAfterFilterCondition>
      secretQrCodeStringIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'secretQrCodeString',
      ));
    });
  }

  QueryBuilder<AlarmSettings, AlarmSettings, QAfterFilterCondition>
      secretQrCodeStringIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'secretQrCodeString',
      ));
    });
  }

  QueryBuilder<AlarmSettings, AlarmSettings, QAfterFilterCondition>
      secretQrCodeStringEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'secretQrCodeString',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AlarmSettings, AlarmSettings, QAfterFilterCondition>
      secretQrCodeStringGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'secretQrCodeString',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AlarmSettings, AlarmSettings, QAfterFilterCondition>
      secretQrCodeStringLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'secretQrCodeString',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AlarmSettings, AlarmSettings, QAfterFilterCondition>
      secretQrCodeStringBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'secretQrCodeString',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AlarmSettings, AlarmSettings, QAfterFilterCondition>
      secretQrCodeStringStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'secretQrCodeString',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AlarmSettings, AlarmSettings, QAfterFilterCondition>
      secretQrCodeStringEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'secretQrCodeString',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AlarmSettings, AlarmSettings, QAfterFilterCondition>
      secretQrCodeStringContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'secretQrCodeString',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AlarmSettings, AlarmSettings, QAfterFilterCondition>
      secretQrCodeStringMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'secretQrCodeString',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AlarmSettings, AlarmSettings, QAfterFilterCondition>
      secretQrCodeStringIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'secretQrCodeString',
        value: '',
      ));
    });
  }

  QueryBuilder<AlarmSettings, AlarmSettings, QAfterFilterCondition>
      secretQrCodeStringIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'secretQrCodeString',
        value: '',
      ));
    });
  }
}

extension AlarmSettingsQueryObject
    on QueryBuilder<AlarmSettings, AlarmSettings, QFilterCondition> {}

extension AlarmSettingsQueryLinks
    on QueryBuilder<AlarmSettings, AlarmSettings, QFilterCondition> {}

extension AlarmSettingsQuerySortBy
    on QueryBuilder<AlarmSettings, AlarmSettings, QSortBy> {
  QueryBuilder<AlarmSettings, AlarmSettings, QAfterSortBy> sortByAudioUri() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'audioUri', Sort.asc);
    });
  }

  QueryBuilder<AlarmSettings, AlarmSettings, QAfterSortBy>
      sortByAudioUriDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'audioUri', Sort.desc);
    });
  }

  QueryBuilder<AlarmSettings, AlarmSettings, QAfterSortBy> sortByOrario() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'orario', Sort.asc);
    });
  }

  QueryBuilder<AlarmSettings, AlarmSettings, QAfterSortBy> sortByOrarioDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'orario', Sort.desc);
    });
  }

  QueryBuilder<AlarmSettings, AlarmSettings, QAfterSortBy>
      sortBySecretQrCodeString() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'secretQrCodeString', Sort.asc);
    });
  }

  QueryBuilder<AlarmSettings, AlarmSettings, QAfterSortBy>
      sortBySecretQrCodeStringDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'secretQrCodeString', Sort.desc);
    });
  }
}

extension AlarmSettingsQuerySortThenBy
    on QueryBuilder<AlarmSettings, AlarmSettings, QSortThenBy> {
  QueryBuilder<AlarmSettings, AlarmSettings, QAfterSortBy> thenByAudioUri() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'audioUri', Sort.asc);
    });
  }

  QueryBuilder<AlarmSettings, AlarmSettings, QAfterSortBy>
      thenByAudioUriDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'audioUri', Sort.desc);
    });
  }

  QueryBuilder<AlarmSettings, AlarmSettings, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<AlarmSettings, AlarmSettings, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<AlarmSettings, AlarmSettings, QAfterSortBy> thenByOrario() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'orario', Sort.asc);
    });
  }

  QueryBuilder<AlarmSettings, AlarmSettings, QAfterSortBy> thenByOrarioDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'orario', Sort.desc);
    });
  }

  QueryBuilder<AlarmSettings, AlarmSettings, QAfterSortBy>
      thenBySecretQrCodeString() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'secretQrCodeString', Sort.asc);
    });
  }

  QueryBuilder<AlarmSettings, AlarmSettings, QAfterSortBy>
      thenBySecretQrCodeStringDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'secretQrCodeString', Sort.desc);
    });
  }
}

extension AlarmSettingsQueryWhereDistinct
    on QueryBuilder<AlarmSettings, AlarmSettings, QDistinct> {
  QueryBuilder<AlarmSettings, AlarmSettings, QDistinct> distinctByAudioUri(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'audioUri', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<AlarmSettings, AlarmSettings, QDistinct> distinctByOrario() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'orario');
    });
  }

  QueryBuilder<AlarmSettings, AlarmSettings, QDistinct>
      distinctBySecretQrCodeString({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'secretQrCodeString',
          caseSensitive: caseSensitive);
    });
  }
}

extension AlarmSettingsQueryProperty
    on QueryBuilder<AlarmSettings, AlarmSettings, QQueryProperty> {
  QueryBuilder<AlarmSettings, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<AlarmSettings, String?, QQueryOperations> audioUriProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'audioUri');
    });
  }

  QueryBuilder<AlarmSettings, DateTime?, QQueryOperations> orarioProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'orario');
    });
  }

  QueryBuilder<AlarmSettings, String?, QQueryOperations>
      secretQrCodeStringProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'secretQrCodeString');
    });
  }
}
