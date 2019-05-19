import 'package:events/models/Attendant.dart';
import 'package:events/resources/AppTextStyles.dart';
import 'package:events/resources/Dimens.dart';
import 'package:events/ui/common/Avatar.dart';
import 'package:flutter/material.dart';

class EventGoingGrid extends StatelessWidget {
  final List<User> _attendants;
  static const int MAX_COUNT = 6;

  EventGoingGrid(this._attendants);

  @override
  Widget build(BuildContext context) {
    int totalCount = _attendants.length;
    int gridCount = totalCount;
    if (totalCount > MAX_COUNT) {
      gridCount = MAX_COUNT;
    }

    return Column(
      children: <Widget>[
        NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (OverscrollIndicatorNotification notification) {
            notification.disallowGlow();
          },
          child: GridView.count(
              shrinkWrap: true,
              crossAxisCount: 2,
              childAspectRatio: 4,
              padding: EdgeInsets.symmetric(
                vertical: AppMargins.vertical,
                horizontal: AppMargins.horizontal,
              ),
              children: List.generate(gridCount, (index) {
                User attendant = _attendants[index];

                return Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Avatar(attendant.imagePath),
                    Container(
                      margin: EdgeInsets.only(left: AppMargins.horizontal),
                      child: Text(
                        attendant.name,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.body,
                      ),
                    ),
                  ],
                );
              })),
        ),
        _seeMoreAttendants(totalCount)
      ],
    );
  }

  Widget _seeMoreAttendants(int totalCount) {
    if (totalCount > MAX_COUNT) {
      return Center(
        child: Text(
          "See all $totalCount attendees",
          style: AppTextStyles.body,
        ),
      );
    } else {
      return Container();
    }
  }
}
