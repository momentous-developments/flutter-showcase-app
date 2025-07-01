import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/layouts/module_layout.dart';
import '../../../core/utils/responsive.dart';
import '../models/ecommerce_models.dart';
import '../providers/ecommerce_providers.dart';
import '../widgets/product_card.dart';

/// Product catalog view with filtering, search, and grid/list toggle
class ProductListView extends ConsumerStatefulWidget {
  const ProductListView({super.key});

  @override
  ConsumerState<ProductListView> createState() => _ProductListViewState();
}

class _ProductListViewState extends ConsumerState<ProductListView> {
  bool _isGridView = true;
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  
  @override
  void initState() {
    super.initState();
    // Load products when the view is initialized
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(productsProvider.notifier).loadProducts();
      ref.read(categoriesProvider);
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    final filtersNotifier = ref.read(productFiltersProvider.notifier);
    filtersNotifier.updateSearch(query.isEmpty ? null : query);
  }

  void _onCategoryChanged(String? category) {
    final filtersNotifier = ref.read(productFiltersProvider.notifier);
    filtersNotifier.updateCategory(category);
  }

  void _onSortChanged(String? sortBy, String? sortOrder) {
    final filtersNotifier = ref.read(productFiltersProvider.notifier);
    filtersNotifier.updateSort(sortBy, sortOrder);
  }

  void _onPriceRangeChanged(double? minPrice, double? maxPrice) {
    final filtersNotifier = ref.read(productFiltersProvider.notifier);
    filtersNotifier.updatePriceRange(minPrice, maxPrice);
  }

  void _clearFilters() {
    _searchController.clear();
    final filtersNotifier = ref.read(productFiltersProvider.notifier);
    filtersNotifier.clearFilters();
  }

