import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/academy_models.dart';
import '../providers/academy_providers.dart';

/// Instructor management view
class InstructorManagementView extends ConsumerStatefulWidget {
  const InstructorManagementView({super.key});

  @override
  ConsumerState<InstructorManagementView> createState() => _InstructorManagementViewState();
}

class _InstructorManagementViewState extends ConsumerState<InstructorManagementView> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  String _sortBy = 'name';
  bool _sortDescending = false;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final instructorsAsync = ref.watch(instructorsProvider);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Instructors'),
        actions: [
          IconButton(
            onPressed: () => _showAddInstructorDialog(context),
            icon: const Icon(Icons.person_add),
          ),
        ],
      ),
      body: Column(
        children: [
          // Search and filter bar
          _buildSearchAndFilterBar(context),
          
          // Instructors list
          Expanded(
            child: instructorsAsync.when(
              data: (instructors) => _buildInstructorsList(context, instructors),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stackTrace) => _buildErrorView(context, error),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddInstructorDialog(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildSearchAndFilterBar(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Search bar
          Expanded(
            child: SearchBar(
              controller: _searchController,
              hintText: 'Search instructors...',
              leading: const Icon(Icons.search),
              trailing: _searchController.text.isNotEmpty
                  ? [
                      IconButton(
                        onPressed: () {
                          _searchController.clear();
                          setState(() => _searchQuery = '');
                        },
                        icon: const Icon(Icons.clear),
                      ),
                    ]
                  : null,
              onChanged: (query) {
                setState(() => _searchQuery = query);
              },
            ),
          ),
          
          const SizedBox(width: 12),
          
          // Sort dropdown
          PopupMenuButton<String>(
            icon: const Icon(Icons.sort),
            onSelected: (sortBy) {
              setState(() {
                if (_sortBy == sortBy) {
                  _sortDescending = !_sortDescending;
                } else {
                  _sortBy = sortBy;
                  _sortDescending = false;
                }
              });
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'name',
                child: Text('Sort by Name'),
              ),
              const PopupMenuItem(
                value: 'rating',
                child: Text('Sort by Rating'),
              ),
              const PopupMenuItem(
                value: 'students',
                child: Text('Sort by Students'),
              ),
              const PopupMenuItem(
                value: 'courses',
                child: Text('Sort by Courses'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInstructorsList(BuildContext context, List<Instructor> instructors) {
    // Apply search filter
    var filteredInstructors = instructors.where((instructor) {
      if (_searchQuery.isEmpty) return true;
      
      final query = _searchQuery.toLowerCase();
      return instructor.name.toLowerCase().contains(query) ||
             instructor.position.toLowerCase().contains(query) ||
             instructor.specializations.any((spec) => 
                 spec.toLowerCase().contains(query));
    }).toList();

    // Apply sorting
    filteredInstructors.sort((a, b) {
      int comparison;
      switch (_sortBy) {
        case 'name':
          comparison = a.name.compareTo(b.name);
          break;
        case 'rating':
          comparison = a.rating.compareTo(b.rating);
          break;
        case 'students':
          comparison = a.totalStudents.compareTo(b.totalStudents);
          break;
        case 'courses':
          comparison = a.courseIds.length.compareTo(b.courseIds.length);
          break;
        default:
          comparison = a.name.compareTo(b.name);
      }
      
      return _sortDescending ? -comparison : comparison;
    });

    if (filteredInstructors.isEmpty) {
      return _buildEmptyView(context);
    }

    final screenSize = MediaQuery.of(context).size;
    final isWideScreen = screenSize.width > 800;

    return RefreshIndicator(
      onRefresh: () async {
        ref.refresh(instructorsProvider);
      },
      child: isWideScreen
          ? _buildInstructorsGrid(context, filteredInstructors)
          : _buildInstructorsListView(context, filteredInstructors),
    );
  }

  Widget _buildInstructorsGrid(BuildContext context, List<Instructor> instructors) {
    final crossAxisCount = MediaQuery.of(context).size.width > 1200 ? 3 : 2;

    return Padding(
      padding: const EdgeInsets.all(16),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          childAspectRatio: 1.2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: instructors.length,
        itemBuilder: (context, index) {
          final instructor = instructors[index];
          return InstructorCard(instructor: instructor);
        },
      ),
    );
  }

  Widget _buildInstructorsListView(BuildContext context, List<Instructor> instructors) {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: instructors.length,
      separatorBuilder: (context, index) => const SizedBox(height: 8),
      itemBuilder: (context, index) {
        final instructor = instructors[index];
        return InstructorListTile(instructor: instructor);
      },
    );
  }

  Widget _buildEmptyView(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              _searchQuery.isNotEmpty ? Icons.search_off : Icons.person_outline,
              size: 64,
              color: theme.colorScheme.onSurfaceVariant,
            ),
            const SizedBox(height: 16),
            Text(
              _searchQuery.isNotEmpty
                  ? 'No instructors match your search'
                  : 'No instructors found',
              style: theme.textTheme.headlineSmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              _searchQuery.isNotEmpty
                  ? 'Try adjusting your search criteria'
                  : 'Add your first instructor to get started',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
            if (_searchQuery.isNotEmpty) ...[
              const SizedBox(height: 24),
              FilledButton(
                onPressed: () {
                  _searchController.clear();
                  setState(() => _searchQuery = '');
                },
                child: const Text('Clear Search'),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildErrorView(BuildContext context, Object error) {
    final theme = Theme.of(context);

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 64,
              color: theme.colorScheme.error,
            ),
            const SizedBox(height: 16),
            Text(
              'Failed to load instructors',
              style: theme.textTheme.headlineSmall?.copyWith(
                color: theme.colorScheme.error,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              error.toString(),
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            FilledButton(
              onPressed: () => ref.refresh(instructorsProvider),
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }

  void _showAddInstructorDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => const AddInstructorDialog(),
    );
  }
}

/// Instructor card widget for grid view
class InstructorCard extends StatelessWidget {
  const InstructorCard({
    super.key,
    required this.instructor,
  });

  final Instructor instructor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => _showInstructorDetails(context, instructor),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Avatar and rating
              Row(
                children: [
                  CircleAvatar(
                    radius: 24,
                    backgroundImage: AssetImage(
                      instructor.avatar.startsWith('/')
                          ? 'assets/images${instructor.avatar}'
                          : instructor.avatar,
                    ),
                    onBackgroundImageError: (exception, stackTrace) {},
                    child: instructor.avatar.isEmpty
                        ? Icon(
                            Icons.person,
                            color: theme.colorScheme.onPrimaryContainer,
                          )
                        : null,
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.amber.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.star,
                          size: 14,
                          color: Colors.amber,
                        ),
                        const SizedBox(width: 2),
                        Text(
                          instructor.rating.toStringAsFixed(1),
                          style: theme.textTheme.labelSmall?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 12),
              
              // Name and position
              Text(
                instructor.name,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                instructor.position,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              
              const Spacer(),
              
              // Stats
              Row(
                children: [
                  Icon(
                    Icons.people,
                    size: 16,
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '${instructor.totalStudents}',
                    style: theme.textTheme.labelSmall,
                  ),
                  const SizedBox(width: 12),
                  Icon(
                    Icons.school,
                    size: 16,
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '${instructor.courseIds.length}',
                    style: theme.textTheme.labelSmall,
                  ),
                ],
              ),
              
              const SizedBox(height: 8),
              
              // Specializations
              if (instructor.specializations.isNotEmpty)
                Wrap(
                  spacing: 4,
                  children: instructor.specializations.take(2).map((spec) {
                    return Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primaryContainer,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        spec,
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: theme.colorScheme.onPrimaryContainer,
                        ),
                      ),
                    );
                  }).toList(),
                ),
            ],
          ),
        ),
      ),
    );
  }

  void _showInstructorDetails(BuildContext context, Instructor instructor) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => InstructorDetailsSheet(instructor: instructor),
    );
  }
}

