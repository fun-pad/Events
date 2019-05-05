import 'package:events/models/Event.dart';
import 'package:events/models/EventState.dart';
import 'package:events/resources/AppColors.dart';
import 'package:events/resources/Dimens.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class EventsListItem extends StatelessWidget {
  final Event event;

  EventsListItem({this.event});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.cardRadius),
      ),
      margin: EdgeInsets.only(
        left: Margins.horizontal,
        right: Margins.horizontal,
        top: Margins.vertical,
      ),
      color: AppColors.bgPrimary,
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
              margin: EdgeInsets.only(
                left: Margins.horizontal,
                right: Margins.horizontal,
                top: Margins.vertical,
                bottom: Margins.vertical,
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
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: TextSizes.title,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 2),
                            child: Text(
                              event.when(),
                              style: TextStyle(
                                fontSize: TextSizes.body,
                              ),
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
                                child: Text("${event.attendants.going} people"),
                              ),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      top: Margins.vertical,
                    ),
                    child: Text(
                      event.description,
                      style: TextStyle(
                        fontSize: TextSizes.body,
                        color: AppColors.textLight,
                      ),
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
