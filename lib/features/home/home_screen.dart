import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/theme/app_theme.dart';
import '../../core/utils/animations.dart';
import '../../core/utils/page_route.dart';
import '../../data/models/center.dart' as model;
import '../../data/models/event.dart';
import '../../data/sync/sync_service.dart';
import '../../l10n/app_localizations.dart';
import '../event_detail/event_detail_screen.dart';
import '../explore/explore_screen.dart';
import '../explore/widgets/event_card.dart';
import '../favorites/favorites_provider.dart';
import '../favorites/favorites_screen.dart';
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
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: [
          _HomeContent(onGoToExplore: _goToExplore),
          const ExploreScreen(),
          const FavoritesScreen(),
          const MapScreen(),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(color: AppColors.borderDark, width: 0.5),
          ),
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (i) => setState(() => _currentIndex = i),
          items: [
            BottomNavigationBarItem(
              icon: const Icon(Icons.home_outlined),
              activeIcon: const Icon(Icons.home_rounded),
              label: l10n.navHome,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.explore_outlined),
              activeIcon: const Icon(Icons.explore_rounded),
              label: l10n.navExplore,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.bookmark_border_rounded),
              activeIcon: const Icon(Icons.bookmark_rounded),
              label: l10n.navSaved,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.map_outlined),
              activeIcon: const Icon(Icons.map_rounded),
              label: l10n.navMap,
            ),
          ],
        ),
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
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.appName),
        actions: [
          IconButton(
            icon: const Icon(Icons.person_outline),
            onPressed: () => Navigator.push(
              context,
              AppPageRoute(page: const ProfileScreen()),
            ),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => ref.read(syncServiceProvider.notifier).syncNow(),
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SlideIn(
                child: _GreetingBanner(
                  city: state.city,
                  showFallback:
                      !state.cityHasEvents && state.upcomingEvents.isNotEmpty,
                ),
              ),
              SlideIn(
                delay: const Duration(milliseconds: 60),
                child: SectionHeader(
                  title: state.isPersonalized
                      ? l10n.sectionForYou
                      : l10n.sectionThisWeek,
                  onSeeAll: onGoToExplore,
                ),
              ),
              SlideIn(
                delay: const Duration(milliseconds: 120),
                child: _EventsSection(
                  events: state.upcomingEvents,
                  onGoToExplore: onGoToExplore,
                ),
              ),
              SlideIn(
                delay: const Duration(milliseconds: 200),
                child: SectionHeader(title: l10n.sectionNearbyCenters),
              ),
              SlideIn(
                delay: const Duration(milliseconds: 260),
                child: _CentersSection(centers: state.centers),
              ),
              const SizedBox(height: 24),
            ],
          ),
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
    final l10n = AppLocalizations.of(context);

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            city.isNotEmpty ? l10n.greetingWithCity(city) : l10n.greetingNoCity,
            style: theme.textTheme.headlineMedium?.copyWith(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w700,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            showFallback && city.isNotEmpty
                ? l10n.homeSubtitleFallback(city)
                : l10n.homeSubtitle,
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

class _EventsSection extends ConsumerWidget {
  const _EventsSection({required this.events, required this.onGoToExplore});
  final List<Event> events;
  final VoidCallback onGoToExplore;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final favoriteIds = ref.watch(favoritesProvider);

    if (events.isEmpty) {
      return _EmptySection(
        icon: Icons.event_busy_rounded,
        message: l10n.noEventsAvailable,
        actionLabel: l10n.btnExploreAll,
        onAction: onGoToExplore,
      );
    }

    return Column(
      children: events
          .map(
            (e) => EventCard(
              event: e,
              isFavorite: favoriteIds.contains(e.id),
              onToggleFavorite: () =>
                  ref.read(favoritesProvider.notifier).toggleFavorite(e.id),
              onTap: () => Navigator.push(
                context,
                AppPageRoute(page: EventDetailScreen(event: e)),
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
    final l10n = AppLocalizations.of(context);

    if (centers.isEmpty) {
      return _EmptySection(
        icon: Icons.business_rounded,
        message: l10n.noCentersFound,
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
    return TapScale(
      child: Padding(
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
                    color: AppColors.green.withValues(alpha: 0.4),
                  ),
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
              Icon(
                Directionality.of(context) == TextDirection.rtl
                    ? Icons.chevron_left_rounded
                    : Icons.chevron_right_rounded,
                color: AppColors.textDisabled,
                size: 20,
              ),
            ],
          ),
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
    return SlideIn(
      child: Padding(
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
              TextButton(onPressed: onAction, child: Text(actionLabel!)),
            ],
          ],
        ),
      ),
    );
  }
}
