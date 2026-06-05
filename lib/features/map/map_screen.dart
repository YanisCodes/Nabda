import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/theme/app_theme.dart';
import '../../data/local/mock_repository.dart';
import '../../data/local/preferences.dart';
import '../../data/models/center.dart' as model;

class MapScreen extends ConsumerWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final prefs = ref.read(preferencesProvider);
    final centers = MockRepository.getCenters();
    final (initialPos, initialZoom) = _initialView(prefs.city, centers);

    return Scaffold(
      appBar: AppBar(title: const Text('Centres ODEJ')),
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
            markers: centers
                .map((c) => _buildMarker(context, c))
                .toList(),
          ),
        ],
      ),
    );
  }

  Marker _buildMarker(BuildContext context, model.Center center) {
    return Marker(
      point: LatLng(center.lat, center.lng),
      width: 44,
      height: 44,
      child: GestureDetector(
        onTap: () => _showSheet(context, center),
        child: const _PinIcon(),
      ),
    );
  }

  /// Retourne la position initiale et le zoom selon la ville du profil.
  (LatLng, double) _initialView(String? city, List<model.Center> centers) {
    if (city != null && city.isNotEmpty) {
      final match = centers.where(
        (c) => c.city.toLowerCase() == city.toLowerCase(),
      );
      if (match.isNotEmpty) {
        final c = match.first;
        return (LatLng(c.lat, c.lng), 11.0);
      }
    }
    // Vue par défaut : nord de l'Algérie — tous les centres visibles
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
  const _PinIcon();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.green,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white.withValues(alpha: 0.9), width: 2),
        boxShadow: [
          BoxShadow(
            color: AppColors.green.withValues(alpha: 0.5),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: const Icon(
        Icons.business_rounded,
        color: Colors.white,
        size: 22,
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

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Poignée
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

          // Nom
          Text(
            center.name,
            style: theme.textTheme.titleLarge?.copyWith(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 14),

          // Infos
          _SheetRow(icon: Icons.location_on_outlined, text: center.address),
          const SizedBox(height: 8),
          _SheetRow(icon: Icons.access_time_outlined, text: center.hours),
          const SizedBox(height: 8),
          _SheetRow(icon: Icons.phone_outlined, text: center.phone),
          const SizedBox(height: 20),

          // Bouton contact
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () => _dialPhone(context, center.phone),
              icon: const Icon(Icons.phone_rounded, size: 18),
              label: const Text('Contacter'),
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
          const SnackBar(
            content: Text('Impossible d\'ouvrir l\'application téléphone'),
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
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.textSecondary,
                ),
          ),
        ),
      ],
    );
  }
}
