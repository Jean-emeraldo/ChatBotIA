class MessageService {
  Future<void> sendMessage(String content) async {
    // Simule l’envoi d’un message
    await Future.delayed(Duration(milliseconds: 500));
    print("Message envoyé : $content");
  }

  Future<List<String>> fetchMessages() async {
    // Simule la récupération des messages
    return [
      "Bonjour, comment puis-je vous aider ?",
      "IA : Analyse en cours..."
    ];
  }
}
