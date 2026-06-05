import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/theme/app_theme.dart';
import '../../data/models/center.dart' as model;
import '../../data/models/event.dart';
import '../event_detail/event_detail_screen.dart';
import '../explore/explore_screen.dart';
import '../explore/widgets/event_card.dart';
import '../map/map_screen.dart';
import '../profile/profile_screen.dart';
import 'home_provider.dart';
import 'widgets/section_header.dart';

// ─── Shell de navigation ──────────────────────────────────────────────────────

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  void _goToExplore() => setState(() => _currentIndex = 1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: [
          _HomeContent(onGoToExplore: _goToExplore),
          const ExploreScreen(),
          const MapScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (i) => setState(() => _currentIndex = i),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home_rounded),
            label: 'Accueil',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.explore_outlined),
            activeIcon: Icon(Icons.explore_rounded),
            label: 'Explorer',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map_outlined),
            activeIcon: Icon(Icons.map_rounded),
            label: 'Carte',
          ),
        ],
      ),
    );
  }
}

// ─── Contenu Accueil ──────────────────────────────────────────────────────────

class _HomeContent extends ConsumerWidget {
  const _HomeContent({required this.onGoToExplore});
  final VoidCallback onGoToExplore;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(homeProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('OTEJ Link'),
        actions: [
          IconButton(
            icon: const Icon(Icons.person_outline),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const ProfileScreen(),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _GreetingBanner(
              city: state.city,
              showFallback: !state.cityHasEvents && state.upcomingEvents.isNotEmpty,
            ),
            SectionHeader(
              title: 'Cette semaine',
              onSeeAll: onGoToExplore,
            ),
            _EventsSection(
              events: state.upcomingEvents,
              onGoToExplore: onGoToExplore,
            ),
            SectionHeader(title: 'Centres proches'),
            _CentersSection(centers: state.centers),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

// ─── Bannière de bienvenue ────────────────────────────────────────────────────

class _GreetingBanner extends StatelessWidget {
  const _GreetingBanner({required this.city, required this.showFallback});
  final String city;
  final bool showFallback;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            city.isNotEmpty ? 'Bonjour, $city !' : 'Bonjour !',
            style: theme.textTheme.headlineMedium?.copyWith(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w700,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            showFallback
                ? 'Pas encore d\'événements à $city.\nVoici les prochains événements disponibles.'
                : 'Découvrez les opportunités ODEJ près de chez vous.',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: AppColors.textSecondary,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Section événements ───────────────────────────────────────────────────────

class _EventsSection extends StatelessWidget {
  const _EventsSection({
    required this.events,
    required this.onGoToExplore,
  });
  final List<Event> events;
  final VoidCallback onGoToExplore;

  @override
  Widget build(BuildContext context) {
    if (events.isEmpty) {
      return _EmptySection(
        icon: Icons.event_busy_rounded,
        message: 'Aucun événement disponible pour l\'instant.',
        actionLabel: 'Explorer tout',
        onAction: onGoToExplore,
      );
    }

    return Column(
      children: events
          .map(
            (e) => EventCard(
              event: e,
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => EventDetailScreen(event: e),
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}

// ─── Section centres ──────────────────────────────────────────────────────────

class _CentersSection extends StatelessWidget {
  const _CentersSection({required this.centers});
  final List<model.Center> centers;

  @override
  Widget build(BuildContext context) {
    if (centers.isEmpty) {
      return const _EmptySection(
        icon: Icons.business_rounded,
        message: 'Aucun centre trouvé.',
      );
    }
    return Column(
      children: centers.map((c) => _CenterTile(center: c)).toList(),
    );
  }
}

class _CenterTile extends StatelessWidget {
  const _CenterTile({required this.center});
  final model.Center center;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: AppColors.surfaceVariantDark,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColors.borderDark),
        ),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: AppColors.greenDark,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                    color: AppColors.green.withValues(alpha: 0.4)),
              ),
              child: const Icon(
                Icons.business_rounded,
                color: AppColors.greenLight,
                size: 22,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    center.name,
                    style: theme.textTheme.titleSmall?.copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    center.address,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: AppColors.textSecondary,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    center.hours,
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: AppColors.textDisabled,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.chevron_right_rounded,
              color: AppColors.textDisabled,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}

// ─── État vide réutilisable ───────────────────────────────────────────────────

class _EmptySection extends StatelessWidget {
  const _EmptySection({
    required this.icon,
    required this.message,
    this.actionLabel,
    this.onAction,
  });

  final IconData icon;
  final String message;
  final String? actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: Column(
        children: [
          Icon(icon, size: 36, color: AppColors.textDisabled),
          const SizedBox(height: 10),
          Text(
            message,
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          if (actionLabel != null && onAction != null) ...[
            const SizedBox(height: 12),
            TextButton(
              onPressed: onAction,
              child: Text(actionLabel!),
            ),
          ],
        ],
      ),
    );
  }
}
