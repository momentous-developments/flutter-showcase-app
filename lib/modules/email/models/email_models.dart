import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'email_models.freezed.dart';
part 'email_models.g.dart';

@freezed
class Email with _$Email {
  const factory Email({
    required String id,
    required String subject,
    required String body,
    required Contact sender,
    required List<Contact> recipients,
    required List<Contact> ccRecipients,
    required List<Contact> bccRecipients,
    required DateTime timestamp,
    required List<Attachment> attachments,
    required EmailFolder folder,
    required List<EmailLabel> labels,
    required EmailPriority priority,
    required bool isRead,
    required bool isStarred,
    required bool isImportant,
    required bool isSpam,
    required bool isDraft,
    String? replyToId,
    String? forwardFromId,
    String? threadId,
    DateTime? scheduledAt,
    String? signature,
    bool? readReceipt,
    String? messageId,
    Map<String, dynamic>? headers,
  }) = _Email;

  factory Email.fromJson(Map<String, dynamic> json) => _$EmailFromJson(json);
}

@freezed
class Contact with _$Contact {
  const factory Contact({
    required String id,
    required String name,
    required String email,
    String? avatar,
    String? phone,
    String? company,
    String? title,
    List<String>? tags,
    DateTime? lastContact,
    bool? isBlocked,
    ContactGroup? group,
    Map<String, dynamic>? customFields,
  }) = _Contact;

  factory Contact.fromJson(Map<String, dynamic> json) => _$ContactFromJson(json);
}

@freezed
class Attachment with _$Attachment {
  const factory Attachment({
    required String id,
    required String name,
    required String mimeType,
    required int size,
    String? url,
    String? localPath,
    String? contentId,
    bool? isInline,
    DateTime? uploadedAt,
    AttachmentStatus? status,
    double? uploadProgress,
  }) = _Attachment;

  factory Attachment.fromJson(Map<String, dynamic> json) => _$AttachmentFromJson(json);
}

@freezed
class EmailFolder with _$EmailFolder {
  const factory EmailFolder({
    required String id,
    required String name,
    required EmailFolderType type,
    required int unreadCount,
    required int totalCount,
    String? parentId,
    List<EmailFolder>? children,
    @JsonKey(includeFromJson: false, includeToJson: false) IconData? icon,
    @JsonKey(includeFromJson: false, includeToJson: false) Color? color,
    bool? isSystem,
    DateTime? lastModified,
  }) = _EmailFolder;

  factory EmailFolder.fromJson(Map<String, dynamic> json) => _$EmailFolderFromJson(json);
}

@freezed
class EmailLabel with _$EmailLabel {
  const factory EmailLabel({
    required String id,
    required String name,
    @JsonKey(includeFromJson: false, includeToJson: false) Color? color,
    String? description,
    bool? isSystem,
    DateTime? createdAt,
  }) = _EmailLabel;

  factory EmailLabel.fromJson(Map<String, dynamic> json) => _$EmailLabelFromJson(json);
}

@freezed
class EmailThread with _$EmailThread {
  const factory EmailThread({
    required String id,
    required String subject,
    required List<Email> emails,
    required List<Contact> participants,
    required DateTime lastActivity,
    required int messageCount,
    required int unreadCount,
    required List<EmailLabel> labels,
    bool? isStarred,
    bool? isImportant,
    bool? isMuted,
    EmailFolder? folder,
  }) = _EmailThread;

  factory EmailThread.fromJson(Map<String, dynamic> json) => _$EmailThreadFromJson(json);
}

@freezed
class EmailRule with _$EmailRule {
  const factory EmailRule({
    required String id,
    required String name,
    required List<EmailCondition> conditions,
    required List<EmailAction> actions,
    required bool isActive,
    DateTime? createdAt,
    DateTime? lastTriggered,
    int? triggerCount,
    String? description,
  }) = _EmailRule;

  factory EmailRule.fromJson(Map<String, dynamic> json) => _$EmailRuleFromJson(json);
}

@freezed
class EmailCondition with _$EmailCondition {
  const factory EmailCondition({
    required EmailConditionField field,
    required EmailConditionOperator operator,
    required String value,
    bool? caseSensitive,
  }) = _EmailCondition;

  factory EmailCondition.fromJson(Map<String, dynamic> json) => _$EmailConditionFromJson(json);
}

@freezed
class EmailAction with _$EmailAction {
  const factory EmailAction({
    required EmailActionType type,
    String? value,
    Map<String, dynamic>? parameters,
  }) = _EmailAction;

  factory EmailAction.fromJson(Map<String, dynamic> json) => _$EmailActionFromJson(json);
}

@freezed
class EmailTemplate with _$EmailTemplate {
  const factory EmailTemplate({
    required String id,
    required String name,
    required String subject,
    required String body,
    String? description,
    List<String>? tags,
    DateTime? createdAt,
    DateTime? lastUsed,
    int? useCount,
    bool? isPublic,
    TemplateType? type,
  }) = _EmailTemplate;

  factory EmailTemplate.fromJson(Map<String, dynamic> json) => _$EmailTemplateFromJson(json);
}

@freezed
class ComposeState with _$ComposeState {
  const factory ComposeState({
    String? to,
    String? cc,
    String? bcc,
    String? subject,
    String? body,
    List<Attachment>? attachments,
    EmailPriority? priority,
    bool? requestReadReceipt,
    DateTime? scheduledAt,
    String? signature,
    String? replyToId,
    String? forwardFromId,
    bool? isDraft,
    DateTime? lastSaved,
    ComposeMode? mode,
  }) = _ComposeState;

  factory ComposeState.fromJson(Map<String, dynamic> json) => _$ComposeStateFromJson(json);
}

