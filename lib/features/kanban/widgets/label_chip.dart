import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/kanban_providers.dart';
import '../models/simple_models.dart';

class TaskLabelChip extends ConsumerWidget {
  final String labelId;
  final bool showText;
  
  const TaskLabelChip({
    super.key,
    required this.labelId,
    this.showText = true,
  });
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final boardId = ref.watch(selectedBoardIdProvider);
    if (boardId == null) return const SizedBox.shrink();
    
    // In a real app, we'd have a provider for labels
    // For now, we'll use mock data
    final label = _getMockLabel(labelId);
    
    final color = Color(int.parse(label.color.replaceFirst('#', '0xFF')));
    
    return Container(
      height: showText ? 20 : 6,
      padding: showText ? const EdgeInsets.symmetric(horizontal: 8) : null,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(showText ? 10 : 3),
      ),
      child: showText
          ? Center(
              child: Text(
                label.name,
                style: TextStyle(
                  color: _getTextColor(color),
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            )
          : null,
    );
  }
  
  TaskLabel _getMockLabel(String labelId) {
    // Mock label data
    final labels = {
      'label1': TaskLabel(
        id: 'label1',
        name: 'Bug',
        color: '#F44336',
        boardId: 'board1',
      ),
      'label2': TaskLabel(
        id: 'label2',
        name: 'Feature',
        color: '#4CAF50',
        boardId: 'board1',
      ),
      'label3': TaskLabel(
        id: 'label3',
        name: 'Enhancement',
        color: '#2196F3',
        boardId: 'board1',
      ),
      'label4': TaskLabel(
        id: 'label4',
        name: 'Documentation',
        color: '#FF9800',
        boardId: 'board1',
      ),
      'label5': TaskLabel(
        id: 'label5',
        name: 'High Priority',
        color: '#E91E63',
        boardId: 'board1',
      ),
    };
    
    return labels[labelId] ?? TaskLabel(
      id: labelId,
      name: 'Unknown',
      color: '#9E9E9E',
      boardId: 'board1',
    );
  }
  
  Color _getTextColor(Color backgroundColor) {
    // Calculate luminance to determine if text should be light or dark
    final luminance = backgroundColor.computeLuminance();
    return luminance > 0.5 ? Colors.black : Colors.white;
  }
}