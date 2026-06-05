import 'package:flutter/material.dart';

import '../../../core/theme/app_theme.dart';
import '../../../data/models/event.dart';
import '../../../data/models/event_category.dart';

class EventCard extends StatelessWidget {
  const EventCard({super.key, required this.event, this.onTap});

  final Event event;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _ImagePlaceholder(category: event.category),
            Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      _CategoryBadge(category: event.category),
                      const Spacer(),
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
                      const Icon(Icons.calendar_today_outlined,
                          size: 13, color: AppColors.textSecondary),
                      const SizedBox(width: 4),
                      Text(
                        _formatDate(event.dateStart),
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                      const SizedBox(width: 14),
                      const Icon(Icons.location_on_outlined,
                          size: 13, color: AppColors.textSecondary),
                      const SizedBox(width: 4),
                      Text(
                        event.city,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: AppColors.textSecondary,
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

  String _formatDate(DateTime d) {
    const months = [
      'jan', 'fév', 'mar', 'avr', 'mai', 'juin',
      'juil', 'août', 'sep', 'oct', 'nov', 'déc',
    ];
    return '${d.day} ${months[d.month - 1]} ${d.year}';
  }
}

class _ImagePlaceholder extends StatelessWidget {
  const _ImagePlaceholder({required this.category});
  final EventCategory category;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
      child: Container(
        height: 130,
        color: _bgColor(category),
        child: Center(
          child: Icon(
            _icon(category),
            size: 52,
            color: Colors.white.withValues(alpha: 0.2),
          ),
        ),
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

class _CategoryBadge extends StatelessWidget {
  const _CategoryBadge({required this.category});
  final EventCategory category;

  @override
  Widget build(BuildContext context) {
    final (label, color) = switch (category) {
      EventCategory.formation => ('Formation', const Color(0xFF1565C0)),
      EventCategory.sport => ('Sport', const Color(0xFF2E7D32)),
      EventCategory.culture => ('Culture', const Color(0xFF6A1B9A)),
      EventCategory.ecologie => ('Écologie', AppColors.green),
      EventCategory.volontariat => ('Volontariat', const Color(0xFFBF360C)),
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
    final color = isFree ? AppColors.success : AppColors.amber;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: color.withValues(alpha: 0.4)),
      ),
      child: Text(
        isFree ? 'Gratuit' : 'Payant',
        style: TextStyle(
          color: color,
          fontSize: 11,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
