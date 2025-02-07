import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:wheelmap/common/constants/app_colors.dart';
import 'package:wheelmap/common/constants/app_strings.dart';
import 'package:wheelmap/presentation/common_widgets/custom_network_image.dart';
import 'package:wheelmap/presentation/common_widgets/text_widgets.dart';
import 'package:wheelmap/presentation/plan/plan_view.dart';
import 'package:wheelmap/domain/entities/routes.dart';

class SquareRouteCard extends StatelessWidget {
  final String routeImagePath;
  final String routeTitle;
  final String routeLocation;
  final String routeDescription;
  final String routeRating;
  final List<Waypoint> routeWaypoints;

  const SquareRouteCard({
    Key? key,
    required this.routeImagePath,
    required this.routeTitle,
    required this.routeLocation,
    required this.routeDescription,
    required this.routeRating,
    required this.routeWaypoints
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.4,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(12),
        ),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          //TODO:- Pass the necessary data to Plan view from here.
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                List<List<double>> coordinates = [];
                for (Waypoint waypoint in routeWaypoints.cast<Waypoint>()){
                  coordinates.add([waypoint.longitude, waypoint.latitude]);
                }
                return PlansView(
                    isDefault: false,
                    coordinates: coordinates
                );
              },

            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: SizedBox(
                      height: 150.0,
                      width: 250.0,
                      child: CustomNetworkImage(
                        imageUrl: routeImagePath,
                      ),
                    ),
                  ),
              ),
              const SizedBox(height: 5),
              SquareRouteCardTextInfo(
                  routeTitle: routeTitle,
                  routeLocation: routeLocation,
                  routeDescription: routeDescription,
                  routeRating: routeRating
              )
            ],
          ),
        ),
      ),
    );
  }
}

class SquareRouteCardTextInfo extends StatelessWidget {
  final String routeTitle;
  final String routeLocation;
  final String routeDescription;
  final String routeRating;

  const SquareRouteCardTextInfo({
    Key? key,
    required this.routeTitle,
    required this.routeLocation,
    required this.routeDescription,
    required this.routeRating,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: RouteCardTitle(text: routeTitle)),
            Icon(
              Icons.star,
              color: Colors.yellow.shade700,
              size: 14,
            ),
            RouteCardRating(text: routeRating)
          ],
        ),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 4.0),
              child: Icon(
                Ionicons.location,
                color: Theme.of(context).primaryColor,
                size: 16,
              ),
            ),
            const SizedBox(width: 2),
            RouteCardLocation(text: routeLocation)
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 5.0),
          child: Row(
            children: [
              RouteCardDescription(text: routeDescription),
              Expanded(child: Container()),
              TextButtonLabel(
                  text: AppStrings.routeButtonText,
                  style: Theme.of(context).textTheme.labelMedium),
              Icon(Icons.arrow_forward_ios,
                  size: 10, color: AppColors.amberSubtitleTextColor)
            ],
          ),
        )
      ],
    );
  }
}
