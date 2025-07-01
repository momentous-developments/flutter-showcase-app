import 'package:flutter/material.dart';
import '../../../core/layouts/module_layout.dart';
import '../../../components/cards/statistics/index.dart';

/// Cards showcase page displaying various card components
class CardsShowcase extends StatelessWidget {
  const CardsShowcase({super.key});

  @override
  Widget build(BuildContext context) {
    return ModuleLayout(
      title: 'Cards',
      subtitle: 'Display content and actions on a single topic',
      body: const CardsShowcaseContent(),
    );
  }
}

/// Content for cards showcase
class CardsShowcaseContent extends StatelessWidget {
  const CardsShowcaseContent({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: const [
        ModuleSectionHeader(title: 'Basic Cards'),
        SizedBox(height: 16),
        _BasicCardsSection(),
        
        SizedBox(height: 32),
        ModuleSectionHeader(title: 'Elevated Cards'),
        SizedBox(height: 16),
        _ElevatedCardsSection(),
        
        SizedBox(height: 32),
        ModuleSectionHeader(title: 'Filled Cards'),
        SizedBox(height: 16),
        _FilledCardsSection(),
        
        SizedBox(height: 32),
        ModuleSectionHeader(title: 'Outlined Cards'),
        SizedBox(height: 16),
        _OutlinedCardsSection(),
        
        SizedBox(height: 32),
        ModuleSectionHeader(title: 'Interactive Cards'),
        SizedBox(height: 16),
        _InteractiveCardsSection(),
        
        SizedBox(height: 32),
        ModuleSectionHeader(title: 'Statistics Cards'),
        SizedBox(height: 16),
        _StatisticsCardsSection(),
        
        SizedBox(height: 32),
        ModuleSectionHeader(title: 'Content Cards'),
        SizedBox(height: 16),
        _ContentCardsSection(),
      ],
    );
  }
}

