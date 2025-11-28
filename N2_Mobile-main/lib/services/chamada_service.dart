// lib/services/chamada_service.dart

import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:chamada_automatizada_n10/models/rodada_model.dart';

class ChamadaService extends ChangeNotifier {
  static const _prefsKey = 'chamada_data_v2';
  late SharedPreferences _prefs;
  Timer? _automationTimer;
  
  // Instância do Banco de Dados
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

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

  // --- Persistência Local ---
  Future<void> _saveData() async {
    final List<String> rodadasJson = _rodadas.map((r) => jsonEncode(r.toJson())).toList();
    await _prefs.setStringList(_prefsKey, rodadasJson);
  }

  void _loadData() {
    final List<String>? rodadasJson = _prefs.getStringList(_prefsKey);
    if (rodadasJson != null) {
      _rodadas = rodadasJson.map((r) => Rodada.fromJson(jsonDecode(r))).toList();
      notifyListeners();
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

  // --- Enviar para o Firebase (ATUALIZADO) ---
  
  Future<void> _enviarParaNuvem(Rodada rodada, String status, String metodo) async {
    try {
      final dadosPresenca = {
        'aluno_id': '12345', 
        'aluno_nome': 'Lucas Rogerio',
        'rodada_id': rodada.id,
        'rodada_titulo': rodada.titulo,
        'data_hora': DateTime.now().toIso8601String(),
        'status': status, // 'PRESENTE' ou 'FALTA'
        'metodo_validacao': metodo // 'local_button_click' ou 'timeout'
      };

      await _firestore.collection('presencas').add(dadosPresenca);
      print("✅ SUCESSO: Registro de $status enviado para o Firebase!");
    } catch (e) {
      print("❌ ERRO: Falha ao enviar para nuvem: $e");
    }
  }

  void registrarPresenca(int rodadaId) {
    try {
      final rodada = _rodadas.firstWhere((r) => r.id == rodadaId);
      if (rodada.status == StatusRodada.emAndamento) {
        rodada.horarioRegistro = DateTime.now();
        
        notifyListeners();
        _saveData();

        // Envia PRESENTE quando o botão é clicado
        _enviarParaNuvem(rodada, 'PRESENTE', 'local_button_click');
      }
    } catch (e) {
      print('Erro: $e');
    }
  }

  // --- Lógica de Automação ---
  void iniciarAutomacao({int segundosPorRodada = 15}) {
    pararAutomacao();
    
     _resetarRodadasParaEstadoInicial();
    
    _automationTimer = Timer.periodic(Duration(seconds: segundosPorRodada), (timer) {
      // Pega as rodadas que estão acabando agora
      final rodadasAtivas = _rodadas.where((r) => r.status == StatusRodada.emAndamento).toList();
      
      // Pega a próxima a iniciar
      final proximaRodada = _rodadas.firstWhere((r) => r.status == StatusRodada.aIniciar, orElse: () => _rodadas.last);

      // --- LÓGICA DE FALTA ---
      if (rodadasAtivas.isNotEmpty) {
        for (var r in rodadasAtivas) {
          
          if (r.horarioRegistro == null) {
             print("⚠️ TEMPO ESGOTADO: Enviando FALTA para rodada ${r.id}");
            _enviarParaNuvem(r, 'FALTA', 'timeout');
          }
          r.status = StatusRodada.encerrada;
        }
      }
      // -----------------------

      if (proximaRodada.status == StatusRodada.aIniciar) {
        proximaRodada.status = StatusRodada.emAndamento;
      } else {
        // Se não tem mais próximas e as ativas acabaram, para o timer
        if (rodadasAtivas.isEmpty) {
          timer.cancel();
        }
      }
      
      notifyListeners();
      _saveData();
    });
  }
  
  void pararAutomacao() {
    _automationTimer?.cancel();
  }

  void resetarRodadas() {
    pararAutomacao();
    _resetarRodadasParaEstadoInicial();
    notifyListeners();
    _saveData();
  }
}