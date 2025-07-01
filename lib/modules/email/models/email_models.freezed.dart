// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'email_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Email _$EmailFromJson(Map<String, dynamic> json) {
  return _Email.fromJson(json);
}

/// @nodoc
mixin _$Email {
  String get id => throw _privateConstructorUsedError;
  String get subject => throw _privateConstructorUsedError;
  String get body => throw _privateConstructorUsedError;
  Contact get sender => throw _privateConstructorUsedError;
  List<Contact> get recipients => throw _privateConstructorUsedError;
  List<Contact> get ccRecipients => throw _privateConstructorUsedError;
  List<Contact> get bccRecipients => throw _privateConstructorUsedError;
  DateTime get timestamp => throw _privateConstructorUsedError;
  List<Attachment> get attachments => throw _privateConstructorUsedError;
  EmailFolder get folder => throw _privateConstructorUsedError;
  List<EmailLabel> get labels => throw _privateConstructorUsedError;
  EmailPriority get priority => throw _privateConstructorUsedError;
  bool get isRead => throw _privateConstructorUsedError;
  bool get isStarred => throw _privateConstructorUsedError;
  bool get isImportant => throw _privateConstructorUsedError;
  bool get isSpam => throw _privateConstructorUsedError;
  bool get isDraft => throw _privateConstructorUsedError;
  String? get replyToId => throw _privateConstructorUsedError;
  String? get forwardFromId => throw _privateConstructorUsedError;
  String? get threadId => throw _privateConstructorUsedError;
  DateTime? get scheduledAt => throw _privateConstructorUsedError;
  String? get signature => throw _privateConstructorUsedError;
  bool? get readReceipt => throw _privateConstructorUsedError;
  String? get messageId => throw _privateConstructorUsedError;
  Map<String, dynamic>? get headers => throw _privateConstructorUsedError;

  /// Serializes this Email to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Email
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EmailCopyWith<Email> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EmailCopyWith<$Res> {
  factory $EmailCopyWith(Email value, $Res Function(Email) then) =
      _$EmailCopyWithImpl<$Res, Email>;
  @useResult
  $Res call(
      {String id,
      String subject,
      String body,
      Contact sender,
      List<Contact> recipients,
      List<Contact> ccRecipients,
      List<Contact> bccRecipients,
      DateTime timestamp,
      List<Attachment> attachments,
      EmailFolder folder,
      List<EmailLabel> labels,
      EmailPriority priority,
      bool isRead,
      bool isStarred,
      bool isImportant,
      bool isSpam,
      bool isDraft,
      String? replyToId,
      String? forwardFromId,
      String? threadId,
      DateTime? scheduledAt,
      String? signature,
      bool? readReceipt,
      String? messageId,
      Map<String, dynamic>? headers});

  $ContactCopyWith<$Res> get sender;
  $EmailFolderCopyWith<$Res> get folder;
}

/// @nodoc
class _$EmailCopyWithImpl<$Res, $Val extends Email>
    implements $EmailCopyWith<$Res> {
  _$EmailCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Email
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? subject = null,
    Object? body = null,
    Object? sender = null,
    Object? recipients = null,
    Object? ccRecipients = null,
    Object? bccRecipients = null,
    Object? timestamp = null,
    Object? attachments = null,
    Object? folder = null,
    Object? labels = null,
    Object? priority = null,
    Object? isRead = null,
    Object? isStarred = null,
    Object? isImportant = null,
    Object? isSpam = null,
    Object? isDraft = null,
    Object? replyToId = freezed,
    Object? forwardFromId = freezed,
    Object? threadId = freezed,
    Object? scheduledAt = freezed,
    Object? signature = freezed,
    Object? readReceipt = freezed,
    Object? messageId = freezed,
    Object? headers = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      subject: null == subject
          ? _value.subject
          : subject // ignore: cast_nullable_to_non_nullable
              as String,
      body: null == body
          ? _value.body
          : body // ignore: cast_nullable_to_non_nullable
              as String,
      sender: null == sender
          ? _value.sender
          : sender // ignore: cast_nullable_to_non_nullable
              as Contact,
      recipients: null == recipients
          ? _value.recipients
          : recipients // ignore: cast_nullable_to_non_nullable
              as List<Contact>,
      ccRecipients: null == ccRecipients
          ? _value.ccRecipients
          : ccRecipients // ignore: cast_nullable_to_non_nullable
              as List<Contact>,
      bccRecipients: null == bccRecipients
          ? _value.bccRecipients
          : bccRecipients // ignore: cast_nullable_to_non_nullable
              as List<Contact>,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      attachments: null == attachments
          ? _value.attachments
          : attachments // ignore: cast_nullable_to_non_nullable
              as List<Attachment>,
      folder: null == folder
          ? _value.folder
          : folder // ignore: cast_nullable_to_non_nullable
              as EmailFolder,
      labels: null == labels
          ? _value.labels
          : labels // ignore: cast_nullable_to_non_nullable
              as List<EmailLabel>,
      priority: null == priority
          ? _value.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as EmailPriority,
      isRead: null == isRead
          ? _value.isRead
          : isRead // ignore: cast_nullable_to_non_nullable
              as bool,
      isStarred: null == isStarred
          ? _value.isStarred
          : isStarred // ignore: cast_nullable_to_non_nullable
              as bool,
      isImportant: null == isImportant
          ? _value.isImportant
          : isImportant // ignore: cast_nullable_to_non_nullable
              as bool,
      isSpam: null == isSpam
          ? _value.isSpam
          : isSpam // ignore: cast_nullable_to_non_nullable
              as bool,
      isDraft: null == isDraft
          ? _value.isDraft
          : isDraft // ignore: cast_nullable_to_non_nullable
              as bool,
      replyToId: freezed == replyToId
          ? _value.replyToId
          : replyToId // ignore: cast_nullable_to_non_nullable
              as String?,
      forwardFromId: freezed == forwardFromId
          ? _value.forwardFromId
          : forwardFromId // ignore: cast_nullable_to_non_nullable
              as String?,
      threadId: freezed == threadId
          ? _value.threadId
          : threadId // ignore: cast_nullable_to_non_nullable
              as String?,
      scheduledAt: freezed == scheduledAt
          ? _value.scheduledAt
          : scheduledAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      signature: freezed == signature
          ? _value.signature
          : signature // ignore: cast_nullable_to_non_nullable
              as String?,
      readReceipt: freezed == readReceipt
          ? _value.readReceipt
          : readReceipt // ignore: cast_nullable_to_non_nullable
              as bool?,
      messageId: freezed == messageId
          ? _value.messageId
          : messageId // ignore: cast_nullable_to_non_nullable
              as String?,
      headers: freezed == headers
          ? _value.headers
          : headers // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ) as $Val);
  }

  /// Create a copy of Email
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ContactCopyWith<$Res> get sender {
    return $ContactCopyWith<$Res>(_value.sender, (value) {
      return _then(_value.copyWith(sender: value) as $Val);
    });
  }

  /// Create a copy of Email
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $EmailFolderCopyWith<$Res> get folder {
    return $EmailFolderCopyWith<$Res>(_value.folder, (value) {
      return _then(_value.copyWith(folder: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$EmailImplCopyWith<$Res> implements $EmailCopyWith<$Res> {
  factory _$$EmailImplCopyWith(
          _$EmailImpl value, $Res Function(_$EmailImpl) then) =
      __$$EmailImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String subject,
      String body,
      Contact sender,
      List<Contact> recipients,
      List<Contact> ccRecipients,
      List<Contact> bccRecipients,
      DateTime timestamp,
      List<Attachment> attachments,
      EmailFolder folder,
      List<EmailLabel> labels,
      EmailPriority priority,
      bool isRead,
      bool isStarred,
      bool isImportant,
      bool isSpam,
      bool isDraft,
      String? replyToId,
      String? forwardFromId,
      String? threadId,
      DateTime? scheduledAt,
      String? signature,
      bool? readReceipt,
      String? messageId,
      Map<String, dynamic>? headers});

  @override
  $ContactCopyWith<$Res> get sender;
  @override
  $EmailFolderCopyWith<$Res> get folder;
}

/// @nodoc
class __$$EmailImplCopyWithImpl<$Res>
    extends _$EmailCopyWithImpl<$Res, _$EmailImpl>
    implements _$$EmailImplCopyWith<$Res> {
  __$$EmailImplCopyWithImpl(
      _$EmailImpl _value, $Res Function(_$EmailImpl) _then)
      : super(_value, _then);

  /// Create a copy of Email
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? subject = null,
    Object? body = null,
    Object? sender = null,
    Object? recipients = null,
    Object? ccRecipients = null,
    Object? bccRecipients = null,
    Object? timestamp = null,
    Object? attachments = null,
    Object? folder = null,
    Object? labels = null,
    Object? priority = null,
    Object? isRead = null,
    Object? isStarred = null,
    Object? isImportant = null,
    Object? isSpam = null,
    Object? isDraft = null,
    Object? replyToId = freezed,
    Object? forwardFromId = freezed,
    Object? threadId = freezed,
    Object? scheduledAt = freezed,
    Object? signature = freezed,
    Object? readReceipt = freezed,
    Object? messageId = freezed,
    Object? headers = freezed,
  }) {
    return _then(_$EmailImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      subject: null == subject
          ? _value.subject
          : subject // ignore: cast_nullable_to_non_nullable
              as String,
      body: null == body
          ? _value.body
          : body // ignore: cast_nullable_to_non_nullable
              as String,
      sender: null == sender
          ? _value.sender
          : sender // ignore: cast_nullable_to_non_nullable
              as Contact,
      recipients: null == recipients
          ? _value._recipients
          : recipients // ignore: cast_nullable_to_non_nullable
              as List<Contact>,
      ccRecipients: null == ccRecipients
          ? _value._ccRecipients
          : ccRecipients // ignore: cast_nullable_to_non_nullable
              as List<Contact>,
      bccRecipients: null == bccRecipients
          ? _value._bccRecipients
          : bccRecipients // ignore: cast_nullable_to_non_nullable
              as List<Contact>,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      attachments: null == attachments
          ? _value._attachments
          : attachments // ignore: cast_nullable_to_non_nullable
              as List<Attachment>,
      folder: null == folder
          ? _value.folder
          : folder // ignore: cast_nullable_to_non_nullable
              as EmailFolder,
      labels: null == labels
          ? _value._labels
          : labels // ignore: cast_nullable_to_non_nullable
              as List<EmailLabel>,
      priority: null == priority
          ? _value.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as EmailPriority,
      isRead: null == isRead
          ? _value.isRead
          : isRead // ignore: cast_nullable_to_non_nullable
              as bool,
      isStarred: null == isStarred
          ? _value.isStarred
          : isStarred // ignore: cast_nullable_to_non_nullable
              as bool,
      isImportant: null == isImportant
          ? _value.isImportant
          : isImportant // ignore: cast_nullable_to_non_nullable
              as bool,
      isSpam: null == isSpam
          ? _value.isSpam
          : isSpam // ignore: cast_nullable_to_non_nullable
              as bool,
      isDraft: null == isDraft
          ? _value.isDraft
          : isDraft // ignore: cast_nullable_to_non_nullable
              as bool,
      replyToId: freezed == replyToId
          ? _value.replyToId
          : replyToId // ignore: cast_nullable_to_non_nullable
              as String?,
      forwardFromId: freezed == forwardFromId
          ? _value.forwardFromId
          : forwardFromId // ignore: cast_nullable_to_non_nullable
              as String?,
      threadId: freezed == threadId
          ? _value.threadId
          : threadId // ignore: cast_nullable_to_non_nullable
              as String?,
      scheduledAt: freezed == scheduledAt
          ? _value.scheduledAt
          : scheduledAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      signature: freezed == signature
          ? _value.signature
          : signature // ignore: cast_nullable_to_non_nullable
              as String?,
      readReceipt: freezed == readReceipt
          ? _value.readReceipt
          : readReceipt // ignore: cast_nullable_to_non_nullable
              as bool?,
      messageId: freezed == messageId
          ? _value.messageId
          : messageId // ignore: cast_nullable_to_non_nullable
              as String?,
      headers: freezed == headers
          ? _value._headers
          : headers // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$EmailImpl implements _Email {
  const _$EmailImpl(
      {required this.id,
      required this.subject,
      required this.body,
      required this.sender,
      required final List<Contact> recipients,
      required final List<Contact> ccRecipients,
      required final List<Contact> bccRecipients,
      required this.timestamp,
      required final List<Attachment> attachments,
      required this.folder,
      required final List<EmailLabel> labels,
      required this.priority,
      required this.isRead,
      required this.isStarred,
      required this.isImportant,
      required this.isSpam,
      required this.isDraft,
      this.replyToId,
      this.forwardFromId,
      this.threadId,
      this.scheduledAt,
      this.signature,
      this.readReceipt,
      this.messageId,
      final Map<String, dynamic>? headers})
      : _recipients = recipients,
        _ccRecipients = ccRecipients,
        _bccRecipients = bccRecipients,
        _attachments = attachments,
        _labels = labels,
        _headers = headers;

  factory _$EmailImpl.fromJson(Map<String, dynamic> json) =>
      _$$EmailImplFromJson(json);

  @override
  final String id;
  @override
  final String subject;
  @override
  final String body;
  @override
  final Contact sender;
  final List<Contact> _recipients;
  @override
  List<Contact> get recipients {
    if (_recipients is EqualUnmodifiableListView) return _recipients;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_recipients);
  }

  final List<Contact> _ccRecipients;
  @override
  List<Contact> get ccRecipients {
    if (_ccRecipients is EqualUnmodifiableListView) return _ccRecipients;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_ccRecipients);
  }

  final List<Contact> _bccRecipients;
  @override
  List<Contact> get bccRecipients {
    if (_bccRecipients is EqualUnmodifiableListView) return _bccRecipients;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_bccRecipients);
  }

  @override
  final DateTime timestamp;
  final List<Attachment> _attachments;
  @override
  List<Attachment> get attachments {
    if (_attachments is EqualUnmodifiableListView) return _attachments;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_attachments);
  }

  @override
  final EmailFolder folder;
  final List<EmailLabel> _labels;
  @override
  List<EmailLabel> get labels {
    if (_labels is EqualUnmodifiableListView) return _labels;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_labels);
  }

  @override
  final EmailPriority priority;
  @override
  final bool isRead;
  @override
  final bool isStarred;
  @override
  final bool isImportant;
  @override
  final bool isSpam;
  @override
  final bool isDraft;
  @override
  final String? replyToId;
  @override
  final String? forwardFromId;
  @override
  final String? threadId;
  @override
  final DateTime? scheduledAt;
  @override
  final String? signature;
  @override
  final bool? readReceipt;
  @override
  final String? messageId;
  final Map<String, dynamic>? _headers;
  @override
  Map<String, dynamic>? get headers {
    final value = _headers;
    if (value == null) return null;
    if (_headers is EqualUnmodifiableMapView) return _headers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'Email(id: $id, subject: $subject, body: $body, sender: $sender, recipients: $recipients, ccRecipients: $ccRecipients, bccRecipients: $bccRecipients, timestamp: $timestamp, attachments: $attachments, folder: $folder, labels: $labels, priority: $priority, isRead: $isRead, isStarred: $isStarred, isImportant: $isImportant, isSpam: $isSpam, isDraft: $isDraft, replyToId: $replyToId, forwardFromId: $forwardFromId, threadId: $threadId, scheduledAt: $scheduledAt, signature: $signature, readReceipt: $readReceipt, messageId: $messageId, headers: $headers)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EmailImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.subject, subject) || other.subject == subject) &&
            (identical(other.body, body) || other.body == body) &&
            (identical(other.sender, sender) || other.sender == sender) &&
            const DeepCollectionEquality()
                .equals(other._recipients, _recipients) &&
            const DeepCollectionEquality()
                .equals(other._ccRecipients, _ccRecipients) &&
            const DeepCollectionEquality()
                .equals(other._bccRecipients, _bccRecipients) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            const DeepCollectionEquality()
                .equals(other._attachments, _attachments) &&
            (identical(other.folder, folder) || other.folder == folder) &&
            const DeepCollectionEquality().equals(other._labels, _labels) &&
            (identical(other.priority, priority) ||
                other.priority == priority) &&
            (identical(other.isRead, isRead) || other.isRead == isRead) &&
            (identical(other.isStarred, isStarred) ||
                other.isStarred == isStarred) &&
            (identical(other.isImportant, isImportant) ||
                other.isImportant == isImportant) &&
            (identical(other.isSpam, isSpam) || other.isSpam == isSpam) &&
            (identical(other.isDraft, isDraft) || other.isDraft == isDraft) &&
            (identical(other.replyToId, replyToId) ||
                other.replyToId == replyToId) &&
            (identical(other.forwardFromId, forwardFromId) ||
                other.forwardFromId == forwardFromId) &&
            (identical(other.threadId, threadId) ||
                other.threadId == threadId) &&
            (identical(other.scheduledAt, scheduledAt) ||
                other.scheduledAt == scheduledAt) &&
            (identical(other.signature, signature) ||
                other.signature == signature) &&
            (identical(other.readReceipt, readReceipt) ||
                other.readReceipt == readReceipt) &&
            (identical(other.messageId, messageId) ||
                other.messageId == messageId) &&
            const DeepCollectionEquality().equals(other._headers, _headers));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        subject,
        body,
        sender,
        const DeepCollectionEquality().hash(_recipients),
        const DeepCollectionEquality().hash(_ccRecipients),
        const DeepCollectionEquality().hash(_bccRecipients),
        timestamp,
        const DeepCollectionEquality().hash(_attachments),
        folder,
        const DeepCollectionEquality().hash(_labels),
        priority,
        isRead,
        isStarred,
        isImportant,
        isSpam,
        isDraft,
        replyToId,
        forwardFromId,
        threadId,
        scheduledAt,
        signature,
        readReceipt,
        messageId,
        const DeepCollectionEquality().hash(_headers)
      ]);

  /// Create a copy of Email
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EmailImplCopyWith<_$EmailImpl> get copyWith =>
      __$$EmailImplCopyWithImpl<_$EmailImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EmailImplToJson(
      this,
    );
  }
}

