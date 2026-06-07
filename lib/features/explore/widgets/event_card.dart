import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;

import '../../../core/theme/app_theme.dart';
import '../../../core/utils/animations.dart';
import '../../../data/models/event.dart';
import '../../../data/models/event_category.dart';
import '../../../data/models/event_timing.dart';
import '../../../l10n/app_localizations.dart';

class EventCard extends StatelessWidget {
  const EventCard({
    super.key,
    required this.event,
    this.onTap,
    this.isFavorite = false,
    this.onToggleFavorite,
  });

  final Event event;
  final VoidCallback? onTap;
  final bool isFavorite;
  final VoidCallback? onToggleFavorite;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final locale = Localizations.localeOf(context).toString();
    final timing = event.timingStatus;

    return TapScale(
      onTap: onTap,
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _ImagePlaceholder(
              category: event.category,
              isFavorite: isFavorite,
              onToggleFavorite: onToggleFavorite,
            ),
            Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      _CategoryBadge(category: event.category),
                      const Spacer(),
                      if (timing == EventTimingStatus.soon ||
                          timing == EventTimingStatus.ongoing) ...[
                        _TimingBadge(status: timing),
                        const SizedBox(width: 6),
                      ],
                      _PriceBadge(isFree: event.isFree),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    event.title,
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(
                        Icons.calendar_today_outlined,
                        size: 13,
                        color: AppColors.textSecondary,
                      ),
                      const SizedBox(width: 4),
                      Flexible(
                        child: Text(
                          _formatDate(event.dateStart, locale),
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: AppColors.textSecondary,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 14),
                      const Icon(
                        Icons.location_on_outlined,
                        size: 13,
                        color: AppColors.textSecondary,
                      ),
                      const SizedBox(width: 4),
                      Flexible(
                        child: Text(
                          event.city,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: AppColors.textSecondary,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime d, String locale) {
    final icuLocale = locale.startsWith('tzm') ? 'fr' : locale;
    return intl.DateFormat.yMMMd(icuLocale).format(d);
  }
}

class _ImagePlaceholder extends StatelessWidget {
  const _ImagePlaceholder({
    required this.category,
    this.isFavorite = false,
    this.onToggleFavorite,
  });
  final EventCategory category;
  final bool isFavorite;
  final VoidCallback? onToggleFavorite;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
      child: Stack(
        children: [
          Container(
            height: 140,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: AlignmentDirectional.topStart,
                end: AlignmentDirectional.bottomEnd,
                colors: [
                  Color.lerp(_bgColor(category), Colors.white, 0.07)!,
                  _bgColor(category),
                ],
              ),
            ),
            child: Center(
              child: Icon(
                _icon(category),
                size: 56,
                color: Colors.white.withValues(alpha: 0.08),
              ),
            ),
          ),
          if (onToggleFavorite != null)
            Positioned(
              top: 8,
              right: 8,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.25),
                  shape: BoxShape.circle,
                ),
                child: AnimatedFavoriteIcon(
                  isFavorite: isFavorite,
                  onTap: onToggleFavorite,
                  size: 20,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Color _bgColor(EventCategory c) => switch (c) {
    EventCategory.formation => const Color(0xFF1A3A5C),
    EventCategory.sport => const Color(0xFF1A4A2E),
    EventCategory.culture => const Color(0xFF3A1A4A),
    EventCategory.ecologie => const Color(0xFF1A4A20),
    EventCategory.volontariat => const Color(0xFF4A2A1A),
  };

  IconData _icon(EventCategory c) => switch (c) {
    EventCategory.formation => Icons.school_rounded,
    EventCategory.sport => Icons.sports_soccer_rounded,
    EventCategory.culture => Icons.theater_comedy_rounded,
    EventCategory.ecologie => Icons.eco_rounded,
    EventCategory.volontariat => Icons.volunteer_activism_rounded,
  };
}

class _TimingBadge extends StatelessWidget {
  const _TimingBadge({required this.status});
  final EventTimingStatus status;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final (label, color) = switch (status) {
      EventTimingStatus.ongoing => (l10n.labelOngoing, AppColors.success),
      EventTimingStatus.soon => (l10n.labelSoon, AppColors.amber),
      _ => ('', Colors.transparent),
    };
    if (label.isEmpty) return const SizedBox.shrink();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: color.withValues(alpha: 0.4)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.access_time_rounded, size: 10, color: color),
          const SizedBox(width: 3),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _CategoryBadge extends StatelessWidget {
  const _CategoryBadge({required this.category});
  final EventCategory category;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final (label, color) = switch (category) {
      EventCategory.formation => (
        l10n.categoryFormation,
        const Color(0xFF1565C0),
      ),
      EventCategory.sport => (l10n.categorySport, const Color(0xFF2E7D32)),
      EventCategory.culture => (l10n.categoryCulture, const Color(0xFF6A1B9A)),
      EventCategory.ecologie => (l10n.categoryEcologie, AppColors.green),
      EventCategory.volontariat => (
        l10n.categoryVolontariat,
        const Color(0xFFBF360C),
      ),
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.18),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: color.withValues(alpha: 0.4)),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 11,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _PriceBadge extends StatelessWidget {
  const _PriceBadge({required this.isFree});
  final bool isFree;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final color = isFree ? AppColors.success : AppColors.amber;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: color.withValues(alpha: 0.4)),
      ),
      child: Text(
        isFree ? l10n.labelFree : l10n.labelPaid,
        style: TextStyle(
          color: color,
          fontSize: 11,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
