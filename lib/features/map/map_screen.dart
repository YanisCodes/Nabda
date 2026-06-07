import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/theme/app_theme.dart';
import '../../data/local/mock_repository.dart';
import '../../data/local/preferences.dart';
import '../../data/models/center.dart' as model;
import '../../l10n/app_localizations.dart';

class MapScreen extends ConsumerWidget {
  const MapScreen({super.key, this.focusCenter, this.focusCity});

  /// Centre à mettre en évidence — prioritaire sur focusCity.
  final model.Center? focusCenter;

  /// Ville de secours si focusCenter est null.
  final String? focusCity;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final prefs = ref.read(preferencesProvider);
    final centers = MockRepository.getCenters();
    final (initialPos, initialZoom) = _initialView(prefs.city, centers);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.screenTitleMap)),
      body: FlutterMap(
        options: MapOptions(
          initialCenter: initialPos,
          initialZoom: initialZoom,
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'com.otej.otej_link',
          ),
          MarkerLayer(
            markers: centers.map((c) => _buildMarker(context, c)).toList(),
          ),
        ],
      ),
    );
  }

  Marker _buildMarker(BuildContext context, model.Center center) {
    final isFocused = focusCenter?.id == center.id;
    return Marker(
      point: LatLng(center.lat, center.lng),
      width: isFocused ? 52 : 44,
      height: isFocused ? 52 : 44,
      child: GestureDetector(
        onTap: () => _showSheet(context, center),
        child: _PinIcon(focused: isFocused),
      ),
    );
  }

  /// Priorité : focusCenter → focusCity → ville du profil → centre Algérie.
  (LatLng, double) _initialView(
    String? profileCity,
    List<model.Center> centers,
  ) {
    if (focusCenter != null) {
      return (LatLng(focusCenter!.lat, focusCenter!.lng), 13.0);
    }
    final targetCity = focusCity ?? profileCity;
    if (targetCity != null && targetCity.isNotEmpty) {
      final match = centers.where(
        (c) => c.city.toLowerCase() == targetCity.toLowerCase(),
      );
      if (match.isNotEmpty) {
        final c = match.first;
        return (LatLng(c.lat, c.lng), 11.0);
      }
    }
    return (const LatLng(36.3, 2.0), 7.0);
  }

  void _showSheet(BuildContext context, model.Center center) {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: AppColors.surfaceDark,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) => _CenterSheet(center: center),
    );
  }
}

// ─── Icône marqueur ───────────────────────────────────────────────────────────

class _PinIcon extends StatelessWidget {
  const _PinIcon({this.focused = false});
  final bool focused;

  @override
  Widget build(BuildContext context) {
    final color = focused ? AppColors.amber : AppColors.green;
    return Container(
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.9),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: focused ? 0.7 : 0.5),
            blurRadius: focused ? 12 : 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Icon(
        Icons.business_rounded,
        color: Colors.white,
        size: focused ? 26 : 22,
      ),
    );
  }
}

// ─── Bottom sheet du centre ───────────────────────────────────────────────────

class _CenterSheet extends StatelessWidget {
  const _CenterSheet({required this.center});
  final model.Center center;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 36,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.borderDark,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            center.name,
            style: theme.textTheme.titleLarge?.copyWith(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 14),
          _SheetRow(icon: Icons.location_on_outlined, text: center.address),
          const SizedBox(height: 8),
          _SheetRow(icon: Icons.access_time_outlined, text: center.hours),
          const SizedBox(height: 8),
          _SheetRow(icon: Icons.phone_outlined, text: center.phone),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () => _dialPhone(context, center.phone),
              icon: const Icon(Icons.phone_rounded, size: 18),
              label: Text(l10n.btnContact),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _dialPhone(BuildContext context, String phone) async {
    final uri = Uri(scheme: 'tel', path: phone.replaceAll(' ', ''));
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

class _SheetRow extends StatelessWidget {
  const _SheetRow({required this.icon, required this.text});
  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 16, color: AppColors.green),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            text,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: AppColors.textSecondary),
          ),
        ),
      ],
    );
  }
}
