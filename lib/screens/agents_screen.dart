import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AgentsScreen extends StatefulWidget {
  const AgentsScreen({Key? key}) : super(key: key);

  @override
  State<AgentsScreen> createState() => _AgentsScreenState();
}

class _AgentsScreenState extends State<AgentsScreen> {
  final TextEditingController _chatController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  List<ChatMessage> _messages = [];

  @override
  void initState() {
    super.initState();
    _messages.add(
      ChatMessage(
        text: "Bonjour ! Je suis Goly, votre assistant IA. Comment puis-je vous aider aujourd'hui ?",
        isUser: false,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agents IA'),
        backgroundColor: const Color(0xFF0F0F0F),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      backgroundColor: const Color(0xFF0F0F0F),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                const Color(0xFF22C55E).withOpacity(0.15),
                const Color(0xFF22C55E).withOpacity(0.05),
              ],
            ),
            border: Border.all(
              color: const Color(0xFF22C55E).withOpacity(0.3),
              width: 1,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildMainLayout(),
                    const SizedBox(height: 24),
                    _buildQuickActions(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Color(0xFF22C55E),
            width: 0.5,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.smart_toy,
                color: const Color(0xFF22C55E),
                size: 28,
              ),
              const SizedBox(width: 12),
              Expanded( // Ajouté Expanded pour éviter overflow
                child: const Text(
                  'Goly - Assistant IA Entreprise',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF22C55E),
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Text(
            'Votre partenaire intelligent pour optimiser votre entreprise',
            style: TextStyle(
              fontSize: 16,
              color: Color(0xFFD1D5DB),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMainLayout() {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 800) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: _buildCapabilities()),
              const SizedBox(width: 24),
              Expanded(child: _buildChatSection()),
            ],
          );
        } else {
          return Column(
            children: [
              _buildCapabilities(),
              const SizedBox(height: 24),
              _buildChatSection(),
            ],
          );
        }
      },
    );
  }

  Widget _buildCapabilities() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Capacités de Goly',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 16),
        Column(
          children: [
            _buildCapabilityItem(FontAwesomeIcons.chartBar, 'Analyse de données avancée'),
            const SizedBox(height: 12),
            _buildCapabilityItem(FontAwesomeIcons.chartLine, 'Prédictions de tendances'),
            const SizedBox(height: 12),
            _buildCapabilityItem(FontAwesomeIcons.fileText, 'Génération de rapports'),
            const SizedBox(height: 12),
            _buildCapabilityItem(FontAwesomeIcons.checkSquare, 'Optimisation des tâches'),
          ],
        ),
      ],
    );
  }

  Widget _buildCapabilityItem(IconData icon, String text) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.5),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          FaIcon(
            icon,
            color: const Color(0xFF22C55E),
            size: 20,
          ),
          const SizedBox(width: 12),
          Expanded( // Ajouté Expanded pour éviter overflow
            child: Text(
              text,
              style: const TextStyle(
                color: Color(0xFFD1D5DB),
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChatSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Chat avec Goly',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 16),
        Container(
          height: 256,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.5),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  controller: _scrollController,
                  itemCount: _messages.length,
                  itemBuilder: (context, index) {
                    return _buildMessage(_messages[index]);
                  },
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _chatController,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: 'Posez une question à Goly...',
                        hintStyle: const TextStyle(color: Color(0xFF9CA3AF)),
                        filled: true,
                        fillColor: const Color(0xFF1F2937),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(color: Color(0xFF22C55E)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(color: Color(0xFF22C55E)),
                        ),
                        contentPadding: const EdgeInsets.all(12),
                      ),
                      onSubmitted: (value) => _sendMessage(),
                    ),
                  ),
                  const SizedBox(width: 8),
                  SizedBox(
                    height: 48,
                    width: 48,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF22C55E),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: EdgeInsets.zero,
                      ),
                      onPressed: _sendMessage,
                      child: const Icon(
                        Icons.send,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMessage(ChatMessage message) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: message.isUser ? const Color(0xFF6B7280) : const Color(0xFF22C55E),
              borderRadius: BorderRadius.circular(16),
            ),
            child: FaIcon(
              message.isUser ? FontAwesomeIcons.user : FontAwesomeIcons.robot,
              color: Colors.black,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: message.isUser
                    ? const Color(0xFF374151)
                    : const Color(0xFF22C55E).withOpacity(0.15),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                message.text,
                style: TextStyle(
                  color: message.isUser ? Colors.white : const Color(0xFF86EFAC),
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Actions rapides',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 16),
        LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth > 800) {
              return Row(
                children: [
                  Expanded(child: _buildActionButton('Analyser les performances')),
                  const SizedBox(width: 16),
                  Expanded(child: _buildActionButton('Générer un rapport')),
                  const SizedBox(width: 16),
                  Expanded(child: _buildActionButton('Optimiser les tâches')),
                ],
              );
            } else {
              return Column(
                children: [
                  _buildActionButton('Analyser les performances'),
                  const SizedBox(height: 16),
                  _buildActionButton('Générer un rapport'),
                  const SizedBox(height: 16),
                  _buildActionButton('Optimiser les tâches'),
                ],
              );
            }
          },
        ),
      ],
    );
  }

  Widget _buildActionButton(String text) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        onPressed: () => _handleQuickAction(text),
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: Color(0xFF22C55E)),
          backgroundColor: Colors.transparent,
          foregroundColor: const Color(0xFF22C55E),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(fontSize: 14),
        ),
      ),
    );
  }

  void _sendMessage() {
    final text = _chatController.text.trim();
    if (text.isEmpty) return;
    setState(() {
      _messages.add(ChatMessage(text: text, isUser: true));
      _chatController.clear();
    });
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _messages.add(ChatMessage(
          text: "Merci pour votre question ! Je traite votre demande...",
          isUser: false,
        ));
      });
    });
    Future.delayed(const Duration(milliseconds: 100), () {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  void _handleQuickAction(String action) {
    setState(() {
      _messages.add(ChatMessage(text: action, isUser: true));
      _messages.add(ChatMessage(
        text: "J'ai bien reçu votre demande : $action. Je commence le traitement...",
        isUser: false,
      ));
    });
  }

  @override
  void dispose() {
    _chatController.dispose();
    _scrollController.dispose();
    super.dispose();
  }
}

class ChatMessage {
  final String text;
  final bool isUser;
  final DateTime timestamp;

  ChatMessage({
    required this.text,
    required this.isUser,
    DateTime? timestamp,
  }) : timestamp = timestamp ?? DateTime.now();
}
