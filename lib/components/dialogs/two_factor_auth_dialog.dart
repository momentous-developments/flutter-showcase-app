import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'models/dialog_models.dart';
import 'widgets/stepper_dialog.dart';
import 'widgets/form_dialog.dart';

/// Dialog for setting up two-factor authentication
class TwoFactorAuthDialog extends StatefulWidget {
  const TwoFactorAuthDialog({
    super.key,
    this.currentData,
    this.onComplete,
    this.onCancel,
  });

  final TwoFactorAuthData? currentData;
  final Function(TwoFactorAuthData)? onComplete;
  final VoidCallback? onCancel;

  @override
  State<TwoFactorAuthDialog> createState() => _TwoFactorAuthDialogState();
}

class _TwoFactorAuthDialogState extends State<TwoFactorAuthDialog> {
  late TwoFactorAuthData _authData;
  String _verificationCode = '';
  bool _isVerifying = false;

  @override
  void initState() {
    super.initState();
    _authData = widget.currentData ?? const TwoFactorAuthData();
  }

  @override
  Widget build(BuildContext context) {
    return StepperDialog(
      title: 'Two-Factor Authentication',
      subtitle: 'Secure your account with 2FA',
      steps: [
        DialogStep(
          title: 'Choose Method',
          description: 'Select your preferred 2FA method',
          content: _buildMethodStep(),
          canProceed: _authData.method.isNotEmpty,
        ),
        DialogStep(
          title: 'Setup Authentication',
          description: _getSetupDescription(),
          content: _buildSetupStep(),
          canProceed: _canProceedFromSetup(),
        ),
        DialogStep(
          title: 'Verify Setup',
          description: 'Confirm your 2FA setup by entering a code',
          content: _buildVerifyStep(),
          canProceed: _verificationCode.length == 6 && !_isVerifying,
        ),
        DialogStep(
          title: 'Backup Codes',
          description: 'Save these backup codes in a secure location',
          content: _buildBackupStep(),
          canProceed: true,
        ),
      ],
      onComplete: () {
        final finalData = _authData.copyWith(isEnabled: true);
        widget.onComplete?.call(finalData);
        Navigator.of(context).pop();
      },
      onCancel: widget.onCancel,
    );
  }

