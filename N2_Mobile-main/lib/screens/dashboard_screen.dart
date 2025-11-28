// lib/screens/dashboard_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:chamada_automatizada_n10/models/rodada_model.dart';
import 'package:chamada_automatizada_n10/services/chamada_service.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  // Função auxiliar para definir a cor e o ícone do Card baseado no status
  (Color, IconData) _getEstiloPorStatus(BuildContext context, Rodada rodada) {
    final theme = Theme.of(context);

    // Se o aluno já marcou presença
    if (rodada.horarioRegistro != null) {
      return (Colors.green.shade50, Icons.check_circle);
    }
    
    // Se não marcou, verifica o estado da rodada
    switch (rodada.status) {
      case StatusRodada.aIniciar:
        return (theme.colorScheme.surfaceVariant.withOpacity(0.6), Icons.hourglass_empty);
      case StatusRodada.emAndamento:
        return (theme.colorScheme.primary.withOpacity(0.12), Icons.sensors);
      case StatusRodada.encerrada:
        // Encerrou sem marcar presença = Falta (vermelho)
        return (Colors.red.shade50, Icons.cancel);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Painel de Chamadas'),
        actions: [
          // 1. Navegar para Histórico
          IconButton(
            icon: const Icon(Icons.history),
            tooltip: 'Histórico',
            onPressed: () => Navigator.pushNamed(context, '/historico'),
          ),
          // 2. Navegar para Status Geral da Turma
          IconButton(
            icon: const Icon(Icons.groups),
            tooltip: 'Status da Turma',
            onPressed: () => Navigator.pushNamed(context, '/status_geral'),
          ),
          // 3. Navegar para Exportar CSV (Nota 9)
          IconButton(
            icon: const Icon(Icons.file_download),
            tooltip: 'Exportar CSV',
            onPressed: () => Navigator.pushNamed(context, '/exportar'),
          ),
        ],
      ),
      body: SafeArea(
        child: Consumer<ChamadaService>(
          builder: (context, chamadaService, child) {
            return LayoutBuilder(
              builder: (context, constraints) {
                final width = constraints.maxWidth;
                final isWide = width > 700;

                // Max width for content to look good on tablets / large phones
                return Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 1000),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        children: [
                          // Controle de automação
                          Card(
                            elevation: 3,
                            margin: const EdgeInsets.only(bottom: 12),
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Text(
                                    "Demonstração de Automação",
                                    style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 8),
                                  Wrap(
                                    spacing: 12,
                                    runSpacing: 8,
                                    alignment: WrapAlignment.center,
                                    children: [
                                      ElevatedButton.icon(
                                        icon: const Icon(Icons.play_arrow),
                                        label: const Text('Iniciar'),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.green,
                                          foregroundColor: Colors.white,
                                        ),
                                        onPressed: () => chamadaService.iniciarAutomacao(),
                                      ),
                                      ElevatedButton.icon(
                                        icon: const Icon(Icons.stop),
                                        label: const Text('Resetar'),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.red,
                                          foregroundColor: Colors.white,
                                        ),
                                        onPressed: () => chamadaService.resetarRodadas(),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),

                          // Lista / Grid de rodadas
                          Expanded(
                            child: isWide
                                ? GridView.builder(
                                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      childAspectRatio: 4.5,
                                      crossAxisSpacing: 12,
                                      mainAxisSpacing: 12,
                                    ),
                                    itemCount: chamadaService.rodadas.length,
                                    itemBuilder: (context, index) {
                                      final rodada = chamadaService.rodadas[index];
                                      final (cor, icone) = _getEstiloPorStatus(context, rodada);
                                      return _RodadaTile(
                                        rodada: rodada,
                                        color: cor,
                                        icon: icone,
                                        onPresent: chamadaService.registrarPresenca,
                                      );
                                    },
                                  )
                                : ListView.builder(
                                    itemCount: chamadaService.rodadas.length,
                                    itemBuilder: (context, index) {
                                      final rodada = chamadaService.rodadas[index];
                                      final (cor, icone) = _getEstiloPorStatus(context, rodada);
                                      return _RodadaTile(
                                        rodada: rodada,
                                        color: cor,
                                        icon: icone,
                                        onPresent: chamadaService.registrarPresenca,
                                      );
                                    },
                                  ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

// Small reusable widget for a rodada entry
class _RodadaTile extends StatelessWidget {
  final Rodada rodada;
  final Color color;
  final IconData icon;
  final void Function(int id) onPresent;

  const _RodadaTile({required this.rodada, required this.color, required this.icon, required this.onPresent});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isPresent = rodada.horarioRegistro != null;

    return Card(
      color: color,
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: ListTile(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        leading: CircleAvatar(
          radius: 22,
          backgroundColor: theme.colorScheme.primaryContainer.withOpacity(0.14),
          child: Icon(icon, size: 22, color: theme.colorScheme.onSurface),
        ),
        title: Text(
          rodada.titulo,
          style: theme.textTheme.titleMedium,
        ),
        subtitle: Text(
          'Status: ${rodada.status.name.toUpperCase()}',
          style: theme.textTheme.bodySmall,
        ),
        trailing: (rodada.status == StatusRodada.emAndamento && !isPresent)
            ? ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                ),
                child: const Text('PRESENTE'),
                onPressed: () {
                  onPresent(rodada.id);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Presença registrada na ${rodada.titulo}!'),
                      backgroundColor: Colors.green.shade600,
                      duration: const Duration(seconds: 1),
                    ),
                  );
                },
              )
            : null,
      ),
    );
  }
}