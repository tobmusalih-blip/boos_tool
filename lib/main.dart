import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(const BOOSToolApp());
}

class BOOSToolApp extends StatelessWidget {
  const BOOSToolApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BOOS Tool',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF07030A),
        primaryColor: const Color(0xFFD50000),
        colorScheme: ColorScheme.dark(
          primary: const Color(0xFFD50000),
          secondary: const Color(0xFF9C27B0),
          surface: const Color(0xFF12081C),
        ),
      ),
      home: const SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  String _displayedText = "";
  final String _fullText = "SYSTEM INITIALIZED: BOOS TOOL ACTIVE.";
  int _charIndex = 0;
  Timer? _typingTimer;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat();

    _startTypingEffect();
  }

  void _startTypingEffect() {
    _typingTimer = Timer.periodic(const Duration(milliseconds: 50), (timer) {
      if (_charIndex < _fullText.length) {
        setState(() {
          _displayedText += _fullText[_charIndex];
          _charIndex++;
        });
      } else {
        timer.cancel();
        Timer(const Duration(seconds: 2), () {
          if (mounted) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const MainScreen()),
            );
          }
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _typingTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF050207),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Transform.rotate(
                  angle: _controller.value * 2 * 3.14159,
                  child: child,
                );
              },
              child: Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: const Color(0xFFD50000), width: 3),
                  gradient: const LinearGradient(
                    colors: [Color(0xFF1F0924), Color(0xFF520707)],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFD50000).withOpacity(0.8),
                      blurRadius: 25,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.dangerous_rounded,
                  size: 70,
                  color: Color(0xFFFF5252),
                ),
              ),
            ),
            const SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Text(
                _displayedText,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Color(0xFFFF5252),
                  fontSize: 18,
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1.5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  String? _selectedSource = 'WhatsApp الرسمي';
  String? _selectedTarget = 'واتساب عمر (OBWhatsApp)';
  bool _keepBackup = true;
  
  final List<String> _sourcePackages = [
    'WhatsApp الرسمي',
    'WhatsApp Business',
  ];

  final List<String> _targetPackages = [
    'واتساب عمر (OBWhatsApp)',
    'واتساب بلس (GBWhatsApp)',
    'واتساب الذهبي (ADWhatsApp)',
  ];

  final String _terminalLogs = ">> [BOOS_CORE] Ready for aggressive remapping...
>> Status: Target paths secured.
>> Awaiting command execution...";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'BOOS TOOL', 
          style: TextStyle(fontWeight: FontWeight.w900, letterSpacing: 2, fontSize: 22, color: Color(0xFFFF5252))
        ),
        backgroundColor: const Color(0xFF12081C),
        elevation: 4,
        shadowColor: const Color(0xFFD50000),
        centerTitle: true,
      ),
      drawer: Drawer(
        backgroundColor: const Color(0xFF07030A),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Color(0xFF12081C),
                border: Border(bottom: BorderSide(color: Color(0xFFD50000), width: 2)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 65,
                    height: 65,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: const Color(0xFFD50000), width: 2),
                      color: const Color(0xFF1F0924),
                    ),
                    child: const Icon(Icons.bolt, size: 40, color: Color(0xFFFF5252)),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'BOOS TOOL v1.3',
                    style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w900, letterSpacing: 1.5),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.send, color: Color(0xFFFF5252)),
              title: const Text('قناة تلجرام الرسمية', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15)),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.info_outline, color: Color(0xFFFF5252)),
              title: const Text('معلومات التطبيق', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15)),
              onTap: () {
                showAboutDialog(
                  context: context,
                  applicationName: 'BOOS Tool',
                  applicationVersion: '1.3 - Aggressive Edition',
                  applicationLegallyResponsible: 'Omar',
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings, color: Color(0xFFFF5252)),
              title: const Text('الإعدادات المتقدمة', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15)),
              onTap: () {},
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text('CHOOSE SOURCE PACKAGE:', style: TextStyle(color: Color(0xFFFF5252), fontSize: 14, fontWeight: FontWeight.w900, letterSpacing: 1)),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: const Color(0xFF12081C),
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: const Color(0xFFD50000), width: 2),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: _selectedSource,
                  dropdownColor: const Color(0xFF12081C),
                  isExpanded: true,
                  items: _sourcePackages.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15)),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      _selectedSource = newValue;
                    });
                  },
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text('TARGET MODDED PACKAGE:', style: TextStyle(color: Color(0xFFFF5252), fontSize: 14, fontWeight: FontWeight.w900, letterSpacing: 1)),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: const Color(0xFF12081C),
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: const Color(0xFFD50000), width: 2),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: _selectedTarget,
                  dropdownColor: const Color(0xFF12081C),
                  isExpanded: true,
                  items: _targetPackages.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15)),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      _selectedTarget = newValue;
                    });
                  },
                ),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0xFF12081C),
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: Colors.white24, width: 1.5),
              ),
              child: SwitchListTile(
                title: const Text('AUTO BACKUP ON FAILURE', style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w900, letterSpacing: 0.5)),
                subtitle: const Text('حفظ مسار طوارئ لاستعادة البيانات فوريًا', style: TextStyle(color: Colors.white54, fontSize: 11, fontWeight: FontWeight.bold)),
                value: _keepBackup,
                activeColor: const Color(0xFFD50000),
                onChanged: (bool value) {
                  setState(() {
                    _keepBackup = value;
                  });
                },
              ),
            ),
            const SizedBox(height: 20),
            const Text('TERMINAL LOGS:', style: TextStyle(color: Color(0xFFFF5252), fontSize: 14, fontWeight: FontWeight.w900, letterSpacing: 1)),
            const SizedBox(height: 8),
            Container(
              height: 150,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: Colors.greenAccent, width: 1.5),
              ),
              child: SingleChildScrollView(
                child: Text(
                  _terminalLogs,
                  style: const TextStyle(
                    color: Colors.greenAccent,
                    fontFamily: 'monospace',
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 25),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFD50000),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 18),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
                elevation: 12,
                shadowColor: const Color(0xFFD50000),
              ),
              onPressed: () {},
              child: const Text(
                '⚡ EXECUTE REMAP & MIGRATION ⚡',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900, letterSpacing: 1.5),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