/// Instructor list tile for list view
class InstructorListTile extends StatelessWidget {
  const InstructorListTile({
    super.key,
    required this.instructor,
  });

  final Instructor instructor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      child: ListTile(
        onTap: () => _showInstructorDetails(context, instructor),
        leading: CircleAvatar(
          backgroundImage: AssetImage(
            instructor.avatar.startsWith('/')
                ? 'assets/images${instructor.avatar}'
                : instructor.avatar,
          ),
          onBackgroundImageError: (exception, stackTrace) {},
          child: instructor.avatar.isEmpty
              ? Icon(
                  Icons.person,
                  color: theme.colorScheme.onPrimaryContainer,
                )
              : null,
        ),
        title: Text(
          instructor.name,
          style: theme.textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(instructor.position),
            const SizedBox(height: 4),
            Row(
              children: [
                Icon(
                  Icons.star,
                  size: 14,
                  color: Colors.amber,
                ),
                const SizedBox(width: 2),
                Text(
                  instructor.rating.toStringAsFixed(1),
                  style: theme.textTheme.labelSmall,
                ),
                const SizedBox(width: 8),
                Icon(
                  Icons.people,
                  size: 14,
                  color: theme.colorScheme.onSurfaceVariant,
                ),
                const SizedBox(width: 2),
                Text(
                  '${instructor.totalStudents} students',
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '${instructor.courseIds.length}',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: theme.colorScheme.primary,
              ),
            ),
            const SizedBox(width: 4),
            Text(
              'courses',
              style: theme.textTheme.labelSmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(width: 8),
            const Icon(Icons.arrow_forward_ios, size: 16),
          ],
        ),
      ),
    );
  }

  void _showInstructorDetails(BuildContext context, Instructor instructor) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => InstructorDetailsSheet(instructor: instructor),
    );
  }
}

