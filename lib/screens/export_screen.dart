import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:chamada_automatizada_n10/services/chamada_service.dart';

class ExportScreen extends StatefulWidget {
  const ExportScreen({super.key});

  @override
  State<ExportScreen> createState() => _ExportScreenState();
}

class _ExportScreenState extends State<ExportScreen> {
  bool _isExporting = false;

  Future<void> _gerarECompartilharCSV(BuildContext context) async {
    setState(() {
      _isExporting = true;
    });

    try {
      final chamadaService = Provider.of<ChamadaService>(context, listen: false);
      final rodadas = chamadaService.rodadas;

      // Definição do cabeçalho do CSV
      String csvContent = "student_id,student_name,date,round,status,recorded_at,validation_method,notes\n";

      // Geração das linhas de dados
      for (var rodada in rodadas) {
        const studentId = "12345";
        const studentName = "Lucas Rogerio";
        
        final agora = DateTime.now();
        final date = "${agora.year}-${agora.month.toString().padLeft(2,'0')}-${agora.day.toString().padLeft(2,'0')}";
        
        final status = rodada.horarioRegistro != null ? 'P' : 'F';
        final recordedAt = rodada.horarioRegistro?.toIso8601String() ?? '';
        final validationMethod = rodada.horarioRegistro != null ? 'local_button_click' : 'NA';

        csvContent += "$studentId,$studentName,$date,${rodada.id},$status,$recordedAt,$validationMethod,-\n";
      }

      // Salvar arquivo no armazenamento temporário
      final directory = await getTemporaryDirectory();
      final path = '${directory.path}/relatorio_chamada_${DateTime.now().millisecondsSinceEpoch}.csv';
      final file = File(path);
      await file.writeAsString(csvContent);

      // Compartilhar arquivo
      if (mounted) {
        final xFile = XFile(file.path);
        await Share.shareXFiles([xFile], text: 'Segue em anexo o relatório de chamada.');
      }

    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Erro ao exportar: $e"), backgroundColor: Colors.red),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isExporting = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Exportar Relatório'),
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 700),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Icon(Icons.file_download, size: 80, color: theme.colorScheme.primary),
                  const SizedBox(height: 20),
                  Text(
                    "Gerar Relatório CSV",
                    textAlign: TextAlign.center,
                    style: theme.textTheme.titleLarge?.copyWith(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Este recurso irá gerar um arquivo contendo o histórico de todas as rodadas para compartilhamento.",
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onBackground.withOpacity(0.7)),
                  ),
                  const SizedBox(height: 40),
                  _isExporting
                      ? const Center(child: CircularProgressIndicator())
                      : ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 15),
                          ),
                          onPressed: () => _gerarECompartilharCSV(context),
                          icon: const Icon(Icons.share),
                          label: Text(
                            "COMPARTILHAR AGORA",
                            style: theme.textTheme.titleMedium,
                          ),
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}