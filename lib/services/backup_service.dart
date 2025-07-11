class BackupService {
  Future<void> createBackup(String data) async {
    // Simule une sauvegarde distante
    await Future.delayed(Duration(seconds: 1));
    print("Sauvegarde créée : $data");
  }

  Future<void> restoreBackup() async {
    // Simule la restauration
    await Future.delayed(Duration(seconds: 1));
    print("Données restaurées avec succès.");
  }

  Future<List<String>> listBackups() async {
    // Simule une liste de sauvegardes
    return ['backup_01', 'backup_02'];
  }
}
