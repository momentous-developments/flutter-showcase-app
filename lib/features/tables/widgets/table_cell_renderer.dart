import 'package:flutter/material.dart';
import '../models/table_models.dart';

class TableCellRenderer {
  static Widget render({
    required BuildContext context,
    required TableColumn column,
    required dynamic value,
    required TableRowData row,
  }) {
    if (column.customRenderer != null) {
      return column.customRenderer!(value, row);
    }
    
    switch (column.type) {
      case ColumnType.text:
        return _renderText(context, column, value);
        
      case ColumnType.number:
        return _renderNumber(context, column, value);
        
      case ColumnType.currency:
        return _renderCurrency(context, column, value);
        
      case ColumnType.percentage:
        return _renderPercentage(context, column, value);
        
      case ColumnType.date:
      case ColumnType.dateTime:
        return _renderDate(context, column, value);
        
      case ColumnType.boolean:
        return _renderBoolean(context, column, value);
        
      case ColumnType.status:
        return _renderStatus(context, column, value);
        
      case ColumnType.badge:
        return _renderBadge(context, column, value);
        
      case ColumnType.image:
        return _renderImage(context, column, value);
        
      case ColumnType.avatar:
        return _renderAvatar(context, column, value);
        
      case ColumnType.rating:
        return _renderRating(context, column, value);
        
      case ColumnType.progress:
        return _renderProgress(context, column, value);
        
      case ColumnType.actions:
        return _renderActions(context, column, value, row);
        
      case ColumnType.custom:
      default:
        return _renderText(context, column, value);
    }
  }
  
  static Widget _renderText(BuildContext context, TableColumn column, dynamic value) {
    final text = column.formatter?.call(value) ?? value?.toString() ?? '';
    return Text(
      text,
      style: Theme.of(context).textTheme.bodyMedium,
      textAlign: column.align,
      overflow: TextOverflow.ellipsis,
    );
  }
  
  static Widget _renderNumber(BuildContext context, TableColumn column, dynamic value) {
    if (value == null) return const Text('');
    
    final format = column.format;
    String formattedValue = value.toString();
    
    if (format != null) {
      final numValue = value is num ? value : num.tryParse(value.toString()) ?? 0;
      
      if (format.decimalPlaces != null) {
        formattedValue = numValue.toStringAsFixed(format.decimalPlaces!);
      }
      
      if (format.thousandSeparator != null) {
        final parts = formattedValue.split('.');
        parts[0] = parts[0].replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (match) => '${match[1]}${format.thousandSeparator}',
        );
        formattedValue = parts.join('.');
      }
      
      if (format.prefix != null) formattedValue = '${format.prefix}$formattedValue';
      if (format.suffix != null) formattedValue = '$formattedValue${format.suffix}';
    }
    