abstract class _Email implements Email {
  const factory _Email(
      {required final String id,
      required final String subject,
      required final String body,
      required final Contact sender,
      required final List<Contact> recipients,
      required final List<Contact> ccRecipients,
      required final List<Contact> bccRecipients,
      required final DateTime timestamp,
      required final List<Attachment> attachments,
      required final EmailFolder folder,
      required final List<EmailLabel> labels,
      required final EmailPriority priority,
      required final bool isRead,
      required final bool isStarred,
      required final bool isImportant,
      required final bool isSpam,
      required final bool isDraft,
      final String? replyToId,
      final String? forwardFromId,
      final String? threadId,
      final DateTime? scheduledAt,
      final String? signature,
      final bool? readReceipt,
      final String? messageId,
      final Map<String, dynamic>? headers}) = _$EmailImpl;

  factory _Email.fromJson(Map<String, dynamic> json) = _$EmailImpl.fromJson;

  @override
  String get id;
  @override
  String get subject;
  @override
  String get body;
  @override
  Contact get sender;
  @override
  List<Contact> get recipients;
  @override
  List<Contact> get ccRecipients;
  @override
  List<Contact> get bccRecipients;
  @override
  DateTime get timestamp;
  @override
  List<Attachment> get attachments;
  @override
  EmailFolder get folder;
  @override
  List<EmailLabel> get labels;
  @override
  EmailPriority get priority;
  @override
  bool get isRead;
  @override
  bool get isStarred;
  @override
  bool get isImportant;
  @override
  bool get isSpam;
  @override
  bool get isDraft;
  @override
  String? get replyToId;
  @override
  String? get forwardFromId;
  @override
  String? get threadId;
  @override
  DateTime? get scheduledAt;
  @override
  String? get signature;
  @override
  bool? get readReceipt;
  @override
  String? get messageId;
  @override
  Map<String, dynamic>? get headers;

  /// Create a copy of Email
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EmailImplCopyWith<_$EmailImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Contact _$ContactFromJson(Map<String, dynamic> json) {
  return _Contact.fromJson(json);
}

/// @nodoc
mixin _$Contact {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  String? get avatar => throw _privateConstructorUsedError;
  String? get phone => throw _privateConstructorUsedError;
  String? get company => throw _privateConstructorUsedError;
  String? get title => throw _privateConstructorUsedError;
  List<String>? get tags => throw _privateConstructorUsedError;
  DateTime? get lastContact => throw _privateConstructorUsedError;
  bool? get isBlocked => throw _privateConstructorUsedError;
  ContactGroup? get group => throw _privateConstructorUsedError;
  Map<String, dynamic>? get customFields => throw _privateConstructorUsedError;

  /// Serializes this Contact to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Contact
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ContactCopyWith<Contact> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ContactCopyWith<$Res> {
  factory $ContactCopyWith(Contact value, $Res Function(Contact) then) =
      _$ContactCopyWithImpl<$Res, Contact>;
  @useResult
  $Res call(
      {String id,
      String name,
      String email,
      String? avatar,
      String? phone,
      String? company,
      String? title,
      List<String>? tags,
      DateTime? lastContact,
      bool? isBlocked,
      ContactGroup? group,
      Map<String, dynamic>? customFields});

  $ContactGroupCopyWith<$Res>? get group;
}

/// @nodoc
class _$ContactCopyWithImpl<$Res, $Val extends Contact>
    implements $ContactCopyWith<$Res> {
  _$ContactCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Contact
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? email = null,
    Object? avatar = freezed,
    Object? phone = freezed,
    Object? company = freezed,
    Object? title = freezed,
    Object? tags = freezed,
    Object? lastContact = freezed,
    Object? isBlocked = freezed,
    Object? group = freezed,
    Object? customFields = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      avatar: freezed == avatar
          ? _value.avatar
          : avatar // ignore: cast_nullable_to_non_nullable
              as String?,
      phone: freezed == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String?,
      company: freezed == company
          ? _value.company
          : company // ignore: cast_nullable_to_non_nullable
              as String?,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      tags: freezed == tags
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      lastContact: freezed == lastContact
          ? _value.lastContact
          : lastContact // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      isBlocked: freezed == isBlocked
          ? _value.isBlocked
          : isBlocked // ignore: cast_nullable_to_non_nullable
              as bool?,
      group: freezed == group
          ? _value.group
          : group // ignore: cast_nullable_to_non_nullable
              as ContactGroup?,
      customFields: freezed == customFields
          ? _value.customFields
          : customFields // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ) as $Val);
  }

  /// Create a copy of Contact
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ContactGroupCopyWith<$Res>? get group {
    if (_value.group == null) {
      return null;
    }

    return $ContactGroupCopyWith<$Res>(_value.group!, (value) {
      return _then(_value.copyWith(group: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ContactImplCopyWith<$Res> implements $ContactCopyWith<$Res> {
  factory _$$ContactImplCopyWith(
          _$ContactImpl value, $Res Function(_$ContactImpl) then) =
      __$$ContactImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String email,
      String? avatar,
      String? phone,
      String? company,
      String? title,
      List<String>? tags,
      DateTime? lastContact,
      bool? isBlocked,
      ContactGroup? group,
      Map<String, dynamic>? customFields});

  @override
  $ContactGroupCopyWith<$Res>? get group;
}

/// @nodoc
class __$$ContactImplCopyWithImpl<$Res>
    extends _$ContactCopyWithImpl<$Res, _$ContactImpl>
    implements _$$ContactImplCopyWith<$Res> {
  __$$ContactImplCopyWithImpl(
      _$ContactImpl _value, $Res Function(_$ContactImpl) _then)
      : super(_value, _then);

  /// Create a copy of Contact
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? email = null,
    Object? avatar = freezed,
    Object? phone = freezed,
    Object? company = freezed,
    Object? title = freezed,
    Object? tags = freezed,
    Object? lastContact = freezed,
    Object? isBlocked = freezed,
    Object? group = freezed,
    Object? customFields = freezed,
  }) {
    return _then(_$ContactImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      avatar: freezed == avatar
          ? _value.avatar
          : avatar // ignore: cast_nullable_to_non_nullable
              as String?,
      phone: freezed == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String?,
      company: freezed == company
          ? _value.company
          : company // ignore: cast_nullable_to_non_nullable
              as String?,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      tags: freezed == tags
          ? _value._tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      lastContact: freezed == lastContact
          ? _value.lastContact
          : lastContact // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      isBlocked: freezed == isBlocked
          ? _value.isBlocked
          : isBlocked // ignore: cast_nullable_to_non_nullable
              as bool?,
      group: freezed == group
          ? _value.group
          : group // ignore: cast_nullable_to_non_nullable
              as ContactGroup?,
      customFields: freezed == customFields
          ? _value._customFields
          : customFields // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ContactImpl implements _Contact {
  const _$ContactImpl(
      {required this.id,
      required this.name,
      required this.email,
      this.avatar,
      this.phone,
      this.company,
      this.title,
      final List<String>? tags,
      this.lastContact,
      this.isBlocked,
      this.group,
      final Map<String, dynamic>? customFields})
      : _tags = tags,
        _customFields = customFields;

  factory _$ContactImpl.fromJson(Map<String, dynamic> json) =>
      _$$ContactImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String email;
  @override
  final String? avatar;
  @override
  final String? phone;
  @override
  final String? company;
  @override
  final String? title;
  final List<String>? _tags;
  @override
  List<String>? get tags {
    final value = _tags;
    if (value == null) return null;
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final DateTime? lastContact;
  @override
  final bool? isBlocked;
  @override
  final ContactGroup? group;
  final Map<String, dynamic>? _customFields;
  @override
  Map<String, dynamic>? get customFields {
    final value = _customFields;
    if (value == null) return null;
    if (_customFields is EqualUnmodifiableMapView) return _customFields;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'Contact(id: $id, name: $name, email: $email, avatar: $avatar, phone: $phone, company: $company, title: $title, tags: $tags, lastContact: $lastContact, isBlocked: $isBlocked, group: $group, customFields: $customFields)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ContactImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.avatar, avatar) || other.avatar == avatar) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.company, company) || other.company == company) &&
            (identical(other.title, title) || other.title == title) &&
            const DeepCollectionEquality().equals(other._tags, _tags) &&
            (identical(other.lastContact, lastContact) ||
                other.lastContact == lastContact) &&
            (identical(other.isBlocked, isBlocked) ||
                other.isBlocked == isBlocked) &&
            (identical(other.group, group) || other.group == group) &&
            const DeepCollectionEquality()
                .equals(other._customFields, _customFields));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      email,
      avatar,
      phone,
      company,
      title,
      const DeepCollectionEquality().hash(_tags),
      lastContact,
      isBlocked,
      group,
      const DeepCollectionEquality().hash(_customFields));

  /// Create a copy of Contact
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ContactImplCopyWith<_$ContactImpl> get copyWith =>
      __$$ContactImplCopyWithImpl<_$ContactImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ContactImplToJson(
      this,
    );
  }
}

abstract class _Contact implements Contact {
  const factory _Contact(
      {required final String id,
      required final String name,
      required final String email,
      final String? avatar,
      final String? phone,
      final String? company,
      final String? title,
      final List<String>? tags,
      final DateTime? lastContact,
      final bool? isBlocked,
      final ContactGroup? group,
      final Map<String, dynamic>? customFields}) = _$ContactImpl;

  factory _Contact.fromJson(Map<String, dynamic> json) = _$ContactImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get email;
  @override
  String? get avatar;
  @override
  String? get phone;
  @override
  String? get company;
  @override
  String? get title;
  @override
  List<String>? get tags;
  @override
  DateTime? get lastContact;
  @override
  bool? get isBlocked;
  @override
  ContactGroup? get group;
  @override
  Map<String, dynamic>? get customFields;

  /// Create a copy of Contact
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ContactImplCopyWith<_$ContactImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Attachment _$AttachmentFromJson(Map<String, dynamic> json) {
  return _Attachment.fromJson(json);
}

/// @nodoc
mixin _$Attachment {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get mimeType => throw _privateConstructorUsedError;
  int get size => throw _privateConstructorUsedError;
  String? get url => throw _privateConstructorUsedError;
  String? get localPath => throw _privateConstructorUsedError;
  String? get contentId => throw _privateConstructorUsedError;
  bool? get isInline => throw _privateConstructorUsedError;
  DateTime? get uploadedAt => throw _privateConstructorUsedError;
  AttachmentStatus? get status => throw _privateConstructorUsedError;
  double? get uploadProgress => throw _privateConstructorUsedError;

  /// Serializes this Attachment to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Attachment
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AttachmentCopyWith<Attachment> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AttachmentCopyWith<$Res> {
  factory $AttachmentCopyWith(
          Attachment value, $Res Function(Attachment) then) =
      _$AttachmentCopyWithImpl<$Res, Attachment>;
  @useResult
  $Res call(
      {String id,
      String name,
      String mimeType,
      int size,
      String? url,
      String? localPath,
      String? contentId,
      bool? isInline,
      DateTime? uploadedAt,
      AttachmentStatus? status,
      double? uploadProgress});
}

/// @nodoc
class _$AttachmentCopyWithImpl<$Res, $Val extends Attachment>
    implements $AttachmentCopyWith<$Res> {
  _$AttachmentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Attachment
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? mimeType = null,
    Object? size = null,
    Object? url = freezed,
    Object? localPath = freezed,
    Object? contentId = freezed,
    Object? isInline = freezed,
    Object? uploadedAt = freezed,
    Object? status = freezed,
    Object? uploadProgress = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      mimeType: null == mimeType
          ? _value.mimeType
          : mimeType // ignore: cast_nullable_to_non_nullable
              as String,
      size: null == size
          ? _value.size
          : size // ignore: cast_nullable_to_non_nullable
              as int,
      url: freezed == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String?,
      localPath: freezed == localPath
          ? _value.localPath
          : localPath // ignore: cast_nullable_to_non_nullable
              as String?,
      contentId: freezed == contentId
          ? _value.contentId
          : contentId // ignore: cast_nullable_to_non_nullable
              as String?,
      isInline: freezed == isInline
          ? _value.isInline
          : isInline // ignore: cast_nullable_to_non_nullable
              as bool?,
      uploadedAt: freezed == uploadedAt
          ? _value.uploadedAt
          : uploadedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as AttachmentStatus?,
      uploadProgress: freezed == uploadProgress
          ? _value.uploadProgress
          : uploadProgress // ignore: cast_nullable_to_non_nullable
              as double?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AttachmentImplCopyWith<$Res>
    implements $AttachmentCopyWith<$Res> {
  factory _$$AttachmentImplCopyWith(
          _$AttachmentImpl value, $Res Function(_$AttachmentImpl) then) =
      __$$AttachmentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String mimeType,
      int size,
      String? url,
      String? localPath,
      String? contentId,
      bool? isInline,
      DateTime? uploadedAt,
      AttachmentStatus? status,
      double? uploadProgress});
}

/// @nodoc
class __$$AttachmentImplCopyWithImpl<$Res>
    extends _$AttachmentCopyWithImpl<$Res, _$AttachmentImpl>
    implements _$$AttachmentImplCopyWith<$Res> {
  __$$AttachmentImplCopyWithImpl(
      _$AttachmentImpl _value, $Res Function(_$AttachmentImpl) _then)
      : super(_value, _then);

  /// Create a copy of Attachment
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? mimeType = null,
    Object? size = null,
    Object? url = freezed,
    Object? localPath = freezed,
    Object? contentId = freezed,
    Object? isInline = freezed,
    Object? uploadedAt = freezed,
    Object? status = freezed,
    Object? uploadProgress = freezed,
  }) {
    return _then(_$AttachmentImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      mimeType: null == mimeType
          ? _value.mimeType
          : mimeType // ignore: cast_nullable_to_non_nullable
              as String,
      size: null == size
          ? _value.size
          : size // ignore: cast_nullable_to_non_nullable
              as int,
      url: freezed == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String?,
      localPath: freezed == localPath
          ? _value.localPath
          : localPath // ignore: cast_nullable_to_non_nullable
              as String?,
      contentId: freezed == contentId
          ? _value.contentId
          : contentId // ignore: cast_nullable_to_non_nullable
              as String?,
      isInline: freezed == isInline
          ? _value.isInline
          : isInline // ignore: cast_nullable_to_non_nullable
              as bool?,
      uploadedAt: freezed == uploadedAt
          ? _value.uploadedAt
          : uploadedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as AttachmentStatus?,
      uploadProgress: freezed == uploadProgress
          ? _value.uploadProgress
          : uploadProgress // ignore: cast_nullable_to_non_nullable
              as double?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AttachmentImpl implements _Attachment {
  const _$AttachmentImpl(
      {required this.id,
      required this.name,
      required this.mimeType,
      required this.size,
      this.url,
      this.localPath,
      this.contentId,
      this.isInline,
      this.uploadedAt,
      this.status,
      this.uploadProgress});

  factory _$AttachmentImpl.fromJson(Map<String, dynamic> json) =>
      _$$AttachmentImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String mimeType;
  @override
  final int size;
  @override
  final String? url;
  @override
  final String? localPath;
  @override
  final String? contentId;
  @override
  final bool? isInline;
  @override
  final DateTime? uploadedAt;
  @override
  final AttachmentStatus? status;
  @override
  final double? uploadProgress;

  @override
  String toString() {
    return 'Attachment(id: $id, name: $name, mimeType: $mimeType, size: $size, url: $url, localPath: $localPath, contentId: $contentId, isInline: $isInline, uploadedAt: $uploadedAt, status: $status, uploadProgress: $uploadProgress)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AttachmentImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.mimeType, mimeType) ||
                other.mimeType == mimeType) &&
            (identical(other.size, size) || other.size == size) &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.localPath, localPath) ||
                other.localPath == localPath) &&
            (identical(other.contentId, contentId) ||
                other.contentId == contentId) &&
            (identical(other.isInline, isInline) ||
                other.isInline == isInline) &&
            (identical(other.uploadedAt, uploadedAt) ||
                other.uploadedAt == uploadedAt) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.uploadProgress, uploadProgress) ||
                other.uploadProgress == uploadProgress));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, mimeType, size, url,
      localPath, contentId, isInline, uploadedAt, status, uploadProgress);

  /// Create a copy of Attachment
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AttachmentImplCopyWith<_$AttachmentImpl> get copyWith =>
      __$$AttachmentImplCopyWithImpl<_$AttachmentImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AttachmentImplToJson(
      this,
    );
  }
}

abstract class _Attachment implements Attachment {
  const factory _Attachment(
      {required final String id,
      required final String name,
      required final String mimeType,
      required final int size,
      final String? url,
      final String? localPath,
      final String? contentId,
      final bool? isInline,
      final DateTime? uploadedAt,
      final AttachmentStatus? status,
      final double? uploadProgress}) = _$AttachmentImpl;

  factory _Attachment.fromJson(Map<String, dynamic> json) =
      _$AttachmentImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get mimeType;
  @override
  int get size;
  @override
  String? get url;
  @override
  String? get localPath;
  @override
  String? get contentId;
  @override
  bool? get isInline;
  @override
  DateTime? get uploadedAt;
  @override
  AttachmentStatus? get status;
  @override
  double? get uploadProgress;

