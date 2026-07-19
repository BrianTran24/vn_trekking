import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import '../../application/trekking_bloc.dart';
import '../../domain/trekking_location.dart';
import '../../infrastructure/mock_trekking_repository.dart';

class TrailsPage extends StatelessWidget {
  const TrailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TrekkingBloc(
        repository: MockTrekkingRepository(),
      )..add(FetchTrekkingLocations()),
      child: const TrailsView(),
    );
  }
}

class TrailsView extends StatefulWidget {
  const TrailsView({super.key});

  @override
  State<TrailsView> createState() => _TrailsViewState();
}

class _TrailsViewState extends State<TrailsView> {
  final MapController _mapController = MapController();
  bool _isExpanded = true;
  static const double _panelWidth = 400.0;
  static const double _collapsedOffset = -350.0; // Keep 50px visible for the toggle button

  Future<void> _handleMyLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Location services are disabled.')),
        );
      }
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied.')),
          );
        }
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
                'Location permissions are permanently denied, we cannot request permissions.'),
          ),
        );
      }
      return;
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    try {
      final position = await Geolocator.getCurrentPosition();
      _mapController.move(
        LatLng(position.latitude, position.longitude),
        15.0,
      );
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error getting location: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // The Map Layer
          FlutterMap(
            mapController: _mapController,
            options: const MapOptions(
              initialCenter: LatLng(22.3364, 103.8438), // Sa Pa, Vietnam
              initialZoom: 13.0,
              interactionOptions: InteractionOptions(
                flags: InteractiveFlag.all & ~InteractiveFlag.scrollWheelZoom,
                pinchZoomWinGestures: MultiFingerGesture.pinchZoom | MultiFingerGesture.pinchMove,
              ),
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.example.vn_trekking',
              ),
              CurrentLocationLayer(),
              BlocBuilder<TrekkingBloc, TrekkingState>(
                builder: (context, state) {
                  if (state is TrekkingLoaded) {
                    return MarkerLayer(
                      markers: state.locations.map((location) {
                        return Marker(
                          point: LatLng(location.latitude, location.longitude),
                          width: 40,
                          height: 40,
                          child: const Icon(
                            Icons.location_on,
                            color: Colors.red,
                            size: 30,
                          ),
                        );
                      }).toList(),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ],
          ),

          // Zoom Controls (Bottom Right)
          Positioned(
            right: 20,
            bottom: 20,
            child: Column(
              children: [
                FloatingActionButton(
                  mini: true,
                  heroTag: 'zoom_in',
                  backgroundColor: Colors.white.withAlpha((0.9 * 255).toInt()),
                  child: Icon(Icons.add, color: Colors.green[800]),
                  onPressed: () {
                    final currentZoom = _mapController.camera.zoom;
                    _mapController.move(_mapController.camera.center, currentZoom + 1);
                  },
                ),
                const SizedBox(height: 10),
                FloatingActionButton(
                  mini: true,
                  heroTag: 'zoom_out',
                  backgroundColor: Colors.white.withAlpha((0.9 * 255).toInt()),
                  child: Icon(Icons.remove, color: Colors.green[800]),
                  onPressed: () {
                    final currentZoom = _mapController.camera.zoom;
                    _mapController.move(_mapController.camera.center, currentZoom - 1);
                  },
                ),
                const SizedBox(height: 10),
                FloatingActionButton(
                  mini: true,
                  heroTag: 'my_location',
                  backgroundColor: Colors.white.withAlpha((0.9 * 255).toInt()),
                  onPressed: _handleMyLocation,
                  child: Icon(Icons.my_location, color: Colors.green[800]),
                ),
              ],
            ),
          ),

          // Location List Overlay (Left side)
          AnimatedPositioned(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            left: _isExpanded ? 20 : _collapsedOffset,
            top: 20,
            bottom: 20,
            width: _panelWidth,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white.withAlpha((0.95 * 255).toInt()),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha((0.1 * 255).toInt()),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Opacity(
                            opacity: _isExpanded ? 1.0 : 0.0,
                            child: Text(
                              'Trekking Locations',
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green[800],
                                  ),
                            ),
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            _isExpanded ? Icons.chevron_left : Icons.chevron_right,
                            color: Colors.green[800],
                          ),
                          onPressed: () {
                            setState(() {
                              _isExpanded = !_isExpanded;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  const Divider(height: 1),
                  Expanded(
                    child: Opacity(
                      opacity: _isExpanded ? 1.0 : 0.0,
                      child: IgnorePointer(
                        ignoring: !_isExpanded,
                        child: BlocBuilder<TrekkingBloc, TrekkingState>(
                          builder: (context, state) {
                            if (state is TrekkingLoading) {
                              return const Center(child: CircularProgressIndicator());
                            } else if (state is TrekkingLoaded) {
                              return ListView.separated(
                                padding: const EdgeInsets.all(10),
                                itemCount: state.locations.length,
                                separatorBuilder: (context, index) =>
                                    const SizedBox(height: 10),
                                itemBuilder: (context, index) {
                                  final location = state.locations[index];
                                  return LocationCard(location: location);
                                },
                              );
                            } else if (state is TrekkingError) {
                              return Center(child: Text(state.message));
                            }
                            return const SizedBox.shrink();
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class LocationCard extends StatelessWidget {
  final TrekkingLocation location;

  const LocationCard({super.key, required this.location});

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          // Handle location tap (e.g., move map to location)
        },
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey[200]!),
          ),
          child: Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.green[50],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text(
                    location.icon,
                    style: const TextStyle(fontSize: 24),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      location.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(Icons.directions_walk,
                            size: 14, color: Colors.grey[600]),
                        const SizedBox(width: 4),
                        Text(
                          location.distance,
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(width: 12),
                        DifficultyBadge(difficulty: location.difficulty),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DifficultyBadge extends StatelessWidget {
  final TrekkingDifficulty difficulty;

  const DifficultyBadge({super.key, required this.difficulty});

  @override
  Widget build(BuildContext context) {
    final color = _getDifficultyColor(difficulty);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: color.withAlpha((0.1 * 255).toInt()),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        difficulty.name.toUpperCase(),
        style: TextStyle(
          color: color,
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Color _getDifficultyColor(TrekkingDifficulty difficulty) {
    switch (difficulty) {
      case TrekkingDifficulty.easy:
        return Colors.green;
      case TrekkingDifficulty.moderate:
        return Colors.orange;
      case TrekkingDifficulty.hard:
        return Colors.red;
    }
  }
}