    return Text(
      formattedValue,
      style: Theme.of(context).textTheme.bodyMedium,
      textAlign: column.align ?? TextAlign.right,
    );
  }
  
  static Widget _renderCurrency(BuildContext context, TableColumn column, dynamic value) {
    if (value == null) return const Text('');
    
    final format = column.format;
    final numValue = value is num ? value : num.tryParse(value.toString()) ?? 0;
    String formattedValue = numValue.toStringAsFixed(format?.decimalPlaces ?? 2);
    
    // Add thousand separators
    final parts = formattedValue.split('.');
    parts[0] = parts[0].replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (match) => '${match[1]},',
    );
    formattedValue = parts.join('.');
    
    formattedValue = '${format?.currencySymbol ?? '\$'}$formattedValue';
    
    return Text(
      formattedValue,
      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
        fontWeight: FontWeight.w500,
      ),
      textAlign: column.align ?? TextAlign.right,
    );
  }
  
  static Widget _renderPercentage(BuildContext context, TableColumn column, dynamic value) {
    if (value == null) return const Text('');
    
    final format = column.format;
    final numValue = value is num ? value : num.tryParse(value.toString()) ?? 0;
    String formattedValue = numValue.toStringAsFixed(format?.decimalPlaces ?? 0);
    formattedValue = '$formattedValue%';
    
    return Text(
      formattedValue,
      style: Theme.of(context).textTheme.bodyMedium,
      textAlign: column.align ?? TextAlign.right,
    );
  }
  
  static Widget _renderDate(BuildContext context, TableColumn column, dynamic value) {
    if (value == null) return const Text('');
    
    final date = value is DateTime ? value : DateTime.tryParse(value.toString());
    if (date == null) return Text(value.toString());
    
    final formatted = column.formatter?.call(date) ?? _defaultDateFormat(date, column.type == ColumnType.dateTime);
    
    return Text(
      formatted,
      style: Theme.of(context).textTheme.bodyMedium,
      textAlign: column.align,
    );
  }
  
  static String _defaultDateFormat(DateTime date, bool includeTime) {
    final dateStr = '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
    if (!includeTime) return dateStr;
    
    final timeStr = '${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
    return '$dateStr $timeStr';
  }
  
  static Widget _renderBoolean(BuildContext context, TableColumn column, dynamic value) {
    final isTrue = value == true || value?.toString().toLowerCase() == 'true';
    
    return Icon(
      isTrue ? Icons.check_circle : Icons.cancel,
      color: isTrue
          ? Theme.of(context).colorScheme.primary
          : Theme.of(context).colorScheme.error,
      size: 20,
    );
  }
  
  static Widget _renderStatus(BuildContext context, TableColumn column, dynamic value) {
    if (value == null) return const Text('');
    
    final statusConfig = column.format?.statusConfig?[value.toString()];
    if (statusConfig == null) {
      return Text(value.toString());
    }
    
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (statusConfig.icon != null) ...[
          Icon(statusConfig.icon, size: 16, color: statusConfig.color),
          const SizedBox(width: 4),
        ],
        Text(
          statusConfig.label,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: statusConfig.color,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
  
  static Widget _renderBadge(BuildContext context, TableColumn column, dynamic value) {
    if (value == null) return const Text('');
    
    final badgeConfig = column.format?.badgeConfig?[value.toString()];
    if (badgeConfig == null) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondaryContainer,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          value.toString(),
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Theme.of(context).colorScheme.onSecondaryContainer,
            fontWeight: FontWeight.w500,
          ),
        ),
      );
    }
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: badgeConfig.backgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (badgeConfig.icon != null) ...[
            Icon(badgeConfig.icon, size: 14, color: badgeConfig.textColor),
            const SizedBox(width: 4),
          ],
          Text(
            badgeConfig.label,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: badgeConfig.textColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
  
  static Widget _renderImage(BuildContext context, TableColumn column, dynamic value) {
    if (value == null || value.toString().isEmpty) {
      return Container(
        width: column.width ?? 60,
        height: column.width ?? 60,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceVariant,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Icon(
          Icons.image,
          color: Theme.of(context).colorScheme.onSurfaceVariant,
        ),
      );
    }
    
    return ClipRRect(
      borderRadius: BorderRadius.circular(4),
      child: Image.network(
        value.toString(),
        width: column.width ?? 60,
        height: column.width ?? 60,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            width: column.width ?? 60,
            height: column.width ?? 60,
            color: Theme.of(context).colorScheme.surfaceVariant,
            child: Icon(
              Icons.broken_image,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          );
        },
      ),
    );
  }
  
  static Widget _renderAvatar(BuildContext context, TableColumn column, dynamic value) {
    return CircleAvatar(
      radius: 20,
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      backgroundImage: value != null && value.toString().isNotEmpty
          ? NetworkImage(value.toString())
          : null,
      onBackgroundImageError: value != null ? (exception, stackTrace) {} : null,
      child: value == null || value.toString().isEmpty
          ? Icon(
              Icons.person,
              color: Theme.of(context).colorScheme.onPrimaryContainer,
            )
          : null,
    );
  }
  
  static Widget _renderRating(BuildContext context, TableColumn column, dynamic value) {
    if (value == null) return const Text('-');
    
    final rating = (value is num ? value : num.tryParse(value.toString()) ?? 0).toDouble();
    final maxRating = 5;
    
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        ...List.generate(maxRating, (index) {
          if (index < rating.floor()) {
            return const Icon(Icons.star, size: 16, color: Colors.amber);
          } else if (index < rating) {
            return const Icon(Icons.star_half, size: 16, color: Colors.amber);
          } else {
            return const Icon(Icons.star_border, size: 16, color: Colors.amber);
          }
        }),
        const SizedBox(width: 4),
        Text(
          rating.toStringAsFixed(1),
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }
  
  static Widget _renderProgress(BuildContext context, TableColumn column, dynamic value) {
    if (value == null) return const Text('-');
    
    final progress = (value is num ? value : num.tryParse(value.toString()) ?? 0) / 100;
    final color = progress < 0.3
        ? Theme.of(context).colorScheme.error
        : progress < 0.7
            ? Theme.of(context).colorScheme.tertiary
            : Theme.of(context).colorScheme.primary;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          '${(progress * 100).toInt()}%',
          style: Theme.of(context).textTheme.bodySmall,
        ),
        const SizedBox(height: 4),
        Container(
          width: column.width ?? 100,
          height: 6,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceVariant,
            borderRadius: BorderRadius.circular(3),
          ),
          child: FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: progress.clamp(0.0, 1.0),
            child: Container(
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(3),
              ),
            ),
          ),
        ),
      ],
    );
  }
  
  static Widget _renderActions(BuildContext context, TableColumn column, dynamic value, TableRowData row) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: const Icon(Icons.visibility),
          iconSize: 20,
          onPressed: () {
            // Handle view action
          },
          tooltip: 'View',
          splashRadius: 20,
        ),
        IconButton(
          icon: const Icon(Icons.edit),
          iconSize: 20,
          onPressed: !row.disabled ? () {
            // Handle edit action
          } : null,
          tooltip: 'Edit',
          splashRadius: 20,
        ),
        IconButton(
          icon: const Icon(Icons.delete),
          iconSize: 20,
          onPressed: !row.disabled ? () {
            // Handle delete action
          } : null,
          tooltip: 'Delete',
          splashRadius: 20,
        ),
      ],
    );
  }
}