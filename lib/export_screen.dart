import 'package:flutter/material.dart';

class ExportScreen extends StatelessWidget {
  const ExportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const csvLayout = '''
student_id,student_name,date,round,status,recorded_at,validation_method,notes
12345,Aluno Exemplo,2025-10-28,1,P,2025-10-28T19:05:10Z,local_network_beacon,-
12345,Aluno Exemplo,2025-10-28,2,P,2025-10-28T19:55:30Z,local_network_beacon,-
12345,Aluno Exemplo,2025-10-28,3,F,-,NA,-
12345,Aluno Exemplo,2025-10-28,4,F,-,NA,-
''';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Layout de Exportação CSV'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'A funcionalidade de exportação gerará um arquivo CSV com o seguinte formato:',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(12),
              color: Colors.grey[200],
              child: const SelectableText(
                csvLayout,
                style: TextStyle(fontFamily: 'monospace', fontSize: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}