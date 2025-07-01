import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/simple_calendar_models.dart';

/// Event card widget for displaying events in various calendar views
class EventCard extends StatelessWidget {
  const EventCard({
    super.key,
    required this.event,
    required this.onTap,
    this.showTime = true,
    this.showDate = false,
    this.compact = false,
    this.isDragging = false,
  });

  final CalendarEvent event;
  final VoidCallback onTap;
  final bool showTime;
  final bool showDate;
  final bool compact;
  final bool isDragging;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    if (compact) {
      return _buildCompactCard(theme);
    }
    
    return _buildFullCard(theme);
  }

  /// Build compact event card for month view
  Widget _buildCompactCard(ThemeData theme) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
        margin: const EdgeInsets.only(bottom: 1),
        decoration: BoxDecoration(
          color: isDragging ? event.colorValue.withOpacity(0.3) : event.colorValue,
          borderRadius: BorderRadius.circular(3),
        ),
        child: Text(
          event.allDay ? event.title : '${DateFormat('HH:mm').format(event.startTime)} ${event.title}',
          style: theme.textTheme.bodySmall?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }

  /// Build full event card for list views
  Widget _buildFullCard(ThemeData theme) {
    final colorScheme = theme.colorScheme;
    
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              // Color indicator and time
              Column(
                children: [
                  Container(
                    width: 16,
                    height: 16,
                    decoration: BoxDecoration(
                      color: event.colorValue,
                      shape: BoxShape.circle,
                    ),
                  ),
                  
                  if (showTime && !event.allDay) ...[
                    const SizedBox(height: 8),
                    Text(
                      DateFormat('HH:mm').format(event.startTime),
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ],
              ),
              
              const SizedBox(width: 12),
              
              // Event details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      event.title,
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    
                    if (showDate) ...[
                      const SizedBox(height: 2),
                      Text(
                        DateFormat('EEEE, MMMM d').format(event.startTime),
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                    
                    if (event.location != null && event.location!.isNotEmpty) ...[
                      const SizedBox(height: 2),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            size: 12,
                            color: colorScheme.onSurfaceVariant,
                          ),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              event.location!,
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: colorScheme.onSurfaceVariant,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                    
                    if (event.description != null && event.description!.isNotEmpty) ...[
                      const SizedBox(height: 4),
                      Text(
                        event.description!,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ],
                ),
              ),
              
              // Event type icon
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: event.colorValue.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  event.type.icon,
                  size: 16,
                  color: event.colorValue,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Event chip for timeline views
class EventChip extends StatelessWidget {
  const EventChip({
    super.key,
    required this.event,
    required this.onTap,
    this.height,
    this.width,
  });

  final CalendarEvent event;
  final VoidCallback onTap;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        width: width,
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
        decoration: BoxDecoration(
          color: event.colorValue,
          borderRadius: BorderRadius.circular(4),
          border: Border.all(
            color: event.colorValue.withOpacity(0.3),
            width: 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              event.title,
              style: theme.textTheme.bodySmall?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            
            if (!event.allDay && height != null && height! > 30) ...[
              const SizedBox(height: 2),
              Text(
                event.timeRange,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: Colors.white.withOpacity(0.9),
                  fontSize: 10,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
            
            if (event.location != null && 
                event.location!.isNotEmpty && 
                height != null && 
                height! > 50) ...[
              const SizedBox(height: 2),
              Row(
                children: [
                  Icon(
                    Icons.location_on,
                    size: 10,
                    color: Colors.white.withOpacity(0.9),
                  ),
                  const SizedBox(width: 2),
                  Expanded(
                    child: Text(
                      event.location!,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: Colors.white.withOpacity(0.9),
                        fontSize: 10,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/// Draggable event card
class DraggableEventCard extends StatelessWidget {
  const DraggableEventCard({
    super.key,
    required this.event,
    required this.child,
    required this.onDragStarted,
    required this.onDragEnd,
    this.onTap,
  });

  final CalendarEvent event;
  final Widget child;
  final VoidCallback onDragStarted;
  final VoidCallback onDragEnd;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Draggable<CalendarEvent>(
      data: event,
      feedback: Material(
        elevation: 8,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          width: 200,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: event.colorValue,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                event.title,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              
              if (!event.allDay) ...[
                const SizedBox(height: 4),
                Text(
                  event.timeRange,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
      childWhenDragging: Opacity(
        opacity: 0.5,
        child: child,
      ),
      onDragStarted: onDragStarted,
      onDragEnd: (details) => onDragEnd(),
      child: GestureDetector(
        onTap: onTap,
        child: child,
      ),
    );
  }
}