  /// Create a copy of Attachment
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AttachmentImplCopyWith<_$AttachmentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

EmailFolder _$EmailFolderFromJson(Map<String, dynamic> json) {
  return _EmailFolder.fromJson(json);
}

/// @nodoc
mixin _$EmailFolder {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  EmailFolderType get type => throw _privateConstructorUsedError;
  int get unreadCount => throw _privateConstructorUsedError;
  int get totalCount => throw _privateConstructorUsedError;
  String? get parentId => throw _privateConstructorUsedError;
  List<EmailFolder>? get children => throw _privateConstructorUsedError;
  @JsonKey(includeFromJson: false, includeToJson: false)
  IconData? get icon => throw _privateConstructorUsedError;
  @JsonKey(includeFromJson: false, includeToJson: false)
  Color? get color => throw _privateConstructorUsedError;
  bool? get isSystem => throw _privateConstructorUsedError;
  DateTime? get lastModified => throw _privateConstructorUsedError;

  /// Serializes this EmailFolder to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of EmailFolder
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EmailFolderCopyWith<EmailFolder> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EmailFolderCopyWith<$Res> {
  factory $EmailFolderCopyWith(
          EmailFolder value, $Res Function(EmailFolder) then) =
      _$EmailFolderCopyWithImpl<$Res, EmailFolder>;
  @useResult
  $Res call(
      {String id,
      String name,
      EmailFolderType type,
      int unreadCount,
      int totalCount,
      String? parentId,
      List<EmailFolder>? children,
      @JsonKey(includeFromJson: false, includeToJson: false) IconData? icon,
      @JsonKey(includeFromJson: false, includeToJson: false) Color? color,
      bool? isSystem,
      DateTime? lastModified});
}

/// @nodoc
class _$EmailFolderCopyWithImpl<$Res, $Val extends EmailFolder>
    implements $EmailFolderCopyWith<$Res> {
  _$EmailFolderCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of EmailFolder
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? type = null,
    Object? unreadCount = null,
    Object? totalCount = null,
    Object? parentId = freezed,
    Object? children = freezed,
    Object? icon = freezed,
    Object? color = freezed,
    Object? isSystem = freezed,
    Object? lastModified = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as EmailFolderType,
      unreadCount: null == unreadCount
          ? _value.unreadCount
          : unreadCount // ignore: cast_nullable_to_non_nullable
              as int,
      totalCount: null == totalCount
          ? _value.totalCount
          : totalCount // ignore: cast_nullable_to_non_nullable
              as int,
      parentId: freezed == parentId
          ? _value.parentId
          : parentId // ignore: cast_nullable_to_non_nullable
              as String?,
      children: freezed == children
          ? _value.children
          : children // ignore: cast_nullable_to_non_nullable
              as List<EmailFolder>?,
      icon: freezed == icon
          ? _value.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as IconData?,
      color: freezed == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as Color?,
      isSystem: freezed == isSystem
          ? _value.isSystem
          : isSystem // ignore: cast_nullable_to_non_nullable
              as bool?,
      lastModified: freezed == lastModified
          ? _value.lastModified
          : lastModified // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$EmailFolderImplCopyWith<$Res>
    implements $EmailFolderCopyWith<$Res> {
  factory _$$EmailFolderImplCopyWith(
          _$EmailFolderImpl value, $Res Function(_$EmailFolderImpl) then) =
      __$$EmailFolderImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      EmailFolderType type,
      int unreadCount,
      int totalCount,
      String? parentId,
      List<EmailFolder>? children,
      @JsonKey(includeFromJson: false, includeToJson: false) IconData? icon,
      @JsonKey(includeFromJson: false, includeToJson: false) Color? color,
      bool? isSystem,
      DateTime? lastModified});
}

/// @nodoc
class __$$EmailFolderImplCopyWithImpl<$Res>
    extends _$EmailFolderCopyWithImpl<$Res, _$EmailFolderImpl>
    implements _$$EmailFolderImplCopyWith<$Res> {
  __$$EmailFolderImplCopyWithImpl(
      _$EmailFolderImpl _value, $Res Function(_$EmailFolderImpl) _then)
      : super(_value, _then);

  /// Create a copy of EmailFolder
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? type = null,
    Object? unreadCount = null,
    Object? totalCount = null,
    Object? parentId = freezed,
    Object? children = freezed,
    Object? icon = freezed,
    Object? color = freezed,
    Object? isSystem = freezed,
    Object? lastModified = freezed,
  }) {
    return _then(_$EmailFolderImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as EmailFolderType,
      unreadCount: null == unreadCount
          ? _value.unreadCount
          : unreadCount // ignore: cast_nullable_to_non_nullable
              as int,
      totalCount: null == totalCount
          ? _value.totalCount
          : totalCount // ignore: cast_nullable_to_non_nullable
              as int,
      parentId: freezed == parentId
          ? _value.parentId
          : parentId // ignore: cast_nullable_to_non_nullable
              as String?,
      children: freezed == children
          ? _value._children
          : children // ignore: cast_nullable_to_non_nullable
              as List<EmailFolder>?,
      icon: freezed == icon
          ? _value.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as IconData?,
      color: freezed == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as Color?,
      isSystem: freezed == isSystem
          ? _value.isSystem
          : isSystem // ignore: cast_nullable_to_non_nullable
              as bool?,
      lastModified: freezed == lastModified
          ? _value.lastModified
          : lastModified // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$EmailFolderImpl implements _EmailFolder {
  const _$EmailFolderImpl(
      {required this.id,
      required this.name,
      required this.type,
      required this.unreadCount,
      required this.totalCount,
      this.parentId,
      final List<EmailFolder>? children,
      @JsonKey(includeFromJson: false, includeToJson: false) this.icon,
      @JsonKey(includeFromJson: false, includeToJson: false) this.color,
      this.isSystem,
      this.lastModified})
      : _children = children;

  factory _$EmailFolderImpl.fromJson(Map<String, dynamic> json) =>
      _$$EmailFolderImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final EmailFolderType type;
  @override
  final int unreadCount;
  @override
  final int totalCount;
  @override
  final String? parentId;
  final List<EmailFolder>? _children;
  @override
  List<EmailFolder>? get children {
    final value = _children;
    if (value == null) return null;
    if (_children is EqualUnmodifiableListView) return _children;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  final IconData? icon;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  final Color? color;
  @override
  final bool? isSystem;
  @override
  final DateTime? lastModified;

  @override
  String toString() {
    return 'EmailFolder(id: $id, name: $name, type: $type, unreadCount: $unreadCount, totalCount: $totalCount, parentId: $parentId, children: $children, icon: $icon, color: $color, isSystem: $isSystem, lastModified: $lastModified)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EmailFolderImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.unreadCount, unreadCount) ||
                other.unreadCount == unreadCount) &&
            (identical(other.totalCount, totalCount) ||
                other.totalCount == totalCount) &&
            (identical(other.parentId, parentId) ||
                other.parentId == parentId) &&
            const DeepCollectionEquality().equals(other._children, _children) &&
            (identical(other.icon, icon) || other.icon == icon) &&
            (identical(other.color, color) || other.color == color) &&
            (identical(other.isSystem, isSystem) ||
                other.isSystem == isSystem) &&
            (identical(other.lastModified, lastModified) ||
                other.lastModified == lastModified));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      type,
      unreadCount,
      totalCount,
      parentId,
      const DeepCollectionEquality().hash(_children),
      icon,
      color,
      isSystem,
      lastModified);

  /// Create a copy of EmailFolder
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EmailFolderImplCopyWith<_$EmailFolderImpl> get copyWith =>
      __$$EmailFolderImplCopyWithImpl<_$EmailFolderImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EmailFolderImplToJson(
      this,
    );
  }
}

abstract class _EmailFolder implements EmailFolder {
  const factory _EmailFolder(
      {required final String id,
      required final String name,
      required final EmailFolderType type,
      required final int unreadCount,
      required final int totalCount,
      final String? parentId,
      final List<EmailFolder>? children,
      @JsonKey(includeFromJson: false, includeToJson: false)
      final IconData? icon,
      @JsonKey(includeFromJson: false, includeToJson: false) final Color? color,
      final bool? isSystem,
      final DateTime? lastModified}) = _$EmailFolderImpl;

  factory _EmailFolder.fromJson(Map<String, dynamic> json) =
      _$EmailFolderImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  EmailFolderType get type;
  @override
  int get unreadCount;
  @override
  int get totalCount;
  @override
  String? get parentId;
  @override
  List<EmailFolder>? get children;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  IconData? get icon;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  Color? get color;
  @override
  bool? get isSystem;
  @override
  DateTime? get lastModified;

  /// Create a copy of EmailFolder
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EmailFolderImplCopyWith<_$EmailFolderImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

EmailLabel _$EmailLabelFromJson(Map<String, dynamic> json) {
  return _EmailLabel.fromJson(json);
}

/// @nodoc
mixin _$EmailLabel {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  @JsonKey(includeFromJson: false, includeToJson: false)
  Color? get color => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  bool? get isSystem => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;

  /// Serializes this EmailLabel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of EmailLabel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EmailLabelCopyWith<EmailLabel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EmailLabelCopyWith<$Res> {
  factory $EmailLabelCopyWith(
          EmailLabel value, $Res Function(EmailLabel) then) =
      _$EmailLabelCopyWithImpl<$Res, EmailLabel>;
  @useResult
  $Res call(
      {String id,
      String name,
      @JsonKey(includeFromJson: false, includeToJson: false) Color? color,
      String? description,
      bool? isSystem,
      DateTime? createdAt});
}

/// @nodoc
class _$EmailLabelCopyWithImpl<$Res, $Val extends EmailLabel>
    implements $EmailLabelCopyWith<$Res> {
  _$EmailLabelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of EmailLabel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? color = freezed,
    Object? description = freezed,
    Object? isSystem = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      color: freezed == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as Color?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      isSystem: freezed == isSystem
          ? _value.isSystem
          : isSystem // ignore: cast_nullable_to_non_nullable
              as bool?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$EmailLabelImplCopyWith<$Res>
    implements $EmailLabelCopyWith<$Res> {
  factory _$$EmailLabelImplCopyWith(
          _$EmailLabelImpl value, $Res Function(_$EmailLabelImpl) then) =
      __$$EmailLabelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      @JsonKey(includeFromJson: false, includeToJson: false) Color? color,
      String? description,
      bool? isSystem,
      DateTime? createdAt});
}

/// @nodoc
class __$$EmailLabelImplCopyWithImpl<$Res>
    extends _$EmailLabelCopyWithImpl<$Res, _$EmailLabelImpl>
    implements _$$EmailLabelImplCopyWith<$Res> {
  __$$EmailLabelImplCopyWithImpl(
      _$EmailLabelImpl _value, $Res Function(_$EmailLabelImpl) _then)
      : super(_value, _then);

  /// Create a copy of EmailLabel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? color = freezed,
    Object? description = freezed,
    Object? isSystem = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(_$EmailLabelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      color: freezed == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as Color?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      isSystem: freezed == isSystem
          ? _value.isSystem
          : isSystem // ignore: cast_nullable_to_non_nullable
              as bool?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$EmailLabelImpl implements _EmailLabel {
  const _$EmailLabelImpl(
      {required this.id,
      required this.name,
      @JsonKey(includeFromJson: false, includeToJson: false) this.color,
      this.description,
      this.isSystem,
      this.createdAt});

  factory _$EmailLabelImpl.fromJson(Map<String, dynamic> json) =>
      _$$EmailLabelImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  final Color? color;
  @override
  final String? description;
  @override
  final bool? isSystem;
  @override
  final DateTime? createdAt;

  @override
  String toString() {
    return 'EmailLabel(id: $id, name: $name, color: $color, description: $description, isSystem: $isSystem, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EmailLabelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.color, color) || other.color == color) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.isSystem, isSystem) ||
                other.isSystem == isSystem) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, name, color, description, isSystem, createdAt);

  /// Create a copy of EmailLabel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EmailLabelImplCopyWith<_$EmailLabelImpl> get copyWith =>
      __$$EmailLabelImplCopyWithImpl<_$EmailLabelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EmailLabelImplToJson(
      this,
    );
  }
}

abstract class _EmailLabel implements EmailLabel {
  const factory _EmailLabel(
      {required final String id,
      required final String name,
      @JsonKey(includeFromJson: false, includeToJson: false) final Color? color,
      final String? description,
      final bool? isSystem,
      final DateTime? createdAt}) = _$EmailLabelImpl;

  factory _EmailLabel.fromJson(Map<String, dynamic> json) =
      _$EmailLabelImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  Color? get color;
  @override
  String? get description;
  @override
  bool? get isSystem;
  @override
  DateTime? get createdAt;

  /// Create a copy of EmailLabel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EmailLabelImplCopyWith<_$EmailLabelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

EmailThread _$EmailThreadFromJson(Map<String, dynamic> json) {
  return _EmailThread.fromJson(json);
}

/// @nodoc
mixin _$EmailThread {
  String get id => throw _privateConstructorUsedError;
  String get subject => throw _privateConstructorUsedError;
  List<Email> get emails => throw _privateConstructorUsedError;
  List<Contact> get participants => throw _privateConstructorUsedError;
  DateTime get lastActivity => throw _privateConstructorUsedError;
  int get messageCount => throw _privateConstructorUsedError;
  int get unreadCount => throw _privateConstructorUsedError;
  List<EmailLabel> get labels => throw _privateConstructorUsedError;
  bool? get isStarred => throw _privateConstructorUsedError;
  bool? get isImportant => throw _privateConstructorUsedError;
  bool? get isMuted => throw _privateConstructorUsedError;
  EmailFolder? get folder => throw _privateConstructorUsedError;

  /// Serializes this EmailThread to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of EmailThread
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EmailThreadCopyWith<EmailThread> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EmailThreadCopyWith<$Res> {
  factory $EmailThreadCopyWith(
          EmailThread value, $Res Function(EmailThread) then) =
      _$EmailThreadCopyWithImpl<$Res, EmailThread>;
  @useResult
  $Res call(
      {String id,
      String subject,
      List<Email> emails,
      List<Contact> participants,
      DateTime lastActivity,
      int messageCount,
      int unreadCount,
      List<EmailLabel> labels,
      bool? isStarred,
      bool? isImportant,
      bool? isMuted,
      EmailFolder? folder});

  $EmailFolderCopyWith<$Res>? get folder;
}

/// @nodoc
class _$EmailThreadCopyWithImpl<$Res, $Val extends EmailThread>
    implements $EmailThreadCopyWith<$Res> {
  _$EmailThreadCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of EmailThread
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? subject = null,
    Object? emails = null,
    Object? participants = null,
    Object? lastActivity = null,
    Object? messageCount = null,
    Object? unreadCount = null,
    Object? labels = null,
    Object? isStarred = freezed,
    Object? isImportant = freezed,
    Object? isMuted = freezed,
    Object? folder = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      subject: null == subject
          ? _value.subject
          : subject // ignore: cast_nullable_to_non_nullable
              as String,
      emails: null == emails
          ? _value.emails
          : emails // ignore: cast_nullable_to_non_nullable
              as List<Email>,
      participants: null == participants
          ? _value.participants
          : participants // ignore: cast_nullable_to_non_nullable
              as List<Contact>,
      lastActivity: null == lastActivity
          ? _value.lastActivity
          : lastActivity // ignore: cast_nullable_to_non_nullable
              as DateTime,
      messageCount: null == messageCount
          ? _value.messageCount
          : messageCount // ignore: cast_nullable_to_non_nullable
              as int,
      unreadCount: null == unreadCount
          ? _value.unreadCount
          : unreadCount // ignore: cast_nullable_to_non_nullable
              as int,
      labels: null == labels
          ? _value.labels
          : labels // ignore: cast_nullable_to_non_nullable
              as List<EmailLabel>,
      isStarred: freezed == isStarred
          ? _value.isStarred
          : isStarred // ignore: cast_nullable_to_non_nullable
              as bool?,
      isImportant: freezed == isImportant
          ? _value.isImportant
          : isImportant // ignore: cast_nullable_to_non_nullable
              as bool?,
      isMuted: freezed == isMuted
          ? _value.isMuted
          : isMuted // ignore: cast_nullable_to_non_nullable
              as bool?,
      folder: freezed == folder
          ? _value.folder
          : folder // ignore: cast_nullable_to_non_nullable
              as EmailFolder?,
    ) as $Val);
  }

  /// Create a copy of EmailThread
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $EmailFolderCopyWith<$Res>? get folder {
    if (_value.folder == null) {
      return null;
    }

    return $EmailFolderCopyWith<$Res>(_value.folder!, (value) {
      return _then(_value.copyWith(folder: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$EmailThreadImplCopyWith<$Res>
    implements $EmailThreadCopyWith<$Res> {
  factory _$$EmailThreadImplCopyWith(
          _$EmailThreadImpl value, $Res Function(_$EmailThreadImpl) then) =
      __$$EmailThreadImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String subject,
      List<Email> emails,
      List<Contact> participants,
      DateTime lastActivity,
      int messageCount,
      int unreadCount,
      List<EmailLabel> labels,
      bool? isStarred,
      bool? isImportant,
      bool? isMuted,
      EmailFolder? folder});

  @override
  $EmailFolderCopyWith<$Res>? get folder;
}

/// @nodoc
class __$$EmailThreadImplCopyWithImpl<$Res>
    extends _$EmailThreadCopyWithImpl<$Res, _$EmailThreadImpl>
    implements _$$EmailThreadImplCopyWith<$Res> {
  __$$EmailThreadImplCopyWithImpl(
      _$EmailThreadImpl _value, $Res Function(_$EmailThreadImpl) _then)
      : super(_value, _then);

  /// Create a copy of EmailThread
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? subject = null,
    Object? emails = null,
    Object? participants = null,
    Object? lastActivity = null,
    Object? messageCount = null,
    Object? unreadCount = null,
    Object? labels = null,
    Object? isStarred = freezed,
    Object? isImportant = freezed,
    Object? isMuted = freezed,
    Object? folder = freezed,
  }) {
    return _then(_$EmailThreadImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      subject: null == subject
          ? _value.subject
          : subject // ignore: cast_nullable_to_non_nullable
              as String,
      emails: null == emails
          ? _value._emails
          : emails // ignore: cast_nullable_to_non_nullable
              as List<Email>,
      participants: null == participants
          ? _value._participants
          : participants // ignore: cast_nullable_to_non_nullable
              as List<Contact>,
      lastActivity: null == lastActivity
          ? _value.lastActivity
          : lastActivity // ignore: cast_nullable_to_non_nullable
              as DateTime,
      messageCount: null == messageCount
          ? _value.messageCount
          : messageCount // ignore: cast_nullable_to_non_nullable
              as int,
      unreadCount: null == unreadCount
          ? _value.unreadCount
          : unreadCount // ignore: cast_nullable_to_non_nullable
              as int,
      labels: null == labels
          ? _value._labels
          : labels // ignore: cast_nullable_to_non_nullable
              as List<EmailLabel>,
      isStarred: freezed == isStarred
          ? _value.isStarred
          : isStarred // ignore: cast_nullable_to_non_nullable
              as bool?,
      isImportant: freezed == isImportant
          ? _value.isImportant
          : isImportant // ignore: cast_nullable_to_non_nullable
              as bool?,
      isMuted: freezed == isMuted
          ? _value.isMuted
          : isMuted // ignore: cast_nullable_to_non_nullable
              as bool?,
      folder: freezed == folder
          ? _value.folder
          : folder // ignore: cast_nullable_to_non_nullable
              as EmailFolder?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$EmailThreadImpl implements _EmailThread {
  const _$EmailThreadImpl(
      {required this.id,
      required this.subject,
      required final List<Email> emails,
      required final List<Contact> participants,
      required this.lastActivity,
      required this.messageCount,
      required this.unreadCount,
      required final List<EmailLabel> labels,
      this.isStarred,
      this.isImportant,
      this.isMuted,
      this.folder})
      : _emails = emails,
        _participants = participants,
        _labels = labels;

  factory _$EmailThreadImpl.fromJson(Map<String, dynamic> json) =>
      _$$EmailThreadImplFromJson(json);

  @override
  final String id;
  @override
  final String subject;
  final List<Email> _emails;
  @override
  List<Email> get emails {
    if (_emails is EqualUnmodifiableListView) return _emails;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_emails);
  }

  final List<Contact> _participants;
  @override
  List<Contact> get participants {
    if (_participants is EqualUnmodifiableListView) return _participants;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_participants);
  }

  @override
  final DateTime lastActivity;
  @override
  final int messageCount;
  @override
  final int unreadCount;
  final List<EmailLabel> _labels;
  @override
  List<EmailLabel> get labels {
    if (_labels is EqualUnmodifiableListView) return _labels;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_labels);
  }

  @override
  final bool? isStarred;
  @override
  final bool? isImportant;
  @override
  final bool? isMuted;
  @override
  final EmailFolder? folder;

  @override
  String toString() {
    return 'EmailThread(id: $id, subject: $subject, emails: $emails, participants: $participants, lastActivity: $lastActivity, messageCount: $messageCount, unreadCount: $unreadCount, labels: $labels, isStarred: $isStarred, isImportant: $isImportant, isMuted: $isMuted, folder: $folder)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EmailThreadImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.subject, subject) || other.subject == subject) &&
            const DeepCollectionEquality().equals(other._emails, _emails) &&
            const DeepCollectionEquality()
                .equals(other._participants, _participants) &&
            (identical(other.lastActivity, lastActivity) ||
                other.lastActivity == lastActivity) &&
            (identical(other.messageCount, messageCount) ||
                other.messageCount == messageCount) &&
            (identical(other.unreadCount, unreadCount) ||
                other.unreadCount == unreadCount) &&
            const DeepCollectionEquality().equals(other._labels, _labels) &&
            (identical(other.isStarred, isStarred) ||
                other.isStarred == isStarred) &&
            (identical(other.isImportant, isImportant) ||
                other.isImportant == isImportant) &&
            (identical(other.isMuted, isMuted) || other.isMuted == isMuted) &&
            (identical(other.folder, folder) || other.folder == folder));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      subject,
      const DeepCollectionEquality().hash(_emails),
      const DeepCollectionEquality().hash(_participants),
      lastActivity,
      messageCount,
      unreadCount,
      const DeepCollectionEquality().hash(_labels),
      isStarred,
      isImportant,
      isMuted,
      folder);

  /// Create a copy of EmailThread
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EmailThreadImplCopyWith<_$EmailThreadImpl> get copyWith =>
      __$$EmailThreadImplCopyWithImpl<_$EmailThreadImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EmailThreadImplToJson(
      this,
    );
  }
}

