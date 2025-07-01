import 'package:flutter/material.dart';

/// Showcase of all Material 3 navigation components
class NavigationShowcase extends StatefulWidget {
  const NavigationShowcase({super.key});

  @override
  State<NavigationShowcase> createState() => _NavigationShowcaseState();
}

class _NavigationShowcaseState extends State<NavigationShowcase> {
  int _selectedIndex = 0;
  int _railIndex = 1;
  int _drawerIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Navigation Components'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildSection('App Bar', [
            Card(
              clipBehavior: Clip.antiAlias,
              child: Column(
                children: [
                  AppBar(
                    title: const Text('Standard App Bar'),
                    leading: IconButton(
                      icon: const Icon(Icons.menu),
                      onPressed: () {},
                    ),
                    actions: [
                      IconButton(
                        icon: const Icon(Icons.search),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: const Icon(Icons.more_vert),
                        onPressed: () {},
                      ),
                    ],
                  ),
                  Container(
                    height: 100,
                    color: Theme.of(context).colorScheme.surfaceVariant,
                    child: const Center(child: Text('Content')),
                  ),
                ],
              ),
            ),
          ]),
          _buildSection('Bottom Navigation Bar', [
            Card(
              clipBehavior: Clip.antiAlias,
              child: NavigationBar(
                selectedIndex: _selectedIndex,
                onDestinationSelected: (index) {
                  setState(() => _selectedIndex = index);
                },
                destinations: const [
                  NavigationDestination(
                    icon: Icon(Icons.home_outlined),
                    selectedIcon: Icon(Icons.home),
                    label: 'Home',
                  ),
                  NavigationDestination(
                    icon: Icon(Icons.explore_outlined),
                    selectedIcon: Icon(Icons.explore),
                    label: 'Explore',
                  ),
                  NavigationDestination(
                    icon: Icon(Icons.bookmark_outline),
                    selectedIcon: Icon(Icons.bookmark),
                    label: 'Saved',
                  ),
                  NavigationDestination(
                    icon: Icon(Icons.person_outline),
                    selectedIcon: Icon(Icons.person),
                    label: 'Profile',
                  ),
                ],
              ),
            ),
          ]),
          _buildSection('Navigation Rail', [
            Card(
              clipBehavior: Clip.antiAlias,
              child: SizedBox(
                height: 300,
                child: Row(
                  children: [
                    NavigationRail(
                      selectedIndex: _railIndex,
                      onDestinationSelected: (index) {
                        setState(() => _railIndex = index);
                      },
                      labelType: NavigationRailLabelType.all,
                      destinations: const [
                        NavigationRailDestination(
                          icon: Icon(Icons.dashboard_outlined),
                          selectedIcon: Icon(Icons.dashboard),
                          label: Text('Dashboard'),
                        ),
                        NavigationRailDestination(
                          icon: Icon(Icons.analytics_outlined),
                          selectedIcon: Icon(Icons.analytics),
                          label: Text('Analytics'),
                        ),
                        NavigationRailDestination(
                          icon: Icon(Icons.settings_outlined),
                          selectedIcon: Icon(Icons.settings),
                          label: Text('Settings'),
                        ),
                      ],
                    ),
                    const VerticalDivider(width: 1),
                    Expanded(
                      child: Container(
                        color: Theme.of(context).colorScheme.surfaceVariant,
                        child: const Center(child: Text('Content Area')),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ]),
          _buildSection('Navigation Drawer', [
            Card(
              child: ListTile(
                leading: const Icon(Icons.menu),
                title: const Text('Navigation Drawer'),
                subtitle: const Text('Tap to see drawer example'),
                trailing: const Icon(Icons.arrow_forward),
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) => SizedBox(
                      width: double.infinity,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const DrawerHeader(
                            decoration: BoxDecoration(
                              color: Colors.blue,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CircleAvatar(
                                  radius: 30,
                                  child: Text('JD'),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  'John Doe',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                  ),
                                ),
                                Text(
                                  'john.doe@example.com',
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          ListTile(
                            leading: const Icon(Icons.inbox),
                            title: const Text('Inbox'),
                            selected: _drawerIndex == 0,
                            onTap: () {
                              setState(() => _drawerIndex = 0);
                              Navigator.pop(context);
                            },
                          ),
                          ListTile(
                            leading: const Icon(Icons.send),
                            title: const Text('Sent'),
                            selected: _drawerIndex == 1,
                            onTap: () {
                              setState(() => _drawerIndex = 1);
                              Navigator.pop(context);
                            },
                          ),
                          ListTile(
                            leading: const Icon(Icons.drafts),
                            title: const Text('Drafts'),
                            selected: _drawerIndex == 2,
                            onTap: () {
                              setState(() => _drawerIndex = 2);
                              Navigator.pop(context);
                            },
                          ),
                          const Divider(),
                          ListTile(
                            leading: const Icon(Icons.settings),
                            title: const Text('Settings'),
                            onTap: () => Navigator.pop(context),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ]),
          _buildSection('Tabs', [
            DefaultTabController(
              length: 3,
              child: Card(
                clipBehavior: Clip.antiAlias,
                child: Column(
                  children: [
                    const TabBar(
                      tabs: [
                        Tab(text: 'Flights', icon: Icon(Icons.flight)),
                        Tab(text: 'Hotels', icon: Icon(Icons.hotel)),
                        Tab(text: 'Cars', icon: Icon(Icons.directions_car)),
                      ],
                    ),
                    SizedBox(
                      height: 200,
                      child: TabBarView(
                        children: [
                          Container(
                            color: Theme.of(context).colorScheme.primaryContainer,
                            child: const Center(child: Text('Flights Content')),
                          ),
                          Container(
                            color: Theme.of(context).colorScheme.secondaryContainer,
                            child: const Center(child: Text('Hotels Content')),
                          ),
                          Container(
                            color: Theme.of(context).colorScheme.tertiaryContainer,
                            child: const Center(child: Text('Cars Content')),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ]),
          _buildSection('Breadcrumbs', [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    TextButton(
                      onPressed: () {},
                      child: const Text('Home'),
                    ),
                    const Icon(Icons.chevron_right, size: 20),
                    TextButton(
                      onPressed: () {},
                      child: const Text('Products'),
                    ),
                    const Icon(Icons.chevron_right, size: 20),
                    TextButton(
                      onPressed: () {},
                      child: const Text('Electronics'),
                    ),
                    const Icon(Icons.chevron_right, size: 20),
                    Text(
                      'Laptops',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ]),
          _buildSection('Stepper', [
            Card(
              child: Stepper(
                currentStep: 1,
                onStepTapped: (step) {},
                steps: const [
                  Step(
                    title: Text('Account'),
                    content: Text('Create your account'),
                    isActive: true,
                    state: StepState.complete,
                  ),
                  Step(
                    title: Text('Profile'),
                    content: Text('Set up your profile'),
                    isActive: true,
                  ),
                  Step(
                    title: Text('Preferences'),
                    content: Text('Configure preferences'),
                    isActive: false,
                  ),
                ],
              ),
            ),
          ]),
        ],
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> children) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 16),
          ...children,
        ],
      ),
    );
  }
}