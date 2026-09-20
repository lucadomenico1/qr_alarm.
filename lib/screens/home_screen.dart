import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:alarm/alarm.dart' as alarm;
import 'qr_setup_screen.dart';
import '../services/database_service.dart';
import '../services/permission_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime? _selectedTime;
  String? _audioUri;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final settings = await DatabaseService.getSettings();
    if (settings != null) {
      setState(() {
        _selectedTime = settings.orario;
        _audioUri = settings.audioUri;
      });
    }
  }

  Future<void> _pickTime() async {
    final TimeOfDay? time = await showTimePicker(
      context: context,
      initialTime: _selectedTime != null
          ? TimeOfDay.fromDateTime(_selectedTime!)
          : TimeOfDay.now(),
    );

    if (time != null) {
      final now = DateTime.now();
      final selectedDateTime = DateTime(now.year, now.month, now.day, time.hour, time.minute);
      await DatabaseService.saveTime(selectedDateTime);
      setState(() {
        _selectedTime = selectedDateTime;
      });
    }
  }

  Future<void> _pickAudio() async {
    final result = await FilePicker.pickFile(
      type: FileType.custom,
      allowedExtensions: ['mp3', 'wav'],
    );

    if (result != null && result.path != null) {
      final path = result.path!;
      await DatabaseService.saveAudioUri(path);
      setState(() {
        _audioUri = path;
      });
    }
  }

  Future<void> _attivaSveglia() async {
    final hasPermissions = await PermissionService.requestCorePermissions();
    if (!hasPermissions) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Abilita tutti i permessi nelle impostazioni per usare la sveglia.')),
      );
      return;
    }

    final settings = await DatabaseService.getSettings();
    
    if (settings?.orario == null || settings?.audioUri == null) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Imposta orario e file audio prima di attivare la sveglia.')),
      );
      return;
    }

    if (settings?.secretQrCodeString == null || settings!.secretQrCodeString!.isEmpty) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Registra il QR di sblocco prima di attivare la sveglia.')),
      );
      return;
    }

    DateTime alarmTime = settings.orario!;
    final now = DateTime.now();
    // Reconstruct alarmTime to be today at the selected hours/minutes
    alarmTime = DateTime(now.year, now.month, now.day, alarmTime.hour, alarmTime.minute);
    
    if (alarmTime.isBefore(now)) {
      alarmTime = alarmTime.add(const Duration(days: 1));
    }

    final alarmSettings = alarm.AlarmSettings(
      id: 1, // Fixed ID since we have only one alarm
      dateTime: alarmTime,
      assetAudioPath: settings.audioUri!,
      loopAudio: true,
      vibrate: true,
      notificationSettings: const alarm.NotificationSettings(
        title: 'Sveglia',
        body: 'Scansiona il QR per disattivare!',
      ),
      volumeSettings: const alarm.VolumeSettings.fixed(
        volume: 1.0,
      ),
    );

    await alarm.Alarm.set(alarmSettings: alarmSettings);

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Sveglia impostata per le ${alarmTime.hour.toString().padLeft(2, '0')}:${alarmTime.minute.toString().padLeft(2, '0')}')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('QR Alarm'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                _selectedTime != null 
                  ? 'Orario: ${_selectedTime!.hour.toString().padLeft(2, '0')}:${_selectedTime!.minute.toString().padLeft(2, '0')}' 
                  : 'Nessun orario impostato',
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: _pickTime,
                child: const Text('Imposta Orario'),
              ),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Text(
                  _audioUri != null 
                    ? 'Audio: ${_audioUri!.split('/').last}' 
                    : 'Nessun audio selezionato',
                  style: const TextStyle(fontSize: 18),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: _pickAudio,
                child: const Text('Seleziona File Audio'),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const QrSetupScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                ),
                child: const Text('Registra QR di Sblocco'),
              ),
              const SizedBox(height: 50),
              ElevatedButton(
                onPressed: _attivaSveglia,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                  textStyle: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                child: const Text('Attiva Sveglia'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
