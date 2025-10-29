import 'package:flutter/material.dart';
import '../model/compromisso.dart';
import '../widgets/compromisso_card.dart';


class HomeScreen extends StatelessWidget {
  final List<Compromisso> compromissos;
  final Function(int, int) onReorder;

  const HomeScreen({
    super.key,
    required this.compromissos,
    required this.onReorder,
  });

  @override
  Widget build(BuildContext context) {
    return compromissos.isEmpty
        ? const Center(
            child: Text(
              'Nenhum compromisso ainda.',
              style: TextStyle(fontSize: 16),
            ),
          )
        : ReorderableListView.builder(
            buildDefaultDragHandles: false,
            itemCount: compromissos.length,
            itemBuilder: (context, index) {
              final item = compromissos[index];

              return Container(
                key: ValueKey(item),
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                child: Row(
                  children: [
                    ReorderableDragStartListener(
                      index: index,
                      child: const Icon(
                        Icons.drag_handle,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: CompromissoCard(compromisso: item),
                    ),
                  ],
                ),
              );
            },
            onReorder: onReorder,
          );
  }
}
