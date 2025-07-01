/// Data models for dialog components
library dialog_models;

/// Address information model
class AddressData {
  final String firstName;
  final String lastName;
  final String country;
  final String address1;
  final String address2;
  final String landmark;
  final String city;
  final String state;
  final String zipCode;
  final String addressType;
  final bool isDefault;

  const AddressData({
    this.firstName = '',
    this.lastName = '',
    this.country = '',
    this.address1 = '',
    this.address2 = '',
    this.landmark = '',
    this.city = '',
    this.state = '',
    this.zipCode = '',
    this.addressType = 'home',
    this.isDefault = false,
  });

  AddressData copyWith({
    String? firstName,
    String? lastName,
    String? country,
    String? address1,
    String? address2,
    String? landmark,
    String? city,
    String? state,
    String? zipCode,
    String? addressType,
    bool? isDefault,
  }) {
    return AddressData(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      country: country ?? this.country,
      address1: address1 ?? this.address1,
      address2: address2 ?? this.address2,
      landmark: landmark ?? this.landmark,
      city: city ?? this.city,
      state: state ?? this.state,
      zipCode: zipCode ?? this.zipCode,
      addressType: addressType ?? this.addressType,
      isDefault: isDefault ?? this.isDefault,
    );
  }
}

/// Billing card information model
class BillingCardData {
  final String cardNumber;
  final String expiryDate;
  final String cvv;
  final String cardholderName;
  final String cardType;
  final bool isDefault;

  const BillingCardData({
    this.cardNumber = '',
    this.expiryDate = '',
    this.cvv = '',
    this.cardholderName = '',
    this.cardType = 'visa',
    this.isDefault = false,
  });

  BillingCardData copyWith({
    String? cardNumber,
    String? expiryDate,
    String? cvv,
    String? cardholderName,
    String? cardType,
    bool? isDefault,
  }) {
    return BillingCardData(
      cardNumber: cardNumber ?? this.cardNumber,
      expiryDate: expiryDate ?? this.expiryDate,
      cvv: cvv ?? this.cvv,
      cardholderName: cardholderName ?? this.cardholderName,
      cardType: cardType ?? this.cardType,
      isDefault: isDefault ?? this.isDefault,
    );
  }
}

/// User information model
class UserInfoData {
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final String role;
  final String department;
  final String bio;
  final String avatarUrl;

  const UserInfoData({
    this.firstName = '',
    this.lastName = '',
    this.email = '',
    this.phone = '',
    this.role = '',
    this.department = '',
    this.bio = '',
    this.avatarUrl = '',
  });

  UserInfoData copyWith({
    String? firstName,
    String? lastName,
    String? email,
    String? phone,
    String? role,
    String? department,
    String? bio,
    String? avatarUrl,
  }) {
    return UserInfoData(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      role: role ?? this.role,
      department: department ?? this.department,
      bio: bio ?? this.bio,
      avatarUrl: avatarUrl ?? this.avatarUrl,
    );
  }
}

/// Payment method model
class PaymentMethodData {
  final String type;
  final String provider;
  final String accountNumber;
  final String accountName;
  final bool isDefault;

  const PaymentMethodData({
    this.type = 'card',
    this.provider = '',
    this.accountNumber = '',
    this.accountName = '',
    this.isDefault = false,
  });

  PaymentMethodData copyWith({
    String? type,
    String? provider,
    String? accountNumber,
    String? accountName,
    bool? isDefault,
  }) {
    return PaymentMethodData(
      type: type ?? this.type,
      provider: provider ?? this.provider,
      accountNumber: accountNumber ?? this.accountNumber,
      accountName: accountName ?? this.accountName,
      isDefault: isDefault ?? this.isDefault,
    );
  }
}

/// Pricing plan model
class PricingPlanData {
  final String id;
  final String name;
  final String description;
  final double price;
  final String interval;
  final List<String> features;
  final bool isPopular;
  final bool isCurrentPlan;

  const PricingPlanData({
    required this.id,
    required this.name,
    this.description = '',
    required this.price,
    this.interval = 'month',
    this.features = const [],
    this.isPopular = false,
    this.isCurrentPlan = false,
  });
}

