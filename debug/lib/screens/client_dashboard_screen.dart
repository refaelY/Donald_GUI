import 'package:flutter/material.dart';
import '../widgets/chats_view.dart';
import '../widgets/profile_view.dart';
import '../screens/manager_dashboard_screen.dart';
import '../widgets/bottom_nav.dart';

class ClientDashboardScreen extends StatefulWidget {
  final String userName;
  const ClientDashboardScreen({super.key, required this.userName});

  @override
  State<ClientDashboardScreen> createState() => _ClientDashboardScreenState();
}

class _ClientDashboardScreenState extends State<ClientDashboardScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _buildBody() {
    switch (_selectedIndex) {
      case 0:
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 18.0, bottom: 2),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  'ברוך הבא ${widget.userName}',
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
                  textAlign: TextAlign.right,
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.16,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(40, 4, 40, 8),
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
                        'סטטוס הבוט',
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
                            'הבוט זמין לשירותך! כאן תוכל לנהל שיחות, ליצור קבוצות ולערוך את הפרופיל שלך. השירות מתעדכן בזמן אמת.',
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
            ),
            Expanded(child: ChatsView(userName: widget.userName)),
          ],
        );
      case 1:
        return _buildCreateGroupTab();
      case 2:
        return Column(
          children: [
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
            Expanded(child: ProfileView(userName: widget.userName)),
          ],
        );
      default:
        return const SizedBox();
    }
  }

  Widget _buildCreateGroupTab() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.only(bottom: 24.0),
            child: Text(
              'כאן תוכל להוסיף קבוצה חדשה ולקבל בוט שינהל עבורך את השיחות, יאפשר מעקב, ניהול וייעול השירות שלך!',
              style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
          ElevatedButton.icon(
            icon: const Icon(Icons.group_add),
            label: const Text('צור קבוצה חדשה'),
            onPressed: () {
              // TODO: מימוש יצירת קבוצה
              showDialog(
                context: context,
                builder: (_) => const AlertDialog(
                  title: Text('יצירת קבוצה'),
                  content: Text('כאן יתווסף מימוש יצירת קבוצה'),
                ),
              );
            },
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            icon: const Icon(Icons.upgrade),
            label: const Text('הפוך לנותן שירות'),
            onPressed: () {
              // TODO: מימוש הפיכה לנותן שירות
              showDialog(
                context: context,
                builder: (_) => const AlertDialog(
                  title: Text('הפוך לנותן שירות'),
                  content: Text('כאן יתווסף מימוש הפיכה לנותן שירות'),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [
                Color.fromARGB(231, 5, 208, 63),
                Color.fromARGB(222, 0, 153, 255),
              ],
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          body: _buildBody(),
          bottomNavigationBar: BottomNav(
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
          ),
        ),
      ),
    );
  }
}
