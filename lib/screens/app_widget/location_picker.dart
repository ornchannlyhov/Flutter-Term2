import 'package:flutter/material.dart';
import 'package:week_3_blabla_project/dummy_data/dummy_data.dart';
import 'package:week_3_blabla_project/theme/theme.dart';
import 'package:week_3_blabla_project/utils/animations_util.dart';
import '../../../model/ride/locations.dart';

class LocationPicker extends StatefulWidget {
  final String label;
  final Location? initialLocation;
  final void Function(Location) onLocationSelected;

  const LocationPicker({
    super.key,
    required this.label,
    this.initialLocation,
    required this.onLocationSelected,
  });

  @override
  State<LocationPicker> createState() => _LocationPickerState();
}

class _LocationPickerState extends State<LocationPicker> {
  Location? selectedLocation;
  final TextEditingController _searchController = TextEditingController();
  List<Location> _filteredLocations = [];

  @override
  void initState() {
    super.initState();
    selectedLocation = widget.initialLocation;
    _filteredLocations = fakeLocations;
  }

  @override
  void didUpdateWidget(covariant LocationPicker oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialLocation != oldWidget.initialLocation) {
      setState(() {
        selectedLocation = widget.initialLocation;
      });
    }
  }

  void _showLocationDialog() async {
    _searchController.clear();
    _filteredLocations = fakeLocations;

    final Location? result = await Navigator.push(
      context,
      AnimationUtils.createBottomToTopRoute(
        LocationSelectionScreen(
          initialSelection: selectedLocation,
          onLocationSelected: (location) {
            Navigator.pop(context, location);
          },
        ),
      ),
    );

    if (result != null) {
      setState(() {
        selectedLocation = result;
      });
      widget.onLocationSelected(result);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _showLocationDialog,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14),
        child: Row(
          children: [
            Icon(Icons.location_on, color: BlaColors.primary, size: 24),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                selectedLocation?.name ?? 'Select ${widget.label} Location',
                style: BlaTextStyles.body.copyWith(
                  color: selectedLocation != null
                      ? BlaColors.textNormal
                      : BlaColors.textLight,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LocationSelectionScreen extends StatefulWidget {
  final Location? initialSelection;
  final void Function(Location) onLocationSelected;

  const LocationSelectionScreen({
    super.key,
    this.initialSelection,
    required this.onLocationSelected,
  });

  @override
  State<LocationSelectionScreen> createState() =>
      _LocationSelectionScreenState();
}

class _LocationSelectionScreenState extends State<LocationSelectionScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Location> _filteredLocations = fakeLocations;

  void _filterLocations(String query) {
    setState(() {
      _filteredLocations = query.isNotEmpty
          ? fakeLocations
              .where(
                  (loc) => loc.name.toLowerCase().contains(query.toLowerCase()))
              .toList()
          : fakeLocations;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BlaColors.white,
      appBar: AppBar(
        backgroundColor: BlaColors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: BlaColors.textNormal),
          onPressed: () => Navigator.pop(context),
        ),
        title: TextField(
          controller: _searchController,
          autofocus: true,
          decoration: InputDecoration(
            hintText: "Search location",
            border: InputBorder.none,
          ),
          onChanged: _filterLocations,
        ),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: _filteredLocations.length,
        separatorBuilder: (_, __) => Divider(color: BlaColors.greyLight),
        itemBuilder: (context, index) {
          final location = _filteredLocations[index];
          return ListTile(
            title: Text(location.name, style: BlaTextStyles.body),
            subtitle: Text(location.country.name, style: BlaTextStyles.label),
            trailing: Icon(Icons.arrow_forward_ios,
                color: BlaColors.iconLight, size: 16),
            onTap: () => widget.onLocationSelected(location),
          );
        },
      ),
    );
  }
}
