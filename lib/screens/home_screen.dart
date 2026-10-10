import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
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
  bool _isQrConfigured = false;

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
        _isQrConfigured = settings.secretQrCodeString != null && settings.secretQrCodeString!.isNotEmpty;
      });
    }
  }

  Future<void> _pickTime() async {
    DateTime tempTime = _selectedTime ?? DateTime.now();
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1C1C1E),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext builder) {
        return SizedBox(
          height: 300,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CupertinoButton(
                    child: const Text('Annulla', style: TextStyle(color: Colors.orange)),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  CupertinoButton(
                    child: const Text('Fine', style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold)),
                    onPressed: () async {
                      Navigator.of(context).pop();
                      final now = DateTime.now();
                      final selectedDateTime = DateTime(now.year, now.month, now.day, tempTime.hour, tempTime.minute);
                      await DatabaseService.saveTime(selectedDateTime);
                      setState(() {
                        _selectedTime = selectedDateTime;
                      });
                    },
                  ),
                ],
              ),
              Expanded(
                child: CupertinoTheme(
                  data: const CupertinoThemeData(
                    brightness: Brightness.dark,
                  ),
                  child: CupertinoDatePicker(
                    mode: CupertinoDatePickerMode.time,
                    initialDateTime: tempTime,
                    use24hFormat: true,
                    onDateTimeChanged: (DateTime newDateTime) {
                      tempTime = newDateTime;
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
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
      SnackBar(
        content: Text('Sveglia impostata per le ${alarmTime.hour.toString().padLeft(2, '0')}:${alarmTime.minute.toString().padLeft(2, '0')}'),
        backgroundColor: Colors.green.shade800,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
          'Sveglie',
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.black,
        elevation: 0,
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 40),
            Center(
              child: GestureDetector(
                onTap: _pickTime,
                child: Text(
                  _selectedTime != null 
                    ? '${_selectedTime!.hour.toString().padLeft(2, '0')}:${_selectedTime!.minute.toString().padLeft(2, '0')}' 
                    : '00:00',
                  style: const TextStyle(
                    fontSize: 85,
                    fontWeight: FontWeight.w200,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40),
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFF1C1C1E),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  ListTile(
                    title: const Text('Suono', style: TextStyle(color: Colors.white, fontSize: 18)),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          width: 150,
                          child: Text(
                            _audioUri != null ? _audioUri!.split('/').last : 'Seleziona',
                            style: const TextStyle(color: Colors.grey, fontSize: 16),
                            textAlign: TextAlign.right,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const Icon(Icons.chevron_right, color: Colors.grey),
                      ],
                    ),
                    onTap: _pickAudio,
                  ),
                  const Divider(color: Color(0xFF38383A), height: 1, indent: 16),
                  ListTile(
                    title: const Text('Codice QR', style: TextStyle(color: Colors.white, fontSize: 18)),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          _isQrConfigured ? 'Configurato' : 'Registra',
                          style: const TextStyle(color: Colors.grey, fontSize: 16),
                        ),
                        const Icon(Icons.chevron_right, color: Colors.grey),
                      ],
                    ),
                    onTap: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const QrSetupScreen()),
                      );
                      _loadSettings(); // Reload to check if QR was set
                    },
                  ),
                ],
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _attivaSveglia,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Attiva Sveglia',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
