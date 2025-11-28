// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rodada_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Rodada _$RodadaFromJson(Map<String, dynamic> json) => Rodada(
  id: (json['id'] as num).toInt(),
  titulo: json['titulo'] as String,
  status:
      $enumDecodeNullable(_$StatusRodadaEnumMap, json['status']) ??
      StatusRodada.aIniciar,
  horarioRegistro: json['horarioRegistro'] == null
      ? null
      : DateTime.parse(json['horarioRegistro'] as String),
);

Map<String, dynamic> _$RodadaToJson(Rodada instance) => <String, dynamic>{
  'id': instance.id,
  'titulo': instance.titulo,
  'status': _$StatusRodadaEnumMap[instance.status]!,
  'horarioRegistro': instance.horarioRegistro?.toIso8601String(),
};

const _$StatusRodadaEnumMap = {
  StatusRodada.aIniciar: 'aIniciar',
  StatusRodada.emAndamento: 'emAndamento',
  StatusRodada.encerrada: 'encerrada',
};
