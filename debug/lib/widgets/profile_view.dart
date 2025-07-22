// 📁 lib/widgets/profile_view.dart
import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../services/user_provider.dart';

class ProfileView extends StatefulWidget {
  final String userName;
  final Function(String newName)? onNameChanged;
  const ProfileView({super.key, required this.userName, this.onNameChanged});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _ageController;
  late TextEditingController _aboutController;
  bool _editing = false;
  bool _loading = false;
  String? _error;
  bool _initLoading = true;

  late UserProvider _userProvider;

  @override
  void initState() {
    super.initState();
    _userProvider = UserProvider();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _ageController = TextEditingController();
    _aboutController = TextEditingController();
    _loadProfile();
    _userProvider.addListener(_onUserChanged);
  }

  void _onUserChanged() {
    final user = _userProvider.user;
    if (user != null) {
      _nameController.text = user.name;
      _emailController.text = user.email;
      _ageController.text = user.age;
      _aboutController.text = user.about;
      setState(() {});
    }
  }

  Future<void> _loadProfile() async {
    setState(() { _initLoading = true; });
    try {
      final user = _userProvider.user;
      if (user != null) {
        _nameController.text = user.name;
        _emailController.text = user.email;
        _ageController.text = user.age;
        _aboutController.text = user.about;
      } else {
        _nameController.text = '';
        _emailController.text = '';
        _ageController.text = '';
        _aboutController.text = '';
      }
    } finally {
      setState(() { _initLoading = false; });
    }
  }

  @override
  void dispose() {
    _userProvider.removeListener(_onUserChanged);
    _nameController.dispose();
    _emailController.dispose();
    _ageController.dispose();
    _aboutController.dispose();
    super.dispose();
  }

  Future<void> _saveProfile() async {
    setState(() { _loading = true; _error = null; });
    try {
      // כאן יש להוסיף קריאה לשרת לעדכון פרטי המשתמש
      await Future.delayed(const Duration(milliseconds: 600));
      _userProvider.updateField(
        name: _nameController.text.trim(),
        email: _emailController.text.trim(),
        age: _ageController.text.trim(),
        about: _aboutController.text.trim(),
      );
      setState(() { _editing = false; });
      if (widget.onNameChanged != null) {
        widget.onNameChanged!(_nameController.text.trim());
      }
    } catch (e) {
      setState(() { _error = 'שגיאה: $e'; });
    } finally {
      setState(() { _loading = false; });
    }
  }


  @override
  Widget build(BuildContext context) {
    if (_initLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircleAvatar(radius: 60, backgroundColor: Color(0xFFEAF5F8)),
              ],
            ),
            const SizedBox(height: 20),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.lightBlueAccent.shade100, width: 2),
                borderRadius: BorderRadius.circular(12),
                color: Colors.white,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _profileRow(
                    icon: Icons.person,
                    label: 'שם משתמש',
                    value: _nameController.text,
                    controller: _nameController,
                    editing: _editing,
                  ),
                  const SizedBox(height: 8),
                  const Divider(
                    color: Color(0xFFB0BEC5),
                    thickness: 0.7,
                    height: 0,
                    indent: 0,
                    endIndent: 0,
                  ),
                  const SizedBox(height: 8),
                  _profileRow(
                    icon: Icons.email,
                    label: 'מייל',
                    value: _emailController.text,
                    controller: _emailController,
                    editing: _editing,
                  ),
                  const SizedBox(height: 8),
                  const Divider(
                    color: Color(0xFFB0BEC5),
                    thickness: 0.7,
                    height: 0,
                    indent: 0,
                    endIndent: 0,
                  ),
                  const SizedBox(height: 8),
                  _profileRow(
                    icon: Icons.cake,
                    label: 'גיל',
                    value: _ageController.text,
                    controller: _ageController,
                    editing: _editing,
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 8),
                  const Divider(
                    color: Color(0xFFB0BEC5),
                    thickness: 0.7,
                    height: 0,
                    indent: 0,
                    endIndent: 0,
                  ),
                  const SizedBox(height: 8),
                  _profileRow(
                    icon: Icons.info_outline,
                    label: 'על עצמי',
                    value: _aboutController.text,
                    controller: _aboutController,
                    editing: _editing,
                    maxLines: 3,
                  ),
                  if (_error != null) ...[
                    const SizedBox(height: 8),
                    Text(_error!, style: const TextStyle(color: Colors.red), textDirection: TextDirection.rtl),
                  ],
                  const SizedBox(height: 8),
                  _editing
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: _loading ? null : _saveProfile,
                              child: _loading ? const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2)) : const Text('שמור', textDirection: TextDirection.rtl),
                            ),
                            TextButton(
                              onPressed: _loading ? null : () => setState(() => _editing = false),
                              child: const Text('ביטול', textDirection: TextDirection.rtl),
                            ),
                          ],
                        )
                      : Align(
                          alignment: Alignment.center,
                          child: TextButton.icon(
                            onPressed: () => setState(() => _editing = true),
                            icon: const Icon(Icons.edit),
                            label: const Text('ערוך', textDirection: TextDirection.rtl),
                          ),
                        ),
                ],
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _profileRow({
    required IconData icon,
    required String label,
    required String value,
    required TextEditingController controller,
    required bool editing,
    int maxLines = 1,
    TextInputType? keyboardType,
  }) {
    final isAbout = label == 'על עצמי';
    final user = _userProvider.user;
    String displayValue = value;
    if (!editing && user != null) {
      if (label == 'שם משתמש') displayValue = user.name;
      else if (label == 'מייל') displayValue = user.email;
      else if (label == 'גיל') displayValue = user.age;
      else if (label == 'על עצמי') displayValue = user.about;
    }
    return Row(
      crossAxisAlignment: isAbout ? CrossAxisAlignment.center : (maxLines > 1 ? CrossAxisAlignment.start : CrossAxisAlignment.center),
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('$label:', style: const TextStyle(fontWeight: FontWeight.bold), textDirection: TextDirection.rtl),
        const SizedBox(width: 8),
        Expanded(
          child: editing
              ? TextFormField(
                  controller: controller,
                  maxLines: maxLines,
                  keyboardType: keyboardType,
                  decoration: InputDecoration(
                    labelText: label,
                    border: const OutlineInputBorder(),
                  ),
                  textDirection: TextDirection.rtl,
                  textAlign: TextAlign.right,
                )
              : Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6.0),
                  child: Text(
                    displayValue.isEmpty ? '---' : displayValue,
                    style: const TextStyle(fontSize: 16),
                    textAlign: TextAlign.right,
                    textDirection: TextDirection.rtl,
                  ),
                ),
        ),
        const SizedBox(width: 12),
        isAbout
            ? Align(
                alignment: Alignment.center,
                child: Icon(icon, color: Colors.blueGrey, size: 28),
              )
            : Icon(icon, color: Colors.blueGrey, size: 28),
      ],
    );
  }

  Widget _infoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Flexible(child: Text(value, textAlign: TextAlign.right, textDirection: TextDirection.rtl)),
        const SizedBox(width: 8),
        Text('$label:', style: const TextStyle(fontWeight: FontWeight.bold), textDirection: TextDirection.rtl),
      ],
    );
  }
}
