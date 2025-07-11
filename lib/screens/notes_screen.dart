import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NotesScreen extends StatelessWidget {
  const NotesScreen({Key? key}) : super(key: key);

  static const Color primaryGreen = Color(0xFF22C55E);
  static const Color borderGreen = Color(0xFF22C55E);
  static const Color textGray300 = Color(0xFFD1D5DB);
  static const Color textWhite = Colors.white;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sauvegardes')),
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            color: Colors.grey[900],
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
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

                  // Pour éviter l'overflow vertical, on met dans SingleChildScrollView si en colonne
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
        Text(
          'Rapports Disponibles',
          style: TextStyle(
            color: textWhite,
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
      onTap: () {
        // Action au clic
      },
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          border: Border.all(color: borderGreen),
          borderRadius: BorderRadius.circular(8),
          color: Colors.transparent,
        ),
        child: Row(
          children: [
            FaIcon(icon, color: textGray300, size: 20),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  color: textGray300,
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
        Text(
          'Métriques Clés',
          style: TextStyle(
            color: textWhite,
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
        color: Colors.black.withOpacity(0.5),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              color: textGray300,
              fontSize: 14,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              color: primaryGreen,
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