abstract class _EmailThread implements EmailThread {
  const factory _EmailThread(
      {required final String id,
      required final String subject,
      required final List<Email> emails,
      required final List<Contact> participants,
      required final DateTime lastActivity,
      required final int messageCount,
      required final int unreadCount,
      required final List<EmailLabel> labels,
      final bool? isStarred,
      final bool? isImportant,
      final bool? isMuted,
      final EmailFolder? folder}) = _$EmailThreadImpl;

  factory _EmailThread.fromJson(Map<String, dynamic> json) =
      _$EmailThreadImpl.fromJson;

  @override
  String get id;
  @override
  String get subject;
  @override
  List<Email> get emails;
  @override
  List<Contact> get participants;
  @override
  DateTime get lastActivity;
  @override
  int get messageCount;
  @override
  int get unreadCount;
  @override
  List<EmailLabel> get labels;
  @override
  bool? get isStarred;
  @override
  bool? get isImportant;
  @override
  bool? get isMuted;
  @override
  EmailFolder? get folder;

  /// Create a copy of EmailThread
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EmailThreadImplCopyWith<_$EmailThreadImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

EmailRule _$EmailRuleFromJson(Map<String, dynamic> json) {
  return _EmailRule.fromJson(json);
}

/// @nodoc
mixin _$EmailRule {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  List<EmailCondition> get conditions => throw _privateConstructorUsedError;
  List<EmailAction> get actions => throw _privateConstructorUsedError;
  bool get isActive => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get lastTriggered => throw _privateConstructorUsedError;
  int? get triggerCount => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;

  /// Serializes this EmailRule to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of EmailRule
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EmailRuleCopyWith<EmailRule> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EmailRuleCopyWith<$Res> {
  factory $EmailRuleCopyWith(EmailRule value, $Res Function(EmailRule) then) =
      _$EmailRuleCopyWithImpl<$Res, EmailRule>;
  @useResult
  $Res call(
      {String id,
      String name,
      List<EmailCondition> conditions,
      List<EmailAction> actions,
      bool isActive,
      DateTime? createdAt,
      DateTime? lastTriggered,
      int? triggerCount,
      String? description});
}

/// @nodoc
class _$EmailRuleCopyWithImpl<$Res, $Val extends EmailRule>
    implements $EmailRuleCopyWith<$Res> {
  _$EmailRuleCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of EmailRule
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? conditions = null,
    Object? actions = null,
    Object? isActive = null,
    Object? createdAt = freezed,
    Object? lastTriggered = freezed,
    Object? triggerCount = freezed,
    Object? description = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      conditions: null == conditions
          ? _value.conditions
          : conditions // ignore: cast_nullable_to_non_nullable
              as List<EmailCondition>,
      actions: null == actions
          ? _value.actions
          : actions // ignore: cast_nullable_to_non_nullable
              as List<EmailAction>,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      lastTriggered: freezed == lastTriggered
          ? _value.lastTriggered
          : lastTriggered // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      triggerCount: freezed == triggerCount
          ? _value.triggerCount
          : triggerCount // ignore: cast_nullable_to_non_nullable
              as int?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$EmailRuleImplCopyWith<$Res>
    implements $EmailRuleCopyWith<$Res> {
  factory _$$EmailRuleImplCopyWith(
          _$EmailRuleImpl value, $Res Function(_$EmailRuleImpl) then) =
      __$$EmailRuleImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      List<EmailCondition> conditions,
      List<EmailAction> actions,
      bool isActive,
      DateTime? createdAt,
      DateTime? lastTriggered,
      int? triggerCount,
      String? description});
}

/// @nodoc
class __$$EmailRuleImplCopyWithImpl<$Res>
    extends _$EmailRuleCopyWithImpl<$Res, _$EmailRuleImpl>
    implements _$$EmailRuleImplCopyWith<$Res> {
  __$$EmailRuleImplCopyWithImpl(
      _$EmailRuleImpl _value, $Res Function(_$EmailRuleImpl) _then)
      : super(_value, _then);

  /// Create a copy of EmailRule
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? conditions = null,
    Object? actions = null,
    Object? isActive = null,
    Object? createdAt = freezed,
    Object? lastTriggered = freezed,
    Object? triggerCount = freezed,
    Object? description = freezed,
  }) {
    return _then(_$EmailRuleImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      conditions: null == conditions
          ? _value._conditions
          : conditions // ignore: cast_nullable_to_non_nullable
              as List<EmailCondition>,
      actions: null == actions
          ? _value._actions
          : actions // ignore: cast_nullable_to_non_nullable
              as List<EmailAction>,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      lastTriggered: freezed == lastTriggered
          ? _value.lastTriggered
          : lastTriggered // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      triggerCount: freezed == triggerCount
          ? _value.triggerCount
          : triggerCount // ignore: cast_nullable_to_non_nullable
              as int?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$EmailRuleImpl implements _EmailRule {
  const _$EmailRuleImpl(
      {required this.id,
      required this.name,
      required final List<EmailCondition> conditions,
      required final List<EmailAction> actions,
      required this.isActive,
      this.createdAt,
      this.lastTriggered,
      this.triggerCount,
      this.description})
      : _conditions = conditions,
        _actions = actions;

  factory _$EmailRuleImpl.fromJson(Map<String, dynamic> json) =>
      _$$EmailRuleImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  final List<EmailCondition> _conditions;
  @override
  List<EmailCondition> get conditions {
    if (_conditions is EqualUnmodifiableListView) return _conditions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_conditions);
  }

  final List<EmailAction> _actions;
  @override
  List<EmailAction> get actions {
    if (_actions is EqualUnmodifiableListView) return _actions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_actions);
  }

  @override
  final bool isActive;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? lastTriggered;
  @override
  final int? triggerCount;
  @override
  final String? description;

  @override
  String toString() {
    return 'EmailRule(id: $id, name: $name, conditions: $conditions, actions: $actions, isActive: $isActive, createdAt: $createdAt, lastTriggered: $lastTriggered, triggerCount: $triggerCount, description: $description)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EmailRuleImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            const DeepCollectionEquality()
                .equals(other._conditions, _conditions) &&
            const DeepCollectionEquality().equals(other._actions, _actions) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.lastTriggered, lastTriggered) ||
                other.lastTriggered == lastTriggered) &&
            (identical(other.triggerCount, triggerCount) ||
                other.triggerCount == triggerCount) &&
            (identical(other.description, description) ||
                other.description == description));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      const DeepCollectionEquality().hash(_conditions),
      const DeepCollectionEquality().hash(_actions),
      isActive,
      createdAt,
      lastTriggered,
      triggerCount,
      description);

  /// Create a copy of EmailRule
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EmailRuleImplCopyWith<_$EmailRuleImpl> get copyWith =>
      __$$EmailRuleImplCopyWithImpl<_$EmailRuleImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EmailRuleImplToJson(
      this,
    );
  }
}

abstract class _EmailRule implements EmailRule {
  const factory _EmailRule(
      {required final String id,
      required final String name,
      required final List<EmailCondition> conditions,
      required final List<EmailAction> actions,
      required final bool isActive,
      final DateTime? createdAt,
      final DateTime? lastTriggered,
      final int? triggerCount,
      final String? description}) = _$EmailRuleImpl;

  factory _EmailRule.fromJson(Map<String, dynamic> json) =
      _$EmailRuleImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  List<EmailCondition> get conditions;
  @override
  List<EmailAction> get actions;
  @override
  bool get isActive;
  @override
  DateTime? get createdAt;
  @override
  DateTime? get lastTriggered;
  @override
  int? get triggerCount;
  @override
  String? get description;

