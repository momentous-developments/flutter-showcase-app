import 'package:flutter/material.dart';
import '../models/dialog_models.dart';
import 'base_dialog.dart';
import 'dialog_footer.dart';

/// Reusable confirmation dialog for various actions
class ConfirmationDialogWidget extends StatefulWidget {
  const ConfirmationDialogWidget({
    super.key,
    required this.type,
    this.onConfirm,
    this.onCancel,
    this.customTitle,
    this.customMessage,
    this.customConfirmText,
    this.customCancelText,
  });

  final ConfirmationType type;
  final VoidCallback? onConfirm;
  final VoidCallback? onCancel;
  final String? customTitle;
  final String? customMessage;
  final String? customConfirmText;
  final String? customCancelText;

  @override
  State<ConfirmationDialogWidget> createState() =>
      _ConfirmationDialogWidgetState();
}

class _ConfirmationDialogWidgetState extends State<ConfirmationDialogWidget> {
  bool _showSecondDialog = false;
  bool _userConfirmed = false;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    if (_showSecondDialog) {
      return _buildResultDialog();
    }
    return _buildConfirmationDialog();
  }

  Widget _buildConfirmationDialog() {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return BaseDialog(
      size: DialogSize.small,
      showCloseButton: false,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.warning_amber_rounded,
            size: 88,
            color: colorScheme.error,
          ),
          const SizedBox(height: 24),
          Text(
            widget.customTitle ?? _getTitle(),
            style: theme.textTheme.headlineSmall?.copyWith(
              color: colorScheme.onSurface,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            widget.customMessage ?? _getMessage(),
            style: theme.textTheme.bodyMedium?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FilledButton(
                onPressed: _isLoading ? null : () => _handleConfirmation(true),
                style: FilledButton.styleFrom(
                  backgroundColor: colorScheme.error,
                  foregroundColor: colorScheme.onError,
                ),
                child: Text(widget.customConfirmText ?? _getConfirmText()),
              ),
              const SizedBox(width: 12),
              FilledButton.tonal(
                onPressed: _isLoading ? null : () => _handleConfirmation(false),
                child: Text(widget.customCancelText ?? 'Cancel'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildResultDialog() {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return BaseDialog(
      size: DialogSize.small,
      showCloseButton: false,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            _userConfirmed ? Icons.check_circle_rounded : Icons.cancel_rounded,
            size: 88,
            color: _userConfirmed ? colorScheme.primary : colorScheme.error,
          ),
          const SizedBox(height: 24),
          Text(
            _userConfirmed ? _getSuccessTitle() : 'Cancelled',
            style: theme.textTheme.headlineSmall?.copyWith(
              color: colorScheme.onSurface,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            _userConfirmed ? _getSuccessMessage() : _getCancelMessage(),
            style: theme.textTheme.bodyMedium?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          FilledButton(
            onPressed: () {
              Navigator.of(context).pop();
              if (widget.onCancel != null) {
                widget.onCancel!();
              }
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _handleConfirmation(bool confirmed) async {
    setState(() {
      _isLoading = true;
      _userConfirmed = confirmed;
    });

    // Simulate async operation
    await Future.delayed(const Duration(milliseconds: 500));

    setState(() {
      _isLoading = false;
      _showSecondDialog = true;
    });

    if (confirmed && widget.onConfirm != null) {
      widget.onConfirm!();
    }
  }

  String _getTitle() {
    switch (widget.type) {
      case ConfirmationType.deleteAccount:
        return 'Are you sure you want to deactivate your account?';
      case ConfirmationType.unsubscribe:
        return 'Are you sure to cancel your subscription?';
      case ConfirmationType.suspendAccount:
        return 'Are you sure?';
      case ConfirmationType.deleteOrder:
        return 'Are you sure?';
      case ConfirmationType.deleteCustomer:
        return 'Are you sure?';
      case ConfirmationType.bulkDelete:
        return 'Delete multiple items?';
      case ConfirmationType.permanentAction:
        return 'This action cannot be undone';
    }
  }

  String _getMessage() {
    switch (widget.type) {
      case ConfirmationType.deleteAccount:
        return 'This will deactivate your account and you will lose access to all services.';
      case ConfirmationType.unsubscribe:
        return 'You will lose access to premium features immediately.';
      case ConfirmationType.suspendAccount:
        return 'You won\'t be able to revert user!';
      case ConfirmationType.deleteOrder:
        return 'You won\'t be able to revert order!';
      case ConfirmationType.deleteCustomer:
        return 'You won\'t be able to revert customer!';
      case ConfirmationType.bulkDelete:
        return 'Selected items will be permanently deleted.';
      case ConfirmationType.permanentAction:
        return 'Please confirm you want to proceed with this action.';
    }
  }

  String _getConfirmText() {
    switch (widget.type) {
      case ConfirmationType.deleteAccount:
        return 'Yes, Deactivate';
      case ConfirmationType.unsubscribe:
        return 'Yes, Unsubscribe';
      case ConfirmationType.suspendAccount:
        return 'Yes, Suspend User!';
      case ConfirmationType.deleteOrder:
        return 'Yes, Delete Order!';
      case ConfirmationType.deleteCustomer:
        return 'Yes, Delete Customer!';
      case ConfirmationType.bulkDelete:
        return 'Yes, Delete All';
      case ConfirmationType.permanentAction:
        return 'Yes, Proceed';
    }
  }

  String _getSuccessTitle() {
    switch (widget.type) {
      case ConfirmationType.deleteAccount:
        return 'Account Deactivated';
      case ConfirmationType.unsubscribe:
        return 'Unsubscribed';
      case ConfirmationType.suspendAccount:
        return 'User Suspended';
      case ConfirmationType.deleteOrder:
        return 'Order Deleted';
      case ConfirmationType.deleteCustomer:
        return 'Customer Deleted';
      case ConfirmationType.bulkDelete:
        return 'Items Deleted';
      case ConfirmationType.permanentAction:
        return 'Action Completed';
    }
  }

  String _getSuccessMessage() {
    switch (widget.type) {
      case ConfirmationType.deleteAccount:
        return 'Your account has been deactivated successfully.';
      case ConfirmationType.unsubscribe:
        return 'Your subscription has been cancelled successfully.';
      case ConfirmationType.suspendAccount:
        return 'User has been suspended successfully.';
      case ConfirmationType.deleteOrder:
        return 'Order has been deleted successfully.';
      case ConfirmationType.deleteCustomer:
        return 'Customer has been removed successfully.';
      case ConfirmationType.bulkDelete:
        return 'All selected items have been deleted.';
      case ConfirmationType.permanentAction:
        return 'The action has been completed successfully.';
    }
  }

  String _getCancelMessage() {
    switch (widget.type) {
      case ConfirmationType.deleteAccount:
        return 'Account deactivation has been cancelled.';
      case ConfirmationType.unsubscribe:
        return 'Subscription cancellation has been cancelled.';
      case ConfirmationType.suspendAccount:
        return 'User suspension has been cancelled.';
      case ConfirmationType.deleteOrder:
        return 'Order deletion has been cancelled.';
      case ConfirmationType.deleteCustomer:
        return 'Customer deletion has been cancelled.';
      case ConfirmationType.bulkDelete:
        return 'Bulk deletion has been cancelled.';
      case ConfirmationType.permanentAction:
        return 'Action has been cancelled.';
    }
  }
}