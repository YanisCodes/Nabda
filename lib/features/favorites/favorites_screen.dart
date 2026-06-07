import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/theme/app_theme.dart';
import '../../core/utils/animations.dart';
import '../../core/utils/page_route.dart';
import '../../data/local/data_providers.dart';
import '../../l10n/app_localizations.dart';
import '../event_detail/event_detail_screen.dart';
import '../explore/widgets/event_card.dart';
import 'favorites_provider.dart';

class FavoritesScreen extends ConsumerWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final allEvents = ref.watch(eventsListProvider);
    final favoriteIds = ref.watch(favoritesProvider);
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);

    final saved = allEvents.where((e) => favoriteIds.contains(e.id)).toList()
      ..sort((a, b) => a.dateStart.compareTo(b.dateStart));

    return Scaffold(
      appBar: AppBar(title: Text(l10n.navSaved)),
      body: saved.isEmpty
          ? Center(
              child: SlideIn(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.bookmark_border_rounded,
                      size: 48,
                      color: AppColors.textDisabled,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      l10n.noSavedEvents,
                      textAlign: TextAlign.center,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.only(top: 8, bottom: 16),
              itemCount: saved.length,
              itemBuilder: (context, i) => SlideIn(
                verticalOffset: 16,
                child: EventCard(
                  event: saved[i],
                  isFavorite: true,
                  onToggleFavorite: () => ref
                      .read(favoritesProvider.notifier)
                      .toggleFavorite(saved[i].id),
                  onTap: () => Navigator.push(
                    context,
                    AppPageRoute(page: EventDetailScreen(event: saved[i])),
                  ),
                ),
              ),
            ),
    );
  }
}
