import 'package:flutter/material.dart';
import 'package:week_3_blabla_project/dummy_data/dummy_data.dart';
import 'package:week_3_blabla_project/theme/theme.dart';
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
  late Location? selectedLocation;
  List<Location> filteredLocations = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    selectedLocation = widget.initialLocation;
    filteredLocations = fakeLocations; 
  }

  void _showLocationDialog() async {
    final Location? result = await showDialog<Location>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            "Select ${widget.label} Location",
            style: BlaTextStyles.heading.copyWith(color: BlaColors.neutralDark),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: "Search for a location...",
                  prefixIcon: Icon(Icons.search, color: BlaColors.neutralLight),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(BlaSpacings.radius),
                  ),
                ),
                onChanged: (query) {
                  if (query.length >= 3) {
                    setState(() {
                      filteredLocations = fakeLocations
                          .where((location) => location.name
                              .toLowerCase()
                              .contains(query.toLowerCase()))
                          .toList();
                    });
                  } else {
                    setState(() {
                      filteredLocations =
                          fakeLocations; 
                    });
                  }
                },
              ),
              const SizedBox(height: BlaSpacings.s),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: filteredLocations.map((location) {
                      return ListTile(
                        title: Text(
                          location.name,
                          style: BlaTextStyles.body
                              .copyWith(color: BlaColors.neutralDark),
                        ),
                        subtitle: Text(
                          location.country.name,
                          style: BlaTextStyles.label
                              .copyWith(color: BlaColors.neutralLight),
                        ),
                        onTap: () => Navigator.pop(context, location),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );

    if (result != null) {
      setState(() {
        selectedLocation = result;
      });
      widget.onLocationSelected(result);
    }
    _searchController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _showLocationDialog,
      child: Container(
        padding: const EdgeInsets.all(BlaSpacings.s),
        decoration: BoxDecoration(
          border: Border.all(color: BlaColors.greyLight),
          borderRadius: BorderRadius.circular(BlaSpacings.radius),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              selectedLocation?.name ?? "Select ${widget.label} Location",
              style: BlaTextStyles.body.copyWith(color: BlaColors.neutralDark),
            ),
            Icon(
              Icons.location_on,
              color: BlaColors.primary,
            ),
          ],
        ),
      ),
    );
  }
}
