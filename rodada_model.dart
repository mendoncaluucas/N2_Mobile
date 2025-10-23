// lib/models/rodada_model.dart

import 'package:json_annotation/json_annotation.dart';

part 'rodada_model.g.dart';


enum StatusRodada { aIniciar, emAndamento, encerrada }

@JsonSerializable() // MANTIDO: Esta anotação está correta aqui, pois está em uma classe.
class Rodada {
  final int id;
  final String titulo;
  StatusRodada status;
  DateTime? horarioRegistro;

  Rodada({
    required this.id,
    required this.titulo,
    this.status = StatusRodada.aIniciar,
    this.horarioRegistro,
  });

  factory Rodada.fromJson(Map<String, dynamic> json) => _$RodadaFromJson(json);
  Map<String, dynamic> toJson() => _$RodadaToJson(this);
}