  Widget _buildMethodStep() {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final methods = [
      AuthMethod(
        id: 'app',
        name: 'Authenticator App',
        description: 'Use an app like Google Authenticator or Authy',
        icon: Icons.smartphone,
        isRecommended: true,
      ),
      AuthMethod(
        id: 'sms',
        name: 'SMS Messages',
        description: 'Receive codes via text message',
        icon: Icons.sms,
      ),
      AuthMethod(
        id: 'email',
        name: 'Email',
        description: 'Receive codes via email',
        icon: Icons.email,
      ),
    ];

    return Column(
      children: methods.map((method) {
        final isSelected = _authData.method == method.id;
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Material(
            color: isSelected
                ? colorScheme.primaryContainer
                : colorScheme.surfaceVariant,
            borderRadius: BorderRadius.circular(12),
            child: InkWell(
              onTap: () {
                setState(() {
                  _authData = _authData.copyWith(method: method.id);
                });
              },
              borderRadius: BorderRadius.circular(12),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: colorScheme.primary.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        method.icon,
                        color: colorScheme.primary,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                method.name,
                                style: theme.textTheme.titleMedium?.copyWith(
                                  color: isSelected
                                      ? colorScheme.onPrimaryContainer
                                      : colorScheme.onSurfaceVariant,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              if (method.isRecommended) ...[
                                const SizedBox(width: 8),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 6,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: colorScheme.primary,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Text(
                                    'Recommended',
                                    style: theme.textTheme.bodySmall?.copyWith(
                                      color: colorScheme.onPrimary,
                                      fontSize: 10,
                                    ),
                                  ),
                                ),
                              ],
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            method.description,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: isSelected
                                  ? colorScheme.onPrimaryContainer
                                  : colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Radio<String>(
                      value: method.id,
                      groupValue: _authData.method,
                      onChanged: (value) {
                        if (value != null) {
                          setState(() {
                            _authData = _authData.copyWith(method: value);
                          });
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildSetupStep() {
    switch (_authData.method) {
      case 'app':
        return _buildAppSetup();
      case 'sms':
        return _buildSmsSetup();
      case 'email':
        return _buildEmailSetup();
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildAppSetup() {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: colorScheme.surfaceVariant,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Step 1: Download an authenticator app',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'We recommend Google Authenticator, Authy, or 1Password.',
                style: theme.textTheme.bodyMedium,
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: colorScheme.surfaceVariant,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Step 2: Scan the QR code',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 16),
              Center(
                child: Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: colorScheme.outline),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.qr_code,
                      size: 120,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Or enter this code manually:',
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: colorScheme.surface,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: colorScheme.outline),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        'ABCD EFGH IJKL MNOP',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          fontFamily: 'monospace',
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Clipboard.setData(
                          const ClipboardData(text: 'ABCDEFGHIJKLMNOP'),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Copied to clipboard')),
                        );
                      },
                      icon: const Icon(Icons.copy),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSmsSetup() {
    return Column(
      children: [
        DialogFormField(
          label: 'Phone Number',
          hint: '+1 (555) 123-4567',
          value: _authData.phoneNumber,
          required: true,
          keyboardType: TextInputType.phone,
          onChanged: (value) {
            setState(() {
              _authData = _authData.copyWith(phoneNumber: value);
            });
          },
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Phone number is required';
            }
            return null;
          },
          prefixIcon: const Icon(Icons.phone),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceVariant,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Icon(
                Icons.info_outline,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Standard messaging rates may apply. We recommend using an authenticator app for better security.',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildEmailSetup() {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.surfaceVariant,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.email,
                color: colorScheme.primary,
              ),
              const SizedBox(width: 12),
              Text(
                'Email 2FA Setup',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            'Verification codes will be sent to your registered email address:',
            style: theme.textTheme.bodyMedium,
          ),
          const SizedBox(height: 8),
          Text(
            'user@example.com',
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: colorScheme.primary,
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: colorScheme.errorContainer,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.warning_outlined,
                  color: colorScheme.onErrorContainer,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Email 2FA is less secure than app-based authentication.',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: colorScheme.onErrorContainer,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVerifyStep() {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Enter the 6-digit code from your ${_getMethodDisplayName()}:',
          style: theme.textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(6, (index) {
            return SizedBox(
              width: 50,
              child: TextFormField(
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(1),
                  FilteringTextInputFormatter.digitsOnly,
                ],
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 16),
                ),
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                onChanged: (value) {
                  if (value.isNotEmpty && index < 5) {
                    FocusScope.of(context).nextFocus();
                  }
                  _updateVerificationCode(index, value);
                },
              ),
            );
          }),
        ),
        const SizedBox(height: 24),
        if (_isVerifying)
          const Center(child: CircularProgressIndicator())
        else
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () {
                  // Resend code logic
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Code sent')),
                  );
                },
                child: const Text('Resend Code'),
              ),
            ],
          ),
      ],
    );
  }

  Widget _buildBackupStep() {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final backupCodes = [
      '1a2b3c4d',
      '5e6f7g8h',
      '9i0j1k2l',
      '3m4n5o6p',
      '7q8r9s0t',
      'u1v2w3x4',
      'y5z6a7b8',
      'c9d0e1f2',
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: colorScheme.errorContainer,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Icon(
                Icons.warning_outlined,
                color: colorScheme.onErrorContainer,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Save these backup codes in a secure location. You can use them to access your account if you lose your device.',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onErrorContainer,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: colorScheme.surfaceVariant,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: colorScheme.outline),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Backup Codes',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Clipboard.setData(
                        ClipboardData(text: backupCodes.join('\n')),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Backup codes copied to clipboard'),
                        ),
                      );
                    },
                    icon: const Icon(Icons.copy),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 3,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                ),
                itemCount: backupCodes.length,
                itemBuilder: (context, index) {
                  return Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: colorScheme.surface,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: colorScheme.outline),
                    ),
                    child: Center(
                      child: Text(
                        backupCodes[index],
                        style: theme.textTheme.bodyMedium?.copyWith(
                          fontFamily: 'monospace',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  String _getSetupDescription() {
    switch (_authData.method) {
      case 'app':
        return 'Configure your authenticator app';
      case 'sms':
        return 'Enter your phone number for SMS codes';
      case 'email':
        return 'Confirm email-based authentication';
      default:
        return 'Configure your 2FA method';
    }
  }

  String _getMethodDisplayName() {
    switch (_authData.method) {
      case 'app':
        return 'authenticator app';
      case 'sms':
        return 'SMS message';
      case 'email':
        return 'email';
      default:
        return '2FA method';
    }
  }

  bool _canProceedFromSetup() {
    switch (_authData.method) {
      case 'app':
        return true; // QR code is always available
      case 'sms':
        return _authData.phoneNumber.isNotEmpty;
      case 'email':
        return true; // Email is pre-configured
      default:
        return false;
    }
  }

  void _updateVerificationCode(int index, String value) {
    final codes = _verificationCode.split('');
    while (codes.length <= index) {
      codes.add('');
    }
    codes[index] = value;
    setState(() {
      _verificationCode = codes.join('').substring(0, 6);
    });
  }
}

class AuthMethod {
  final String id;
  final String name;
  final String description;
  final IconData icon;
  final bool isRecommended;

  const AuthMethod({
    required this.id,
    required this.name,
    required this.description,
    required this.icon,
    this.isRecommended = false,
  });
}