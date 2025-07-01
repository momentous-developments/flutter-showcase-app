import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../models/academy_models.dart';
import '../providers/academy_providers.dart';
import '../widgets/index.dart';

/// Course list view with filtering and search functionality
class CourseListView extends ConsumerStatefulWidget {
  const CourseListView({super.key});

  @override
  ConsumerState<CourseListView> createState() => _CourseListViewState();
}

class _CourseListViewState extends ConsumerState<CourseListView>
    with TickerProviderStateMixin {
  late TabController _tabController;
  late TextEditingController _searchController;
  bool _isGridView = true;
  bool _showFilters = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final coursesAsync = ref.watch(coursesProvider);
    final theme = Theme.of(context);

    return Scaffold(
      body: Column(
        children: [
          // Header with search and filters
          _buildHeader(context, ref),
          
          // Category tabs
          _buildCategoryTabs(context, ref),
          
          // Filter bar (collapsible)
          if (_showFilters) _buildFilterBar(context, ref),
          
          // Course list/grid
          Expanded(
            child: coursesAsync.when(
              data: (courses) => _buildCourseList(context, ref, courses),
              loading: () => const Center(
                child: CircularProgressIndicator(),
              ),
              error: (error, stackTrace) => _buildErrorView(context, ref, error),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _toggleViewMode(),
        child: Icon(_isGridView ? Icons.list : Icons.grid_view),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final filter = ref.watch(courseFilterNotifierProvider);

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
      child: Column(
        children: [
          Row(
            children: [
              // Search bar
              Expanded(
                child: SearchBar(
                  controller: _searchController,
                  hintText: 'Search courses...',
                  leading: const Icon(Icons.search),
                  trailing: _searchController.text.isNotEmpty
                      ? [
                          IconButton(
                            onPressed: () {
                              _searchController.clear();
                              ref
                                  .read(courseFilterNotifierProvider.notifier)
                                  .updateSearchQuery('');
                            },
                            icon: const Icon(Icons.clear),
                          ),
                        ]
                      : null,
                  onChanged: (query) {
                    ref
                        .read(courseFilterNotifierProvider.notifier)
                        .updateSearchQuery(query);
                  },
                ),
              ),
              
              const SizedBox(width: 12),
              
              // Filter button
              IconButton.filledTonal(
                onPressed: () => setState(() => _showFilters = !_showFilters),
                icon: Icon(
                  _showFilters ? Icons.filter_list_off : Icons.filter_list,
                ),
              ),
              
              // Sort button
              PopupMenuButton<String>(
                icon: const Icon(Icons.sort),
                onSelected: (sortBy) {
                  ref
                      .read(courseFilterNotifierProvider.notifier)
                      .updateSorting(sortBy, filter.sortDescending);
                },
                itemBuilder: (context) => [
                  const PopupMenuItem(
                    value: 'title',
                    child: Text('Sort by Title'),
                  ),
                  const PopupMenuItem(
                    value: 'rating',
                    child: Text('Sort by Rating'),
                  ),
                  const PopupMenuItem(
                    value: 'price',
                    child: Text('Sort by Price'),
                  ),
                  const PopupMenuItem(
                    value: 'popularity',
                    child: Text('Sort by Popularity'),
                  ),
                ],
              ),
            ],
          ),
          
          // Quick filter chips
          const SizedBox(height: 12),
          _buildQuickFilters(context, ref),
        ],
      ),
    );
  }

  Widget _buildQuickFilters(BuildContext context, WidgetRef ref) {
    final filter = ref.watch(courseFilterNotifierProvider);
    
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          // Free courses filter
          FilterChip(
            label: const Text('Free'),
            selected: filter.freeOnly,
            onSelected: (selected) {
              ref
                  .read(courseFilterNotifierProvider.notifier)
                  .toggleFreeOnly();
            },
          ),
          
          const SizedBox(width: 8),
          
          // Enrolled courses filter
          FilterChip(
            label: const Text('Enrolled'),
            selected: filter.enrolledOnly,
            onSelected: (selected) {
              ref
                  .read(courseFilterNotifierProvider.notifier)
                  .toggleEnrolledOnly();
            },
          ),
          
          const SizedBox(width: 8),
          
          // Rating filter
          FilterChip(
            label: const Text('4+ Stars'),
            selected: filter.minRating >= 4.0,
            onSelected: (selected) {
              ref
                  .read(courseFilterNotifierProvider.notifier)
                  .updateMinRating(selected ? 4.0 : 0.0);
            },
          ),
          
          const SizedBox(width: 8),
          
          // Clear filters
          if (filter != const CourseFilter())
            ActionChip(
              label: const Text('Clear All'),
              onPressed: () {
                ref
                    .read(courseFilterNotifierProvider.notifier)
                    .resetFilter();
                _searchController.clear();
              },
            ),
        ],
      ),
    );
  }

  Widget _buildCategoryTabs(BuildContext context, WidgetRef ref) {
    final categoriesAsync = ref.watch(courseCategoriesProvider);
    final theme = Theme.of(context);

    return categoriesAsync.when(
      data: (categories) {
        final allCategories = ['All', ...categories];
        
        return Container(
          height: 48,
          decoration: BoxDecoration(
            color: theme.colorScheme.surfaceVariant.withOpacity(0.3),
            border: Border(
              bottom: BorderSide(
                color: theme.colorScheme.outline.withOpacity(0.2),
              ),
            ),
          ),
          child: TabBar(
            controller: _tabController,
            isScrollable: true,
            tabAlignment: TabAlignment.start,
            tabs: allCategories.map((category) => Tab(text: category)).toList(),
            onTap: (index) {
              final selectedCategories = index == 0 
                  ? <String>[]
                  : [allCategories[index]];
              
              ref
                  .read(courseFilterNotifierProvider.notifier)
                  .updateCategories(selectedCategories);
            },
          ),
        );
      },
      loading: () => const SizedBox(height: 48),
      error: (error, stackTrace) => const SizedBox(height: 48),
    );
  }

  Widget _buildFilterBar(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final filter = ref.watch(courseFilterNotifierProvider);
    final levelsAsync = ref.watch(courseLevelsProvider);
    final languagesAsync = ref.watch(courseLanguagesProvider);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceVariant.withOpacity(0.5),
        border: Border(
          bottom: BorderSide(
            color: theme.colorScheme.outline.withOpacity(0.2),
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Filters',
            style: theme.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          
          const SizedBox(height: 12),
          
          // Level filters
          Text(
            'Level',
            style: theme.textTheme.labelMedium?.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            children: levelsAsync.map((level) {
              final isSelected = filter.levels.contains(level);
              return FilterChip(
                label: Text(level),
                selected: isSelected,
                onSelected: (selected) {
                  final newLevels = List<String>.from(filter.levels);
                  if (selected) {
                    newLevels.add(level);
                  } else {
                    newLevels.remove(level);
                  }
                  ref
                      .read(courseFilterNotifierProvider.notifier)
                      .updateLevels(newLevels);
                },
              );
            }).toList(),
          ),
          
          const SizedBox(height: 16),
          
          // Language filters
          Text(
            'Language',
            style: theme.textTheme.labelMedium?.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            children: languagesAsync.map((language) {
              final isSelected = filter.languages.contains(language);
              return FilterChip(
                label: Text(language),
                selected: isSelected,
                onSelected: (selected) {
                  final newLanguages = List<String>.from(filter.languages);
                  if (selected) {
                    newLanguages.add(language);
                  } else {
                    newLanguages.remove(language);
                  }
                  ref
                      .read(courseFilterNotifierProvider.notifier)
                      .updateLanguages(newLanguages);
                },
              );
            }).toList(),
          ),
          
          const SizedBox(height: 16),
          
          // Price range
          Text(
            'Price Range',
            style: theme.textTheme.labelMedium?.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Slider(
            value: filter.maxPrice == double.infinity ? 200 : filter.maxPrice,
            min: 0,
            max: 200,
            divisions: 20,
            label: filter.maxPrice == double.infinity 
                ? 'Any price'
                : '\$${filter.maxPrice.toStringAsFixed(0)}',
            onChanged: (value) {
              ref
                  .read(courseFilterNotifierProvider.notifier)
                  .updateMaxPrice(value == 200 ? double.infinity : value);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCourseList(
    BuildContext context,
    WidgetRef ref,
    List<Course> courses,
  ) {
    if (courses.isEmpty) {
      return _buildEmptyView(context, ref);
    }

    return RefreshIndicator(
      onRefresh: () async {
        ref.refresh(coursesProvider);
      },
      child: _isGridView
          ? _buildGridView(context, ref, courses)
          : _buildListView(context, ref, courses),
    );
  }

  Widget _buildGridView(
    BuildContext context,
    WidgetRef ref,
    List<Course> courses,
  ) {
    final screenWidth = MediaQuery.of(context).size.width;
    final crossAxisCount = screenWidth > 1200 
        ? 4 
        : screenWidth > 800 
            ? 3 
            : screenWidth > 600 
                ? 2 
                : 1;

    return Padding(
      padding: const EdgeInsets.all(16),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          childAspectRatio: 0.75,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: courses.length,
        itemBuilder: (context, index) {
          final course = courses[index];
          return CourseCard(
            course: course,
            showProgress: course.isEnrolled,
          );
        },
      ),
    );
  }

  Widget _buildListView(
    BuildContext context,
    WidgetRef ref,
    List<Course> courses,
  ) {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: courses.length,
      separatorBuilder: (context, index) => const SizedBox(height: 8),
      itemBuilder: (context, index) {
        final course = courses[index];
        return CompactCourseCard(course: course);
      },
    );
  }

  Widget _buildEmptyView(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final filter = ref.watch(courseFilterNotifierProvider);
    final hasActiveFilters = filter != const CourseFilter();

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              hasActiveFilters ? Icons.search_off : Icons.school_outlined,
              size: 64,
              color: theme.colorScheme.onSurfaceVariant,
            ),
            const SizedBox(height: 16),
            Text(
              hasActiveFilters 
                  ? 'No courses match your filters'
                  : 'No courses available',
              style: theme.textTheme.headlineSmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              hasActiveFilters
                  ? 'Try adjusting your search criteria'
                  : 'Check back later for new courses',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
            if (hasActiveFilters) ...[
              const SizedBox(height: 24),
              FilledButton(
                onPressed: () {
                  ref
                      .read(courseFilterNotifierProvider.notifier)
                      .resetFilter();
                  _searchController.clear();
                },
                child: const Text('Clear Filters'),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildErrorView(BuildContext context, WidgetRef ref, Object error) {
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
              'Failed to load courses',
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
              onPressed: () => ref.refresh(coursesProvider),
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }

  void _toggleViewMode() {
    setState(() {
      _isGridView = !_isGridView;
    });
  }
}