/// Basic cards section
class _BasicCardsSection extends StatelessWidget {
  const _BasicCardsSection();

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 16,
      runSpacing: 16,
      children: [
        SizedBox(
          width: 200,
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Basic Card',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'This is a basic card with default styling.',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          width: 200,
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.info,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Card with Icon',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'This card includes an icon in the header.',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

/// Elevated cards section
class _ElevatedCardsSection extends StatelessWidget {
  const _ElevatedCardsSection();

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 16,
      runSpacing: 16,
      children: [
        SizedBox(
          width: 200,
          child: Card(
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Elevated Card',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'This card has elevated appearance with shadow.',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          width: 200,
          child: Card(
            elevation: 8,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'High Elevation',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'This card has higher elevation for more prominence.',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

/// Filled cards section
class _FilledCardsSection extends StatelessWidget {
  const _FilledCardsSection();

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 16,
      runSpacing: 16,
      children: [
        SizedBox(
          width: 200,
          child: Card(
            color: Theme.of(context).colorScheme.surfaceVariant,
            elevation: 0,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Filled Card',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'This card uses a filled surface variant.',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          width: 200,
          child: Card(
            color: Theme.of(context).colorScheme.primaryContainer,
            elevation: 0,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Primary Container',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'This card uses primary container color.',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

/// Outlined cards section
class _OutlinedCardsSection extends StatelessWidget {
  const _OutlinedCardsSection();

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 16,
      runSpacing: 16,
      children: [
        SizedBox(
          width: 200,
          child: Card(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: BorderSide(
                color: Theme.of(context).colorScheme.outline,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Outlined Card',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'This card has an outlined border.',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          width: 200,
          child: Card(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: BorderSide(
                color: Theme.of(context).colorScheme.primary,
                width: 2,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Primary Outline',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'This card has a primary colored outline.',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

/// Interactive cards section
class _InteractiveCardsSection extends StatelessWidget {
  const _InteractiveCardsSection();

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 16,
      runSpacing: 16,
      children: [
        SizedBox(
          width: 200,
          child: Card(
            clipBehavior: Clip.antiAlias,
            child: InkWell(
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Card tapped!')),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Clickable Card',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Tap this card to see interaction.',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 12),
                    Icon(
                      Icons.touch_app,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          width: 200,
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Card with Actions',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'This card has action buttons.',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {},
                        child: const Text('Cancel'),
                      ),
                      const SizedBox(width: 8),
                      FilledButton(
                        onPressed: () {},
                        child: const Text('Action'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

/// Content cards section
class _ContentCardsSection extends StatelessWidget {
  const _ContentCardsSection();

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 16,
      runSpacing: 16,
      children: [
        SizedBox(
          width: 300,
          child: Card(
            clipBehavior: Clip.antiAlias,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 120,
                  width: double.infinity,
                  color: Theme.of(context).colorScheme.primaryContainer,
                  child: Icon(
                    Icons.image,
                    size: 48,
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Media Card',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'This card includes media content like images or videos.',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          width: 300,
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: Theme.of(context).colorScheme.secondary,
                        child: Text(
                          'JD',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onSecondary,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'User Profile Card',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            Text(
                              'John Doe',
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: Theme.of(context).colorScheme.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.more_vert),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'This is a card designed for displaying user information with avatar and actions.',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

/// Statistics cards section
class _StatisticsCardsSection extends StatelessWidget {
  const _StatisticsCardsSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Square Statistics Cards
        Text(
          'Square Statistics',
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 12),
        SquareStatsGrid(
          statsData: SampleStatisticsData.squareStats,
          crossAxisCount: 4,
        ),
        
        const SizedBox(height: 24),
        
        // Horizontal Statistics Cards
        Text(
          'Horizontal Statistics',
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 12),
        HorizontalStatsCollection(
          statsData: SampleStatisticsData.horizontalStats,
        ),
        
        const SizedBox(height: 24),
        
        // Horizontal with Avatar Statistics Cards
        Text(
          'Horizontal with Avatar',
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 12),
        HorizontalWithAvatarCollection(
          statsData: SampleStatisticsData.horizontalStats,
          avatarVariant: 'rounded',
          avatarSkin: 'light',
        ),
        
        const SizedBox(height: 24),
        
        // Customer Statistics Cards
        Text(
          'Customer Statistics',
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 12),
        CustomerStatsCollection(
          statsData: SampleStatisticsData.customerStats,
          crossAxisCount: 2,
        ),
        
        const SizedBox(height: 24),
        
        // Vertical Statistics Cards
        Text(
          'Vertical Statistics',
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 12),
        VerticalStatsCollection(
          statsData: SampleStatisticsData.verticalStats,
          crossAxisCount: 2,
        ),
        
        const SizedBox(height: 24),
        
        // Statistics with Chart Cards
        Text(
          'Statistics with Charts',
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 12),
        StatsWithAreaChartCollection(
          statsData: SampleStatisticsData.statsWithChart,
          crossAxisCount: 2,
        ),
        
        const SizedBox(height: 24),
        
        // Border Statistics Cards (demo data)
        Text(
          'Horizontal with Border',
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 12),
        HorizontalWithBorderCollection(
          statsData: const [
            HorizontalBorderStatsData(
              title: 'Monthly Sales',
              stats: '15,420',
              trendNumber: 12.5,
              avatarIcon: Icons.shopping_cart,
              color: Colors.blue,
            ),
            HorizontalBorderStatsData(
              title: 'New Users',
              stats: '2,340',
              trendNumber: -5.2,
              avatarIcon: Icons.person_add,
              color: Colors.green,
            ),
          ],
        ),
        
        const SizedBox(height: 24),
        
        // Subtitle Statistics Cards (demo data)
        Text(
          'Horizontal with Subtitle',
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 12),
        HorizontalWithSubtitleCollection(
          statsData: const [
            HorizontalSubtitleStatsData(
              title: 'Revenue Growth',
              stats: '25.8k',
              avatarIcon: Icons.trending_up,
              avatarColor: Colors.green,
              trend: TrendDirection.positive,
              trendNumber: '15.2',
              subtitle: 'Compared to last month',
            ),
            HorizontalSubtitleStatsData(
              title: 'Customer Churn',
              stats: '3.2%',
              avatarIcon: Icons.trending_down,
              avatarColor: Colors.red,
              trend: TrendDirection.negative,
              trendNumber: '2.1',
              subtitle: 'Slight increase from last week',
            ),
          ],
        ),
      ],
    );
  }
}