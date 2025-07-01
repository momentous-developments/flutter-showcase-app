import 'package:flutter/material.dart';
import '../models/dialog_models.dart';
import 'base_dialog.dart';
import 'dialog_footer.dart';

/// Multi-step wizard dialog with progress indicator
class StepperDialog extends StatefulWidget {
  const StepperDialog({
    super.key,
    required this.title,
    this.subtitle,
    required this.steps,
    this.onComplete,
    this.onCancel,
    this.size = DialogSize.large,
    this.showProgress = true,
  });

  final String title;
  final String? subtitle;
  final List<DialogStep> steps;
  final VoidCallback? onComplete;
  final VoidCallback? onCancel;
  final DialogSize size;
  final bool showProgress;

  @override
  State<StepperDialog> createState() => _StepperDialogState();
}

class _StepperDialogState extends State<StepperDialog> {
  int _currentStep = 0;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final currentStepData = widget.steps[_currentStep];

    return BaseDialog(
      title: widget.title,
      subtitle: widget.subtitle,
      size: widget.size,
      showCloseButton: true,
      onClose: widget.onCancel ?? () => Navigator.of(context).pop(),
      scrollable: false,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (widget.showProgress) _buildProgressIndicator(),
          Flexible(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 16,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    currentStepData.title,
                    style: theme.textTheme.titleLarge?.copyWith(
                      color: colorScheme.onSurface,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  if (currentStepData.description.isNotEmpty) ...[
                    const SizedBox(height: 8),
                    Text(
                      currentStepData.description,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                  const SizedBox(height: 24),
                  currentStepData.content,
                ],
              ),
            ),
          ),
          _buildStepActions(),
        ],
      ),
    );
  }

  Widget _buildProgressIndicator() {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: colorScheme.outlineVariant,
            width: 1,
          ),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                'Step ${_currentStep + 1} of ${widget.steps.length}',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Spacer(),
              Text(
                '${((_currentStep + 1) / widget.steps.length * 100).round()}%',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: colorScheme.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          LinearProgressIndicator(
            value: (_currentStep + 1) / widget.steps.length,
            backgroundColor: colorScheme.surfaceVariant,
            valueColor: AlwaysStoppedAnimation<Color>(colorScheme.primary),
          ),
        ],
      ),
    );
  }

  Widget _buildStepActions() {
    final isFirstStep = _currentStep == 0;
    final isLastStep = _currentStep == widget.steps.length - 1;
    final currentStep = widget.steps[_currentStep];

    return DialogFooter(
      isLoading: _isLoading,
      tertiaryAction: !isFirstStep
          ? DialogActionButton.outlined(
              text: 'Back',
              onPressed: _isLoading ? null : _goToPreviousStep,
            )
          : null,
      secondaryAction: DialogActionButton.text(
        text: 'Cancel',
        onPressed: _isLoading
            ? null
            : widget.onCancel ?? () => Navigator.of(context).pop(),
      ),
      primaryAction: DialogActionButton.primary(
        text: isLastStep ? 'Complete' : 'Next',
        onPressed: currentStep.canProceed && !_isLoading
            ? isLastStep
                ? _handleComplete
                : _goToNextStep
            : null,
        isLoading: _isLoading && isLastStep,
      ),
    );
  }

  void _goToNextStep() {
    if (_currentStep < widget.steps.length - 1) {
      setState(() {
        _currentStep++;
      });
    }
  }

  void _goToPreviousStep() {
    if (_currentStep > 0) {
      setState(() {
        _currentStep--;
      });
    }
  }

  void _handleComplete() async {
    setState(() {
      _isLoading = true;
    });

    try {
      widget.onComplete?.call();
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }
}

/// Individual step in the stepper dialog
class DialogStep {
  final String title;
  final String description;
  final Widget content;
  final bool canProceed;
  final VoidCallback? onNext;
  final VoidCallback? onPrevious;

  const DialogStep({
    required this.title,
    this.description = '',
    required this.content,
    this.canProceed = true,
    this.onNext,
    this.onPrevious,
  });
}