  @override
  Widget build(BuildContext context) {
    final products = ref.watch(filteredProductsProvider);
    final categories = ref.watch(categoriesProvider);
    final filters = ref.watch(productFiltersProvider);

    return ModuleLayout(
      title: 'Products',
      subtitle: 'Browse our product catalog',
      actions: [
        // View Toggle
        IconButton(
          onPressed: () => setState(() => _isGridView = !_isGridView),
          icon: Icon(_isGridView ? Icons.view_list : Icons.grid_view),
          tooltip: _isGridView ? 'List View' : 'Grid View',
        ),
        // Refresh
        IconButton(
          onPressed: () => ref.read(productsProvider.notifier).refresh(),
          icon: const Icon(Icons.refresh),
          tooltip: 'Refresh',
        ),
      ],
      body: Column(
        children: [
          // Search and Filters
          _buildFilterSection(categories, filters),
          
          const SizedBox(height: 16),
          
          // Products Grid/List
          Expanded(
            child: products.when(
              data: (productList) => _buildProductsView(productList),
              loading: () => _buildLoadingView(),
              error: (error, stackTrace) => _buildErrorView(error),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterSection(AsyncValue<List<ProductCategory>> categories, ProductFilters filters) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Search Bar
            Row(
              children: [
                Expanded(
                  child: SearchBar(
                    controller: _searchController,
                    hintText: 'Search products...',
                    leading: const Icon(Icons.search),
                    onChanged: _onSearchChanged,
                    trailing: _searchController.text.isNotEmpty
                        ? [
                            IconButton(
                              onPressed: () {
                                _searchController.clear();
                                _onSearchChanged('');
                              },
                              icon: const Icon(Icons.clear),
                            ),
                          ]
                        : null,
                  ),
                ),
                const SizedBox(width: 16),
                FilledButton.icon(
                  onPressed: _clearFilters,
                  icon: const Icon(Icons.clear_all),
                  label: const Text('Clear Filters'),
                ),
              ],
            ),
            
            const SizedBox(height: 16),
            
            // Filter Row
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  // Category Filter
                  _buildCategoryFilter(categories, filters.category),
                  
                  const SizedBox(width: 16),
                  
                  // Sort Filter
                  _buildSortFilter(filters.sortBy, filters.sortOrder),
                  
                  const SizedBox(width: 16),
                  
                  // Price Range Filter
                  _buildPriceRangeFilter(filters.minPrice, filters.maxPrice),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryFilter(AsyncValue<List<ProductCategory>> categories, String? selectedCategory) {
    return categories.when(
      data: (categoryList) {
        return DropdownButton<String>(
          value: selectedCategory,
          hint: const Text('Category'),
          items: [
            const DropdownMenuItem<String>(
              value: null,
              child: Text('All Categories'),
            ),
            ...categoryList.map((category) {
              return DropdownMenuItem<String>(
                value: category.name,
                child: Text(category.name),
              );
            }),
          ],
          onChanged: _onCategoryChanged,
        );
      },
      loading: () => const CircularProgressIndicator(),
      error: (_, __) => const Text('Categories unavailable'),
    );
  }

  Widget _buildSortFilter(String? sortBy, String? sortOrder) {
    const sortOptions = [
      {'value': null, 'label': 'Default'},
      {'value': 'name', 'label': 'Name'},
      {'value': 'price', 'label': 'Price'},
      {'value': 'rating', 'label': 'Rating'},
      {'value': 'newest', 'label': 'Newest'},
    ];

    return Row(
      children: [
        DropdownButton<String>(
          value: sortBy,
          hint: const Text('Sort by'),
          items: sortOptions.map((option) {
            return DropdownMenuItem<String>(
              value: option['value'],
              child: Text(option['label']!),
            );
          }).toList(),
          onChanged: (value) => _onSortChanged(value, sortOrder ?? 'asc'),
        ),
        
        if (sortBy != null) ...[
          const SizedBox(width: 8),
          IconButton(
            onPressed: () => _onSortChanged(
              sortBy,
              sortOrder == 'asc' ? 'desc' : 'asc',
            ),
            icon: Icon(
              sortOrder == 'desc' ? Icons.arrow_downward : Icons.arrow_upward,
            ),
            tooltip: sortOrder == 'desc' ? 'Descending' : 'Ascending',
          ),
        ],
      ],
    );
  }

  Widget _buildPriceRangeFilter(double? minPrice, double? maxPrice) {
    return OutlinedButton.icon(
      onPressed: () => _showPriceRangeDialog(minPrice, maxPrice),
      icon: const Icon(Icons.tune),
      label: Text(
        minPrice != null || maxPrice != null
            ? 'Price: ${_formatPriceRange(minPrice, maxPrice)}'
            : 'Price Range',
      ),
    );
  }

  String _formatPriceRange(double? minPrice, double? maxPrice) {
    if (minPrice != null && maxPrice != null) {
      return '\$${minPrice.toInt()} - \$${maxPrice.toInt()}';
    } else if (minPrice != null) {
      return '\$${minPrice.toInt()}+';
    } else if (maxPrice != null) {
      return 'Up to \$${maxPrice.toInt()}';
    }
    return 'Any';
  }

  void _showPriceRangeDialog(double? currentMin, double? currentMax) {
    showDialog(
      context: context,
      builder: (context) => _PriceRangeDialog(
        initialMin: currentMin,
        initialMax: currentMax,
        onPriceRangeChanged: _onPriceRangeChanged,
      ),
    );
  }

  Widget _buildProductsView(List<Product> products) {
    if (products.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.inventory_2_outlined,
              size: 64,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
            const SizedBox(height: 16),
            Text(
              'No products found',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(
              'Try adjusting your search or filters',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      );
    }

    return ResponsiveLayoutBuilder(
      builder: (context, info) {
        if (_isGridView) {
          return _buildProductGrid(products, info);
        } else {
          return _buildProductList(products);
        }
      },
    );
  }

  Widget _buildProductGrid(List<Product> products, ResponsiveLayoutInfo info) {
    final crossAxisCount = info.isDesktop ? 4 : (info.isTablet ? 3 : 2);
    
    return GridView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.all(16),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        childAspectRatio: 0.75,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        return ProductCard(
          product: product,
          isGridView: true,
          onTap: () => _navigateToProductDetails(product),
        );
      },
    );
  }

  Widget _buildProductList(List<Product> products) {
    return ListView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.all(16),
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        return ProductCard(
          product: product,
          isGridView: false,
          onTap: () => _navigateToProductDetails(product),
        );
      },
    );
  }

  Widget _buildLoadingView() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
          SizedBox(height: 16),
          Text('Loading products...'),
        ],
      ),
    );
  }

  Widget _buildErrorView(Object error) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: 64,
            color: Theme.of(context).colorScheme.error,
          ),
          const SizedBox(height: 16),
          Text(
            'Error loading products',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 8),
          Text(
            error.toString(),
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          FilledButton.icon(
            onPressed: () => ref.read(productsProvider.notifier).refresh(),
            icon: const Icon(Icons.refresh),
            label: const Text('Retry'),
          ),
        ],
      ),
    );
  }

  void _navigateToProductDetails(Product product) {
    // TODO: Navigate to product details
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Navigate to ${product.name} details')),
    );
  }
}

