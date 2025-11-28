import 'package:json_annotation/json_annotation.dart';

// O build_runner vai gerar este arquivo depois
part 'rodada_model.g.dart';

// CORREÇÃO: Removemos a anotação @JsonSerializable daqui
enum StatusRodada { aIniciar, emAndamento, encerrada }

@JsonSerializable() // A anotação fica APENAS aqui na classe
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

  // Métodos para converter para JSON (necessário para salvar no celular)
  factory Rodada.fromJson(Map<String, dynamic> json) => _$RodadaFromJson(json);
  Map<String, dynamic> toJson() => _$RodadaToJson(this);
}