  /// Create a copy of EmailRule
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EmailRuleImplCopyWith<_$EmailRuleImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

EmailCondition _$EmailConditionFromJson(Map<String, dynamic> json) {
  return _EmailCondition.fromJson(json);
}

/// @nodoc
mixin _$EmailCondition {
  EmailConditionField get field => throw _privateConstructorUsedError;
  EmailConditionOperator get operator => throw _privateConstructorUsedError;
  String get value => throw _privateConstructorUsedError;
  bool? get caseSensitive => throw _privateConstructorUsedError;

  /// Serializes this EmailCondition to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of EmailCondition
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EmailConditionCopyWith<EmailCondition> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EmailConditionCopyWith<$Res> {
  factory $EmailConditionCopyWith(
          EmailCondition value, $Res Function(EmailCondition) then) =
      _$EmailConditionCopyWithImpl<$Res, EmailCondition>;
  @useResult
  $Res call(
      {EmailConditionField field,
      EmailConditionOperator operator,
      String value,
      bool? caseSensitive});
}

/// @nodoc
class _$EmailConditionCopyWithImpl<$Res, $Val extends EmailCondition>
    implements $EmailConditionCopyWith<$Res> {
  _$EmailConditionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of EmailCondition
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? field = null,
    Object? operator = null,
    Object? value = null,
    Object? caseSensitive = freezed,
  }) {
    return _then(_value.copyWith(
      field: null == field
          ? _value.field
          : field // ignore: cast_nullable_to_non_nullable
              as EmailConditionField,
      operator: null == operator
          ? _value.operator
          : operator // ignore: cast_nullable_to_non_nullable
              as EmailConditionOperator,
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as String,
      caseSensitive: freezed == caseSensitive
          ? _value.caseSensitive
          : caseSensitive // ignore: cast_nullable_to_non_nullable
              as bool?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$EmailConditionImplCopyWith<$Res>
    implements $EmailConditionCopyWith<$Res> {
  factory _$$EmailConditionImplCopyWith(_$EmailConditionImpl value,
          $Res Function(_$EmailConditionImpl) then) =
      __$$EmailConditionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {EmailConditionField field,
      EmailConditionOperator operator,
      String value,
      bool? caseSensitive});
}

/// @nodoc
class __$$EmailConditionImplCopyWithImpl<$Res>
    extends _$EmailConditionCopyWithImpl<$Res, _$EmailConditionImpl>
    implements _$$EmailConditionImplCopyWith<$Res> {
  __$$EmailConditionImplCopyWithImpl(
      _$EmailConditionImpl _value, $Res Function(_$EmailConditionImpl) _then)
      : super(_value, _then);

  /// Create a copy of EmailCondition
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? field = null,
    Object? operator = null,
    Object? value = null,
    Object? caseSensitive = freezed,
  }) {
    return _then(_$EmailConditionImpl(
      field: null == field
          ? _value.field
          : field // ignore: cast_nullable_to_non_nullable
              as EmailConditionField,
      operator: null == operator
          ? _value.operator
          : operator // ignore: cast_nullable_to_non_nullable
              as EmailConditionOperator,
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as String,
      caseSensitive: freezed == caseSensitive
          ? _value.caseSensitive
          : caseSensitive // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$EmailConditionImpl implements _EmailCondition {
  const _$EmailConditionImpl(
      {required this.field,
      required this.operator,
      required this.value,
      this.caseSensitive});

  factory _$EmailConditionImpl.fromJson(Map<String, dynamic> json) =>
      _$$EmailConditionImplFromJson(json);

  @override
  final EmailConditionField field;
  @override
  final EmailConditionOperator operator;
  @override
  final String value;
  @override
  final bool? caseSensitive;

  @override
  String toString() {
    return 'EmailCondition(field: $field, operator: $operator, value: $value, caseSensitive: $caseSensitive)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EmailConditionImpl &&
            (identical(other.field, field) || other.field == field) &&
            (identical(other.operator, operator) ||
                other.operator == operator) &&
            (identical(other.value, value) || other.value == value) &&
            (identical(other.caseSensitive, caseSensitive) ||
                other.caseSensitive == caseSensitive));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, field, operator, value, caseSensitive);

  /// Create a copy of EmailCondition
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EmailConditionImplCopyWith<_$EmailConditionImpl> get copyWith =>
      __$$EmailConditionImplCopyWithImpl<_$EmailConditionImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EmailConditionImplToJson(
      this,
    );
  }
}

abstract class _EmailCondition implements EmailCondition {
  const factory _EmailCondition(
      {required final EmailConditionField field,
      required final EmailConditionOperator operator,
      required final String value,
      final bool? caseSensitive}) = _$EmailConditionImpl;

  factory _EmailCondition.fromJson(Map<String, dynamic> json) =
      _$EmailConditionImpl.fromJson;

  @override
  EmailConditionField get field;
  @override
  EmailConditionOperator get operator;
  @override
  String get value;
  @override
  bool? get caseSensitive;

  /// Create a copy of EmailCondition
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EmailConditionImplCopyWith<_$EmailConditionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

EmailAction _$EmailActionFromJson(Map<String, dynamic> json) {
  return _EmailAction.fromJson(json);
}

/// @nodoc
mixin _$EmailAction {
  EmailActionType get type => throw _privateConstructorUsedError;
  String? get value => throw _privateConstructorUsedError;
  Map<String, dynamic>? get parameters => throw _privateConstructorUsedError;

  /// Serializes this EmailAction to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of EmailAction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EmailActionCopyWith<EmailAction> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EmailActionCopyWith<$Res> {
  factory $EmailActionCopyWith(
          EmailAction value, $Res Function(EmailAction) then) =
      _$EmailActionCopyWithImpl<$Res, EmailAction>;
  @useResult
  $Res call(
      {EmailActionType type, String? value, Map<String, dynamic>? parameters});
}

/// @nodoc
class _$EmailActionCopyWithImpl<$Res, $Val extends EmailAction>
    implements $EmailActionCopyWith<$Res> {
  _$EmailActionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of EmailAction
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? value = freezed,
    Object? parameters = freezed,
  }) {
    return _then(_value.copyWith(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as EmailActionType,
      value: freezed == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as String?,
      parameters: freezed == parameters
          ? _value.parameters
          : parameters // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$EmailActionImplCopyWith<$Res>
    implements $EmailActionCopyWith<$Res> {
  factory _$$EmailActionImplCopyWith(
          _$EmailActionImpl value, $Res Function(_$EmailActionImpl) then) =
      __$$EmailActionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {EmailActionType type, String? value, Map<String, dynamic>? parameters});
}

/// @nodoc
class __$$EmailActionImplCopyWithImpl<$Res>
    extends _$EmailActionCopyWithImpl<$Res, _$EmailActionImpl>
    implements _$$EmailActionImplCopyWith<$Res> {
  __$$EmailActionImplCopyWithImpl(
      _$EmailActionImpl _value, $Res Function(_$EmailActionImpl) _then)
      : super(_value, _then);

  /// Create a copy of EmailAction
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? value = freezed,
    Object? parameters = freezed,
  }) {
    return _then(_$EmailActionImpl(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as EmailActionType,
      value: freezed == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as String?,
      parameters: freezed == parameters
          ? _value._parameters
          : parameters // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$EmailActionImpl implements _EmailAction {
  const _$EmailActionImpl(
      {required this.type, this.value, final Map<String, dynamic>? parameters})
      : _parameters = parameters;

  factory _$EmailActionImpl.fromJson(Map<String, dynamic> json) =>
      _$$EmailActionImplFromJson(json);

  @override
  final EmailActionType type;
  @override
  final String? value;
  final Map<String, dynamic>? _parameters;
  @override
  Map<String, dynamic>? get parameters {
    final value = _parameters;
    if (value == null) return null;
    if (_parameters is EqualUnmodifiableMapView) return _parameters;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'EmailAction(type: $type, value: $value, parameters: $parameters)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EmailActionImpl &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.value, value) || other.value == value) &&
            const DeepCollectionEquality()
                .equals(other._parameters, _parameters));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, type, value,
      const DeepCollectionEquality().hash(_parameters));

  /// Create a copy of EmailAction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EmailActionImplCopyWith<_$EmailActionImpl> get copyWith =>
      __$$EmailActionImplCopyWithImpl<_$EmailActionImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EmailActionImplToJson(
      this,
    );
  }
}

abstract class _EmailAction implements EmailAction {
  const factory _EmailAction(
      {required final EmailActionType type,
      final String? value,
      final Map<String, dynamic>? parameters}) = _$EmailActionImpl;

  factory _EmailAction.fromJson(Map<String, dynamic> json) =
      _$EmailActionImpl.fromJson;

  @override
  EmailActionType get type;
  @override
  String? get value;
  @override
  Map<String, dynamic>? get parameters;

  /// Create a copy of EmailAction
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EmailActionImplCopyWith<_$EmailActionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

EmailTemplate _$EmailTemplateFromJson(Map<String, dynamic> json) {
  return _EmailTemplate.fromJson(json);
}

/// @nodoc
mixin _$EmailTemplate {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get subject => throw _privateConstructorUsedError;
  String get body => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  List<String>? get tags => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get lastUsed => throw _privateConstructorUsedError;
  int? get useCount => throw _privateConstructorUsedError;
  bool? get isPublic => throw _privateConstructorUsedError;
  TemplateType? get type => throw _privateConstructorUsedError;

  /// Serializes this EmailTemplate to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of EmailTemplate
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EmailTemplateCopyWith<EmailTemplate> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EmailTemplateCopyWith<$Res> {
  factory $EmailTemplateCopyWith(
          EmailTemplate value, $Res Function(EmailTemplate) then) =
      _$EmailTemplateCopyWithImpl<$Res, EmailTemplate>;
  @useResult
  $Res call(
      {String id,
      String name,
      String subject,
      String body,
      String? description,
      List<String>? tags,
      DateTime? createdAt,
      DateTime? lastUsed,
      int? useCount,
      bool? isPublic,
      TemplateType? type});
}

/// @nodoc
class _$EmailTemplateCopyWithImpl<$Res, $Val extends EmailTemplate>
    implements $EmailTemplateCopyWith<$Res> {
  _$EmailTemplateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of EmailTemplate
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? subject = null,
    Object? body = null,
    Object? description = freezed,
    Object? tags = freezed,
    Object? createdAt = freezed,
    Object? lastUsed = freezed,
    Object? useCount = freezed,
    Object? isPublic = freezed,
    Object? type = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      subject: null == subject
          ? _value.subject
          : subject // ignore: cast_nullable_to_non_nullable
              as String,
      body: null == body
          ? _value.body
          : body // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      tags: freezed == tags
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      lastUsed: freezed == lastUsed
          ? _value.lastUsed
          : lastUsed // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      useCount: freezed == useCount
          ? _value.useCount
          : useCount // ignore: cast_nullable_to_non_nullable
              as int?,
      isPublic: freezed == isPublic
          ? _value.isPublic
          : isPublic // ignore: cast_nullable_to_non_nullable
              as bool?,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as TemplateType?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$EmailTemplateImplCopyWith<$Res>
    implements $EmailTemplateCopyWith<$Res> {
  factory _$$EmailTemplateImplCopyWith(
          _$EmailTemplateImpl value, $Res Function(_$EmailTemplateImpl) then) =
      __$$EmailTemplateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String subject,
      String body,
      String? description,
      List<String>? tags,
      DateTime? createdAt,
      DateTime? lastUsed,
      int? useCount,
      bool? isPublic,
      TemplateType? type});
}

/// @nodoc
class __$$EmailTemplateImplCopyWithImpl<$Res>
    extends _$EmailTemplateCopyWithImpl<$Res, _$EmailTemplateImpl>
    implements _$$EmailTemplateImplCopyWith<$Res> {
  __$$EmailTemplateImplCopyWithImpl(
      _$EmailTemplateImpl _value, $Res Function(_$EmailTemplateImpl) _then)
      : super(_value, _then);

  /// Create a copy of EmailTemplate
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? subject = null,
    Object? body = null,
    Object? description = freezed,
    Object? tags = freezed,
    Object? createdAt = freezed,
    Object? lastUsed = freezed,
    Object? useCount = freezed,
    Object? isPublic = freezed,
    Object? type = freezed,
  }) {
    return _then(_$EmailTemplateImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      subject: null == subject
          ? _value.subject
          : subject // ignore: cast_nullable_to_non_nullable
              as String,
      body: null == body
          ? _value.body
          : body // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      tags: freezed == tags
          ? _value._tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      lastUsed: freezed == lastUsed
          ? _value.lastUsed
          : lastUsed // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      useCount: freezed == useCount
          ? _value.useCount
          : useCount // ignore: cast_nullable_to_non_nullable
              as int?,
      isPublic: freezed == isPublic
          ? _value.isPublic
          : isPublic // ignore: cast_nullable_to_non_nullable
              as bool?,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as TemplateType?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$EmailTemplateImpl implements _EmailTemplate {
  const _$EmailTemplateImpl(
      {required this.id,
      required this.name,
      required this.subject,
      required this.body,
      this.description,
      final List<String>? tags,
      this.createdAt,
      this.lastUsed,
      this.useCount,
      this.isPublic,
      this.type})
      : _tags = tags;

  factory _$EmailTemplateImpl.fromJson(Map<String, dynamic> json) =>
      _$$EmailTemplateImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String subject;
  @override
  final String body;
  @override
  final String? description;
  final List<String>? _tags;
  @override
  List<String>? get tags {
    final value = _tags;
    if (value == null) return null;
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final DateTime? createdAt;
  @override
  final DateTime? lastUsed;
  @override
  final int? useCount;
  @override
  final bool? isPublic;
  @override
  final TemplateType? type;

  @override
  String toString() {
    return 'EmailTemplate(id: $id, name: $name, subject: $subject, body: $body, description: $description, tags: $tags, createdAt: $createdAt, lastUsed: $lastUsed, useCount: $useCount, isPublic: $isPublic, type: $type)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EmailTemplateImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.subject, subject) || other.subject == subject) &&
            (identical(other.body, body) || other.body == body) &&
            (identical(other.description, description) ||
                other.description == description) &&
            const DeepCollectionEquality().equals(other._tags, _tags) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.lastUsed, lastUsed) ||
                other.lastUsed == lastUsed) &&
            (identical(other.useCount, useCount) ||
                other.useCount == useCount) &&
            (identical(other.isPublic, isPublic) ||
                other.isPublic == isPublic) &&
            (identical(other.type, type) || other.type == type));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      subject,
      body,
      description,
      const DeepCollectionEquality().hash(_tags),
      createdAt,
      lastUsed,
      useCount,
      isPublic,
      type);

  /// Create a copy of EmailTemplate
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EmailTemplateImplCopyWith<_$EmailTemplateImpl> get copyWith =>
      __$$EmailTemplateImplCopyWithImpl<_$EmailTemplateImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EmailTemplateImplToJson(
      this,
    );
  }
}

abstract class _EmailTemplate implements EmailTemplate {
  const factory _EmailTemplate(
      {required final String id,
      required final String name,
      required final String subject,
      required final String body,
      final String? description,
      final List<String>? tags,
      final DateTime? createdAt,
      final DateTime? lastUsed,
      final int? useCount,
      final bool? isPublic,
      final TemplateType? type}) = _$EmailTemplateImpl;

  factory _EmailTemplate.fromJson(Map<String, dynamic> json) =
      _$EmailTemplateImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get subject;
  @override
  String get body;
  @override
  String? get description;
  @override
  List<String>? get tags;
  @override
  DateTime? get createdAt;
  @override
  DateTime? get lastUsed;
  @override
  int? get useCount;
  @override
  bool? get isPublic;
  @override
  TemplateType? get type;

  /// Create a copy of EmailTemplate
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EmailTemplateImplCopyWith<_$EmailTemplateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ComposeState _$ComposeStateFromJson(Map<String, dynamic> json) {
  return _ComposeState.fromJson(json);
}

/// @nodoc
mixin _$ComposeState {
  String? get to => throw _privateConstructorUsedError;
  String? get cc => throw _privateConstructorUsedError;
  String? get bcc => throw _privateConstructorUsedError;
  String? get subject => throw _privateConstructorUsedError;
  String? get body => throw _privateConstructorUsedError;
  List<Attachment>? get attachments => throw _privateConstructorUsedError;
  EmailPriority? get priority => throw _privateConstructorUsedError;
  bool? get requestReadReceipt => throw _privateConstructorUsedError;
  DateTime? get scheduledAt => throw _privateConstructorUsedError;
  String? get signature => throw _privateConstructorUsedError;
  String? get replyToId => throw _privateConstructorUsedError;
  String? get forwardFromId => throw _privateConstructorUsedError;
  bool? get isDraft => throw _privateConstructorUsedError;
  DateTime? get lastSaved => throw _privateConstructorUsedError;
  ComposeMode? get mode => throw _privateConstructorUsedError;

  /// Serializes this ComposeState to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ComposeState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ComposeStateCopyWith<ComposeState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ComposeStateCopyWith<$Res> {
  factory $ComposeStateCopyWith(
          ComposeState value, $Res Function(ComposeState) then) =
      _$ComposeStateCopyWithImpl<$Res, ComposeState>;
  @useResult
  $Res call(
      {String? to,
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
      ComposeMode? mode});
}

/// @nodoc
class _$ComposeStateCopyWithImpl<$Res, $Val extends ComposeState>
    implements $ComposeStateCopyWith<$Res> {
  _$ComposeStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ComposeState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? to = freezed,
    Object? cc = freezed,
    Object? bcc = freezed,
    Object? subject = freezed,
    Object? body = freezed,
    Object? attachments = freezed,
    Object? priority = freezed,
    Object? requestReadReceipt = freezed,
    Object? scheduledAt = freezed,
    Object? signature = freezed,
    Object? replyToId = freezed,
    Object? forwardFromId = freezed,
    Object? isDraft = freezed,
    Object? lastSaved = freezed,
    Object? mode = freezed,
  }) {
    return _then(_value.copyWith(
      to: freezed == to
          ? _value.to
          : to // ignore: cast_nullable_to_non_nullable
              as String?,
      cc: freezed == cc
          ? _value.cc
          : cc // ignore: cast_nullable_to_non_nullable
              as String?,
      bcc: freezed == bcc
          ? _value.bcc
          : bcc // ignore: cast_nullable_to_non_nullable
              as String?,
      subject: freezed == subject
          ? _value.subject
          : subject // ignore: cast_nullable_to_non_nullable
              as String?,
      body: freezed == body
          ? _value.body
          : body // ignore: cast_nullable_to_non_nullable
              as String?,
      attachments: freezed == attachments
          ? _value.attachments
          : attachments // ignore: cast_nullable_to_non_nullable
              as List<Attachment>?,
      priority: freezed == priority
          ? _value.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as EmailPriority?,
      requestReadReceipt: freezed == requestReadReceipt
          ? _value.requestReadReceipt
          : requestReadReceipt // ignore: cast_nullable_to_non_nullable
              as bool?,
      scheduledAt: freezed == scheduledAt
          ? _value.scheduledAt
          : scheduledAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      signature: freezed == signature
          ? _value.signature
          : signature // ignore: cast_nullable_to_non_nullable
              as String?,
      replyToId: freezed == replyToId
          ? _value.replyToId
          : replyToId // ignore: cast_nullable_to_non_nullable
              as String?,
      forwardFromId: freezed == forwardFromId
          ? _value.forwardFromId
          : forwardFromId // ignore: cast_nullable_to_non_nullable
              as String?,
      isDraft: freezed == isDraft
          ? _value.isDraft
          : isDraft // ignore: cast_nullable_to_non_nullable
              as bool?,
      lastSaved: freezed == lastSaved
          ? _value.lastSaved
          : lastSaved // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      mode: freezed == mode
          ? _value.mode
          : mode // ignore: cast_nullable_to_non_nullable
              as ComposeMode?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ComposeStateImplCopyWith<$Res>
    implements $ComposeStateCopyWith<$Res> {
  factory _$$ComposeStateImplCopyWith(
          _$ComposeStateImpl value, $Res Function(_$ComposeStateImpl) then) =
      __$$ComposeStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? to,
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
      ComposeMode? mode});
}

/// @nodoc
class __$$ComposeStateImplCopyWithImpl<$Res>
    extends _$ComposeStateCopyWithImpl<$Res, _$ComposeStateImpl>
    implements _$$ComposeStateImplCopyWith<$Res> {
  __$$ComposeStateImplCopyWithImpl(
      _$ComposeStateImpl _value, $Res Function(_$ComposeStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of ComposeState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? to = freezed,
    Object? cc = freezed,
    Object? bcc = freezed,
    Object? subject = freezed,
    Object? body = freezed,
    Object? attachments = freezed,
    Object? priority = freezed,
    Object? requestReadReceipt = freezed,
    Object? scheduledAt = freezed,
    Object? signature = freezed,
    Object? replyToId = freezed,
    Object? forwardFromId = freezed,
    Object? isDraft = freezed,
    Object? lastSaved = freezed,
    Object? mode = freezed,
  }) {
    return _then(_$ComposeStateImpl(
      to: freezed == to
          ? _value.to
          : to // ignore: cast_nullable_to_non_nullable
              as String?,
      cc: freezed == cc
          ? _value.cc
          : cc // ignore: cast_nullable_to_non_nullable
              as String?,
      bcc: freezed == bcc
          ? _value.bcc
          : bcc // ignore: cast_nullable_to_non_nullable
              as String?,
      subject: freezed == subject
          ? _value.subject
          : subject // ignore: cast_nullable_to_non_nullable
              as String?,
      body: freezed == body
          ? _value.body
          : body // ignore: cast_nullable_to_non_nullable
              as String?,
      attachments: freezed == attachments
          ? _value._attachments
          : attachments // ignore: cast_nullable_to_non_nullable
              as List<Attachment>?,
      priority: freezed == priority
          ? _value.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as EmailPriority?,
      requestReadReceipt: freezed == requestReadReceipt
          ? _value.requestReadReceipt
          : requestReadReceipt // ignore: cast_nullable_to_non_nullable
              as bool?,
      scheduledAt: freezed == scheduledAt
          ? _value.scheduledAt
          : scheduledAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      signature: freezed == signature
          ? _value.signature
          : signature // ignore: cast_nullable_to_non_nullable
              as String?,
      replyToId: freezed == replyToId
          ? _value.replyToId
          : replyToId // ignore: cast_nullable_to_non_nullable
              as String?,
      forwardFromId: freezed == forwardFromId
          ? _value.forwardFromId
          : forwardFromId // ignore: cast_nullable_to_non_nullable
              as String?,
      isDraft: freezed == isDraft
          ? _value.isDraft
          : isDraft // ignore: cast_nullable_to_non_nullable
              as bool?,
      lastSaved: freezed == lastSaved
          ? _value.lastSaved
          : lastSaved // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      mode: freezed == mode
          ? _value.mode
          : mode // ignore: cast_nullable_to_non_nullable
              as ComposeMode?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ComposeStateImpl implements _ComposeState {
  const _$ComposeStateImpl(
      {this.to,
      this.cc,
      this.bcc,
      this.subject,
      this.body,
      final List<Attachment>? attachments,
      this.priority,
      this.requestReadReceipt,
      this.scheduledAt,
      this.signature,
      this.replyToId,
      this.forwardFromId,
      this.isDraft,
      this.lastSaved,
      this.mode})
      : _attachments = attachments;

  factory _$ComposeStateImpl.fromJson(Map<String, dynamic> json) =>
      _$$ComposeStateImplFromJson(json);

  @override
  final String? to;
  @override
  final String? cc;
  @override
  final String? bcc;
  @override
  final String? subject;
  @override
  final String? body;
  final List<Attachment>? _attachments;
  @override
  List<Attachment>? get attachments {
    final value = _attachments;
    if (value == null) return null;
    if (_attachments is EqualUnmodifiableListView) return _attachments;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final EmailPriority? priority;
  @override
  final bool? requestReadReceipt;
  @override
  final DateTime? scheduledAt;
  @override
  final String? signature;
  @override
  final String? replyToId;
  @override
  final String? forwardFromId;
  @override
  final bool? isDraft;
  @override
  final DateTime? lastSaved;
  @override
  final ComposeMode? mode;

  @override
  String toString() {
    return 'ComposeState(to: $to, cc: $cc, bcc: $bcc, subject: $subject, body: $body, attachments: $attachments, priority: $priority, requestReadReceipt: $requestReadReceipt, scheduledAt: $scheduledAt, signature: $signature, replyToId: $replyToId, forwardFromId: $forwardFromId, isDraft: $isDraft, lastSaved: $lastSaved, mode: $mode)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ComposeStateImpl &&
            (identical(other.to, to) || other.to == to) &&
            (identical(other.cc, cc) || other.cc == cc) &&
            (identical(other.bcc, bcc) || other.bcc == bcc) &&
            (identical(other.subject, subject) || other.subject == subject) &&
            (identical(other.body, body) || other.body == body) &&
            const DeepCollectionEquality()
                .equals(other._attachments, _attachments) &&
            (identical(other.priority, priority) ||
                other.priority == priority) &&
            (identical(other.requestReadReceipt, requestReadReceipt) ||
                other.requestReadReceipt == requestReadReceipt) &&
            (identical(other.scheduledAt, scheduledAt) ||
                other.scheduledAt == scheduledAt) &&
            (identical(other.signature, signature) ||
                other.signature == signature) &&
            (identical(other.replyToId, replyToId) ||
                other.replyToId == replyToId) &&
            (identical(other.forwardFromId, forwardFromId) ||
                other.forwardFromId == forwardFromId) &&
            (identical(other.isDraft, isDraft) || other.isDraft == isDraft) &&
            (identical(other.lastSaved, lastSaved) ||
                other.lastSaved == lastSaved) &&
            (identical(other.mode, mode) || other.mode == mode));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      to,
      cc,
      bcc,
      subject,
      body,
      const DeepCollectionEquality().hash(_attachments),
      priority,
      requestReadReceipt,
      scheduledAt,
      signature,
      replyToId,
      forwardFromId,
      isDraft,
      lastSaved,
      mode);

  /// Create a copy of ComposeState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ComposeStateImplCopyWith<_$ComposeStateImpl> get copyWith =>
      __$$ComposeStateImplCopyWithImpl<_$ComposeStateImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ComposeStateImplToJson(
      this,
    );
  }
}

abstract class _ComposeState implements ComposeState {
  const factory _ComposeState(
      {final String? to,
      final String? cc,
      final String? bcc,
      final String? subject,
      final String? body,
      final List<Attachment>? attachments,
      final EmailPriority? priority,
      final bool? requestReadReceipt,
      final DateTime? scheduledAt,
      final String? signature,
      final String? replyToId,
      final String? forwardFromId,
      final bool? isDraft,
      final DateTime? lastSaved,
      final ComposeMode? mode}) = _$ComposeStateImpl;

  factory _ComposeState.fromJson(Map<String, dynamic> json) =
      _$ComposeStateImpl.fromJson;

  @override
  String? get to;
  @override
  String? get cc;
  @override
  String? get bcc;
  @override
  String? get subject;
  @override
  String? get body;
  @override
  List<Attachment>? get attachments;
  @override
  EmailPriority? get priority;
  @override
  bool? get requestReadReceipt;
  @override
  DateTime? get scheduledAt;
  @override
  String? get signature;
  @override
  String? get replyToId;
  @override
  String? get forwardFromId;
  @override
  bool? get isDraft;
  @override
  DateTime? get lastSaved;
  @override
  ComposeMode? get mode;

  /// Create a copy of ComposeState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ComposeStateImplCopyWith<_$ComposeStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

EmailSettings _$EmailSettingsFromJson(Map<String, dynamic> json) {
  return _EmailSettings.fromJson(json);
}

/// @nodoc
mixin _$EmailSettings {
  String get id => throw _privateConstructorUsedError;
  String get displayName => throw _privateConstructorUsedError;
  String get emailAddress => throw _privateConstructorUsedError;
  String? get signature => throw _privateConstructorUsedError;
  bool? get autoReply => throw _privateConstructorUsedError;
  String? get autoReplyMessage => throw _privateConstructorUsedError;
  DateTime? get autoReplyStartDate => throw _privateConstructorUsedError;
  DateTime? get autoReplyEndDate => throw _privateConstructorUsedError;
  int? get refreshInterval => throw _privateConstructorUsedError;
  bool? get showPreview => throw _privateConstructorUsedError;
  int? get previewLines => throw _privateConstructorUsedError;
  bool? get markAsReadOnPreview => throw _privateConstructorUsedError;
  bool? get enableSpamFilter => throw _privateConstructorUsedError;
  bool? get enableReadReceipts => throw _privateConstructorUsedError;
  bool? get enablePushNotifications => throw _privateConstructorUsedError;
  NotificationSettings? get notifications => throw _privateConstructorUsedError;
  SecuritySettings? get security => throw _privateConstructorUsedError;

  /// Serializes this EmailSettings to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of EmailSettings
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EmailSettingsCopyWith<EmailSettings> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EmailSettingsCopyWith<$Res> {
  factory $EmailSettingsCopyWith(
          EmailSettings value, $Res Function(EmailSettings) then) =
      _$EmailSettingsCopyWithImpl<$Res, EmailSettings>;
  @useResult
  $Res call(
      {String id,
      String displayName,
      String emailAddress,
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
      SecuritySettings? security});

  $NotificationSettingsCopyWith<$Res>? get notifications;
  $SecuritySettingsCopyWith<$Res>? get security;
}

/// @nodoc
class _$EmailSettingsCopyWithImpl<$Res, $Val extends EmailSettings>
    implements $EmailSettingsCopyWith<$Res> {
  _$EmailSettingsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of EmailSettings
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? displayName = null,
    Object? emailAddress = null,
    Object? signature = freezed,
    Object? autoReply = freezed,
    Object? autoReplyMessage = freezed,
    Object? autoReplyStartDate = freezed,
    Object? autoReplyEndDate = freezed,
    Object? refreshInterval = freezed,
    Object? showPreview = freezed,
    Object? previewLines = freezed,
    Object? markAsReadOnPreview = freezed,
    Object? enableSpamFilter = freezed,
    Object? enableReadReceipts = freezed,
    Object? enablePushNotifications = freezed,
    Object? notifications = freezed,
    Object? security = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      displayName: null == displayName
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String,
      emailAddress: null == emailAddress
          ? _value.emailAddress
          : emailAddress // ignore: cast_nullable_to_non_nullable
              as String,
      signature: freezed == signature
          ? _value.signature
          : signature // ignore: cast_nullable_to_non_nullable
              as String?,
      autoReply: freezed == autoReply
          ? _value.autoReply
          : autoReply // ignore: cast_nullable_to_non_nullable
              as bool?,
      autoReplyMessage: freezed == autoReplyMessage
          ? _value.autoReplyMessage
          : autoReplyMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      autoReplyStartDate: freezed == autoReplyStartDate
          ? _value.autoReplyStartDate
          : autoReplyStartDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      autoReplyEndDate: freezed == autoReplyEndDate
          ? _value.autoReplyEndDate
          : autoReplyEndDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      refreshInterval: freezed == refreshInterval
          ? _value.refreshInterval
          : refreshInterval // ignore: cast_nullable_to_non_nullable
              as int?,
      showPreview: freezed == showPreview
          ? _value.showPreview
          : showPreview // ignore: cast_nullable_to_non_nullable
              as bool?,
      previewLines: freezed == previewLines
          ? _value.previewLines
          : previewLines // ignore: cast_nullable_to_non_nullable
              as int?,
      markAsReadOnPreview: freezed == markAsReadOnPreview
          ? _value.markAsReadOnPreview
          : markAsReadOnPreview // ignore: cast_nullable_to_non_nullable
              as bool?,
      enableSpamFilter: freezed == enableSpamFilter
          ? _value.enableSpamFilter
          : enableSpamFilter // ignore: cast_nullable_to_non_nullable
              as bool?,
      enableReadReceipts: freezed == enableReadReceipts
          ? _value.enableReadReceipts
          : enableReadReceipts // ignore: cast_nullable_to_non_nullable
              as bool?,
      enablePushNotifications: freezed == enablePushNotifications
          ? _value.enablePushNotifications
          : enablePushNotifications // ignore: cast_nullable_to_non_nullable
              as bool?,
      notifications: freezed == notifications
          ? _value.notifications
          : notifications // ignore: cast_nullable_to_non_nullable
              as NotificationSettings?,
      security: freezed == security
          ? _value.security
          : security // ignore: cast_nullable_to_non_nullable
              as SecuritySettings?,
    ) as $Val);
  }

  /// Create a copy of EmailSettings
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $NotificationSettingsCopyWith<$Res>? get notifications {
    if (_value.notifications == null) {
      return null;
    }

    return $NotificationSettingsCopyWith<$Res>(_value.notifications!, (value) {
      return _then(_value.copyWith(notifications: value) as $Val);
    });
  }

  /// Create a copy of EmailSettings
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SecuritySettingsCopyWith<$Res>? get security {
    if (_value.security == null) {
      return null;
    }

    return $SecuritySettingsCopyWith<$Res>(_value.security!, (value) {
      return _then(_value.copyWith(security: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$EmailSettingsImplCopyWith<$Res>
    implements $EmailSettingsCopyWith<$Res> {
  factory _$$EmailSettingsImplCopyWith(
          _$EmailSettingsImpl value, $Res Function(_$EmailSettingsImpl) then) =
      __$$EmailSettingsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String displayName,
      String emailAddress,
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
      SecuritySettings? security});

  @override
  $NotificationSettingsCopyWith<$Res>? get notifications;
  @override
  $SecuritySettingsCopyWith<$Res>? get security;
}

/// @nodoc
class __$$EmailSettingsImplCopyWithImpl<$Res>
    extends _$EmailSettingsCopyWithImpl<$Res, _$EmailSettingsImpl>
    implements _$$EmailSettingsImplCopyWith<$Res> {
  __$$EmailSettingsImplCopyWithImpl(
      _$EmailSettingsImpl _value, $Res Function(_$EmailSettingsImpl) _then)
      : super(_value, _then);

  /// Create a copy of EmailSettings
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? displayName = null,
    Object? emailAddress = null,
    Object? signature = freezed,
    Object? autoReply = freezed,
    Object? autoReplyMessage = freezed,
    Object? autoReplyStartDate = freezed,
    Object? autoReplyEndDate = freezed,
    Object? refreshInterval = freezed,
    Object? showPreview = freezed,
    Object? previewLines = freezed,
    Object? markAsReadOnPreview = freezed,
    Object? enableSpamFilter = freezed,
    Object? enableReadReceipts = freezed,
    Object? enablePushNotifications = freezed,
    Object? notifications = freezed,
    Object? security = freezed,
  }) {
    return _then(_$EmailSettingsImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      displayName: null == displayName
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String,
      emailAddress: null == emailAddress
          ? _value.emailAddress
          : emailAddress // ignore: cast_nullable_to_non_nullable
              as String,
      signature: freezed == signature
          ? _value.signature
          : signature // ignore: cast_nullable_to_non_nullable
              as String?,
      autoReply: freezed == autoReply
          ? _value.autoReply
          : autoReply // ignore: cast_nullable_to_non_nullable
              as bool?,
      autoReplyMessage: freezed == autoReplyMessage
          ? _value.autoReplyMessage
          : autoReplyMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      autoReplyStartDate: freezed == autoReplyStartDate
          ? _value.autoReplyStartDate
          : autoReplyStartDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      autoReplyEndDate: freezed == autoReplyEndDate
          ? _value.autoReplyEndDate
          : autoReplyEndDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      refreshInterval: freezed == refreshInterval
          ? _value.refreshInterval
          : refreshInterval // ignore: cast_nullable_to_non_nullable
              as int?,
      showPreview: freezed == showPreview
          ? _value.showPreview
          : showPreview // ignore: cast_nullable_to_non_nullable
              as bool?,
      previewLines: freezed == previewLines
          ? _value.previewLines
          : previewLines // ignore: cast_nullable_to_non_nullable
              as int?,
      markAsReadOnPreview: freezed == markAsReadOnPreview
          ? _value.markAsReadOnPreview
          : markAsReadOnPreview // ignore: cast_nullable_to_non_nullable
              as bool?,
      enableSpamFilter: freezed == enableSpamFilter
          ? _value.enableSpamFilter
          : enableSpamFilter // ignore: cast_nullable_to_non_nullable
              as bool?,
      enableReadReceipts: freezed == enableReadReceipts
          ? _value.enableReadReceipts
          : enableReadReceipts // ignore: cast_nullable_to_non_nullable
              as bool?,
      enablePushNotifications: freezed == enablePushNotifications
          ? _value.enablePushNotifications
          : enablePushNotifications // ignore: cast_nullable_to_non_nullable
              as bool?,
      notifications: freezed == notifications
          ? _value.notifications
          : notifications // ignore: cast_nullable_to_non_nullable
              as NotificationSettings?,
      security: freezed == security
          ? _value.security
          : security // ignore: cast_nullable_to_non_nullable
              as SecuritySettings?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$EmailSettingsImpl implements _EmailSettings {
  const _$EmailSettingsImpl(
      {required this.id,
      required this.displayName,
      required this.emailAddress,
      this.signature,
      this.autoReply,
      this.autoReplyMessage,
      this.autoReplyStartDate,
      this.autoReplyEndDate,
      this.refreshInterval,
      this.showPreview,
      this.previewLines,
      this.markAsReadOnPreview,
      this.enableSpamFilter,
      this.enableReadReceipts,
      this.enablePushNotifications,
      this.notifications,
      this.security});

  factory _$EmailSettingsImpl.fromJson(Map<String, dynamic> json) =>
      _$$EmailSettingsImplFromJson(json);

  @override
  final String id;
  @override
  final String displayName;
  @override
  final String emailAddress;
  @override
  final String? signature;
  @override
  final bool? autoReply;
  @override
  final String? autoReplyMessage;
  @override
  final DateTime? autoReplyStartDate;
  @override
  final DateTime? autoReplyEndDate;
  @override
  final int? refreshInterval;
  @override
  final bool? showPreview;
  @override
  final int? previewLines;
  @override
  final bool? markAsReadOnPreview;
  @override
  final bool? enableSpamFilter;
  @override
  final bool? enableReadReceipts;
  @override
  final bool? enablePushNotifications;
  @override
  final NotificationSettings? notifications;
  @override
  final SecuritySettings? security;

  @override
  String toString() {
    return 'EmailSettings(id: $id, displayName: $displayName, emailAddress: $emailAddress, signature: $signature, autoReply: $autoReply, autoReplyMessage: $autoReplyMessage, autoReplyStartDate: $autoReplyStartDate, autoReplyEndDate: $autoReplyEndDate, refreshInterval: $refreshInterval, showPreview: $showPreview, previewLines: $previewLines, markAsReadOnPreview: $markAsReadOnPreview, enableSpamFilter: $enableSpamFilter, enableReadReceipts: $enableReadReceipts, enablePushNotifications: $enablePushNotifications, notifications: $notifications, security: $security)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EmailSettingsImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.displayName, displayName) ||
                other.displayName == displayName) &&
            (identical(other.emailAddress, emailAddress) ||
                other.emailAddress == emailAddress) &&
            (identical(other.signature, signature) ||
                other.signature == signature) &&
            (identical(other.autoReply, autoReply) ||
                other.autoReply == autoReply) &&
            (identical(other.autoReplyMessage, autoReplyMessage) ||
                other.autoReplyMessage == autoReplyMessage) &&
            (identical(other.autoReplyStartDate, autoReplyStartDate) ||
                other.autoReplyStartDate == autoReplyStartDate) &&
            (identical(other.autoReplyEndDate, autoReplyEndDate) ||
                other.autoReplyEndDate == autoReplyEndDate) &&
            (identical(other.refreshInterval, refreshInterval) ||
                other.refreshInterval == refreshInterval) &&
            (identical(other.showPreview, showPreview) ||
                other.showPreview == showPreview) &&
            (identical(other.previewLines, previewLines) ||
                other.previewLines == previewLines) &&
            (identical(other.markAsReadOnPreview, markAsReadOnPreview) ||
                other.markAsReadOnPreview == markAsReadOnPreview) &&
            (identical(other.enableSpamFilter, enableSpamFilter) ||
                other.enableSpamFilter == enableSpamFilter) &&
            (identical(other.enableReadReceipts, enableReadReceipts) ||
                other.enableReadReceipts == enableReadReceipts) &&
            (identical(
                    other.enablePushNotifications, enablePushNotifications) ||
                other.enablePushNotifications == enablePushNotifications) &&
            (identical(other.notifications, notifications) ||
                other.notifications == notifications) &&
            (identical(other.security, security) ||
                other.security == security));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      displayName,
      emailAddress,
      signature,
      autoReply,
      autoReplyMessage,
      autoReplyStartDate,
      autoReplyEndDate,
      refreshInterval,
      showPreview,
      previewLines,
      markAsReadOnPreview,
      enableSpamFilter,
      enableReadReceipts,
      enablePushNotifications,
      notifications,
      security);

  /// Create a copy of EmailSettings
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EmailSettingsImplCopyWith<_$EmailSettingsImpl> get copyWith =>
      __$$EmailSettingsImplCopyWithImpl<_$EmailSettingsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EmailSettingsImplToJson(
      this,
    );
  }
}

abstract class _EmailSettings implements EmailSettings {
  const factory _EmailSettings(
      {required final String id,
      required final String displayName,
      required final String emailAddress,
      final String? signature,
      final bool? autoReply,
      final String? autoReplyMessage,
      final DateTime? autoReplyStartDate,
      final DateTime? autoReplyEndDate,
      final int? refreshInterval,
      final bool? showPreview,
      final int? previewLines,
      final bool? markAsReadOnPreview,
      final bool? enableSpamFilter,
      final bool? enableReadReceipts,
      final bool? enablePushNotifications,
      final NotificationSettings? notifications,
      final SecuritySettings? security}) = _$EmailSettingsImpl;

  factory _EmailSettings.fromJson(Map<String, dynamic> json) =
      _$EmailSettingsImpl.fromJson;

  @override
  String get id;
  @override
  String get displayName;
  @override
  String get emailAddress;
  @override
  String? get signature;
  @override
  bool? get autoReply;
  @override
  String? get autoReplyMessage;
  @override
  DateTime? get autoReplyStartDate;
  @override
  DateTime? get autoReplyEndDate;
  @override
  int? get refreshInterval;
  @override
  bool? get showPreview;
  @override
  int? get previewLines;
  @override
  bool? get markAsReadOnPreview;
  @override
  bool? get enableSpamFilter;
  @override
  bool? get enableReadReceipts;
  @override
  bool? get enablePushNotifications;
  @override
  NotificationSettings? get notifications;
  @override
  SecuritySettings? get security;

  /// Create a copy of EmailSettings
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EmailSettingsImplCopyWith<_$EmailSettingsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

NotificationSettings _$NotificationSettingsFromJson(Map<String, dynamic> json) {
  return _NotificationSettings.fromJson(json);
}

/// @nodoc
mixin _$NotificationSettings {
  bool? get newEmail => throw _privateConstructorUsedError;
  bool? get importantEmail => throw _privateConstructorUsedError;
  bool? get mentions => throw _privateConstructorUsedError;
  bool? get calendar => throw _privateConstructorUsedError;
  bool? get reminders => throw _privateConstructorUsedError;
  List<String>? get excludedSenders => throw _privateConstructorUsedError;
  List<String>? get vipSenders => throw _privateConstructorUsedError;
  bool? get quietHours => throw _privateConstructorUsedError;
  DateTime? get quietStartTime => throw _privateConstructorUsedError;
  DateTime? get quietEndTime => throw _privateConstructorUsedError;

  /// Serializes this NotificationSettings to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of NotificationSettings
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $NotificationSettingsCopyWith<NotificationSettings> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NotificationSettingsCopyWith<$Res> {
  factory $NotificationSettingsCopyWith(NotificationSettings value,
          $Res Function(NotificationSettings) then) =
      _$NotificationSettingsCopyWithImpl<$Res, NotificationSettings>;
  @useResult
  $Res call(
      {bool? newEmail,
      bool? importantEmail,
      bool? mentions,
      bool? calendar,
      bool? reminders,
      List<String>? excludedSenders,
      List<String>? vipSenders,
      bool? quietHours,
      DateTime? quietStartTime,
      DateTime? quietEndTime});
}

/// @nodoc
class _$NotificationSettingsCopyWithImpl<$Res,
        $Val extends NotificationSettings>
    implements $NotificationSettingsCopyWith<$Res> {
  _$NotificationSettingsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of NotificationSettings
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? newEmail = freezed,
    Object? importantEmail = freezed,
    Object? mentions = freezed,
    Object? calendar = freezed,
    Object? reminders = freezed,
    Object? excludedSenders = freezed,
    Object? vipSenders = freezed,
    Object? quietHours = freezed,
    Object? quietStartTime = freezed,
    Object? quietEndTime = freezed,
  }) {
    return _then(_value.copyWith(
      newEmail: freezed == newEmail
          ? _value.newEmail
          : newEmail // ignore: cast_nullable_to_non_nullable
              as bool?,
      importantEmail: freezed == importantEmail
          ? _value.importantEmail
          : importantEmail // ignore: cast_nullable_to_non_nullable
              as bool?,
      mentions: freezed == mentions
          ? _value.mentions
          : mentions // ignore: cast_nullable_to_non_nullable
              as bool?,
      calendar: freezed == calendar
          ? _value.calendar
          : calendar // ignore: cast_nullable_to_non_nullable
              as bool?,
      reminders: freezed == reminders
          ? _value.reminders
          : reminders // ignore: cast_nullable_to_non_nullable
              as bool?,
      excludedSenders: freezed == excludedSenders
          ? _value.excludedSenders
          : excludedSenders // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      vipSenders: freezed == vipSenders
          ? _value.vipSenders
          : vipSenders // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      quietHours: freezed == quietHours
          ? _value.quietHours
          : quietHours // ignore: cast_nullable_to_non_nullable
              as bool?,
      quietStartTime: freezed == quietStartTime
          ? _value.quietStartTime
          : quietStartTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      quietEndTime: freezed == quietEndTime
          ? _value.quietEndTime
          : quietEndTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NotificationSettingsImplCopyWith<$Res>
    implements $NotificationSettingsCopyWith<$Res> {
  factory _$$NotificationSettingsImplCopyWith(_$NotificationSettingsImpl value,
          $Res Function(_$NotificationSettingsImpl) then) =
      __$$NotificationSettingsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool? newEmail,
      bool? importantEmail,
      bool? mentions,
      bool? calendar,
      bool? reminders,
      List<String>? excludedSenders,
      List<String>? vipSenders,
      bool? quietHours,
      DateTime? quietStartTime,
      DateTime? quietEndTime});
}

/// @nodoc
class __$$NotificationSettingsImplCopyWithImpl<$Res>
    extends _$NotificationSettingsCopyWithImpl<$Res, _$NotificationSettingsImpl>
    implements _$$NotificationSettingsImplCopyWith<$Res> {
  __$$NotificationSettingsImplCopyWithImpl(_$NotificationSettingsImpl _value,
      $Res Function(_$NotificationSettingsImpl) _then)
      : super(_value, _then);

  /// Create a copy of NotificationSettings
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? newEmail = freezed,
    Object? importantEmail = freezed,
    Object? mentions = freezed,
    Object? calendar = freezed,
    Object? reminders = freezed,
    Object? excludedSenders = freezed,
    Object? vipSenders = freezed,
    Object? quietHours = freezed,
    Object? quietStartTime = freezed,
    Object? quietEndTime = freezed,
  }) {
    return _then(_$NotificationSettingsImpl(
      newEmail: freezed == newEmail
          ? _value.newEmail
          : newEmail // ignore: cast_nullable_to_non_nullable
              as bool?,
      importantEmail: freezed == importantEmail
          ? _value.importantEmail
          : importantEmail // ignore: cast_nullable_to_non_nullable
              as bool?,
      mentions: freezed == mentions
          ? _value.mentions
          : mentions // ignore: cast_nullable_to_non_nullable
              as bool?,
      calendar: freezed == calendar
          ? _value.calendar
          : calendar // ignore: cast_nullable_to_non_nullable
              as bool?,
      reminders: freezed == reminders
          ? _value.reminders
          : reminders // ignore: cast_nullable_to_non_nullable
              as bool?,
      excludedSenders: freezed == excludedSenders
          ? _value._excludedSenders
          : excludedSenders // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      vipSenders: freezed == vipSenders
          ? _value._vipSenders
          : vipSenders // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      quietHours: freezed == quietHours
          ? _value.quietHours
          : quietHours // ignore: cast_nullable_to_non_nullable
              as bool?,
      quietStartTime: freezed == quietStartTime
          ? _value.quietStartTime
          : quietStartTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      quietEndTime: freezed == quietEndTime
          ? _value.quietEndTime
          : quietEndTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$NotificationSettingsImpl implements _NotificationSettings {
  const _$NotificationSettingsImpl(
      {this.newEmail,
      this.importantEmail,
      this.mentions,
      this.calendar,
      this.reminders,
      final List<String>? excludedSenders,
      final List<String>? vipSenders,
      this.quietHours,
      this.quietStartTime,
      this.quietEndTime})
      : _excludedSenders = excludedSenders,
        _vipSenders = vipSenders;

  factory _$NotificationSettingsImpl.fromJson(Map<String, dynamic> json) =>
      _$$NotificationSettingsImplFromJson(json);

  @override
  final bool? newEmail;
  @override
  final bool? importantEmail;
  @override
  final bool? mentions;
  @override
  final bool? calendar;
  @override
  final bool? reminders;
  final List<String>? _excludedSenders;
  @override
  List<String>? get excludedSenders {
    final value = _excludedSenders;
    if (value == null) return null;
    if (_excludedSenders is EqualUnmodifiableListView) return _excludedSenders;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<String>? _vipSenders;
  @override
  List<String>? get vipSenders {
    final value = _vipSenders;
    if (value == null) return null;
    if (_vipSenders is EqualUnmodifiableListView) return _vipSenders;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final bool? quietHours;
  @override
  final DateTime? quietStartTime;
  @override
  final DateTime? quietEndTime;

  @override
  String toString() {
    return 'NotificationSettings(newEmail: $newEmail, importantEmail: $importantEmail, mentions: $mentions, calendar: $calendar, reminders: $reminders, excludedSenders: $excludedSenders, vipSenders: $vipSenders, quietHours: $quietHours, quietStartTime: $quietStartTime, quietEndTime: $quietEndTime)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NotificationSettingsImpl &&
            (identical(other.newEmail, newEmail) ||
                other.newEmail == newEmail) &&
            (identical(other.importantEmail, importantEmail) ||
                other.importantEmail == importantEmail) &&
            (identical(other.mentions, mentions) ||
                other.mentions == mentions) &&
            (identical(other.calendar, calendar) ||
                other.calendar == calendar) &&
            (identical(other.reminders, reminders) ||
                other.reminders == reminders) &&
            const DeepCollectionEquality()
                .equals(other._excludedSenders, _excludedSenders) &&
            const DeepCollectionEquality()
                .equals(other._vipSenders, _vipSenders) &&
            (identical(other.quietHours, quietHours) ||
                other.quietHours == quietHours) &&
            (identical(other.quietStartTime, quietStartTime) ||
                other.quietStartTime == quietStartTime) &&
            (identical(other.quietEndTime, quietEndTime) ||
                other.quietEndTime == quietEndTime));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      newEmail,
      importantEmail,
      mentions,
      calendar,
      reminders,
      const DeepCollectionEquality().hash(_excludedSenders),
      const DeepCollectionEquality().hash(_vipSenders),
      quietHours,
      quietStartTime,
      quietEndTime);

  /// Create a copy of NotificationSettings
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NotificationSettingsImplCopyWith<_$NotificationSettingsImpl>
      get copyWith =>
          __$$NotificationSettingsImplCopyWithImpl<_$NotificationSettingsImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NotificationSettingsImplToJson(
      this,
    );
  }
}

abstract class _NotificationSettings implements NotificationSettings {
  const factory _NotificationSettings(
      {final bool? newEmail,
      final bool? importantEmail,
      final bool? mentions,
      final bool? calendar,
      final bool? reminders,
      final List<String>? excludedSenders,
      final List<String>? vipSenders,
      final bool? quietHours,
      final DateTime? quietStartTime,
      final DateTime? quietEndTime}) = _$NotificationSettingsImpl;

  factory _NotificationSettings.fromJson(Map<String, dynamic> json) =
      _$NotificationSettingsImpl.fromJson;

  @override
  bool? get newEmail;
  @override
  bool? get importantEmail;
  @override
  bool? get mentions;
  @override
  bool? get calendar;
  @override
  bool? get reminders;
  @override
  List<String>? get excludedSenders;
  @override
  List<String>? get vipSenders;
  @override
  bool? get quietHours;
  @override
  DateTime? get quietStartTime;
  @override
  DateTime? get quietEndTime;

  /// Create a copy of NotificationSettings
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NotificationSettingsImplCopyWith<_$NotificationSettingsImpl>
      get copyWith => throw _privateConstructorUsedError;
}

SecuritySettings _$SecuritySettingsFromJson(Map<String, dynamic> json) {
  return _SecuritySettings.fromJson(json);
}

/// @nodoc
mixin _$SecuritySettings {
  bool? get twoFactorAuth => throw _privateConstructorUsedError;
  bool? get blockExternalImages => throw _privateConstructorUsedError;
  bool? get warnPhishing => throw _privateConstructorUsedError;
  bool? get encryptionRequired => throw _privateConstructorUsedError;
  List<String>? get trustedDomains => throw _privateConstructorUsedError;
  List<String>? get blockedSenders => throw _privateConstructorUsedError;
  bool? get requireSenderAuth => throw _privateConstructorUsedError;

  /// Serializes this SecuritySettings to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SecuritySettings
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SecuritySettingsCopyWith<SecuritySettings> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SecuritySettingsCopyWith<$Res> {
  factory $SecuritySettingsCopyWith(
          SecuritySettings value, $Res Function(SecuritySettings) then) =
      _$SecuritySettingsCopyWithImpl<$Res, SecuritySettings>;
  @useResult
  $Res call(
      {bool? twoFactorAuth,
      bool? blockExternalImages,
      bool? warnPhishing,
      bool? encryptionRequired,
      List<String>? trustedDomains,
      List<String>? blockedSenders,
      bool? requireSenderAuth});
}

/// @nodoc
class _$SecuritySettingsCopyWithImpl<$Res, $Val extends SecuritySettings>
    implements $SecuritySettingsCopyWith<$Res> {
  _$SecuritySettingsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SecuritySettings
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? twoFactorAuth = freezed,
    Object? blockExternalImages = freezed,
    Object? warnPhishing = freezed,
    Object? encryptionRequired = freezed,
    Object? trustedDomains = freezed,
    Object? blockedSenders = freezed,
    Object? requireSenderAuth = freezed,
  }) {
    return _then(_value.copyWith(
      twoFactorAuth: freezed == twoFactorAuth
          ? _value.twoFactorAuth
          : twoFactorAuth // ignore: cast_nullable_to_non_nullable
              as bool?,
      blockExternalImages: freezed == blockExternalImages
          ? _value.blockExternalImages
          : blockExternalImages // ignore: cast_nullable_to_non_nullable
              as bool?,
      warnPhishing: freezed == warnPhishing
          ? _value.warnPhishing
          : warnPhishing // ignore: cast_nullable_to_non_nullable
              as bool?,
      encryptionRequired: freezed == encryptionRequired
          ? _value.encryptionRequired
          : encryptionRequired // ignore: cast_nullable_to_non_nullable
              as bool?,
      trustedDomains: freezed == trustedDomains
          ? _value.trustedDomains
          : trustedDomains // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      blockedSenders: freezed == blockedSenders
          ? _value.blockedSenders
          : blockedSenders // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      requireSenderAuth: freezed == requireSenderAuth
          ? _value.requireSenderAuth
          : requireSenderAuth // ignore: cast_nullable_to_non_nullable
              as bool?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SecuritySettingsImplCopyWith<$Res>
    implements $SecuritySettingsCopyWith<$Res> {
  factory _$$SecuritySettingsImplCopyWith(_$SecuritySettingsImpl value,
          $Res Function(_$SecuritySettingsImpl) then) =
      __$$SecuritySettingsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool? twoFactorAuth,
      bool? blockExternalImages,
      bool? warnPhishing,
      bool? encryptionRequired,
      List<String>? trustedDomains,
      List<String>? blockedSenders,
      bool? requireSenderAuth});
}

/// @nodoc
class __$$SecuritySettingsImplCopyWithImpl<$Res>
    extends _$SecuritySettingsCopyWithImpl<$Res, _$SecuritySettingsImpl>
    implements _$$SecuritySettingsImplCopyWith<$Res> {
  __$$SecuritySettingsImplCopyWithImpl(_$SecuritySettingsImpl _value,
      $Res Function(_$SecuritySettingsImpl) _then)
      : super(_value, _then);

  /// Create a copy of SecuritySettings
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? twoFactorAuth = freezed,
    Object? blockExternalImages = freezed,
    Object? warnPhishing = freezed,
    Object? encryptionRequired = freezed,
    Object? trustedDomains = freezed,
    Object? blockedSenders = freezed,
    Object? requireSenderAuth = freezed,
  }) {
    return _then(_$SecuritySettingsImpl(
      twoFactorAuth: freezed == twoFactorAuth
          ? _value.twoFactorAuth
          : twoFactorAuth // ignore: cast_nullable_to_non_nullable
              as bool?,
      blockExternalImages: freezed == blockExternalImages
          ? _value.blockExternalImages
          : blockExternalImages // ignore: cast_nullable_to_non_nullable
              as bool?,
      warnPhishing: freezed == warnPhishing
          ? _value.warnPhishing
          : warnPhishing // ignore: cast_nullable_to_non_nullable
              as bool?,
      encryptionRequired: freezed == encryptionRequired
          ? _value.encryptionRequired
          : encryptionRequired // ignore: cast_nullable_to_non_nullable
              as bool?,
      trustedDomains: freezed == trustedDomains
          ? _value._trustedDomains
          : trustedDomains // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      blockedSenders: freezed == blockedSenders
          ? _value._blockedSenders
          : blockedSenders // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      requireSenderAuth: freezed == requireSenderAuth
          ? _value.requireSenderAuth
          : requireSenderAuth // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SecuritySettingsImpl implements _SecuritySettings {
  const _$SecuritySettingsImpl(
      {this.twoFactorAuth,
      this.blockExternalImages,
      this.warnPhishing,
      this.encryptionRequired,
      final List<String>? trustedDomains,
      final List<String>? blockedSenders,
      this.requireSenderAuth})
      : _trustedDomains = trustedDomains,
        _blockedSenders = blockedSenders;

  factory _$SecuritySettingsImpl.fromJson(Map<String, dynamic> json) =>
      _$$SecuritySettingsImplFromJson(json);

  @override
  final bool? twoFactorAuth;
  @override
  final bool? blockExternalImages;
  @override
  final bool? warnPhishing;
  @override
  final bool? encryptionRequired;
  final List<String>? _trustedDomains;
  @override
  List<String>? get trustedDomains {
    final value = _trustedDomains;
    if (value == null) return null;
    if (_trustedDomains is EqualUnmodifiableListView) return _trustedDomains;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<String>? _blockedSenders;
  @override
  List<String>? get blockedSenders {
    final value = _blockedSenders;
    if (value == null) return null;
    if (_blockedSenders is EqualUnmodifiableListView) return _blockedSenders;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final bool? requireSenderAuth;

  @override
  String toString() {
    return 'SecuritySettings(twoFactorAuth: $twoFactorAuth, blockExternalImages: $blockExternalImages, warnPhishing: $warnPhishing, encryptionRequired: $encryptionRequired, trustedDomains: $trustedDomains, blockedSenders: $blockedSenders, requireSenderAuth: $requireSenderAuth)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SecuritySettingsImpl &&
            (identical(other.twoFactorAuth, twoFactorAuth) ||
                other.twoFactorAuth == twoFactorAuth) &&
            (identical(other.blockExternalImages, blockExternalImages) ||
                other.blockExternalImages == blockExternalImages) &&
            (identical(other.warnPhishing, warnPhishing) ||
                other.warnPhishing == warnPhishing) &&
            (identical(other.encryptionRequired, encryptionRequired) ||
                other.encryptionRequired == encryptionRequired) &&
            const DeepCollectionEquality()
                .equals(other._trustedDomains, _trustedDomains) &&
            const DeepCollectionEquality()
                .equals(other._blockedSenders, _blockedSenders) &&
            (identical(other.requireSenderAuth, requireSenderAuth) ||
                other.requireSenderAuth == requireSenderAuth));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      twoFactorAuth,
      blockExternalImages,
      warnPhishing,
      encryptionRequired,
      const DeepCollectionEquality().hash(_trustedDomains),
      const DeepCollectionEquality().hash(_blockedSenders),
      requireSenderAuth);

  /// Create a copy of SecuritySettings
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SecuritySettingsImplCopyWith<_$SecuritySettingsImpl> get copyWith =>
      __$$SecuritySettingsImplCopyWithImpl<_$SecuritySettingsImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SecuritySettingsImplToJson(
      this,
    );
  }
}

abstract class _SecuritySettings implements SecuritySettings {
  const factory _SecuritySettings(
      {final bool? twoFactorAuth,
      final bool? blockExternalImages,
      final bool? warnPhishing,
      final bool? encryptionRequired,
      final List<String>? trustedDomains,
      final List<String>? blockedSenders,
      final bool? requireSenderAuth}) = _$SecuritySettingsImpl;

  factory _SecuritySettings.fromJson(Map<String, dynamic> json) =
      _$SecuritySettingsImpl.fromJson;

  @override
  bool? get twoFactorAuth;
  @override
  bool? get blockExternalImages;
  @override
  bool? get warnPhishing;
  @override
  bool? get encryptionRequired;
  @override
  List<String>? get trustedDomains;
  @override
  List<String>? get blockedSenders;
  @override
  bool? get requireSenderAuth;

  /// Create a copy of SecuritySettings
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SecuritySettingsImplCopyWith<_$SecuritySettingsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ContactGroup _$ContactGroupFromJson(Map<String, dynamic> json) {
  return _ContactGroup.fromJson(json);
}

/// @nodoc
mixin _$ContactGroup {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  @JsonKey(includeFromJson: false, includeToJson: false)
  Color? get color => throw _privateConstructorUsedError;
  List<String>? get contactIds => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;

  /// Serializes this ContactGroup to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ContactGroup
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ContactGroupCopyWith<ContactGroup> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ContactGroupCopyWith<$Res> {
  factory $ContactGroupCopyWith(
          ContactGroup value, $Res Function(ContactGroup) then) =
      _$ContactGroupCopyWithImpl<$Res, ContactGroup>;
  @useResult
  $Res call(
      {String id,
      String name,
      String? description,
      @JsonKey(includeFromJson: false, includeToJson: false) Color? color,
      List<String>? contactIds,
      DateTime? createdAt});
}

/// @nodoc
class _$ContactGroupCopyWithImpl<$Res, $Val extends ContactGroup>
    implements $ContactGroupCopyWith<$Res> {
  _$ContactGroupCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ContactGroup
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = freezed,
    Object? color = freezed,
    Object? contactIds = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      color: freezed == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as Color?,
      contactIds: freezed == contactIds
          ? _value.contactIds
          : contactIds // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ContactGroupImplCopyWith<$Res>
    implements $ContactGroupCopyWith<$Res> {
  factory _$$ContactGroupImplCopyWith(
          _$ContactGroupImpl value, $Res Function(_$ContactGroupImpl) then) =
      __$$ContactGroupImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String? description,
      @JsonKey(includeFromJson: false, includeToJson: false) Color? color,
      List<String>? contactIds,
      DateTime? createdAt});
}

/// @nodoc
class __$$ContactGroupImplCopyWithImpl<$Res>
    extends _$ContactGroupCopyWithImpl<$Res, _$ContactGroupImpl>
    implements _$$ContactGroupImplCopyWith<$Res> {
  __$$ContactGroupImplCopyWithImpl(
      _$ContactGroupImpl _value, $Res Function(_$ContactGroupImpl) _then)
      : super(_value, _then);

  /// Create a copy of ContactGroup
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = freezed,
    Object? color = freezed,
    Object? contactIds = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(_$ContactGroupImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      color: freezed == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as Color?,
      contactIds: freezed == contactIds
          ? _value._contactIds
          : contactIds // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ContactGroupImpl implements _ContactGroup {
  const _$ContactGroupImpl(
      {required this.id,
      required this.name,
      this.description,
      @JsonKey(includeFromJson: false, includeToJson: false) this.color,
      final List<String>? contactIds,
      this.createdAt})
      : _contactIds = contactIds;

  factory _$ContactGroupImpl.fromJson(Map<String, dynamic> json) =>
      _$$ContactGroupImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String? description;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  final Color? color;
  final List<String>? _contactIds;
  @override
  List<String>? get contactIds {
    final value = _contactIds;
    if (value == null) return null;
    if (_contactIds is EqualUnmodifiableListView) return _contactIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final DateTime? createdAt;

  @override
  String toString() {
    return 'ContactGroup(id: $id, name: $name, description: $description, color: $color, contactIds: $contactIds, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ContactGroupImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.color, color) || other.color == color) &&
            const DeepCollectionEquality()
                .equals(other._contactIds, _contactIds) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, description, color,
      const DeepCollectionEquality().hash(_contactIds), createdAt);

  /// Create a copy of ContactGroup
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ContactGroupImplCopyWith<_$ContactGroupImpl> get copyWith =>
      __$$ContactGroupImplCopyWithImpl<_$ContactGroupImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ContactGroupImplToJson(
      this,
    );
  }
}

abstract class _ContactGroup implements ContactGroup {
  const factory _ContactGroup(
      {required final String id,
      required final String name,
      final String? description,
      @JsonKey(includeFromJson: false, includeToJson: false) final Color? color,
      final List<String>? contactIds,
      final DateTime? createdAt}) = _$ContactGroupImpl;

  factory _ContactGroup.fromJson(Map<String, dynamic> json) =
      _$ContactGroupImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String? get description;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  Color? get color;
  @override
  List<String>? get contactIds;
  @override
  DateTime? get createdAt;

  /// Create a copy of ContactGroup
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ContactGroupImplCopyWith<_$ContactGroupImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

EmailSearchFilter _$EmailSearchFilterFromJson(Map<String, dynamic> json) {
  return _EmailSearchFilter.fromJson(json);
}

/// @nodoc
mixin _$EmailSearchFilter {
  String? get query => throw _privateConstructorUsedError;
  Contact? get sender => throw _privateConstructorUsedError;
  List<Contact>? get recipients => throw _privateConstructorUsedError;
  List<EmailFolder>? get folders => throw _privateConstructorUsedError;
  List<EmailLabel>? get labels => throw _privateConstructorUsedError;
  DateTime? get dateFrom => throw _privateConstructorUsedError;
  DateTime? get dateTo => throw _privateConstructorUsedError;
  bool? get hasAttachments => throw _privateConstructorUsedError;
  bool? get isUnread => throw _privateConstructorUsedError;
  bool? get isStarred => throw _privateConstructorUsedError;
  bool? get isImportant => throw _privateConstructorUsedError;
  EmailPriority? get priority => throw _privateConstructorUsedError;
  int? get sizeMin => throw _privateConstructorUsedError;
  int? get sizeMax => throw _privateConstructorUsedError;

  /// Serializes this EmailSearchFilter to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of EmailSearchFilter
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EmailSearchFilterCopyWith<EmailSearchFilter> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EmailSearchFilterCopyWith<$Res> {
  factory $EmailSearchFilterCopyWith(
          EmailSearchFilter value, $Res Function(EmailSearchFilter) then) =
      _$EmailSearchFilterCopyWithImpl<$Res, EmailSearchFilter>;
  @useResult
  $Res call(
      {String? query,
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
      int? sizeMax});

  $ContactCopyWith<$Res>? get sender;
}

/// @nodoc
class _$EmailSearchFilterCopyWithImpl<$Res, $Val extends EmailSearchFilter>
    implements $EmailSearchFilterCopyWith<$Res> {
  _$EmailSearchFilterCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of EmailSearchFilter
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? query = freezed,
    Object? sender = freezed,
    Object? recipients = freezed,
    Object? folders = freezed,
    Object? labels = freezed,
    Object? dateFrom = freezed,
    Object? dateTo = freezed,
    Object? hasAttachments = freezed,
    Object? isUnread = freezed,
    Object? isStarred = freezed,
    Object? isImportant = freezed,
    Object? priority = freezed,
    Object? sizeMin = freezed,
    Object? sizeMax = freezed,
  }) {
    return _then(_value.copyWith(
      query: freezed == query
          ? _value.query
          : query // ignore: cast_nullable_to_non_nullable
              as String?,
      sender: freezed == sender
          ? _value.sender
          : sender // ignore: cast_nullable_to_non_nullable
              as Contact?,
      recipients: freezed == recipients
          ? _value.recipients
          : recipients // ignore: cast_nullable_to_non_nullable
              as List<Contact>?,
      folders: freezed == folders
          ? _value.folders
          : folders // ignore: cast_nullable_to_non_nullable
              as List<EmailFolder>?,
      labels: freezed == labels
          ? _value.labels
          : labels // ignore: cast_nullable_to_non_nullable
              as List<EmailLabel>?,
      dateFrom: freezed == dateFrom
          ? _value.dateFrom
          : dateFrom // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      dateTo: freezed == dateTo
          ? _value.dateTo
          : dateTo // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      hasAttachments: freezed == hasAttachments
          ? _value.hasAttachments
          : hasAttachments // ignore: cast_nullable_to_non_nullable
              as bool?,
      isUnread: freezed == isUnread
          ? _value.isUnread
          : isUnread // ignore: cast_nullable_to_non_nullable
              as bool?,
      isStarred: freezed == isStarred
          ? _value.isStarred
          : isStarred // ignore: cast_nullable_to_non_nullable
              as bool?,
      isImportant: freezed == isImportant
          ? _value.isImportant
          : isImportant // ignore: cast_nullable_to_non_nullable
              as bool?,
      priority: freezed == priority
          ? _value.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as EmailPriority?,
      sizeMin: freezed == sizeMin
          ? _value.sizeMin
          : sizeMin // ignore: cast_nullable_to_non_nullable
              as int?,
      sizeMax: freezed == sizeMax
          ? _value.sizeMax
          : sizeMax // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }

  /// Create a copy of EmailSearchFilter
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ContactCopyWith<$Res>? get sender {
    if (_value.sender == null) {
      return null;
    }

    return $ContactCopyWith<$Res>(_value.sender!, (value) {
      return _then(_value.copyWith(sender: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$EmailSearchFilterImplCopyWith<$Res>
    implements $EmailSearchFilterCopyWith<$Res> {
  factory _$$EmailSearchFilterImplCopyWith(_$EmailSearchFilterImpl value,
          $Res Function(_$EmailSearchFilterImpl) then) =
      __$$EmailSearchFilterImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? query,
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
      int? sizeMax});

  @override
  $ContactCopyWith<$Res>? get sender;
}

/// @nodoc
class __$$EmailSearchFilterImplCopyWithImpl<$Res>
    extends _$EmailSearchFilterCopyWithImpl<$Res, _$EmailSearchFilterImpl>
    implements _$$EmailSearchFilterImplCopyWith<$Res> {
  __$$EmailSearchFilterImplCopyWithImpl(_$EmailSearchFilterImpl _value,
      $Res Function(_$EmailSearchFilterImpl) _then)
      : super(_value, _then);

  /// Create a copy of EmailSearchFilter
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? query = freezed,
    Object? sender = freezed,
    Object? recipients = freezed,
    Object? folders = freezed,
    Object? labels = freezed,
    Object? dateFrom = freezed,
    Object? dateTo = freezed,
    Object? hasAttachments = freezed,
    Object? isUnread = freezed,
    Object? isStarred = freezed,
    Object? isImportant = freezed,
    Object? priority = freezed,
    Object? sizeMin = freezed,
    Object? sizeMax = freezed,
  }) {
    return _then(_$EmailSearchFilterImpl(
      query: freezed == query
          ? _value.query
          : query // ignore: cast_nullable_to_non_nullable
              as String?,
      sender: freezed == sender
          ? _value.sender
          : sender // ignore: cast_nullable_to_non_nullable
              as Contact?,
      recipients: freezed == recipients
          ? _value._recipients
          : recipients // ignore: cast_nullable_to_non_nullable
              as List<Contact>?,
      folders: freezed == folders
          ? _value._folders
          : folders // ignore: cast_nullable_to_non_nullable
              as List<EmailFolder>?,
      labels: freezed == labels
          ? _value._labels
          : labels // ignore: cast_nullable_to_non_nullable
              as List<EmailLabel>?,
      dateFrom: freezed == dateFrom
          ? _value.dateFrom
          : dateFrom // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      dateTo: freezed == dateTo
          ? _value.dateTo
          : dateTo // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      hasAttachments: freezed == hasAttachments
          ? _value.hasAttachments
          : hasAttachments // ignore: cast_nullable_to_non_nullable
              as bool?,
      isUnread: freezed == isUnread
          ? _value.isUnread
          : isUnread // ignore: cast_nullable_to_non_nullable
              as bool?,
      isStarred: freezed == isStarred
          ? _value.isStarred
          : isStarred // ignore: cast_nullable_to_non_nullable
              as bool?,
      isImportant: freezed == isImportant
          ? _value.isImportant
          : isImportant // ignore: cast_nullable_to_non_nullable
              as bool?,
      priority: freezed == priority
          ? _value.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as EmailPriority?,
      sizeMin: freezed == sizeMin
          ? _value.sizeMin
          : sizeMin // ignore: cast_nullable_to_non_nullable
              as int?,
      sizeMax: freezed == sizeMax
          ? _value.sizeMax
          : sizeMax // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$EmailSearchFilterImpl implements _EmailSearchFilter {
  const _$EmailSearchFilterImpl(
      {this.query,
      this.sender,
      final List<Contact>? recipients,
      final List<EmailFolder>? folders,
      final List<EmailLabel>? labels,
      this.dateFrom,
      this.dateTo,
      this.hasAttachments,
      this.isUnread,
      this.isStarred,
      this.isImportant,
      this.priority,
      this.sizeMin,
      this.sizeMax})
      : _recipients = recipients,
        _folders = folders,
        _labels = labels;

  factory _$EmailSearchFilterImpl.fromJson(Map<String, dynamic> json) =>
      _$$EmailSearchFilterImplFromJson(json);

  @override
  final String? query;
  @override
  final Contact? sender;
  final List<Contact>? _recipients;
  @override
  List<Contact>? get recipients {
    final value = _recipients;
    if (value == null) return null;
    if (_recipients is EqualUnmodifiableListView) return _recipients;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<EmailFolder>? _folders;
  @override
  List<EmailFolder>? get folders {
    final value = _folders;
    if (value == null) return null;
    if (_folders is EqualUnmodifiableListView) return _folders;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<EmailLabel>? _labels;
  @override
  List<EmailLabel>? get labels {
    final value = _labels;
    if (value == null) return null;
    if (_labels is EqualUnmodifiableListView) return _labels;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final DateTime? dateFrom;
  @override
  final DateTime? dateTo;
  @override
  final bool? hasAttachments;
  @override
  final bool? isUnread;
  @override
  final bool? isStarred;
  @override
  final bool? isImportant;
  @override
  final EmailPriority? priority;
  @override
  final int? sizeMin;
  @override
  final int? sizeMax;

  @override
  String toString() {
    return 'EmailSearchFilter(query: $query, sender: $sender, recipients: $recipients, folders: $folders, labels: $labels, dateFrom: $dateFrom, dateTo: $dateTo, hasAttachments: $hasAttachments, isUnread: $isUnread, isStarred: $isStarred, isImportant: $isImportant, priority: $priority, sizeMin: $sizeMin, sizeMax: $sizeMax)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EmailSearchFilterImpl &&
            (identical(other.query, query) || other.query == query) &&
            (identical(other.sender, sender) || other.sender == sender) &&
            const DeepCollectionEquality()
                .equals(other._recipients, _recipients) &&
            const DeepCollectionEquality().equals(other._folders, _folders) &&
            const DeepCollectionEquality().equals(other._labels, _labels) &&
            (identical(other.dateFrom, dateFrom) ||
                other.dateFrom == dateFrom) &&
            (identical(other.dateTo, dateTo) || other.dateTo == dateTo) &&
            (identical(other.hasAttachments, hasAttachments) ||
                other.hasAttachments == hasAttachments) &&
            (identical(other.isUnread, isUnread) ||
                other.isUnread == isUnread) &&
            (identical(other.isStarred, isStarred) ||
                other.isStarred == isStarred) &&
            (identical(other.isImportant, isImportant) ||
                other.isImportant == isImportant) &&
            (identical(other.priority, priority) ||
                other.priority == priority) &&
            (identical(other.sizeMin, sizeMin) || other.sizeMin == sizeMin) &&
            (identical(other.sizeMax, sizeMax) || other.sizeMax == sizeMax));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      query,
      sender,
      const DeepCollectionEquality().hash(_recipients),
      const DeepCollectionEquality().hash(_folders),
      const DeepCollectionEquality().hash(_labels),
      dateFrom,
      dateTo,
      hasAttachments,
      isUnread,
      isStarred,
      isImportant,
      priority,
      sizeMin,
      sizeMax);

  /// Create a copy of EmailSearchFilter
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EmailSearchFilterImplCopyWith<_$EmailSearchFilterImpl> get copyWith =>
      __$$EmailSearchFilterImplCopyWithImpl<_$EmailSearchFilterImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EmailSearchFilterImplToJson(
      this,
    );
  }
}

abstract class _EmailSearchFilter implements EmailSearchFilter {
  const factory _EmailSearchFilter(
      {final String? query,
      final Contact? sender,
      final List<Contact>? recipients,
      final List<EmailFolder>? folders,
      final List<EmailLabel>? labels,
      final DateTime? dateFrom,
      final DateTime? dateTo,
      final bool? hasAttachments,
      final bool? isUnread,
      final bool? isStarred,
      final bool? isImportant,
      final EmailPriority? priority,
      final int? sizeMin,
      final int? sizeMax}) = _$EmailSearchFilterImpl;

  factory _EmailSearchFilter.fromJson(Map<String, dynamic> json) =
      _$EmailSearchFilterImpl.fromJson;

  @override
  String? get query;
  @override
  Contact? get sender;
  @override
  List<Contact>? get recipients;
  @override
  List<EmailFolder>? get folders;
  @override
  List<EmailLabel>? get labels;
  @override
  DateTime? get dateFrom;
  @override
  DateTime? get dateTo;
  @override
  bool? get hasAttachments;
  @override
  bool? get isUnread;
  @override
  bool? get isStarred;
  @override
  bool? get isImportant;
  @override
  EmailPriority? get priority;
  @override
  int? get sizeMin;
  @override
  int? get sizeMax;

  /// Create a copy of EmailSearchFilter
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EmailSearchFilterImplCopyWith<_$EmailSearchFilterImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
