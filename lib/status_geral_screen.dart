import 'package:flutter/material.dart';

class StatusGeralScreen extends StatelessWidget {
  const StatusGeralScreen({super.key});

  // Dados mockados de alunos para a demonstração
  final List<Map<String, dynamic>> alunos = const [
    {'id': 101, 'nome': 'Ana Beatriz', 'presencas': [true, true, true, true]},
    {'id': 102, 'nome': 'Carlos Silva', 'presencas': [true, true, false, false]},
    {'id': 103, 'nome': 'Daniela Lima', 'presencas': [true, false, true, false]},
    {'id': 104, 'nome': 'Eduardo Jorge', 'presencas': [true, true, true, false]},
    {'id': 105, 'nome': 'Fernanda Mota', 'presencas': [false, false, false, false]},
    {'id': 106, 'nome': 'Gabriel Costa', 'presencas': [true, true, true, true]},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Status Geral da Turma'),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          headingRowColor: MaterialStateColor.resolveWith((states) => Colors.deepPurple.shade50),
          columns: const [
            DataColumn(label: Text('Aluno', style: TextStyle(fontWeight: FontWeight.bold))),
            DataColumn(label: Text('Rodada 1')),
            DataColumn(label: Text('Rodada 2')),
            DataColumn(label: Text('Rodada 3')),
            DataColumn(label: Text('Rodada 4')),
          ],
          rows: alunos.map((aluno) {
            return DataRow(cells: [
              DataCell(Text(aluno['nome'])),
              ...List.generate(4, (index) {
                final presente = aluno['presencas'][index];
                return DataCell(
                  Icon(
                    presente ? Icons.check_circle : Icons.cancel,
                    color: presente ? Colors.green.shade700 : Colors.red.shade700,
                  ),
                );
              }),
            ]);
          }).toList(),
        ),
      ),
    );
  }
}