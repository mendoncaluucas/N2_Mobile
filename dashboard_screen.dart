import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/rodada_model.dart';
import '../services/chamada_service.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  (Color, IconData) _getEstiloPorStatus(Rodada rodada) {
    if (rodada.horarioRegistro != null) {
      return (Colors.green.shade100, Icons.check_circle);
    }
    switch (rodada.status) {
      case StatusRodada.aIniciar:
        return (Colors.grey.shade300, Icons.hourglass_empty);
      case StatusRodada.emAndamento:
        return (Colors.blue.shade100, Icons.sensors);
      case StatusRodada.encerrada:
        return (Colors.red.shade100, Icons.cancel);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Painel de Chamadas'),
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            tooltip: 'Histórico',
            onPressed: () => Navigator.pushNamed(context, '/historico'),
          ),
          IconButton(
            icon: const Icon(Icons.groups),
            tooltip: 'Status da Turma',
            onPressed: () => Navigator.pushNamed(context, '/status_geral'),
          ),
          IconButton(
            icon: const Icon(Icons.description),
            tooltip: 'Exportar (Mock)',
            onPressed: () => Navigator.pushNamed(context, '/exportar'),
          ),
        ],
      ),
      body: Consumer<ChamadaService>(
        builder: (context, chamadaService, child) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        const Text("Demonstração de Automação", style: TextStyle(fontWeight: FontWeight.bold)),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            ElevatedButton.icon(
                              icon: const Icon(Icons.play_arrow),
                              label: const Text('Iniciar'),
                              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                              onPressed: () => chamadaService.iniciarAutomacao(),
                            ),
                            ElevatedButton.icon(
                              icon: const Icon(Icons.stop),
                              label: const Text('Resetar'),
                              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                              onPressed: () => chamadaService.resetarRodadas(),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: ListView.builder(
                    itemCount: chamadaService.rodadas.length,
                    itemBuilder: (context, index) {
                      final rodada = chamadaService.rodadas[index];
                      final (cor, icone) = _getEstiloPorStatus(rodada);

                      return Card(
                        color: cor,
                        child: ListTile(
                          leading: Icon(icone),
                          title: Text(rodada.titulo),
                          subtitle: Text('Status: ${rodada.status.name}'),
                          trailing: rodada.status == StatusRodada.emAndamento && rodada.horarioRegistro == null
                              ? ElevatedButton(
                                  child: const Text('PRESENTE'),
                                  onPressed: () {
                                    chamadaService.registrarPresenca(rodada.id);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text('Presença registrada na ${rodada.titulo}!'), backgroundColor: Colors.green),
                                    );
                                  },
                                )
                              : null,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}