/// Price range dialog
class _PriceRangeDialog extends StatefulWidget {
  const _PriceRangeDialog({
    required this.onPriceRangeChanged,
    this.initialMin,
    this.initialMax,
  });

  final Function(double?, double?) onPriceRangeChanged;
  final double? initialMin;
  final double? initialMax;

  @override
  State<_PriceRangeDialog> createState() => _PriceRangeDialogState();
}

class _PriceRangeDialogState extends State<_PriceRangeDialog> {
  late TextEditingController _minController;
  late TextEditingController _maxController;
  RangeValues _currentRangeValues = const RangeValues(0, 1000);

  @override
  void initState() {
    super.initState();
    _minController = TextEditingController(
      text: widget.initialMin?.toInt().toString() ?? '',
    );
    _maxController = TextEditingController(
      text: widget.initialMax?.toInt().toString() ?? '',
    );
    
    _currentRangeValues = RangeValues(
      widget.initialMin ?? 0,
      widget.initialMax ?? 1000,
    );
  }

  @override
  void dispose() {
    _minController.dispose();
    _maxController.dispose();
    super.dispose();
  }

  void _updateRangeFromSlider(RangeValues values) {
    setState(() {
      _currentRangeValues = values;
      _minController.text = values.start.toInt().toString();
      _maxController.text = values.end.toInt().toString();
    });
  }

  void _updateRangeFromText() {
    final minValue = double.tryParse(_minController.text);
    final maxValue = double.tryParse(_maxController.text);
    
    if (minValue != null && maxValue != null && minValue <= maxValue) {
      setState(() {
        _currentRangeValues = RangeValues(minValue, maxValue);
      });
    }
  }

  void _applyFilter() {
    final minValue = _minController.text.isEmpty 
        ? null 
        : double.tryParse(_minController.text);
    final maxValue = _maxController.text.isEmpty 
        ? null 
        : double.tryParse(_maxController.text);
    
    widget.onPriceRangeChanged(minValue, maxValue);
    Navigator.of(context).pop();
  }

  void _clearFilter() {
    widget.onPriceRangeChanged(null, null);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return AlertDialog(
      title: const Text('Price Range'),
      content: SizedBox(
        width: 300,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Text inputs
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _minController,
                    decoration: const InputDecoration(
                      labelText: 'Min Price',
                      prefixText: '\$',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                    onChanged: (_) => _updateRangeFromText(),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextField(
                    controller: _maxController,
                    decoration: const InputDecoration(
                      labelText: 'Max Price',
                      prefixText: '\$',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                    onChanged: (_) => _updateRangeFromText(),
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 24),
            
            // Range slider
            Text(
              '\$${_currentRangeValues.start.toInt()} - \$${_currentRangeValues.end.toInt()}',
              style: theme.textTheme.titleMedium,
            ),
            
            RangeSlider(
              values: _currentRangeValues,
              min: 0,
              max: 1000,
              divisions: 20,
              onChanged: _updateRangeFromSlider,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: _clearFilter,
          child: const Text('Clear'),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: _applyFilter,
          child: const Text('Apply'),
        ),
      ],
    );
  }
}