import 'package:flutter/material.dart';
import 'package:debug/widgets/bottom_nav.dart';
import '../widgets/chats_view.dart';
import '../widgets/clients_view.dart';
import '../widgets/profile_view.dart';

class ManagerDashboardScreen extends StatefulWidget {
  final String userName;
  const ManagerDashboardScreen({super.key, required this.userName});

  @override
  State<ManagerDashboardScreen> createState() => _ManagerDashboardScreenState();
}

class _ManagerDashboardScreenState extends State<ManagerDashboardScreen> {
  int _selectedIndex = 0;

  Widget _buildBody() {
    switch (_selectedIndex) {
      case 0:
        return ChatsView(userName: widget.userName);
      case 1:
        return ClientsView(userName: widget.userName);
      case 2:
        return ProfileView(userName: widget.userName);
      default:
        return const SizedBox();
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [Color(0xFFF26B3A), Color(0xFF3CA4DC)],
            ),
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent, // חשוב!
          body: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [Color(0xFFF26B3A), Color(0xFF3CA4DC)],
              ),
            ),
            child: SafeArea(
              child: Column(
                children: [
                  if (_selectedIndex == 0)
                    Padding(
                      padding: const EdgeInsets.only(top: 18.0, bottom: 4),
                      child: Text(
                        'ברוכים הבאים ${widget.userName}',
                        style: const TextStyle(
                          fontSize: 39,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          shadows: [
                            Shadow(
                              color: Colors.black26,
                              blurRadius: 4,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  if (_selectedIndex == 0)
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.20,
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(40, 8, 40, 12),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.95),
                            borderRadius: BorderRadius.circular(14),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.07),
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          padding: const EdgeInsets.all(18),
                          child: const Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'סטטוס מתעדכן',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blueGrey,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(height: 8),
                              Expanded(
                                child: SingleChildScrollView(
                                  child: Text(
                                    'ברוכים הבאים למערכת הניהול! כאן תוכלו לנהל את כל השיחות, הלקוחות וההגדרות שלכם בצורה פשוטה, נוחה ומהירה. המערכת מאפשרת לכם לעקוב אחרי כל מה שקורה בעסק, לשמור על קשר עם הלקוחות, ולשפר את השירות שלכם בכל רגע נתון. בהצלחה!',
                                    style: TextStyle(
                                      fontSize: 17,
                                      color: Colors.black87,
                                      height: 1.5,
                                    ),
                                    textAlign: TextAlign.center,
                                    maxLines: 8,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  else
                    Padding(
                      padding: const EdgeInsets.only(top: 18.0, bottom: 12),
                      child: Text(
                        'המשתמש של ${widget.userName}',
                        style: const TextStyle(
                          fontSize: 39,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  Expanded(child: _buildBody()),
                ],
              ),
            ),
          ),
          bottomNavigationBar: BottomNav(
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
          ),
        ),
      ],
    );
  }
}
