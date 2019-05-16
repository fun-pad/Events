import 'package:events/models/Event.dart';
import 'package:events/models/EventState.dart';
import 'package:events/resources/AppColors.dart';
import 'package:events/resources/AppTextStyles.dart';
import 'package:events/resources/Dimens.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class EventsListItem extends StatelessWidget {
  final Event event;
  final GestureTapCallback itemSelected;

  EventsListItem({this.event, this.itemSelected});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.cardRadius),
      ),
      margin: EdgeInsets.only(
        left: AppMargins.horizontal,
        right: AppMargins.horizontal,
        top: AppMargins.vertical,
      ),
      color: AppColors.bgPrimary,
      child: InkWell(
        onTap: itemSelected,
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(AppRadius.cardRadius),
                  topRight: Radius.circular(AppRadius.cardRadius),
                ),
                child: Image.asset(
                  event.image.path,
                  fit: BoxFit.fill,
                  height: 120,
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(
                  vertical: AppMargins.vertical,
                  horizontal: AppMargins.horizontal,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              event.name,
                              style: AppTextStyles.title,
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 2),
                              child: Text(
                                event.when(),
                                style: AppTextStyles.body,
                              ),
                            )
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            _getIconForEvent(event),
                            Row(
                              children: <Widget>[
                                Icon(
                                  Icons.people_outline,
                                  color: AppColors.textPrimary,
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                    left: 4,
                                  ),
                                  child:
                                      Text("${event.attendants.going} people"),
                                ),
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        top: AppMargins.vertical,
                      ),
                      child: Text(
                        event.description,
                        style: AppTextStyles.bodyLight,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
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

  Icon _getIconForEvent(Event event) {
    var icon;
    var color;
    if (event.state == EventState.ACCEPTED) {
      icon = Icons.check_circle_outline;
      color = AppColors.green;
    } else if (event.state == EventState.MAYBE) {
      icon = Icons.more_horiz;
      color = AppColors.orange;
    } else {
      icon = Icons.outlined_flag;
      color = AppColors.red;
    }

    return Icon(
      icon,
      color: color,
    );
  }
}
