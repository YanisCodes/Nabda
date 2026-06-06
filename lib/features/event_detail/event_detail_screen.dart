import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart' as intl;
import 'package:url_launcher/url_launcher.dart';

import '../../core/theme/app_theme.dart';
import '../../data/local/data_providers.dart';
import '../../data/models/center.dart' as model;
import '../../data/models/event.dart';
import '../../data/models/event_category.dart';
import '../../l10n/app_localizations.dart';
import '../map/map_screen.dart';

class EventDetailScreen extends ConsumerWidget {
  const EventDetailScreen({super.key, required this.event});

  final Event event;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final allCenters = ref.watch(centersListProvider);
    final center = event.centerId != null
        ? allCenters.where((c) => c.id == event.centerId).firstOrNull
        : null;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _EventSliverAppBar(event: event),
          SliverToBoxAdapter(
            child: _EventBody(event: event, center: center),
          ),
        ],
      ),
    );
  }
}

// ─── Header collapsible ───────────────────────────────────────────────────────

class _EventSliverAppBar extends StatelessWidget {
  const _EventSliverAppBar({required this.event});
  final Event event;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 210,
      pinned: true,
      title: Text(
        event.title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.pin,
        background: _CategoryHeader(category: event.category),
      ),
    );
  }
}

class _CategoryHeader extends StatelessWidget {
  const _CategoryHeader({required this.category});
  final EventCategory category;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: _bgColor(category),
      child: SizedBox.expand(
        child: Center(
          child: Icon(
            _icon(category),
            size: 80,
            color: Colors.white.withValues(alpha: 0.18),
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

// ─── Corps scrollable ─────────────────────────────────────────────────────────

class _EventBody extends StatelessWidget {
  const _EventBody({required this.event, required this.center});
  final Event event;
  final model.Center? center;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            event.title,
            style: theme.textTheme.headlineSmall?.copyWith(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w700,
              height: 1.3,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              _CategoryBadge(category: event.category),
              const SizedBox(width: 8),
              _PriceBadge(isFree: event.isFree),
            ],
          ),
          const SizedBox(height: 20),
          _InfoRow(
            icon: Icons.calendar_today_outlined,
            text: _formatDateRange(event, Localizations.localeOf(context).toString()),
          ),
          const SizedBox(height: 10),
          _InfoRow(
            icon: Icons.location_on_outlined,
            text: event.city,
          ),
          const SizedBox(height: 20),
          const Divider(height: 1),
          const SizedBox(height: 20),
          Text(
            l10n.sectionAbout,
            style: theme.textTheme.titleMedium?.copyWith(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            event.description,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: AppColors.textSecondary,
              height: 1.6,
            ),
          ),
          if (center != null) ...[
            const SizedBox(height: 24),
            const Divider(height: 1),
            const SizedBox(height: 20),
            _CenterCard(center: center!),
          ],
          const SizedBox(height: 28),
          _ContactButton(center: center),
          const SizedBox(height: 10),
          _MapButton(center: center, city: event.city),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  String _formatDateRange(Event e, String locale) {
    final start = _fmt(e.dateStart, locale);
    if (e.dateEnd == null) return start;
    final end = _fmt(e.dateEnd!, locale);
    if (start == end) {
      return '$start · ${_time(e.dateStart)} – ${_time(e.dateEnd!)}';
    }
    return '$start – $end';
  }

  String _fmt(DateTime d, String locale) {
    final icuLocale = locale.startsWith('tzm') ? 'fr' : locale;
    return intl.DateFormat.yMMMd(icuLocale).format(d);
  }

  String _time(DateTime d) =>
      '${d.hour}h${d.minute.toString().padLeft(2, '0')}';
}

// ─── Widgets internes ─────────────────────────────────────────────────────────

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.icon, required this.text});
  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 16, color: AppColors.green),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.textSecondary,
                ),
          ),
        ),
      ],
    );
  }
}

class _CenterCard extends StatelessWidget {
  const _CenterCard({required this.center});
  final model.Center center;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.sectionOrganizerCenter,
          style: theme.textTheme.titleMedium?.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: AppColors.surfaceVariantDark,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: AppColors.borderDark),
          ),
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
              const SizedBox(height: 8),
              _CenterRow(icon: Icons.location_on_outlined, text: center.address),
              const SizedBox(height: 6),
              _CenterRow(icon: Icons.access_time_outlined, text: center.hours),
              const SizedBox(height: 6),
              _CenterRow(icon: Icons.phone_outlined, text: center.phone),
            ],
          ),
        ),
      ],
    );
  }
}

class _CenterRow extends StatelessWidget {
  const _CenterRow({required this.icon, required this.text});
  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 14, color: AppColors.textDisabled),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.textSecondary,
                ),
          ),
        ),
      ],
    );
  }
}

class _ContactButton extends StatelessWidget {
  const _ContactButton({required this.center});
  final model.Center? center;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final phone = center?.phone;

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: phone != null ? () => _dialPhone(context, phone) : null,
        icon: const Icon(Icons.phone_rounded, size: 18),
        label: Text(l10n.btnContactCenter),
      ),
    );
  }

  Future<void> _dialPhone(BuildContext context, String phone) async {
    final cleaned = phone.replaceAll(' ', '');
    final uri = Uri(scheme: 'tel', path: cleaned);
    if (!await launchUrl(uri)) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context).errorCantOpenPhone),
          ),
        );
      }
    }
  }
}

class _MapButton extends StatelessWidget {
  const _MapButton({required this.center, required this.city});
  final model.Center? center;
  final String city;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final hasLocation = center != null || city.isNotEmpty;

    return SizedBox(
      width: double.infinity,
      child: OutlinedButton.icon(
        onPressed: hasLocation
            ? () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => MapScreen(
                      focusCenter: center,
                      focusCity: center == null ? city : null,
                    ),
                  ),
                )
            : null,
        icon: const Icon(Icons.map_outlined, size: 18),
        label: Text(l10n.btnViewOnMap),
      ),
    );
  }
}

// ─── Badges ───────────────────────────────────────────────────────────────────

class _CategoryBadge extends StatelessWidget {
  const _CategoryBadge({required this.category});
  final EventCategory category;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final (label, color) = switch (category) {
      EventCategory.formation => (l10n.categoryFormation, const Color(0xFF1565C0)),
      EventCategory.sport => (l10n.categorySport, const Color(0xFF2E7D32)),
      EventCategory.culture => (l10n.categoryCulture, const Color(0xFF6A1B9A)),
      EventCategory.ecologie => (l10n.categoryEcologie, AppColors.green),
      EventCategory.volontariat => (l10n.categoryVolontariat, const Color(0xFFBF360C)),
    };
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.18),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: color.withValues(alpha: 0.4)),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 12,
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
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: color.withValues(alpha: 0.4)),
      ),
      child: Text(
        isFree ? l10n.labelFree : l10n.labelPaid,
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
