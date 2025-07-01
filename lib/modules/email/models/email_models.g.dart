// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'email_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$EmailImpl _$$EmailImplFromJson(Map<String, dynamic> json) => _$EmailImpl(
      id: json['id'] as String,
      subject: json['subject'] as String,
      body: json['body'] as String,
      sender: Contact.fromJson(json['sender'] as Map<String, dynamic>),
      recipients: (json['recipients'] as List<dynamic>)
          .map((e) => Contact.fromJson(e as Map<String, dynamic>))
          .toList(),
      ccRecipients: (json['ccRecipients'] as List<dynamic>)
          .map((e) => Contact.fromJson(e as Map<String, dynamic>))
          .toList(),
      bccRecipients: (json['bccRecipients'] as List<dynamic>)
          .map((e) => Contact.fromJson(e as Map<String, dynamic>))
          .toList(),
      timestamp: DateTime.parse(json['timestamp'] as String),
      attachments: (json['attachments'] as List<dynamic>)
          .map((e) => Attachment.fromJson(e as Map<String, dynamic>))
          .toList(),
      folder: EmailFolder.fromJson(json['folder'] as Map<String, dynamic>),
      labels: (json['labels'] as List<dynamic>)
          .map((e) => EmailLabel.fromJson(e as Map<String, dynamic>))
          .toList(),
      priority: $enumDecode(_$EmailPriorityEnumMap, json['priority']),
      isRead: json['isRead'] as bool,
      isStarred: json['isStarred'] as bool,
      isImportant: json['isImportant'] as bool,
      isSpam: json['isSpam'] as bool,
      isDraft: json['isDraft'] as bool,
      replyToId: json['replyToId'] as String?,
      forwardFromId: json['forwardFromId'] as String?,
      threadId: json['threadId'] as String?,
      scheduledAt: json['scheduledAt'] == null
          ? null
          : DateTime.parse(json['scheduledAt'] as String),
      signature: json['signature'] as String?,
      readReceipt: json['readReceipt'] as bool?,
      messageId: json['messageId'] as String?,
      headers: json['headers'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$$EmailImplToJson(_$EmailImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'subject': instance.subject,
      'body': instance.body,
      'sender': instance.sender,
      'recipients': instance.recipients,
      'ccRecipients': instance.ccRecipients,
      'bccRecipients': instance.bccRecipients,
      'timestamp': instance.timestamp.toIso8601String(),
      'attachments': instance.attachments,
      'folder': instance.folder,
      'labels': instance.labels,
      'priority': _$EmailPriorityEnumMap[instance.priority]!,
      'isRead': instance.isRead,
      'isStarred': instance.isStarred,
      'isImportant': instance.isImportant,
      'isSpam': instance.isSpam,
      'isDraft': instance.isDraft,
      'replyToId': instance.replyToId,
      'forwardFromId': instance.forwardFromId,
      'threadId': instance.threadId,
      'scheduledAt': instance.scheduledAt?.toIso8601String(),
      'signature': instance.signature,
      'readReceipt': instance.readReceipt,
      'messageId': instance.messageId,
      'headers': instance.headers,
    };

const _$EmailPriorityEnumMap = {
  EmailPriority.low: 'low',
  EmailPriority.normal: 'normal',
  EmailPriority.high: 'high',
  EmailPriority.urgent: 'urgent',
};

_$ContactImpl _$$ContactImplFromJson(Map<String, dynamic> json) =>
    _$ContactImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      avatar: json['avatar'] as String?,
      phone: json['phone'] as String?,
      company: json['company'] as String?,
      title: json['title'] as String?,
      tags: (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList(),
      lastContact: json['lastContact'] == null
          ? null
          : DateTime.parse(json['lastContact'] as String),
      isBlocked: json['isBlocked'] as bool?,
      group: json['group'] == null
          ? null
          : ContactGroup.fromJson(json['group'] as Map<String, dynamic>),
      customFields: json['customFields'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$$ContactImplToJson(_$ContactImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'avatar': instance.avatar,
      'phone': instance.phone,
      'company': instance.company,
      'title': instance.title,
      'tags': instance.tags,
      'lastContact': instance.lastContact?.toIso8601String(),
      'isBlocked': instance.isBlocked,
      'group': instance.group,
      'customFields': instance.customFields,
    };

_$AttachmentImpl _$$AttachmentImplFromJson(Map<String, dynamic> json) =>
    _$AttachmentImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      mimeType: json['mimeType'] as String,
      size: (json['size'] as num).toInt(),
      url: json['url'] as String?,
      localPath: json['localPath'] as String?,
      contentId: json['contentId'] as String?,
      isInline: json['isInline'] as bool?,
      uploadedAt: json['uploadedAt'] == null
          ? null
          : DateTime.parse(json['uploadedAt'] as String),
      status: $enumDecodeNullable(_$AttachmentStatusEnumMap, json['status']),
      uploadProgress: (json['uploadProgress'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$$AttachmentImplToJson(_$AttachmentImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'mimeType': instance.mimeType,
      'size': instance.size,
      'url': instance.url,
      'localPath': instance.localPath,
      'contentId': instance.contentId,
      'isInline': instance.isInline,
      'uploadedAt': instance.uploadedAt?.toIso8601String(),
      'status': _$AttachmentStatusEnumMap[instance.status],
      'uploadProgress': instance.uploadProgress,
    };

const _$AttachmentStatusEnumMap = {
  AttachmentStatus.uploading: 'uploading',
  AttachmentStatus.uploaded: 'uploaded',
  AttachmentStatus.failed: 'failed',
  AttachmentStatus.processing: 'processing',
};

_$EmailFolderImpl _$$EmailFolderImplFromJson(Map<String, dynamic> json) =>
    _$EmailFolderImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      type: $enumDecode(_$EmailFolderTypeEnumMap, json['type']),
      unreadCount: (json['unreadCount'] as num).toInt(),
      totalCount: (json['totalCount'] as num).toInt(),
      parentId: json['parentId'] as String?,
      children: (json['children'] as List<dynamic>?)
          ?.map((e) => EmailFolder.fromJson(e as Map<String, dynamic>))
          .toList(),
      isSystem: json['isSystem'] as bool?,
      lastModified: json['lastModified'] == null
          ? null
          : DateTime.parse(json['lastModified'] as String),
    );

Map<String, dynamic> _$$EmailFolderImplToJson(_$EmailFolderImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'type': _$EmailFolderTypeEnumMap[instance.type]!,
      'unreadCount': instance.unreadCount,
      'totalCount': instance.totalCount,
      'parentId': instance.parentId,
      'children': instance.children,
      'isSystem': instance.isSystem,
      'lastModified': instance.lastModified?.toIso8601String(),
    };

const _$EmailFolderTypeEnumMap = {
  EmailFolderType.inbox: 'inbox',
  EmailFolderType.sent: 'sent',
  EmailFolderType.drafts: 'drafts',
  EmailFolderType.trash: 'trash',
  EmailFolderType.spam: 'spam',
  EmailFolderType.outbox: 'outbox',
  EmailFolderType.archive: 'archive',
  EmailFolderType.custom: 'custom',
};

_$EmailLabelImpl _$$EmailLabelImplFromJson(Map<String, dynamic> json) =>
    _$EmailLabelImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      isSystem: json['isSystem'] as bool?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$EmailLabelImplToJson(_$EmailLabelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'isSystem': instance.isSystem,
      'createdAt': instance.createdAt?.toIso8601String(),
    };

_$EmailThreadImpl _$$EmailThreadImplFromJson(Map<String, dynamic> json) =>
    _$EmailThreadImpl(
      id: json['id'] as String,
      subject: json['subject'] as String,
      emails: (json['emails'] as List<dynamic>)
          .map((e) => Email.fromJson(e as Map<String, dynamic>))
          .toList(),
      participants: (json['participants'] as List<dynamic>)
          .map((e) => Contact.fromJson(e as Map<String, dynamic>))
          .toList(),
      lastActivity: DateTime.parse(json['lastActivity'] as String),
      messageCount: (json['messageCount'] as num).toInt(),
      unreadCount: (json['unreadCount'] as num).toInt(),
      labels: (json['labels'] as List<dynamic>)
          .map((e) => EmailLabel.fromJson(e as Map<String, dynamic>))
          .toList(),
      isStarred: json['isStarred'] as bool?,
      isImportant: json['isImportant'] as bool?,
      isMuted: json['isMuted'] as bool?,
      folder: json['folder'] == null
          ? null
          : EmailFolder.fromJson(json['folder'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$EmailThreadImplToJson(_$EmailThreadImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'subject': instance.subject,
      'emails': instance.emails,
      'participants': instance.participants,
      'lastActivity': instance.lastActivity.toIso8601String(),
      'messageCount': instance.messageCount,
      'unreadCount': instance.unreadCount,
      'labels': instance.labels,
      'isStarred': instance.isStarred,
      'isImportant': instance.isImportant,
      'isMuted': instance.isMuted,
      'folder': instance.folder,
    };

_$EmailRuleImpl _$$EmailRuleImplFromJson(Map<String, dynamic> json) =>
    _$EmailRuleImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      conditions: (json['conditions'] as List<dynamic>)
          .map((e) => EmailCondition.fromJson(e as Map<String, dynamic>))
          .toList(),
      actions: (json['actions'] as List<dynamic>)
          .map((e) => EmailAction.fromJson(e as Map<String, dynamic>))
          .toList(),
      isActive: json['isActive'] as bool,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      lastTriggered: json['lastTriggered'] == null
          ? null
          : DateTime.parse(json['lastTriggered'] as String),
      triggerCount: (json['triggerCount'] as num?)?.toInt(),
      description: json['description'] as String?,
    );

Map<String, dynamic> _$$EmailRuleImplToJson(_$EmailRuleImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'conditions': instance.conditions,
      'actions': instance.actions,
      'isActive': instance.isActive,
      'createdAt': instance.createdAt?.toIso8601String(),
      'lastTriggered': instance.lastTriggered?.toIso8601String(),
      'triggerCount': instance.triggerCount,
      'description': instance.description,
    };

_$EmailConditionImpl _$$EmailConditionImplFromJson(Map<String, dynamic> json) =>
    _$EmailConditionImpl(
      field: $enumDecode(_$EmailConditionFieldEnumMap, json['field']),
      operator: $enumDecode(_$EmailConditionOperatorEnumMap, json['operator']),
      value: json['value'] as String,
      caseSensitive: json['caseSensitive'] as bool?,
    );

Map<String, dynamic> _$$EmailConditionImplToJson(
        _$EmailConditionImpl instance) =>
    <String, dynamic>{
      'field': _$EmailConditionFieldEnumMap[instance.field]!,
      'operator': _$EmailConditionOperatorEnumMap[instance.operator]!,
      'value': instance.value,
      'caseSensitive': instance.caseSensitive,
    };

const _$EmailConditionFieldEnumMap = {
  EmailConditionField.sender: 'sender',
  EmailConditionField.recipient: 'recipient',
  EmailConditionField.subject: 'subject',
  EmailConditionField.body: 'body',
  EmailConditionField.attachment: 'attachment',
  EmailConditionField.size: 'size',
  EmailConditionField.date: 'date',
  EmailConditionField.label: 'label',
  EmailConditionField.folder: 'folder',
};

const _$EmailConditionOperatorEnumMap = {
  EmailConditionOperator.equals: 'equals',
  EmailConditionOperator.contains: 'contains',
  EmailConditionOperator.startsWith: 'startsWith',
  EmailConditionOperator.endsWith: 'endsWith',
  EmailConditionOperator.greaterThan: 'greaterThan',
  EmailConditionOperator.lessThan: 'lessThan',
  EmailConditionOperator.regex: 'regex',
};

_$EmailActionImpl _$$EmailActionImplFromJson(Map<String, dynamic> json) =>
    _$EmailActionImpl(
      type: $enumDecode(_$EmailActionTypeEnumMap, json['type']),
      value: json['value'] as String?,
      parameters: json['parameters'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$$EmailActionImplToJson(_$EmailActionImpl instance) =>
    <String, dynamic>{
      'type': _$EmailActionTypeEnumMap[instance.type]!,
      'value': instance.value,
      'parameters': instance.parameters,
    };

const _$EmailActionTypeEnumMap = {
  EmailActionType.moveToFolder: 'moveToFolder',
  EmailActionType.addLabel: 'addLabel',
  EmailActionType.removeLabel: 'removeLabel',
  EmailActionType.markAsRead: 'markAsRead',
  EmailActionType.markAsImportant: 'markAsImportant',
  EmailActionType.forward: 'forward',
  EmailActionType.reply: 'reply',
  EmailActionType.delete: 'delete',
  EmailActionType.archive: 'archive',
  EmailActionType.star: 'star',
  EmailActionType.block: 'block',
};

_$EmailTemplateImpl _$$EmailTemplateImplFromJson(Map<String, dynamic> json) =>
    _$EmailTemplateImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      subject: json['subject'] as String,
      body: json['body'] as String,
      description: json['description'] as String?,
      tags: (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList(),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      lastUsed: json['lastUsed'] == null
          ? null
          : DateTime.parse(json['lastUsed'] as String),
      useCount: (json['useCount'] as num?)?.toInt(),
      isPublic: json['isPublic'] as bool?,
      type: $enumDecodeNullable(_$TemplateTypeEnumMap, json['type']),
    );

Map<String, dynamic> _$$EmailTemplateImplToJson(_$EmailTemplateImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'subject': instance.subject,
      'body': instance.body,
      'description': instance.description,
      'tags': instance.tags,
      'createdAt': instance.createdAt?.toIso8601String(),
      'lastUsed': instance.lastUsed?.toIso8601String(),
      'useCount': instance.useCount,
      'isPublic': instance.isPublic,
      'type': _$TemplateTypeEnumMap[instance.type],
    };

const _$TemplateTypeEnumMap = {
  TemplateType.personal: 'personal',
  TemplateType.business: 'business',
  TemplateType.marketing: 'marketing',
  TemplateType.support: 'support',
  TemplateType.newsletter: 'newsletter',
};

_$ComposeStateImpl _$$ComposeStateImplFromJson(Map<String, dynamic> json) =>
    _$ComposeStateImpl(
      to: json['to'] as String?,
      cc: json['cc'] as String?,
      bcc: json['bcc'] as String?,
      subject: json['subject'] as String?,
      body: json['body'] as String?,
      attachments: (json['attachments'] as List<dynamic>?)
          ?.map((e) => Attachment.fromJson(e as Map<String, dynamic>))
          .toList(),
      priority: $enumDecodeNullable(_$EmailPriorityEnumMap, json['priority']),
      requestReadReceipt: json['requestReadReceipt'] as bool?,
      scheduledAt: json['scheduledAt'] == null
          ? null
          : DateTime.parse(json['scheduledAt'] as String),
      signature: json['signature'] as String?,
      replyToId: json['replyToId'] as String?,
      forwardFromId: json['forwardFromId'] as String?,
      isDraft: json['isDraft'] as bool?,
      lastSaved: json['lastSaved'] == null
          ? null
          : DateTime.parse(json['lastSaved'] as String),
      mode: $enumDecodeNullable(_$ComposeModeEnumMap, json['mode']),
    );

Map<String, dynamic> _$$ComposeStateImplToJson(_$ComposeStateImpl instance) =>
    <String, dynamic>{
      'to': instance.to,
      'cc': instance.cc,
      'bcc': instance.bcc,
      'subject': instance.subject,
      'body': instance.body,
      'attachments': instance.attachments,
      'priority': _$EmailPriorityEnumMap[instance.priority],
      'requestReadReceipt': instance.requestReadReceipt,
      'scheduledAt': instance.scheduledAt?.toIso8601String(),
      'signature': instance.signature,
      'replyToId': instance.replyToId,
      'forwardFromId': instance.forwardFromId,
      'isDraft': instance.isDraft,
      'lastSaved': instance.lastSaved?.toIso8601String(),
      'mode': _$ComposeModeEnumMap[instance.mode],
    };

const _$ComposeModeEnumMap = {
  ComposeMode.new_: 'new_',
  ComposeMode.reply: 'reply',
  ComposeMode.replyAll: 'replyAll',
  ComposeMode.forward: 'forward',
  ComposeMode.draft: 'draft',
};

_$EmailSettingsImpl _$$EmailSettingsImplFromJson(Map<String, dynamic> json) =>
    _$EmailSettingsImpl(
      id: json['id'] as String,
      displayName: json['displayName'] as String,
      emailAddress: json['emailAddress'] as String,
      signature: json['signature'] as String?,
      autoReply: json['autoReply'] as bool?,
      autoReplyMessage: json['autoReplyMessage'] as String?,
      autoReplyStartDate: json['autoReplyStartDate'] == null
          ? null
          : DateTime.parse(json['autoReplyStartDate'] as String),
      autoReplyEndDate: json['autoReplyEndDate'] == null
          ? null
          : DateTime.parse(json['autoReplyEndDate'] as String),
      refreshInterval: (json['refreshInterval'] as num?)?.toInt(),
      showPreview: json['showPreview'] as bool?,
      previewLines: (json['previewLines'] as num?)?.toInt(),
      markAsReadOnPreview: json['markAsReadOnPreview'] as bool?,
      enableSpamFilter: json['enableSpamFilter'] as bool?,
      enableReadReceipts: json['enableReadReceipts'] as bool?,
      enablePushNotifications: json['enablePushNotifications'] as bool?,
      notifications: json['notifications'] == null
          ? null
          : NotificationSettings.fromJson(
              json['notifications'] as Map<String, dynamic>),
      security: json['security'] == null
          ? null
          : SecuritySettings.fromJson(json['security'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$EmailSettingsImplToJson(_$EmailSettingsImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'displayName': instance.displayName,
      'emailAddress': instance.emailAddress,
      'signature': instance.signature,
      'autoReply': instance.autoReply,
      'autoReplyMessage': instance.autoReplyMessage,
      'autoReplyStartDate': instance.autoReplyStartDate?.toIso8601String(),
      'autoReplyEndDate': instance.autoReplyEndDate?.toIso8601String(),
      'refreshInterval': instance.refreshInterval,
      'showPreview': instance.showPreview,
      'previewLines': instance.previewLines,
      'markAsReadOnPreview': instance.markAsReadOnPreview,
      'enableSpamFilter': instance.enableSpamFilter,
      'enableReadReceipts': instance.enableReadReceipts,
      'enablePushNotifications': instance.enablePushNotifications,
      'notifications': instance.notifications,
      'security': instance.security,
    };

_$NotificationSettingsImpl _$$NotificationSettingsImplFromJson(
        Map<String, dynamic> json) =>
    _$NotificationSettingsImpl(
      newEmail: json['newEmail'] as bool?,
      importantEmail: json['importantEmail'] as bool?,
      mentions: json['mentions'] as bool?,
      calendar: json['calendar'] as bool?,
      reminders: json['reminders'] as bool?,
      excludedSenders: (json['excludedSenders'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      vipSenders: (json['vipSenders'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      quietHours: json['quietHours'] as bool?,
      quietStartTime: json['quietStartTime'] == null
          ? null
          : DateTime.parse(json['quietStartTime'] as String),
      quietEndTime: json['quietEndTime'] == null
          ? null
          : DateTime.parse(json['quietEndTime'] as String),
    );

Map<String, dynamic> _$$NotificationSettingsImplToJson(
        _$NotificationSettingsImpl instance) =>
    <String, dynamic>{
      'newEmail': instance.newEmail,
      'importantEmail': instance.importantEmail,
      'mentions': instance.mentions,
      'calendar': instance.calendar,
      'reminders': instance.reminders,
      'excludedSenders': instance.excludedSenders,
      'vipSenders': instance.vipSenders,
      'quietHours': instance.quietHours,
      'quietStartTime': instance.quietStartTime?.toIso8601String(),
      'quietEndTime': instance.quietEndTime?.toIso8601String(),
    };

_$SecuritySettingsImpl _$$SecuritySettingsImplFromJson(
        Map<String, dynamic> json) =>
    _$SecuritySettingsImpl(
      twoFactorAuth: json['twoFactorAuth'] as bool?,
      blockExternalImages: json['blockExternalImages'] as bool?,
      warnPhishing: json['warnPhishing'] as bool?,
      encryptionRequired: json['encryptionRequired'] as bool?,
      trustedDomains: (json['trustedDomains'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      blockedSenders: (json['blockedSenders'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      requireSenderAuth: json['requireSenderAuth'] as bool?,
    );

Map<String, dynamic> _$$SecuritySettingsImplToJson(
        _$SecuritySettingsImpl instance) =>
    <String, dynamic>{
      'twoFactorAuth': instance.twoFactorAuth,
      'blockExternalImages': instance.blockExternalImages,
      'warnPhishing': instance.warnPhishing,
      'encryptionRequired': instance.encryptionRequired,
      'trustedDomains': instance.trustedDomains,
      'blockedSenders': instance.blockedSenders,
      'requireSenderAuth': instance.requireSenderAuth,
    };

_$ContactGroupImpl _$$ContactGroupImplFromJson(Map<String, dynamic> json) =>
    _$ContactGroupImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      contactIds: (json['contactIds'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$ContactGroupImplToJson(_$ContactGroupImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'contactIds': instance.contactIds,
      'createdAt': instance.createdAt?.toIso8601String(),
    };

_$EmailSearchFilterImpl _$$EmailSearchFilterImplFromJson(
        Map<String, dynamic> json) =>
    _$EmailSearchFilterImpl(
      query: json['query'] as String?,
      sender: json['sender'] == null
          ? null
          : Contact.fromJson(json['sender'] as Map<String, dynamic>),
      recipients: (json['recipients'] as List<dynamic>?)
          ?.map((e) => Contact.fromJson(e as Map<String, dynamic>))
          .toList(),
      folders: (json['folders'] as List<dynamic>?)
          ?.map((e) => EmailFolder.fromJson(e as Map<String, dynamic>))
          .toList(),
      labels: (json['labels'] as List<dynamic>?)
          ?.map((e) => EmailLabel.fromJson(e as Map<String, dynamic>))
          .toList(),
      dateFrom: json['dateFrom'] == null
          ? null
          : DateTime.parse(json['dateFrom'] as String),
      dateTo: json['dateTo'] == null
          ? null
          : DateTime.parse(json['dateTo'] as String),
      hasAttachments: json['hasAttachments'] as bool?,
      isUnread: json['isUnread'] as bool?,
      isStarred: json['isStarred'] as bool?,
      isImportant: json['isImportant'] as bool?,
      priority: $enumDecodeNullable(_$EmailPriorityEnumMap, json['priority']),
      sizeMin: (json['sizeMin'] as num?)?.toInt(),
      sizeMax: (json['sizeMax'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$EmailSearchFilterImplToJson(
        _$EmailSearchFilterImpl instance) =>
    <String, dynamic>{
      'query': instance.query,
      'sender': instance.sender,
      'recipients': instance.recipients,
      'folders': instance.folders,
      'labels': instance.labels,
      'dateFrom': instance.dateFrom?.toIso8601String(),
      'dateTo': instance.dateTo?.toIso8601String(),
      'hasAttachments': instance.hasAttachments,
      'isUnread': instance.isUnread,
      'isStarred': instance.isStarred,
      'isImportant': instance.isImportant,
      'priority': _$EmailPriorityEnumMap[instance.priority],
      'sizeMin': instance.sizeMin,
      'sizeMax': instance.sizeMax,
    };
