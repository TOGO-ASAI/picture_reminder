import 'package:flutter/material.dart';
import 'app/routes.dart';
import 'package:provider/provider.dart';
import 'screens/db_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => MyAppState(),
        child: MaterialApp(
          title: 'Sphere App',
          initialRoute: AppRoutes.gallery,
          onGenerateRoute: AppRoutes.generateRoute,
          theme: ThemeData(
            fontFamily: 'NotoSansJP',
            useMaterial3: true,
          ),
          home: const BottomNavigation(),
        ));
  }
}

class MyAppState extends ChangeNotifier {
  var selectedIndex = 1;

  void changePage(int index) {
    selectedIndex = index;
    notifyListeners();
  }
}

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    return Scaffold(
      body: SafeArea(
        child: Navigator(
          key: _navigatorKey,
          initialRoute: AppRoutes.gallery,
          onGenerateRoute: AppRoutes.generateRoute,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) => const ModalSheetContent(),
          );
        },
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: SafeArea(
        child: BottomAppBar(
          child: Padding(
            padding: const EdgeInsets.all(0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    appState.changePage(0);
                    _navigatorKey.currentState
                        ?.pushReplacementNamed(AppRoutes.schedule);
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.calendar_today,
                        size: 24,
                        color: appState.selectedIndex == 0
                            ? Colors.deepOrange
                            : null,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        '予定',
                        style: TextStyle(
                          fontSize: 12,
                          color: appState.selectedIndex == 0
                              ? Colors.deepOrange
                              : null,
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    appState.changePage(1);
                    _navigatorKey.currentState
                        ?.pushReplacementNamed(AppRoutes.gallery);
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.photo_album,
                        size: 24,
                        color: appState.selectedIndex == 1
                            ? Colors.deepOrange
                            : null,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'アルバム',
                        style: TextStyle(
                          fontSize: 12,
                          color: appState.selectedIndex == 1
                              ? Colors.deepOrange
                              : null,
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    appState.changePage(2);
                    _navigatorKey.currentState
                        ?.pushReplacementNamed(AppRoutes.settings);
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.settings,
                        size: 24,
                        color: appState.selectedIndex == 2
                            ? Colors.deepOrange
                            : null,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        '設定',
                        style: TextStyle(
                          fontSize: 12,
                          color: appState.selectedIndex == 2
                              ? Colors.deepOrange
                              : null,
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    appState.changePage(3);
                    _navigatorKey.currentState
                        ?.pushReplacementNamed(AppRoutes.db);
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.table_chart,
                        size: 24,
                        color: appState.selectedIndex == 3
                            ? Colors.deepOrange
                            : null,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'DB',
                        style: TextStyle(
                          fontSize: 12,
                          color: appState.selectedIndex == 3
                              ? Colors.deepOrange
                              : null,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ModalSheetContent extends StatefulWidget {
  const ModalSheetContent({Key? key}) : super(key: key);

  @override
  State<ModalSheetContent> createState() => _ModalSheetContentState();
}

class _ModalSheetContentState extends State<ModalSheetContent> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? now,
      firstDate: now,
      lastDate: DateTime(now.year + 5),
    );
    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  Future<void> _pickTime() async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: _selectedTime ?? TimeOfDay.now(),
    );
    if (pickedTime != null) {
      setState(() {
        _selectedTime = pickedTime;
      });
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate() &&
        _selectedDate != null &&
        _selectedTime != null) {
      final reminderDateTime = DateTime(
        _selectedDate!.year,
        _selectedDate!.month,
        _selectedDate!.day,
        _selectedTime!.hour,
        _selectedTime!.minute,
      );
      print('Title: ${_titleController.text}');
      print('Description: ${_descriptionController.text}');
      print('Reminder Date and Time: $reminderDateTime');
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(28.0),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Title'),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Description'),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      _selectedDate == null
                          ? 'No date selected'
                          : 'Date: ${_selectedDate!.toLocal().toString().split(' ')[0]}',
                    ),
                  ),
                  TextButton(
                    onPressed: _pickDate,
                    child: const Text('Select Date'),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      _selectedTime == null
                          ? 'No time selected'
                          : 'Time: ${_selectedTime!.format(context)}',
                    ),
                  ),
                  TextButton(
                    onPressed: _pickTime,
                    child: const Text('Select Time'),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _submitForm,
                child: const Text('Save Reminder'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
