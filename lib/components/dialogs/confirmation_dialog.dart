import 'package:flutter/material.dart';
import 'models/dialog_models.dart';
import 'widgets/confirmation_dialog.dart';

/// Public interface for showing confirmation dialogs
class ConfirmationDialog {
  /// Show a confirmation dialog
  static Future<bool?> show(
    BuildContext context, {
    required ConfirmationType type,
    String? title,
    String? message,
    String? confirmText,
    String? cancelText,
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
  }) {
    return showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) => ConfirmationDialogWidget(
        type: type,
        customTitle: title,
        customMessage: message,
        customConfirmText: confirmText,
        customCancelText: cancelText,
        onConfirm: onConfirm,
        onCancel: onCancel,
      ),
    );
  }

  /// Show delete account confirmation
  static Future<bool?> showDeleteAccount(
    BuildContext context, {
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
  }) {
    return show(
      context,
      type: ConfirmationType.deleteAccount,
      onConfirm: onConfirm,
      onCancel: onCancel,
    );
  }

  /// Show unsubscribe confirmation
  static Future<bool?> showUnsubscribe(
    BuildContext context, {
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
  }) {
    return show(
      context,
      type: ConfirmationType.unsubscribe,
      onConfirm: onConfirm,
      onCancel: onCancel,
    );
  }

  /// Show suspend account confirmation
  static Future<bool?> showSuspendAccount(
    BuildContext context, {
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
  }) {
    return show(
      context,
      type: ConfirmationType.suspendAccount,
      onConfirm: onConfirm,
      onCancel: onCancel,
    );
  }

  /// Show delete order confirmation
  static Future<bool?> showDeleteOrder(
    BuildContext context, {
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
  }) {
    return show(
      context,
      type: ConfirmationType.deleteOrder,
      onConfirm: onConfirm,
      onCancel: onCancel,
    );
  }

  /// Show delete customer confirmation
  static Future<bool?> showDeleteCustomer(
    BuildContext context, {
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
  }) {
    return show(
      context,
      type: ConfirmationType.deleteCustomer,
      onConfirm: onConfirm,
      onCancel: onCancel,
    );
  }

  /// Show bulk delete confirmation
  static Future<bool?> showBulkDelete(
    BuildContext context, {
    int itemCount = 0,
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
  }) {
    return show(
      context,
      type: ConfirmationType.bulkDelete,
      title: 'Delete $itemCount items?',
      message: 'This will permanently delete all selected items.',
      onConfirm: onConfirm,
      onCancel: onCancel,
    );
  }

  /// Show permanent action confirmation
  static Future<bool?> showPermanentAction(
    BuildContext context, {
    required String title,
    required String message,
    String confirmText = 'Proceed',
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
  }) {
    return show(
      context,
      type: ConfirmationType.permanentAction,
      title: title,
      message: message,
      confirmText: confirmText,
      onConfirm: onConfirm,
      onCancel: onCancel,
    );
  }
}