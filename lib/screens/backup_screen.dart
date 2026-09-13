import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BackupScreen extends StatelessWidget {
  static const Color primaryBlue = Color(0xFF38BDF8);
  static const Color borderBlue = Color(0xFFBAE6FD);
  static const Color darkBlue = Color(0xFF0284C7);
  static const Color textGray300 = Color(0xFF475569);
  static const Color bgWhite = Colors.white;
  static const Color bgWhiteOpacity = Color.fromRGBO(240, 249, 255, 0.9);

  final List<Map<String, dynamic>> infoItems = [
    {
      'icon': FontAwesomeIcons.clock,
      'label': 'Dernière sauvegarde',
      'value': 'Aujourd\'hui, 14:30',
    },
    {
      'icon': FontAwesomeIcons.database,
      'label': 'Espace utilisé',
      'value': '1.2 Go',
    },
    {
      'icon': FontAwesomeIcons.cloudUploadAlt,
      'label': 'Sauvegarde automatique',
      'value': 'Activée',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FBFF),
      appBar: AppBar(
        title: const Text('Sauvegarde'),
        backgroundColor: const Color(0xFF0284C7),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: LayoutBuilder(
            builder: (context, constraints) {
              double maxWidth = constraints.maxWidth;
              double itemWidth = maxWidth < 650 ? maxWidth : 300;

              return Wrap(
                spacing: 24,
                runSpacing: 24,
                children: [
                  SizedBox(
                    width: itemWidth,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: infoItems.map((item) {
                        return Container(
                          padding: const EdgeInsets.all(12),
                          margin: const EdgeInsets.only(bottom: 12),
                          decoration: BoxDecoration(
                            color: bgWhiteOpacity,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: borderBlue),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  FaIcon(
                                    item['icon'],
                                    color: primaryBlue,
                                    size: 16,
                                  ),
                                  const SizedBox(width: 12),
                                  Text(
                                    item['label'],
                                    style: const TextStyle(
                                      color: Color(0xFF0F172A),
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                item['value'],
                                style: const TextStyle(
                                  color: Color(0xFF0284C7),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  SizedBox(
                    width: itemWidth,
                    child: Column(
                      children: [
                        _BackupActionButton(
                          icon: FontAwesomeIcons.syncAlt,
                          label: 'Réaliser une sauvegarde',
                          isPrimary: true,
                          onPressed: () {},
                        ),
                        const SizedBox(height: 12),
                        _BackupActionButton(
                          icon: FontAwesomeIcons.undoAlt,
                          label: 'Restaurer une sauvegarde',
                          onPressed: () {},
                        ),
                        const SizedBox(height: 12),
                        _BackupActionButton(
                          icon: FontAwesomeIcons.trashAlt,
                          label: 'Supprimer les sauvegardes',
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class _BackupActionButton extends StatefulWidget {
  final IconData icon;
  final String label;
  final bool isPrimary;
  final VoidCallback onPressed;

  const _BackupActionButton({
    Key? key,
    required this.icon,
    required this.label,
    this.isPrimary = false,
    required this.onPressed,
  }) : super(key: key);

  @override
  __BackupActionButtonState createState() => __BackupActionButtonState();
}

class __BackupActionButtonState extends State<_BackupActionButton> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    final primaryBlue = BackupScreen.primaryBlue;
    final borderBlue = BackupScreen.borderBlue;
    final darkBlue = BackupScreen.darkBlue;
    final textGray300 = BackupScreen.textGray300;

    Color backgroundColor;
    Color borderColor;
    Color textColor;

    if (widget.isPrimary) {
      backgroundColor = _hovering ? darkBlue : primaryBlue;
      borderColor = primaryBlue;
      textColor = Colors.white;
    } else {
      backgroundColor = _hovering ? primaryBlue.withOpacity(0.1) : Colors.transparent;
      borderColor = _hovering ? primaryBlue : borderBlue;
      textColor = _hovering ? primaryBlue : textGray300;
    }

    return MouseRegion(
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      cursor: SystemMouseCursors.click,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          backgroundColor: backgroundColor,
          side: BorderSide(color: borderColor),
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          alignment: Alignment.centerLeft,
        ),
        onPressed: widget.onPressed,
        child: Row(
          children: [
            FaIcon(
              widget.icon,
              color: textColor,
              size: 16,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                widget.label,
                style: TextStyle(
                  color: textColor,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
