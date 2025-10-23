import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/chamada_service.dart';
import 'package:intl/intl.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Usamos 'watch' para que a tela se atualize se os dados mudarem em background
    final chamadaService = context.watch<ChamadaService>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Histórico do Dia'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: chamadaService.rodadas.length,
          itemBuilder: (context, index) {
            final rodada = chamadaService.rodadas[index];
            final temPresenca = rodada.horarioRegistro != null;
            final statusTexto = temPresenca
                ? 'Presente - Registrado às ${DateFormat('HH:mm:ss').format(rodada.horarioRegistro!)}'
                : 'Ausente ou rodada não concluída';
            
            return Card(
              child: ListTile(
                leading: Icon(
                  temPresenca ? Icons.check_circle : Icons.cancel_outlined,
                  color: temPresenca ? Colors.green : Colors.red,
                ),
                title: Text(rodada.titulo),
                subtitle: Text(statusTexto),
              ),
            );
          },
        ),
      ),
    );
  }
}