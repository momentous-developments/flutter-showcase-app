import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/kanban_providers.dart';
import '../models/simple_models.dart';
import '../widgets/board_card.dart';

class BoardListView extends ConsumerWidget {
  const BoardListView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final boardsAsync = ref.watch(boardListProvider);
    
    return boardsAsync.when(
      data: (boards) => boards.isEmpty
          ? _buildEmptyState(context, ref)
          : _buildBoardGrid(context, ref, boards),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 48, color: Colors.red),
            const SizedBox(height: 16),
            Text('Error: $error'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => ref.refresh(boardListProvider),
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildEmptyState(BuildContext context, WidgetRef ref) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.dashboard_outlined,
            size: 64,
            color: Theme.of(context).colorScheme.outline,
          ),
          const SizedBox(height: 16),
          Text(
            'No boards yet',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 8),
          Text(
            'Create your first board to get started',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
          ),
          const SizedBox(height: 24),
          FilledButton.icon(
            onPressed: () => _showCreateBoardDialog(context, ref),
            icon: const Icon(Icons.add),
            label: const Text('Create Board'),
          ),
        ],
      ),
    );
  }
  
  Widget _buildBoardGrid(BuildContext context, WidgetRef ref, List<Board> boards) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'My Boards',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                FilledButton.icon(
                  onPressed: () => _showCreateBoardDialog(context, ref),
                  icon: const Icon(Icons.add),
                  label: const Text('New Board'),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final crossAxisCount = constraints.maxWidth > 1200
                      ? 4
                      : constraints.maxWidth > 800
                          ? 3
                          : constraints.maxWidth > 500
                              ? 2
                              : 1;
                  
                  return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: 1.5,
                    ),
                    itemCount: boards.length,
                    itemBuilder: (context, index) {
                      final board = boards[index];
                      return BoardCard(
                        board: board,
                        onTap: () {
                          ref.read(selectedBoardIdProvider.notifier).state = board.id;
                          ref.read(currentBoardProvider.notifier).loadBoard(board.id);
                        },
                        onEdit: () => _showEditBoardDialog(context, ref, board),
                        onDelete: () => _confirmDeleteBoard(context, ref, board),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  void _showCreateBoardDialog(BuildContext context, WidgetRef ref) {
    final titleController = TextEditingController();
    final descriptionController = TextEditingController();
    String selectedTemplate = 'default';
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Create New Board'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: titleController,
                autofocus: true,
                decoration: const InputDecoration(
                  labelText: 'Board Title',
                  hintText: 'Enter board title',
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Description (optional)',
                  hintText: 'Enter board description',
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 16),
              const Text(
                'Template',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              StatefulBuilder(
                builder: (context, setState) => Column(
                  children: [
                    RadioListTile(
                      title: const Text('Default'),
                      subtitle: const Text('Basic kanban board with standard columns'),
                      value: 'default',
                      groupValue: selectedTemplate,
                      onChanged: (value) => setState(() => selectedTemplate = value!),
                    ),
                    RadioListTile(
                      title: const Text('Software Development'),
                      subtitle: const Text('Optimized for software projects'),
                      value: 'software',
                      groupValue: selectedTemplate,
                      onChanged: (value) => setState(() => selectedTemplate = value!),
                    ),
                    RadioListTile(
                      title: const Text('Marketing'),
                      subtitle: const Text('Perfect for marketing campaigns'),
                      value: 'marketing',
                      groupValue: selectedTemplate,
                      onChanged: (value) => setState(() => selectedTemplate = value!),
                    ),
                    RadioListTile(
                      title: const Text('Custom'),
                      subtitle: const Text('Start with an empty board'),
                      value: 'custom',
                      groupValue: selectedTemplate,
                      onChanged: (value) => setState(() => selectedTemplate = value!),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              if (titleController.text.isNotEmpty) {
                final board = Board(
                  id: '',
                  title: titleController.text,
                  description: descriptionController.text.isEmpty ? null : descriptionController.text,
                  ownerId: 'user1', // Current user ID
                  memberIds: ['user1'],
                  columns: [],
                  createdAt: DateTime.now(),
                  updatedAt: DateTime.now(),
                  template: selectedTemplate,
                );
                ref.read(boardListProvider.notifier).createBoard(board);
                Navigator.of(context).pop();
              }
            },
            child: const Text('Create'),
          ),
        ],
      ),
    );
  }
  
  void _showEditBoardDialog(BuildContext context, WidgetRef ref, Board board) {
    final titleController = TextEditingController(text: board.title);
    final descriptionController = TextEditingController(text: board.description ?? '');
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Board'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              autofocus: true,
              decoration: const InputDecoration(
                labelText: 'Board Title',
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(
                labelText: 'Description',
              ),
              maxLines: 3,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              if (titleController.text.isNotEmpty) {
                final updatedBoard = board.copyWith(
                  title: titleController.text,
                  description: descriptionController.text.isEmpty ? null : descriptionController.text,
                );
                ref.read(boardListProvider.notifier).updateBoard(board.id, updatedBoard);
                Navigator.of(context).pop();
              }
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
  
  void _confirmDeleteBoard(BuildContext context, WidgetRef ref, Board board) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Board'),
        content: Text('Are you sure you want to delete "${board.title}"? This action cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
            onPressed: () {
              ref.read(boardListProvider.notifier).deleteBoard(board.id);
              Navigator.of(context).pop();
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}