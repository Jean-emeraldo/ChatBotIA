class AgentAIService {
  Future<String> analyzeEmail(String content) async {
    // Simule une analyse IA
    await Future.delayed(Duration(seconds: 2));
    if (content.contains("virement bancaire") || content.contains("cliquez ici")) {
      return "⚠️ Cet e-mail semble être du phishing.";
    }
    return "✅ Cet e-mail semble sain.";
  }

  Future<String> summarizeText(String text) async {
    // Simule un résumé de texte
    await Future.delayed(Duration(seconds: 1));
    return "Résumé : ${text.substring(0, text.length > 50 ? 50 : text.length)}...";
  }
}