/// Instructor details bottom sheet
class InstructorDetailsSheet extends StatelessWidget {
  const InstructorDetailsSheet({
    super.key,
    required this.instructor,
  });

  final Instructor instructor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      height: screenHeight * 0.8,
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              CircleAvatar(
                radius: 32,
                backgroundImage: AssetImage(
                  instructor.avatar.startsWith('/')
                      ? 'assets/images${instructor.avatar}'
                      : instructor.avatar,
                ),
                onBackgroundImageError: (exception, stackTrace) {},
                child: instructor.avatar.isEmpty
                    ? Icon(
                        Icons.person,
                        size: 32,
                        color: theme.colorScheme.onPrimaryContainer,
                      )
                    : null,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      instructor.name,
                      style: theme.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      instructor.position,
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: const Icon(Icons.close),
              ),
            ],
          ),
          
          const SizedBox(height: 24),
          
          // Stats row
          Row(
            children: [
              _buildStat(context, 'Rating', instructor.rating.toStringAsFixed(1), Icons.star),
              _buildStat(context, 'Students', instructor.totalStudents.toString(), Icons.people),
              _buildStat(context, 'Courses', instructor.courseIds.length.toString(), Icons.school),
              _buildStat(context, 'Reviews', instructor.reviewCount.toString(), Icons.reviews),
            ],
          ),
          
          const SizedBox(height: 24),
          
          // Bio
          if (instructor.bio.isNotEmpty) ...[
            Text(
              'Bio',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              instructor.bio,
              style: theme.textTheme.bodyMedium,
            ),
            const SizedBox(height: 24),
          ],
          
          // Specializations
          if (instructor.specializations.isNotEmpty) ...[
            Text(
              'Specializations',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: instructor.specializations.map((spec) {
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    spec,
                    style: theme.textTheme.labelMedium?.copyWith(
                      color: theme.colorScheme.onPrimaryContainer,
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 24),
          ],
          
          const Spacer(),
          
          // Action buttons
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {
                    // Send message to instructor
                  },
                  icon: const Icon(Icons.message),
                  label: const Text('Message'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: FilledButton.icon(
                  onPressed: () {
                    // View instructor's courses
                  },
                  icon: const Icon(Icons.school),
                  label: const Text('View Courses'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStat(BuildContext context, String label, String value, IconData icon) {
    final theme = Theme.of(context);

    return Expanded(
      child: Column(
        children: [
          Icon(icon, color: theme.colorScheme.primary),
          const SizedBox(height: 4),
          Text(
            value,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.primary,
            ),
          ),
          Text(
            label,
            style: theme.textTheme.labelSmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}

/// Add instructor dialog
class AddInstructorDialog extends StatefulWidget {
  const AddInstructorDialog({super.key});

  @override
  State<AddInstructorDialog> createState() => _AddInstructorDialogState();
}

class _AddInstructorDialogState extends State<AddInstructorDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _positionController = TextEditingController();
  final _bioController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _positionController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add New Instructor'),
      content: SizedBox(
        width: 400,
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Full Name',
                  prefixIcon: Icon(Icons.person),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter instructor name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.email),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter email';
                  }
                  if (!value.contains('@')) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _positionController,
                decoration: const InputDecoration(
                  labelText: 'Position/Title',
                  prefixIcon: Icon(Icons.work),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter position';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _bioController,
                decoration: const InputDecoration(
                  labelText: 'Bio (optional)',
                  prefixIcon: Icon(Icons.description),
                ),
                maxLines: 3,
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: _addInstructor,
          child: const Text('Add Instructor'),
        ),
      ],
    );
  }

  void _addInstructor() {
    if (_formKey.currentState!.validate()) {
      // Create new instructor
      final instructor = Instructor(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: _nameController.text,
        email: _emailController.text,
        avatar: '',
        position: _positionController.text,
        bio: _bioController.text,
        courseIds: [],
        joinDate: DateTime.now(),
        totalStudents: 0,
        rating: 0.0,
        reviewCount: 0,
      );

      // TODO: Add instructor to the database
      
      Navigator.of(context).pop();
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Instructor ${instructor.name} added successfully'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }
}