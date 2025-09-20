import 'package:flutter/material.dart';
import 'widgets/stateful_task_card.dart';
import 'widgets/add_task_modal.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Task App',
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blueAccent,
          brightness: Brightness.dark,
        ),
        brightness: Brightness.dark,
      ),
      home: TaskHomePage(
        isDarkMode: isDarkMode,
        onThemeToggle: () {
          setState(() {
            isDarkMode = !isDarkMode;
          });
        },
      ),
    );
  }
}

class TaskHomePage extends StatefulWidget {
  final bool isDarkMode;
  final VoidCallback onThemeToggle;

  const TaskHomePage({
    super.key,
    required this.isDarkMode,
    required this.onThemeToggle,
  });

  @override
  State<TaskHomePage> createState() => _TaskHomePageState();
}

class _TaskHomePageState extends State<TaskHomePage> {
  final List<Map<String, String>> tasks = [
  {
    'title': 'Finish Flutter exercise',
    'description': 'Complete the widget personalization and state management tasks.',
    'priority': 'High',
    'dueDate': 'Today',
    'assignee': 'You',
    'status': 'To Do',
  },
  {
    'title': 'Read Flutter docs',
    'description': 'Review widget fundamentals and state management.',
    'priority': 'Medium',
    'dueDate': 'Tomorrow',
    'assignee': 'You',
    'status': 'In Progress',
  },
  {
    'title': 'Group report professional communication',
    'description': 'Participate and review the report',
    'priority': 'High',
    'dueDate': 'Sept. 19, 2025',
    'assignee': 'Group',
    'status': 'Done',
  },
  {
    'title': 'Group project soft eng',
    'description': 'Participate make it good',
    'priority': 'Medium',
    'dueDate': 'Sept. 22, 2025',
    'assignee': 'Group',
    'status': 'To Do',
  },
  {
    'title': 'Group project info management',
    'description': 'Interview',
    'priority': 'Medium',
    'dueDate': 'Sept. 23, 2025',
    'assignee': 'Group',
    'status': 'In Progress',
  },
];

  @override
  Widget build(BuildContext context) {
    final int todoCount =
        tasks.where((t) => t['status']?.toLowerCase() == 'to do').length;
    final int inProgressCount =
        tasks.where((t) => t['status']?.toLowerCase() == 'in progress').length;
    final int doneCount =
        tasks.where((t) => t['status']?.toLowerCase() == 'done').length;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tasks'),
        actions: [
          IconButton(
            icon: Icon(widget.isDarkMode ? Icons.dark_mode : Icons.light_mode),
            onPressed: widget.onThemeToggle,
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          
          Card(
            color: Colors.pink.shade50,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            margin: const EdgeInsets.all(12),
            child: ListTile(
              leading: const CircleAvatar(
                radius: 24,
                child: Icon(Icons.person, size: 28),
              ),
              title: const Text(
                "Cresamdra Torio",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              subtitle: const Text("Student / App Developer"),
              trailing: ElevatedButton(
                onPressed: () async {
                  final newTask =
                      await showModalBottomSheet<Map<String, String>>(
                    context: context,
                    isScrollControlled: true,
                    builder: (context) => const AddTaskModal(),
                  );
                  if (newTask != null) {
                    setState(() {
                      newTask['status'] = 'To Do';
                      tasks.add(newTask);
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Task '${newTask['title']}' added!")),
                    );
                  }
                },
                child: const Text("Add task"),
              ),
            ),
          ),

          
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'MY TASK',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 12),

          
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.red.shade50,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 12,
                          height: 12,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('To Do ($todoCount)',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold)),
                          ],
                        ),
                        const Spacer(),
                        const Icon(Icons.more_horiz),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.orange.shade50,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 12,
                          height: 12,
                          decoration: BoxDecoration(
                            color: Colors.orange,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('In Progress ($inProgressCount)',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold)),
                          ],
                        ),
                        const Spacer(),
                        const Icon(Icons.more_horiz),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.green.shade50,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 12,
                          height: 12,
                          decoration: BoxDecoration(
                            color: Colors.green,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Done ($doneCount)',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold)),
                          ],
                        ),
                        const Spacer(),
                        const Icon(Icons.more_horiz),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text('Task List',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ),
          const SizedBox(height: 8),

          
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                final task = tasks[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: StatefulTaskCard(
                    title: task['title']!,
                    description: task['description']!,
                    priority: task['priority']!,
                    dueDate: task['dueDate'],
                    assignee: task['assignee'],
                  ),
                );
              },
            ),
          ),
        ],
      ),

      
      floatingActionButton: Builder(
        builder: (context) => FloatingActionButton(
          onPressed: () async {
            final newTask = await showModalBottomSheet<Map<String, String>>(
              context: context,
              isScrollControlled: true,
              builder: (context) => const AddTaskModal(),
            );
            if (newTask != null) {
              setState(() {
                newTask['status'] = 'To Do';
                tasks.add(newTask);
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Task '${newTask['title']}' added!")),
              );
            }
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
