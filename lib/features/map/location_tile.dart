import 'package:aero_glace_app/util/theme.dart';
import 'package:aero_glace_app/widgets/glossy_box.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:latlong2/latlong.dart';

/// Widget affichant les informations d’une boutique et permettant d’interagir avec la carte.
///
/// Affiche l’adresse de la boutique et le bouton pour générer l'itinéraire depuis la location d'utilisateur.
///
/// Arguments :
/// - [city] : nom de la ville où se situe la boutique.
/// - [address] : adresse complète de la boutique.
/// - [coordinates] : latitude et longitude de la boutique ([LatLng]).
/// - [onPressed] : callback exécuté lorsque l’utilisateur appuie sur le bouton de navigation.
class LocationTile extends StatefulWidget {
  /// Nom de la ville de la boutique.
  final String city;

  /// Adresse complète de la boutique.
  final String address;

  /// Coordonnées GPS de la boutique ([LatLng]).
  final LatLng coordinates;

  /// Callback appelé lorsque l'utilisateur appuie sur le bouton de navigation.
  final void Function(LatLng)? onPressed;

  /// Crée un widget [LocationTile].
  const LocationTile({
    super.key,
    required this.city,
    required this.address,
    required this.coordinates,
    required this.onPressed,
  });

  @override
  State<LocationTile> createState() => _LocationTileState();
}

class _LocationTileState extends State<LocationTile> {
  @override
  Widget build(BuildContext context) {
    return GlossyBox(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: 12,
            children: [
              Icon(
                LucideIcons.mapPin300,
                size: 25,
                color: context.colorSchema.primary,
              ),

              // Nom et adresse de la boutique.
              Flexible(
                fit: FlexFit.tight,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '${context.tr('aero_glace')} - ${widget.city}',
                      style: context.textTheme.titleMedium,
                    ),
                    Text(
                      widget.address,
                      style: context.textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),

              // Bouton pour générer un itinéraire
              IconButton(
                onPressed: () => widget.onPressed!(widget.coordinates),
                style: IconButton.styleFrom(
                  padding: const EdgeInsets.all(12),
                  backgroundColor: context.colorSchema.primaryContainer,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                icon: Icon(
                  LucideIcons.navigation,
                  size: 25,
                  color: context.colorSchema.onPrimaryContainer,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
