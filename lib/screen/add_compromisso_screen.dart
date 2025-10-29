import 'package:flutter/material.dart';
import '../model/compromisso.dart';

class AddCompromissoScreen extends StatefulWidget {
  final void Function(Compromisso) onSalvar;

  const AddCompromissoScreen({super.key, required this.onSalvar});

  @override
  State<AddCompromissoScreen> createState() => _AddCompromissoScreenState();
}

class _AddCompromissoScreenState extends State<AddCompromissoScreen> {
  final tituloCtrl = TextEditingController();
  final descricaoCtrl = TextEditingController();
  DateTime? dataSelecionada;
  bool tituloError = false;
  bool dataError = false;

  @override
  void initState() {
    super.initState();
    tituloCtrl.addListener(() {
      setState(() {});
    });
    descricaoCtrl.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    tituloCtrl.dispose();
    descricaoCtrl.dispose();
    super.dispose();
  }

  void _limparCampos() {
    tituloCtrl.clear();
    descricaoCtrl.clear();
    setState(() {
      dataSelecionada = null;
      tituloError = false;
      dataError = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              color: const Color(0xFFF5F5F5),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Título',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF333333),
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: tituloCtrl,
                  maxLength: 25,
                  onChanged: (value) {
                    setState(() {
                      tituloError = value.isEmpty;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: 'Digite o título do Compromisso',
                    enabledBorder: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                      borderSide: BorderSide(
                        color:
                            tituloError ? Colors.red : const Color(0xFFCCCCCC),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                      borderSide: BorderSide(
                        color: tituloError
                            ? Colors.red
                            : Theme.of(context)
                                .primaryColor,
                        width: 2,
                      ),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 16),
                    counterText: '',
                  ),
                ),
                const SizedBox(height: 4),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    '${tituloCtrl.text.length}/25',
                    style: TextStyle(
                      fontSize: 12,
                      color: tituloCtrl.text.length > 25
                          ? Colors.red
                          : const Color(0xFF666666),
                    ),
                  ),
                ),
                if (tituloError)
                  const Padding(
                    padding: EdgeInsets.only(top: 4),
                    child: Text(
                      'Por favor, digite um título',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 12,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              color: const Color(0xFFF5F5F5),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Descrição',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF333333),
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: descricaoCtrl,
                  maxLines: 4,
                  maxLength: 200,
                  decoration: const InputDecoration(
                    hintText: 'Digite uma descrição (opcional)',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      borderSide: BorderSide(color: Color(0xFFCCCCCC)),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                    counterText: '', 
                  ),
                ),
                const SizedBox(height: 4),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    '${descricaoCtrl.text.length}/200',
                    style: TextStyle(
                      fontSize: 12,
                      color: descricaoCtrl.text.length > 200
                          ? Colors.red
                          : const Color(0xFF666666),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.only(bottom: 24),
            decoration: BoxDecoration(
              color: const Color(0xFFF5F5F5),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Data e Hora',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF333333),
                  ),
                ),
                const SizedBox(height: 8),
                InkWell(
                  onTap: () async {
                    final data = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2020),
                      lastDate: DateTime(2100),
                    );
                    if (data != null) {
                      final hora = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      );
                      if (hora != null) {
                        setState(() {
                          dataSelecionada = DateTime(
                            data.year,
                            data.month,
                            data.day,
                            hora.hour,
                            hora.minute,
                          );
                          dataError = false;
                        });
                      }
                    }
                  },
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color:
                            dataError ? Colors.red : const Color(0xFFCCCCCC),
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.calendar_today,
                          color: dataError
                              ? Colors.red
                              : const Color(0xFF666666),
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          dataSelecionada != null
                              ? '${dataSelecionada!.day.toString().padLeft(2, '0')}/${dataSelecionada!.month.toString().padLeft(2, '0')}/${dataSelecionada!.year} ${dataSelecionada!.hour.toString().padLeft(2, '0')}:${dataSelecionada!.minute.toString().padLeft(2, '0')}'
                              : 'Selecione uma data e hora',
                          style: TextStyle(
                            color: dataSelecionada != null
                                ? const Color(0xFF333333)
                                : const Color(0xFF999999),
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                if (dataError)
                  const Padding(
                    padding: EdgeInsets.only(top: 4),
                    child: Text(
                      'Por favor, selecione uma data',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 12,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFA5D6A7),
                foregroundColor: const Color(0xFF2E7D32),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,
              ),
              onPressed: () {
                setState(() {
                  tituloError = tituloCtrl.text.isEmpty;
                  dataError = dataSelecionada == null;
                });

                if (!tituloError && !dataError) {
                  final novo = Compromisso(
                    titulo: tituloCtrl.text,
                    descricao: descricaoCtrl.text,
                    dataHora: dataSelecionada!,
                  );
                  widget.onSalvar(novo);
                  _limparCampos();
                }
              },
              child: const Text(
                'Salvar Compromisso',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

