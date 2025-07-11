import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'messages_screen.dart';
import 'tasks_screen.dart';
import 'agents_screen.dart';
import 'backup_screen.dart';
import 'notes_screen.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: DashboardScreen(),
  ));
}

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool _isSidebarVisible = false;

  final Color primaryGreen = const Color(0xFF22C55E);
  final Color bgBlack = const Color(0xFF121212);
  final Color borderGreen = const Color(0xFF16A34A);
  final Color textGray300 = Colors.grey.shade300;
  final Color textGray400 = Colors.grey.shade400;
  final Color textGray500 = Colors.grey.shade500;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 8, vsync: this);
    _tabController.addListener(_handleTabSelection);
  }

  void _handleTabSelection() {
    if (_tabController.indexIsChanging) return;

    switch (_tabController.index) {
      case 1:
        _navigateToScreen(TasksScreen());
        break;
      case 3:
        _navigateToScreen(const NotesScreen());
        break;
      case 4:
        _navigateToScreen(const MessagesScreen());
        break;
      case 6:
        _navigateToScreen(AgentsScreen());
        break;
      case 7:
        _navigateToScreen(BackupScreen());
        break;
      default:
        break;
    }
  }

  Future<void> _navigateToScreen(Widget screen) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => screen),
    );
    if (mounted) {
      _tabController.index = 0;
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  PreferredSizeWidget _buildMobileAppBar() {
    return AppBar(
      backgroundColor: bgBlack,
      leading: IconButton(
        icon: FaIcon(FontAwesomeIcons.bars, color: primaryGreen),
        onPressed: () {
          setState(() {
            _isSidebarVisible = !_isSidebarVisible;
          });
        },
      ),
      title: Text(
        'Dashboard Entreprise',
        style: TextStyle(
          color: primaryGreen,
          fontWeight: FontWeight.w800,
          fontSize: 20,
        ),
      ),
      actions: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            IconButton(
              icon: FaIcon(FontAwesomeIcons.bell, color: primaryGreen),
              onPressed: () {},
            ),
            Positioned(
              right: 6,
              top: 6,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: primaryGreen,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  '3',
                  style: TextStyle(
                    color: bgBlack,
                    fontWeight: FontWeight.w700,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(width: 8),
        GestureDetector(
          onTap: () {},
          child: CircleAvatar(
            backgroundColor: primaryGreen,
            radius: 16,
            child: Text(
              'AD',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w700,
                fontSize: 12,
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(48),
        child: Container(
          color: bgBlack,
          child: TabBar(
            controller: _tabController,
            isScrollable: true,
            indicatorColor: primaryGreen,
            labelColor: primaryGreen,
            unselectedLabelColor: textGray400,
            labelStyle: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 14,
            ),
            unselectedLabelStyle: const TextStyle(
              fontWeight: FontWeight.w500,
            ),
            indicatorWeight: 3,
            tabs: const [
              Tab(text: 'Vue d\'ensemble'),
              Tab(text: 'Tâches'),
              Tab(text: 'Projets'),
              Tab(text: 'Rapports'),
              Tab(text: 'Messages'),
              Tab(text: 'Clients'),
              Tab(text: 'Goly IA'),
              Tab(text: 'Sauvegarde'),
            ],
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildEmptyAppBar() {
    return const PreferredSize(
      preferredSize: Size.zero,
      child: SizedBox.shrink(),
    );
  }

  Widget _buildSidebar() {
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 300),
      left: _isSidebarVisible ? 0 : -280,
      top: 0,
      bottom: 0,
      child: Container(
        width: 280,
        color: bgBlack,
        child: SafeArea(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: borderGreen)),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: primaryGreen,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      alignment: Alignment.center,
                      child: const Text(
                        'G',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Dashboard',
                        style: TextStyle(
                          color: primaryGreen,
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.close, color: primaryGreen),
                      onPressed: () {
                        setState(() {
                          _isSidebarVisible = false;
                        });
                      },
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    _buildSidebarItem(
                      icon: FontAwesomeIcons.home,
                      label: 'Dashboard',
                      index: 0,
                    ),
                    _buildSidebarItem(
                      icon: FontAwesomeIcons.checkSquare,
                      label: 'Gestion des Tâches',
                      index: 1,
                    ),
                    _buildSidebarItem(
                      icon: FontAwesomeIcons.folderOpen,
                      label: 'Projets',
                      index: 2,
                    ),
                    _buildSidebarItem(
                      icon: FontAwesomeIcons.chartBar,
                      label: 'Rapports',
                      index: 3,
                    ),
                    _buildSidebarItem(
                      icon: FontAwesomeIcons.comments,
                      label: 'Messages',
                      index: 4,
                    ),
                    _buildSidebarItem(
                      icon: FontAwesomeIcons.users,
                      label: 'Clients',
                      index: 5,
                    ),
                    _buildSidebarItem(
                      icon: FontAwesomeIcons.robot,
                      label: 'Goly IA',
                      index: 6,
                    ),
                    _buildSidebarItem(
                      icon: FontAwesomeIcons.database,
                      label: 'Sauvegarde',
                      index: 7,
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border(top: BorderSide(color: borderGreen)),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: primaryGreen,
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: const Text(
                        'GO',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Rabetsara',
                            style: TextStyle(
                              color: primaryGreen,
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            'Goly@admin.com',
                            style: TextStyle(
                              color: textGray500,
                              fontSize: 13,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSidebarItem({
    required IconData icon,
    required String label,
    required int index,
  }) {
    final bool isActive = _tabController.index == index;
    return InkWell(
      onTap: () async {
        setState(() {
          _isSidebarVisible = false;
        });
        if ([1, 3, 4, 6, 7].contains(index)) {
          switch (index) {
            case 1:
              await _navigateToScreen(TasksScreen());
              break;
            case 3:
              await _navigateToScreen(const NotesScreen());
              break;
            case 4:
              await _navigateToScreen(const MessagesScreen());
              break;
            case 6:
              await _navigateToScreen(AgentsScreen());
              break;
            case 7:
              await _navigateToScreen(BackupScreen());
              break;
          }
        } else {
          _tabController.index = index;
        }
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          color: isActive ? primaryGreen.withOpacity(0.2) : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          border: isActive ? Border.all(color: primaryGreen, width: 1) : null,
        ),
        child: Row(
          children: [
            FaIcon(
              icon,
              size: 18,
              color: isActive ? primaryGreen : textGray300,
            ),
            const SizedBox(width: 16),
            Flexible(
              child: Text(
                label,
                style: TextStyle(
                  color: isActive ? primaryGreen : textGray300,
                  fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
                  fontSize: 16,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;
    return Scaffold(
      backgroundColor: bgBlack,
      appBar: isMobile ? _buildMobileAppBar() : _buildEmptyAppBar(),
      body: isMobile
          ? Stack(
              children: [
                TabBarView(
                  controller: _tabController,
                  children: [
                    _buildDashboardTab(),
                    TasksScreen(),
                    _buildPlaceholderTab('Projets'),
                    Container(),
                    const MessagesScreen(),
                    _buildPlaceholderTab('Clients'),
                    AgentsScreen(),
                    BackupScreen(),
                  ],
                ),
                if (_isSidebarVisible) _buildSidebar(),
              ],
            )
          : Row(
              children: [
                SizedBox(
                  width: 280,
                  child: _buildSidebar(),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 16,
                          horizontal: 24,
                        ),
                        decoration: BoxDecoration(
                          color: bgBlack,
                          border: Border(
                            bottom: BorderSide(color: borderGreen),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                'Dashboard Entreprise',
                                style: TextStyle(
                                  color: primaryGreen,
                                  fontWeight: FontWeight.w800,
                                  fontSize: 24,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Stack(
                                  clipBehavior: Clip.none,
                                  children: [
                                    IconButton(
                                      icon: FaIcon(
                                        FontAwesomeIcons.bell,
                                        color: primaryGreen,
                                      ),
                                      onPressed: () {},
                                    ),
                                    Positioned(
                                      right: 6,
                                      top: 6,
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 6,
                                          vertical: 2,
                                        ),
                                        decoration: BoxDecoration(
                                          color: primaryGreen,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Text(
                                          '3',
                                          style: TextStyle(
                                            color: bgBlack,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(width: 16),
                                CircleAvatar(
                                  backgroundColor: primaryGreen,
                                  radius: 20,
                                  child: Text(
                                    'AD',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        color: bgBlack,
                        child: TabBar(
                          controller: _tabController,
                          isScrollable: true,
                          indicatorColor: primaryGreen,
                          labelColor: primaryGreen,
                          unselectedLabelColor: textGray400,
                          labelStyle:
                              const TextStyle(fontWeight: FontWeight.w700),
                          unselectedLabelStyle:
                              const TextStyle(fontWeight: FontWeight.w500),
                          indicatorWeight: 3,
                          tabs: const [
                            Tab(text: 'Vue d\'ensemble'),
                            Tab(text: 'Tâches'),
                            Tab(text: 'Projets'),
                            Tab(text: 'Rapports'),
                            Tab(text: 'Messages'),
                            Tab(text: 'Clients'),
                            Tab(text: 'Goly IA'),
                            Tab(text: 'Sauvegarde'),
                          ],
                        ),
                      ),
                      Expanded(
                        child: TabBarView(
                          controller: _tabController,
                          children: [
                            _buildDashboardTab(),
                            TasksScreen(),
                            _buildPlaceholderTab('Projets'),
                            Container(),
                            const MessagesScreen(),
                            _buildPlaceholderTab('Clients'),
                            AgentsScreen(),
                            BackupScreen(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }

  Widget _buildDashboardTab() {
    return SingleChildScrollView(
      child: Column(
        children: [
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            childAspectRatio: 1.2,
            padding: const EdgeInsets.all(8),
            children: [
              _buildStatsCard(
                'Tâches Actives',
                FontAwesomeIcons.checkSquare,
                '24',
                '+2 depuis hier',
              ),
              _buildStatsCard(
                'Projets',
                FontAwesomeIcons.folderOpen,
                '8',
                '3 en cours',
              ),
              _buildStatsCard(
                'Messages',
                FontAwesomeIcons.comments,
                '12',
                '5 non lus',
              ),
              _buildStatsCard(
                'Revenus',
                FontAwesomeIcons.chartLine,
                '€95,000',
                '+15% ce mois',
              ),
            ],
          ),
          _buildAiAssistantCard(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Activité Récente',
                style: TextStyle(
                  color: primaryGreen,
                  fontWeight: FontWeight.w800,
                  fontSize: 18,
                ),
              ),
            ),
          ),
          ListView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.all(16),
            children: [
              _buildActivityItem('Nouvelle tâche assignée', 'Il y a 5 min'),
              _buildActivityItem('Rapport mensuel généré', 'Il y a 1h'),
              _buildActivityItem('Message de client reçu', 'Il y a 2h'),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Projets en Cours',
                style: TextStyle(
                  color: primaryGreen,
                  fontWeight: FontWeight.w800,
                  fontSize: 18,
                ),
              ),
            ),
          ),
          ListView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            children: [
              _buildProjectItem('Projet Alpha', 85, 'En cours', '15 Jan 2025'),
              _buildProjectItem('Refonte Site Web', 60, 'En cours', '28 Jan 2025'),
              _buildProjectItem('App Mobile', 30, 'Démarré', '15 Fév 2025'),
            ],
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildStatsCard(String title, IconData icon, String value, String change) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: borderGreen.withOpacity(0.8)),
      ),
      color: bgBlack,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Flexible(
                  child: Text(
                    title,
                    style: TextStyle(
                      color: primaryGreen,
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 8),
                FaIcon(icon, color: primaryGreen, size: 18),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              value,
              style: TextStyle(
                color: textGray300,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              change,
              style: TextStyle(
                color: primaryGreen,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    ).animate().fadeIn(duration: 500.ms).slideY(begin: 0.1, end: 0);
  }

  Widget _buildAiAssistantCard() {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: borderGreen.withOpacity(0.8)),
      ),
      color: bgBlack,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                FaIcon(FontAwesomeIcons.robot, color: primaryGreen, size: 20),
                const SizedBox(width: 8),
                Flexible(
                  child: Text(
                    'Goly - Assistant IA',
                    style: TextStyle(
                      color: primaryGreen,
                      fontWeight: FontWeight.w800,
                      fontSize: 18,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'Votre assistant intelligent pour optimiser votre productivité',
              style: TextStyle(color: textGray400, fontSize: 14),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Demandez à Goly...',
                      hintStyle: TextStyle(color: textGray500),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: borderGreen),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: primaryGreen),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                      filled: true,
                      fillColor: bgBlack.withOpacity(0.3),
                    ),
                    style: TextStyle(color: textGray300),
                  ),
                ),
                const SizedBox(width: 8),
                SizedBox(
                  height: 48,
                  width: 48,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryGreen,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {},
                    child: FaIcon(FontAwesomeIcons.paperPlane, size: 16),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              '💡 Suggestion: "Analysez les performances" ou "Créez un rapport"',
              style: TextStyle(
                color: textGray400,
                fontStyle: FontStyle.italic,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.1, end: 0);
  }

  Widget _buildActivityItem(String text, String time) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Container(
        width: 12,
        height: 12,
        decoration: BoxDecoration(
          color: primaryGreen,
          shape: BoxShape.circle,
        ),
      ),
      title: Text(
        text,
        style: TextStyle(
          color: textGray300,
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: Text(
        time,
        style: TextStyle(color: textGray500, fontSize: 12),
      ),
    );
  }

  Widget _buildProjectItem(String name, int progress, String status, String deadline) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      color: bgBlack,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(color: borderGreen.withOpacity(0.5)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    name,
                    style: TextStyle(
                      color: primaryGreen,
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text(
                  '$progress%',
                  style: TextStyle(
                    color: primaryGreen,
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: progress / 100,
                color: primaryGreen,
                backgroundColor: borderGreen.withOpacity(0.3),
                minHeight: 6,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    status,
                    style: TextStyle(color: textGray400, fontSize: 12),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text(
                  deadline,
                  style: TextStyle(color: textGray400, fontSize: 12),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlaceholderTab(String label) {
    return Center(
      child: Text(
        '$label - Contenu à implémenter',
        style: TextStyle(color: textGray400, fontSize: 16),
      ),
    );
  }
}
