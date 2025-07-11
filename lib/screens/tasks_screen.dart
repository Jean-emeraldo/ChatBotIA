import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

enum Priority { high, medium, low }

enum Status { todo, inProgress, done, planned }

extension PriorityExtension on Priority {
  String get label {
    switch (this) {
      case Priority.high:
        return 'Haute';
      case Priority.medium:
        return 'Moyenne';
      case Priority.low:
        return 'Basse';
    }
  }

  Color get color {
    switch (this) {
      case Priority.high:
        return Colors.red.shade400;
      case Priority.medium:
        return Colors.orange.shade400;
      case Priority.low:
        return Colors.green.shade400;
    }
  }

  IconData get icon {
    switch (this) {
      case Priority.high:
        return Icons.keyboard_arrow_up;
      case Priority.medium:
        return Icons.keyboard_arrow_right;
      case Priority.low:
        return Icons.keyboard_arrow_down;
    }
  }
}

extension StatusExtension on Status {
  String get label {
    switch (this) {
      case Status.todo:
        return 'À faire';
      case Status.inProgress:
        return 'En cours';
      case Status.done:
        return 'Terminé';
      case Status.planned:
        return 'Planifié';
    }
  }

  Color get color {
    switch (this) {
      case Status.todo:
        return Colors.blue.shade400;
      case Status.inProgress:
        return Colors.cyan.shade400;
      case Status.done:
        return Colors.green.shade400;
      case Status.planned:
        return Colors.purple.shade400;
    }
  }

  IconData get icon {
    switch (this) {
      case Status.todo:
        return Icons.radio_button_unchecked;
      case Status.inProgress:
        return Icons.autorenew;
      case Status.done:
        return Icons.check_circle;
      case Status.planned:
        return Icons.calendar_today;
    }
  }
}

class Task {
  final String title;
  final String assignee;
  final Priority priority;
  final Status status;
  final DateTime dueDate;

  Task({
    required this.title,
    required this.assignee,
    required this.priority,
    required this.status,
    required this.dueDate,
  });
}

class TaskItem extends StatefulWidget {
  final Task task;
  final int index;

  const TaskItem({super.key, required this.task, required this.index});

  @override
  State<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.02).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  bool get _enableHoverEffect => true;

  @override
  Widget build(BuildContext context) {
    Widget content = ScaleTransition(
      scale: _scaleAnimation,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {},
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFF1E1E1E),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: _isHovered
                  ? widget.task.status.color.withOpacity(0.5)
                  : Colors.grey.shade800,
              width: 1.5,
            ),
            boxShadow: _isHovered
                ? [
                    BoxShadow(
                      color: widget.task.status.color.withOpacity(0.2),
                      blurRadius: 10,
                      spreadRadius: 2,
                    )
                  ]
                : null,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildStatusIndicator(),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.task.title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 12,
                      runSpacing: 4,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 150),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                FontAwesomeIcons.user,
                                size: 14,
                                color: Colors.grey.shade500,
                              ),
                              const SizedBox(width: 4),
                              Flexible(
                                child: Text(
                                  widget.task.assignee,
                                  style: TextStyle(
                                    color: Colors.grey.shade500,
                                    fontSize: 14,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                        ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 100),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                FontAwesomeIcons.calendar,
                                size: 14,
                                color: Colors.grey.shade500,
                              ),
                              const SizedBox(width: 4),
                              Flexible(
                                child: Text(
                                  '${widget.task.dueDate.day}/${widget.task.dueDate.month}',
                                  style: TextStyle(
                                    color: Colors.grey.shade500,
                                    fontSize: 14,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Flexible(child: _buildPriorityBadge()),
              const SizedBox(width: 8),
              Flexible(child: _buildStatusBadge()),
            ],
          ),
        ),
      ),
    );

    if (_enableHoverEffect) {
      return MouseRegion(
        onEnter: (_) {
          setState(() => _isHovered = true);
          _controller.forward();
        },
        onExit: (_) {
          setState(() => _isHovered = false);
          _controller.reverse();
        },
        child: content,
      );
    } else {
      return content;
    }
  }

  Widget _buildStatusIndicator() {
    return Container(
      width: 6,
      height: 50,
      decoration: BoxDecoration(
        color: widget.task.status.color,
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }

  Widget _buildPriorityBadge() {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 120),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: widget.task.priority.color.withOpacity(0.2),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              widget.task.priority.icon,
              size: 16,
              color: widget.task.priority.color,
            ),
            const SizedBox(width: 6),
            Flexible(
              child: Text(
                widget.task.priority.label,
                style: TextStyle(
                  color: widget.task.priority.color,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusBadge() {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 120),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: widget.task.status.color.withOpacity(0.2),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              widget.task.status.icon,
              size: 16,
              color: widget.task.status.color,
            ),
            const SizedBox(width: 6),
            Flexible(
              child: Text(
                widget.task.status.label,
                style: TextStyle(
                  color: widget.task.status.color,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TasksScreen extends StatelessWidget {
  const TasksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gestion des Tâches'),
      ),
      body: ListView.builder(
        itemCount: 10,
        padding: const EdgeInsets.all(16),
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: TaskItem(
              task: Task(
                title: 'Tâche $index',
                assignee: 'Utilisateur $index',
                priority: Priority.values[index % Priority.values.length],
                status: Status.values[index % Status.values.length],
                dueDate: DateTime.now().add(Duration(days: index)),
              ),
              index: index,
            ),
          );
        },
      ),
    );
  }
}
