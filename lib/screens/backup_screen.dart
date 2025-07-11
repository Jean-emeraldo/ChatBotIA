import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BackupScreen extends StatelessWidget {
  // Couleurs personnalisées d'après tes variables CSS (à ajuster si besoin)
  static const Color primaryGreen = Color(0xFF22C55E);
  static const Color borderGreen = Color(0xFF22C55E);
  static const Color darkGreen = Color(0xFF16A34A);
  static const Color textGray300 = Color(0xFFD1D5DB);
  static const Color bgBlack = Color(0xFF000000);
  static const Color bgBlackOpacity = Color.fromRGBO(0, 0, 0, 0.5);

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
      backgroundColor: bgBlack,
      appBar: AppBar(
        title: Text('Sauvegarde'),
        backgroundColor: Colors.black,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: LayoutBuilder(
            builder: (context, constraints) {
              // Largeur max disponible
              double maxWidth = constraints.maxWidth;
              // Largeur pour chaque colonne (min 300px ou full width si écran petit)
              double itemWidth = maxWidth < 650 ? maxWidth : 300;

              return Wrap(
                spacing: 24,
                runSpacing: 24,
                children: [
                  // Liste infos
                  SizedBox(
                    width: itemWidth,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: infoItems.map((item) {
                        return Container(
                          padding: EdgeInsets.all(12),
                          margin: EdgeInsets.only(bottom: 12),
                          decoration: BoxDecoration(
                            color: bgBlackOpacity,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  FaIcon(
                                    item['icon'],
                                    color: primaryGreen,
                                    size: 16,
                                  ),
                                  SizedBox(width: 12),
                                  Text(
                                    item['label'],
                                    style: TextStyle(
                                      color: textGray300,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                item['value'],
                                style: TextStyle(
                                  color: primaryGreen,
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
                  // Liste actions
                  SizedBox(
                    width: itemWidth,
                    child: Column(
                      children: [
                        _BackupActionButton(
                          icon: FontAwesomeIcons.syncAlt,
                          label: 'Réaliser une sauvegarde',
                          isPrimary: true,
                          onPressed: () {
                            // TODO: action sauvegarde
                          },
                        ),
                        SizedBox(height: 12),
                        _BackupActionButton(
                          icon: FontAwesomeIcons.undoAlt,
                          label: 'Restaurer une sauvegarde',
                          onPressed: () {
                            // TODO: action restauration
                          },
                        ),
                        SizedBox(height: 12),
                        _BackupActionButton(
                          icon: FontAwesomeIcons.trashAlt,
                          label: 'Supprimer les sauvegardes',
                          onPressed: () {
                            // TODO: action suppression
                          },
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
    final primaryGreen = BackupScreen.primaryGreen;
    final borderGreen = BackupScreen.borderGreen;
    final darkGreen = BackupScreen.darkGreen;
    final textGray300 = BackupScreen.textGray300;
    final bgBlack = BackupScreen.bgBlack;

    Color backgroundColor;
    Color borderColor;
    Color textColor;

    if (widget.isPrimary) {
      backgroundColor = _hovering ? darkGreen : primaryGreen;
      borderColor = primaryGreen;
      textColor = bgBlack;
    } else {
      backgroundColor = _hovering ? primaryGreen.withOpacity(0.1) : Colors.transparent;
      borderColor = _hovering ? primaryGreen : borderGreen;
      textColor = _hovering ? primaryGreen : textGray300;
    }

    return MouseRegion(
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      cursor: SystemMouseCursors.click,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          backgroundColor: backgroundColor,
          side: BorderSide(color: borderColor),
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
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
            SizedBox(width: 12),
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
