import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'views/dashboard.dart';
import 'views/course_list.dart';
import 'views/course_details.dart';

/// Main Academy module page with navigation
class AcademyPage extends ConsumerStatefulWidget {
  const AcademyPage({super.key});

  @override
  ConsumerState<AcademyPage> createState() => _AcademyPageState();
}

class _AcademyPageState extends ConsumerState<AcademyPage>
    with TickerProviderStateMixin {
  int _selectedIndex = 0;
  late TabController _tabController;

  final List<AcademyTab> _tabs = [
    AcademyTab(
      title: 'Dashboard',
      icon: Icons.dashboard_outlined,
      selectedIcon: Icons.dashboard,
    ),
    AcademyTab(
      title: 'Courses',
      icon: Icons.school_outlined,
      selectedIcon: Icons.school,
    ),
    AcademyTab(
      title: 'My Learning',
      icon: Icons.book_outlined,
      selectedIcon: Icons.book,
    ),
    AcademyTab(
      title: 'Instructors',
      icon: Icons.person_outline,
      selectedIcon: Icons.person,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        setState(() => _selectedIndex = _tabController.index);
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenSize = MediaQuery.of(context).size;
    final isWideScreen = screenSize.width > 1200;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Icon(
              Icons.school,
              color: theme.colorScheme.primary,
            ),
            const SizedBox(width: 8),
            const Text('Academy'),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              // Search functionality
              _showSearchDialog(context);
            },
            icon: const Icon(Icons.search),
          ),
          IconButton(
            onPressed: () {
              // Notifications
              _showNotifications(context);
            },
            icon: const Icon(Icons.notifications_outlined),
          ),
          const SizedBox(width: 8),
        ],
        bottom: isWideScreen
            ? null
            : TabBar(
                controller: _tabController,
                tabs: _tabs.map((tab) => Tab(
                  icon: Icon(
                    _selectedIndex == _tabs.indexOf(tab)
                        ? tab.selectedIcon
                        : tab.icon,
                  ),
                  text: tab.title,
                )).toList(),
              ),
      ),
      body: isWideScreen
          ? _buildWideScreenLayout(context)
          : _buildNarrowScreenLayout(context),
    );
  }

  Widget _buildWideScreenLayout(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      children: [
        // Sidebar navigation
        Container(
          width: 280,
          decoration: BoxDecoration(
            color: theme.colorScheme.surfaceVariant.withOpacity(0.3),
            border: Border(
              right: BorderSide(
                color: theme.colorScheme.outline.withOpacity(0.2),
              ),
            ),
          ),
          child: Column(
            children: [
              // Academy branding
              Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Learning Academy',
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.primary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Your journey to excellence',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              
              const Divider(),
              
              // Navigation items
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  itemCount: _tabs.length,
                  itemBuilder: (context, index) {
                    final tab = _tabs[index];
                    final isSelected = _selectedIndex == index;
                    
                    return Container(
                      margin: const EdgeInsets.symmetric(vertical: 2),
                      child: ListTile(
                        selected: isSelected,
                        leading: Icon(
                          isSelected ? tab.selectedIcon : tab.icon,
                          color: isSelected
                              ? theme.colorScheme.primary
                              : theme.colorScheme.onSurfaceVariant,
                        ),
                        title: Text(
                          tab.title,
                          style: TextStyle(
                            fontWeight: isSelected 
                                ? FontWeight.w600 
                                : FontWeight.normal,
                            color: isSelected
                                ? theme.colorScheme.primary
                                : theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        onTap: () => _onTabSelected(index),
                      ),
                    );
                  },
                ),
              ),
              
              // Quick actions
              Container(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton.icon(
                        onPressed: () => context.push('/modules/academy/courses'),
                        icon: const Icon(Icons.explore),
                        label: const Text('Explore Courses'),
                      ),
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton.icon(
                        onPressed: () => _showCreateCourseDialog(context),
                        icon: const Icon(Icons.add),
                        label: const Text('Create Course'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        
        // Main content
        Expanded(
          child: _buildTabContent(_selectedIndex),
        ),
      ],
    );
  }

  Widget _buildNarrowScreenLayout(BuildContext context) {
    return TabBarView(
      controller: _tabController,
      children: List.generate(_tabs.length, (index) => _buildTabContent(index)),
    );
  }

  Widget _buildTabContent(int index) {
    switch (index) {
      case 0:
        return const AcademyDashboardView();
      case 1:
        return const CourseListView();
      case 2:
        return _buildMyLearningView();
      case 3:
        return _buildInstructorsView();
      default:
        return const AcademyDashboardView();
    }
  }

  Widget _buildMyLearningView() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.book_outlined,
            size: 64,
            color: Colors.grey,
          ),
          SizedBox(height: 16),
          Text(
            'My Learning',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Track your progress and continue learning',
            style: TextStyle(
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInstructorsView() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.person_outline,
            size: 64,
            color: Colors.grey,
          ),
          SizedBox(height: 16),
          Text(
            'Instructors',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Meet our expert instructors',
            style: TextStyle(
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  void _onTabSelected(int index) {
    setState(() => _selectedIndex = index);
    _tabController.animateTo(index);
  }

  void _showSearchDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Search Academy'),
        content: const TextField(
          decoration: InputDecoration(
            hintText: 'Search for courses, instructors, topics...',
            prefixIcon: Icon(Icons.search),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              Navigator.of(context).pop();
              // Perform search
            },
            child: const Text('Search'),
          ),
        ],
      ),
    );
  }

  void _showNotifications(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Notifications'),
        content: const SizedBox(
          width: 300,
          height: 200,
          child: Center(
            child: Text('No new notifications'),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _showCreateCourseDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Create Course'),
        content: const Text(
          'Course creation feature will be available soon. '
          'Contact your administrator for more information.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}

/// Academy tab model
class AcademyTab {
  final String title;
  final IconData icon;
  final IconData selectedIcon;

  const AcademyTab({
    required this.title,
    required this.icon,
    required this.selectedIcon,
  });
}