/// Permission model
class PermissionData {
  final String id;
  final String name;
  final String description;
  final String category;
  final bool isGranted;

  const PermissionData({
    required this.id,
    required this.name,
    this.description = '',
    this.category = 'general',
    this.isGranted = false,
  });

  PermissionData copyWith({
    String? id,
    String? name,
    String? description,
    String? category,
    bool? isGranted,
  }) {
    return PermissionData(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      category: category ?? this.category,
      isGranted: isGranted ?? this.isGranted,
    );
  }
}

/// Role model
class RoleData {
  final String id;
  final String name;
  final String description;
  final List<String> permissions;
  final int userCount;

  const RoleData({
    required this.id,
    required this.name,
    this.description = '',
    this.permissions = const [],
    this.userCount = 0,
  });
}

/// App creation step data
class CreateAppStepData {
  final String framework;
  final String database;
  final String name;
  final String description;
  final String region;
  final String plan;
  final Map<String, dynamic> billing;

  const CreateAppStepData({
    this.framework = '',
    this.database = '',
    this.name = '',
    this.description = '',
    this.region = '',
    this.plan = '',
    this.billing = const {},
  });

  CreateAppStepData copyWith({
    String? framework,
    String? database,
    String? name,
    String? description,
    String? region,
    String? plan,
    Map<String, dynamic>? billing,
  }) {
    return CreateAppStepData(
      framework: framework ?? this.framework,
      database: database ?? this.database,
      name: name ?? this.name,
      description: description ?? this.description,
      region: region ?? this.region,
      plan: plan ?? this.plan,
      billing: billing ?? this.billing,
    );
  }
}

/// Two-factor authentication setup data
class TwoFactorAuthData {
  final String method;
  final String phoneNumber;
  final String backupCodes;
  final bool isEnabled;

  const TwoFactorAuthData({
    this.method = 'app',
    this.phoneNumber = '',
    this.backupCodes = '',
    this.isEnabled = false,
  });

  TwoFactorAuthData copyWith({
    String? method,
    String? phoneNumber,
    String? backupCodes,
    bool? isEnabled,
  }) {
    return TwoFactorAuthData(
      method: method ?? this.method,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      backupCodes: backupCodes ?? this.backupCodes,
      isEnabled: isEnabled ?? this.isEnabled,
    );
  }
}

/// Confirmation dialog types
enum ConfirmationType {
  deleteAccount,
  unsubscribe,
  suspendAccount,
  deleteOrder,
  deleteCustomer,
  bulkDelete,
  permanentAction,
}


/// Form validation state
class ValidationState {
  final Map<String, String?> errors;
  final bool isValid;

  const ValidationState({
    this.errors = const {},
    this.isValid = true,
  });

  ValidationState copyWith({
    Map<String, String?>? errors,
    bool? isValid,
  }) {
    return ValidationState(
      errors: errors ?? this.errors,
      isValid: isValid ?? this.isValid,
    );
  }
}

/// Wizard step information
class WizardStepInfo {
  final int currentStep;
  final int totalSteps;
  final bool canGoNext;
  final bool canGoPrevious;
  final String stepTitle;
  final String stepDescription;

  const WizardStepInfo({
    this.currentStep = 0,
    this.totalSteps = 1,
    this.canGoNext = true,
    this.canGoPrevious = false,
    this.stepTitle = '',
    this.stepDescription = '',
  });

  WizardStepInfo copyWith({
    int? currentStep,
    int? totalSteps,
    bool? canGoNext,
    bool? canGoPrevious,
    String? stepTitle,
    String? stepDescription,
  }) {
    return WizardStepInfo(
      currentStep: currentStep ?? this.currentStep,
      totalSteps: totalSteps ?? this.totalSteps,
      canGoNext: canGoNext ?? this.canGoNext,
      canGoPrevious: canGoPrevious ?? this.canGoPrevious,
      stepTitle: stepTitle ?? this.stepTitle,
      stepDescription: stepDescription ?? this.stepDescription,
    );
  }
}