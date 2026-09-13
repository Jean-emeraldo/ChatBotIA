import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NotesScreen extends StatelessWidget {
  const NotesScreen({Key? key}) : super(key: key);

  static const Color primaryBlue = Color(0xFF38BDF8);
  static const Color borderBlue = Color(0xFFBAE6FD);
  static const Color textGray300 = Color(0xFF475569);
  static const Color textWhite = Colors.white;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sauvegardes'),
        backgroundColor: const Color(0xFF0284C7),
      ),
      backgroundColor: const Color(0xFFF8FBFF),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: const BorderSide(color: Color(0xFFBAE6FD), width: 1),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  bool isWide = constraints.maxWidth > 600;

                  Widget content = isWide
                      ? Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(child: _buildReportsSection()),
                            const SizedBox(width: 24),
                            Expanded(child: _buildMetricsSection()),
                          ],
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildReportsSection(),
                            const SizedBox(height: 24),
                            _buildMetricsSection(),
                          ],
                        );

                  return isWide
                      ? content
                      : SingleChildScrollView(child: content);
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildReportsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Rapports Disponibles',
          style: TextStyle(
            color: Color(0xFF0F172A),
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 16),
        Column(
          children: [
            _reportButton(icon: FontAwesomeIcons.fileLines, label: 'Rapport Mensuel'),
            const SizedBox(height: 8),
            _reportButton(icon: FontAwesomeIcons.chartBar, label: 'Analyse des Performances'),
            const SizedBox(height: 8),
            _reportButton(icon: FontAwesomeIcons.chartLine, label: 'Tendances des Revenus'),
          ],
        ),
      ],
    );
  }

  Widget _reportButton({required IconData icon, required String label}) {
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          border: Border.all(color: borderBlue),
          borderRadius: BorderRadius.circular(8),
          color: const Color(0xFFF0F9FF),
        ),
        child: Row(
          children: [
            FaIcon(icon, color: primaryBlue, size: 20),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                label,
                style: const TextStyle(
                  color: Color(0xFF0F172A),
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMetricsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Métriques Clés',
          style: TextStyle(
            color: Color(0xFF0F172A),
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 16),
        Column(
          children: [
            _metricItem(label: 'Taux de Completion', value: '87%'),
            const SizedBox(height: 12),
            _metricItem(label: 'Satisfaction Client', value: '4.8/5'),
            const SizedBox(height: 12),
            _metricItem(label: 'ROI Moyen', value: '+23%'),
          ],
        ),
      ],
    );
  }

  Widget _metricItem({required String label, required String value}) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF0F9FF),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFBAE6FD)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: Color(0xFF475569),
              fontSize: 14,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              color: Color(0xFF0284C7),
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
