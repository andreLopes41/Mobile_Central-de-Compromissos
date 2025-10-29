import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../model/compromisso.dart';

class CalendarioScreen extends StatefulWidget {
  final List<Compromisso> compromissos;
  const CalendarioScreen({super.key, required this.compromissos});

  @override
  State<CalendarioScreen> createState() => _CalendarioScreenState();
}

class _CalendarioScreenState extends State<CalendarioScreen> {
  DateTime diaSelecionado = DateTime.now();

  List<Compromisso> getCompromissosDoDia(DateTime dia) {
    return widget.compromissos
        .where((c) =>
            c.dataHora.year == dia.year &&
            c.dataHora.month == dia.month &&
            c.dataHora.day == dia.day)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final compromissosDoDia = getCompromissosDoDia(diaSelecionado);

    return SingleChildScrollView(
      child: Column(
        children: [
          TableCalendar(
            focusedDay: diaSelecionado,
            firstDay: DateTime.utc(2020, 1, 1),
            lastDay: DateTime.utc(2100, 12, 31),
            selectedDayPredicate: (day) => isSameDay(day, diaSelecionado),
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                diaSelecionado = selectedDay;
              });
            },
            calendarBuilders: CalendarBuilders(
              markerBuilder: (context, date, events) {
                final temCompromisso = getCompromissosDoDia(date).isNotEmpty;
                if (temCompromisso) {
                  return const Icon(Icons.circle,
                      color: Colors.green, size: 8);
                }
                return null;
              },
            ),
            locale: 'pt_BR',
            headerStyle: HeaderStyle(
              formatButtonVisible: false,
              titleCentered: true,
              titleTextStyle: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF388E3C)),
              leftChevronIcon:
                  const Icon(Icons.chevron_left, color: Color(0xFF388E3C)),
              rightChevronIcon:
                  const Icon(Icons.chevron_right, color: Color(0xFF388E3C)),
            ),
            calendarStyle: CalendarStyle(
              todayDecoration: BoxDecoration(
                color: const Color(0xFF81C784).withOpacity(0.5),
                shape: BoxShape.circle,
              ),
              selectedDecoration: const BoxDecoration(
                color: Color(0xFF388E3C),
                shape: BoxShape.circle,
              ),
              markerDecoration: const BoxDecoration(
                color: Color(0xFF81C784),
                shape: BoxShape.circle,
              ),
            ),
          ),
          const SizedBox(height: 20),
          compromissosDoDia.isEmpty
              ? const Padding(
                  padding: EdgeInsets.all(20),
                  child: Text(
                    'Nenhum compromisso neste dia.',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFF666666),
                    ),
                  ),
                )
              : ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.all(16),
                  itemCount: compromissosDoDia.length,
                  itemBuilder: (context, index) {
                    final compromisso = compromissosDoDia[index];
                    return Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withValues(),
                            spreadRadius: 1,
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    compromisso.titulo,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF333333),
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF388E3C),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    '${compromisso.dataHora.hour.toString().padLeft(2, '0')}:${compromisso.dataHora.minute.toString().padLeft(2, '0')}',
                                    style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            if (compromisso.descricao.isNotEmpty) ...[
                              const SizedBox(height: 8),
                              Text(
                                compromisso.descricao,
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFF666666),
                                  height: 1.4,
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    );
                  },
                ),
        ],
      ),
    );
  }
}