@freezed
class EmailSettings with _$EmailSettings {
  const factory EmailSettings({
    required String id,
    required String displayName,
    required String emailAddress,
    String? signature,
    bool? autoReply,
    String? autoReplyMessage,
    DateTime? autoReplyStartDate,
    DateTime? autoReplyEndDate,
    int? refreshInterval,
    bool? showPreview,
    int? previewLines,
    bool? markAsReadOnPreview,
    bool? enableSpamFilter,
    bool? enableReadReceipts,
    bool? enablePushNotifications,
    NotificationSettings? notifications,
    SecuritySettings? security,
  }) = _EmailSettings;

  factory EmailSettings.fromJson(Map<String, dynamic> json) => _$EmailSettingsFromJson(json);
}

@freezed
class NotificationSettings with _$NotificationSettings {
  const factory NotificationSettings({
    bool? newEmail,
    bool? importantEmail,
    bool? mentions,
    bool? calendar,
    bool? reminders,
    List<String>? excludedSenders,
    List<String>? vipSenders,
    bool? quietHours,
    DateTime? quietStartTime,
    DateTime? quietEndTime,
  }) = _NotificationSettings;

  factory NotificationSettings.fromJson(Map<String, dynamic> json) => _$NotificationSettingsFromJson(json);
}

@freezed
class SecuritySettings with _$SecuritySettings {
  const factory SecuritySettings({
    bool? twoFactorAuth,
    bool? blockExternalImages,
    bool? warnPhishing,
    bool? encryptionRequired,
    List<String>? trustedDomains,
    List<String>? blockedSenders,
    bool? requireSenderAuth,
  }) = _SecuritySettings;

  factory SecuritySettings.fromJson(Map<String, dynamic> json) => _$SecuritySettingsFromJson(json);
}

@freezed
class ContactGroup with _$ContactGroup {
  const factory ContactGroup({
    required String id,
    required String name,
    String? description,
    @JsonKey(includeFromJson: false, includeToJson: false) Color? color,
    List<String>? contactIds,
    DateTime? createdAt,
  }) = _ContactGroup;

  factory ContactGroup.fromJson(Map<String, dynamic> json) => _$ContactGroupFromJson(json);
}

@freezed
class EmailSearchFilter with _$EmailSearchFilter {
  const factory EmailSearchFilter({
    String? query,
    Contact? sender,
    List<Contact>? recipients,
    List<EmailFolder>? folders,
    List<EmailLabel>? labels,
    DateTime? dateFrom,
    DateTime? dateTo,
    bool? hasAttachments,
    bool? isUnread,
    bool? isStarred,
    bool? isImportant,
    EmailPriority? priority,
    int? sizeMin,
    int? sizeMax,
  }) = _EmailSearchFilter;

  factory EmailSearchFilter.fromJson(Map<String, dynamic> json) => _$EmailSearchFilterFromJson(json);
}

// Enums
enum EmailFolderType {
  inbox,
  sent,
  drafts,
  trash,
  spam,
  outbox,
  archive,
  custom,
}

enum EmailPriority {
  low,
  normal,
  high,
  urgent,
}

enum AttachmentStatus {
  uploading,
  uploaded,
  failed,
  processing,
}

enum EmailConditionField {
  sender,
  recipient,
  subject,
  body,
  attachment,
  size,
  date,
  label,
  folder,
}

enum EmailConditionOperator {
  equals,
  contains,
  startsWith,
  endsWith,
  greaterThan,
  lessThan,
  regex,
}

enum EmailActionType {
  moveToFolder,
  addLabel,
  removeLabel,
  markAsRead,
  markAsImportant,
  forward,
  reply,
  delete,
  archive,
  star,
  block,
}

enum TemplateType {
  personal,
  business,
  marketing,
  support,
  newsletter,
}

enum ComposeMode {
  new_,
  reply,
  replyAll,
  forward,
  draft,
}

// Extension methods for better usability
extension EmailExtensions on Email {
  bool get hasAttachments => attachments.isNotEmpty;
  
  bool get isInThread => threadId != null;
  
  String get displaySubject => subject.isEmpty ? '(No Subject)' : subject;
  
  String get previewText {
    final plainText = body.replaceAll(RegExp(r'<[^>]*>'), '');
    return plainText.length > 100 
        ? '${plainText.substring(0, 100)}...'
        : plainText;
  }
  
  Duration get timeAgo => DateTime.now().difference(timestamp);
  
  String get formattedSize {
    var totalSize = attachments.fold<int>(0, (sum, att) => sum + att.size);
    if (totalSize < 1024) return '${totalSize}B';
    if (totalSize < 1024 * 1024) return '${(totalSize / 1024).toStringAsFixed(1)}KB';
    return '${(totalSize / (1024 * 1024)).toStringAsFixed(1)}MB';
  }
}

extension ContactExtensions on Contact {
  String get displayName => name.isEmpty ? email : name;
  
  String get initials {
    if (name.isNotEmpty) {
      final parts = name.split(' ');
      return parts.length > 1 
          ? '${parts.first[0]}${parts.last[0]}'.toUpperCase()
          : name[0].toUpperCase();
    }
    return email[0].toUpperCase();
  }
}

extension AttachmentExtensions on Attachment {
  String get formattedSize {
    if (size < 1024) return '${size}B';
    if (size < 1024 * 1024) return '${(size / 1024).toStringAsFixed(1)}KB';
    return '${(size / (1024 * 1024)).toStringAsFixed(1)}MB';
  }
  
  bool get isImage => mimeType.startsWith('image/');
  bool get isDocument => mimeType.contains('document') || mimeType.contains('pdf');
  bool get isVideo => mimeType.startsWith('video/');
  bool get isAudio => mimeType.startsWith('audio/');
}