import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/rodada_model.dart';

class ChamadaService extends ChangeNotifier {
  static const _prefsKey = 'chamada_data_v2'; // Chave para salvar os dados
  late SharedPreferences _prefs;
  Timer? _automationTimer;

  List<Rodada> _rodadas = [];
  List<Rodada> get rodadas => _rodadas;

  ChamadaService() {
    _init();
  }

  Future<void> _init() async {
    _prefs = await SharedPreferences.getInstance();
    _loadData();

    if (_rodadas.isEmpty) {
      _resetarRodadasParaEstadoInicial();
    }
  }

  // --- Lógica de Persistência ---
  Future<void> _saveData() async {
    final List<String> rodadasJson = _rodadas.map((r) => jsonEncode(r.toJson())).toList();
    await _prefs.setStringList(_prefsKey, rodadasJson);
    print("Dados salvos com sucesso.");
  }

  void _loadData() {
    final List<String>? rodadasJson = _prefs.getStringList(_prefsKey);
    if (rodadasJson != null) {
      _rodadas = rodadasJson.map((r) => Rodada.fromJson(jsonDecode(r))).toList();
      notifyListeners();
      print("Dados carregados com sucesso.");
    }
  }

  void _resetarRodadasParaEstadoInicial() {
    _rodadas = [
      Rodada(id: 1, titulo: 'Rodada 1 - 19:00'),
      Rodada(id: 2, titulo: 'Rodada 2 - 19:50'),
      Rodada(id: 3, titulo: 'Rodada 3 - 20:40'),
      Rodada(id: 4, titulo: 'Rodada 4 - 21:30'),
    ];
  }

  // --- Lógica de Negócio ---
  void registrarPresenca(int rodadaId) {
    try {
      final rodada = _rodadas.firstWhere((r) => r.id == rodadaId);
      if (rodada.status == StatusRodada.emAndamento) {
        rodada.horarioRegistro = DateTime.now();
        notifyListeners();
        _saveData();
      }
    } catch (e) {
      print('Erro ao registrar presença: $e');
    }
  }

  // --- Lógica de Automação e Simulação ---
  void iniciarProximaRodadaManualmente() {
    final proximaRodada = _rodadas.firstWhere(
      (r) => r.status == StatusRodada.aIniciar,
      orElse: () => _rodadas.last, // Fallback para evitar erro
    );

    for (var r in _rodadas) {
      if (r.status == StatusRodada.emAndamento) {
        r.status = StatusRodada.encerrada;
      }
    }

    if (proximaRodada.status == StatusRodada.aIniciar) {
      proximaRodada.status = StatusRodada.emAndamento;
    }
    
    notifyListeners();
    _saveData();
  }

  void iniciarAutomacao({int segundosPorRodada = 20}) {
    pararAutomacao(); // Garante que não haja timers duplicados
    resetarRodadas();
    
    _automationTimer = Timer.periodic(Duration(seconds: segundosPorRodada), (timer) {
      final rodadasAtivas = _rodadas.where((r) => r.status == StatusRodada.emAndamento).toList();
      final proximaRodada = _rodadas.firstWhere((r) => r.status == StatusRodada.aIniciar, orElse: () => _rodadas.last);

      if (rodadasAtivas.isNotEmpty) {
        for (var r in rodadasAtivas) {
          r.status = StatusRodada.encerrada;
        }
      }

      if (proximaRodada.status == StatusRodada.aIniciar) {
        proximaRodada.status = StatusRodada.emAndamento;
      } else {
        timer.cancel(); // Todas as rodadas foram processadas
        print("Automação concluída.");
      }
      
      notifyListeners();
      _saveData();
    });
    print("Automação iniciada com rodadas de $segundosPorRodada segundos.");
  }
  
  void pararAutomacao() {
    _automationTimer?.cancel();
    print("Automação parada pelo usuário.");
  }

  void resetarRodadas() {
    pararAutomacao();
    _resetarRodadasParaEstadoInicial();
    notifyListeners();
    _saveData();
  }
}