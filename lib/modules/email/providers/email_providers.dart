import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/services/api_service.dart';
import '../models/email_models.dart';
import '../services/email_service.dart';

// Email Service Provider
final emailServiceProvider = Provider<EmailService>((ref) {
  final apiService = ref.watch(apiServiceProvider);
  return EmailService(apiService);
});

// Current Folder Provider
final currentFolderProvider = StateProvider<EmailFolder?>((ref) => null);

// Current Email Provider
final currentEmailProvider = StateProvider<Email?>((ref) => null);

// Selected Emails Provider (for bulk operations)
final selectedEmailsProvider = StateProvider<Set<String>>((ref) => {});

// Email Search Filter Provider
final emailSearchFilterProvider = StateProvider<EmailSearchFilter?>((ref) => null);

// Compose State Provider
final composeStateProvider = StateProvider<ComposeState?>((ref) => null);

// Email Settings Provider
final emailSettingsProvider = FutureProvider<EmailSettings>((ref) async {
  final emailService = ref.watch(emailServiceProvider);
  return emailService.getSettings();
});

// Folders Provider
final emailFoldersProvider = FutureProvider<List<EmailFolder>>((ref) async {
  final emailService = ref.watch(emailServiceProvider);
  return emailService.getFolders();
});

// Labels Provider
final emailLabelsProvider = FutureProvider<List<EmailLabel>>((ref) async {
  final emailService = ref.watch(emailServiceProvider);
  return emailService.getLabels();
});

// Contacts Provider
final contactsProvider = FutureProvider.family<List<Contact>, ContactsParams>((ref, params) async {
  final emailService = ref.watch(emailServiceProvider);
  return emailService.getContacts(
    query: params.query,
    groupId: params.groupId,
    page: params.page,
    limit: params.limit,
  );
});

// Templates Provider
final emailTemplatesProvider = FutureProvider.family<List<EmailTemplate>, TemplatesParams>((ref, params) async {
  final emailService = ref.watch(emailServiceProvider);
  return emailService.getTemplates(
    type: params.type,
    query: params.query,
    page: params.page,
    limit: params.limit,
  );
});

// Email Rules Provider
final emailRulesProvider = FutureProvider<List<EmailRule>>((ref) async {
  final emailService = ref.watch(emailServiceProvider);
  return emailService.getRules();
});

// Emails Provider
final emailsProvider = FutureProvider.family<List<Email>, EmailsParams>((ref, params) async {
  final emailService = ref.watch(emailServiceProvider);
  return emailService.getEmails(
    folderId: params.folderId,
    page: params.page,
    limit: params.limit,
    filter: params.filter,
  );
});

// Email Thread Provider
final emailThreadProvider = FutureProvider.family<EmailThread, String>((ref, threadId) async {
  final emailService = ref.watch(emailServiceProvider);
  return emailService.getEmailThread(threadId);
});

// Unread Count Provider
final unreadCountProvider = FutureProvider<int>((ref) async {
  final emailService = ref.watch(emailServiceProvider);
  final emails = await emailService.getUnreadEmails();
  return emails.length;
});

// Important Emails Provider
final importantEmailsProvider = FutureProvider<List<Email>>((ref) async {
  final emailService = ref.watch(emailServiceProvider);
  return emailService.getImportantEmails();
});

// Starred Emails Provider
final starredEmailsProvider = FutureProvider<List<Email>>((ref) async {
  final emailService = ref.watch(emailServiceProvider);
  return emailService.getStarredEmails();
});

// Drafts Provider
final draftsProvider = FutureProvider<List<Email>>((ref) async {
  final emailService = ref.watch(emailServiceProvider);
  return emailService.getEmails(
    filter: const EmailSearchFilter(folders: [
      EmailFolder(
        id: 'drafts',
        name: 'Drafts',
        type: EmailFolderType.drafts,
        unreadCount: 0,
        totalCount: 0,
      ),
    ]),
  );
});

// Email Actions Provider
final emailActionsProvider = Provider<EmailActions>((ref) {
  final emailService = ref.watch(emailServiceProvider);
  final selectedEmails = ref.watch(selectedEmailsProvider.notifier);
  
  return EmailActions(
    emailService: emailService,
    selectedEmailsNotifier: selectedEmails,
    ref: ref,
  );
});

// Compose Actions Provider
final composeActionsProvider = Provider<ComposeActions>((ref) {
  final emailService = ref.watch(emailServiceProvider);
  final composeState = ref.watch(composeStateProvider.notifier);
  
  return ComposeActions(
    emailService: emailService,
    composeStateNotifier: composeState,
    ref: ref,
  );
});

// Search Provider
final emailSearchProvider = FutureProvider.family<List<Email>, EmailSearchFilter>((ref, filter) async {
  final emailService = ref.watch(emailServiceProvider);
  return emailService.searchEmails(filter);
});

// Contact Search Provider
final contactSearchProvider = FutureProvider.family<List<Contact>, String>((ref, query) async {
  final emailService = ref.watch(emailServiceProvider);
  return emailService.searchContacts(query);
});

// Auto-refresh Provider
final autoRefreshProvider = StreamProvider<int>((ref) async* {
  var counter = 0;
  while (true) {
    await Future.delayed(const Duration(minutes: 5));
    yield counter++;
    // Invalidate email providers to trigger refresh
    ref.invalidate(emailsProvider);
    ref.invalidate(unreadCountProvider);
  }
});

// Navigation State Provider
final emailNavigationProvider = StateProvider<EmailNavigationState>((ref) {
  return const EmailNavigationState();
});

// Email View Mode Provider (list, thread, compose)
final emailViewModeProvider = StateProvider<EmailViewMode>((ref) => EmailViewMode.list);

// Email Sort Provider
final emailSortProvider = StateProvider<EmailSort>((ref) => const EmailSort());

// Quick Filters Provider
final quickFiltersProvider = StateProvider<Map<String, bool>>((ref) => {
  'unread': false,
  'starred': false,
  'important': false,
  'attachments': false,
});

// Bulk Operations Provider
final bulkOperationsProvider = Provider<BulkOperations>((ref) {
  final emailService = ref.watch(emailServiceProvider);
  final selectedEmails = ref.watch(selectedEmailsProvider);
  
  return BulkOperations(
    emailService: emailService,
    selectedEmailIds: selectedEmails,
    ref: ref,
  );
});

// Parameter classes
class EmailsParams {
  final String? folderId;
  final int page;
  final int limit;
  final EmailSearchFilter? filter;

  const EmailsParams({
    this.folderId,
    this.page = 1,
    this.limit = 50,
    this.filter,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is EmailsParams &&
        other.folderId == folderId &&
        other.page == page &&
        other.limit == limit &&
        other.filter == filter;
  }

  @override
  int get hashCode => Object.hash(folderId, page, limit, filter);
}

class ContactsParams {
  final String? query;
  final String? groupId;
  final int page;
  final int limit;

  const ContactsParams({
    this.query,
    this.groupId,
    this.page = 1,
    this.limit = 50,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ContactsParams &&
        other.query == query &&
        other.groupId == groupId &&
        other.page == page &&
        other.limit == limit;
  }

  @override
  int get hashCode => Object.hash(query, groupId, page, limit);
}

class TemplatesParams {
  final TemplateType? type;
  final String? query;
  final int page;
  final int limit;

  const TemplatesParams({
    this.type,
    this.query,
    this.page = 1,
    this.limit = 50,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is TemplatesParams &&
        other.type == type &&
        other.query == query &&
        other.page == page &&
        other.limit == limit;
  }

  @override
  int get hashCode => Object.hash(type, query, page, limit);
}

// State classes
@immutable
class EmailNavigationState {
  final String? currentFolderId;
  final String? currentEmailId;
  final String? currentThreadId;
  final bool showSidebar;

  const EmailNavigationState({
    this.currentFolderId,
    this.currentEmailId,
    this.currentThreadId,
    this.showSidebar = true,
  });

  EmailNavigationState copyWith({
    String? currentFolderId,
    String? currentEmailId,
    String? currentThreadId,
    bool? showSidebar,
  }) {
    return EmailNavigationState(
      currentFolderId: currentFolderId ?? this.currentFolderId,
      currentEmailId: currentEmailId ?? this.currentEmailId,
      currentThreadId: currentThreadId ?? this.currentThreadId,
      showSidebar: showSidebar ?? this.showSidebar,
    );
  }
}

@immutable
class EmailSort {
  final EmailSortField field;
  final bool ascending;

  const EmailSort({
    this.field = EmailSortField.date,
    this.ascending = false,
  });

  EmailSort copyWith({
    EmailSortField? field,
    bool? ascending,
  }) {
    return EmailSort(
      field: field ?? this.field,
      ascending: ascending ?? this.ascending,
    );
  }
}

enum EmailViewMode {
  list,
  thread,
  compose,
  settings,
  contacts,
  templates,
}

enum EmailSortField {
  date,
  sender,
  subject,
  size,
  importance,
}

// Action classes
class EmailActions {
  final EmailService emailService;
  final StateController<Set<String>> selectedEmailsNotifier;
  final Ref ref;

  EmailActions({
    required this.emailService,
    required this.selectedEmailsNotifier,
    required this.ref,
  });

  Future<void> markAsRead(String emailId, {bool read = true}) async {
    await emailService.markAsRead(emailId, read: read);
    _refreshEmails();
  }

  Future<void> markAsStarred(String emailId, {bool starred = true}) async {
    await emailService.markAsStarred(emailId, starred: starred);
    _refreshEmails();
  }

  Future<void> markAsImportant(String emailId, {bool important = true}) async {
    await emailService.markAsImportant(emailId, important: important);
    _refreshEmails();
  }

  Future<void> moveToFolder(String emailId, String folderId) async {
    await emailService.moveToFolder(emailId, folderId);
    _refreshEmails();
  }

  Future<void> deleteEmail(String emailId) async {
    await emailService.deleteEmail(emailId);
    _refreshEmails();
  }

  Future<void> addLabel(String emailId, String labelId) async {
    await emailService.addLabel(emailId, labelId);
    _refreshEmails();
  }

  Future<void> removeLabel(String emailId, String labelId) async {
    await emailService.removeLabel(emailId, labelId);
    _refreshEmails();
  }

  void selectEmail(String emailId) {
    final current = selectedEmailsNotifier.state;
    selectedEmailsNotifier.state = {...current, emailId};
  }

  void deselectEmail(String emailId) {
    final current = selectedEmailsNotifier.state;
    selectedEmailsNotifier.state = current.where((id) => id != emailId).toSet();
  }

  void selectAllEmails(List<String> emailIds) {
    selectedEmailsNotifier.state = emailIds.toSet();
  }

  void clearSelection() {
    selectedEmailsNotifier.state = {};
  }

  void _refreshEmails() {
    ref.invalidate(emailsProvider);
    ref.invalidate(unreadCountProvider);
    ref.invalidate(importantEmailsProvider);
    ref.invalidate(starredEmailsProvider);
  }
}

class ComposeActions {
  final EmailService emailService;
  final StateController<ComposeState?> composeStateNotifier;
  final Ref ref;

  ComposeActions({
    required this.emailService,
    required this.composeStateNotifier,
    required this.ref,
  });

  void newEmail() {
    composeStateNotifier.state = const ComposeState(
      mode: ComposeMode.new_,
    );
  }

  void replyToEmail(Email email) {
    composeStateNotifier.state = ComposeState(
      to: email.sender.email,
      subject: email.subject.startsWith('Re:') ? email.subject : 'Re: ${email.subject}',
      replyToId: email.id,
      mode: ComposeMode.reply,
    );
  }

  void replyAllToEmail(Email email) {
    final allRecipients = [
      email.sender,
      ...email.recipients,
      ...email.ccRecipients,
    ].where((contact) => contact.email != _getCurrentUserEmail()).toList();

    composeStateNotifier.state = ComposeState(
      to: allRecipients.map((c) => c.email).join(', '),
      subject: email.subject.startsWith('Re:') ? email.subject : 'Re: ${email.subject}',
      replyToId: email.id,
      mode: ComposeMode.replyAll,
    );
  }

  void forwardEmail(Email email) {
    composeStateNotifier.state = ComposeState(
      subject: email.subject.startsWith('Fwd:') ? email.subject : 'Fwd: ${email.subject}',
      body: _createForwardBody(email),
      attachments: email.attachments,
      forwardFromId: email.id,
      mode: ComposeMode.forward,
    );
  }

  void updateCompose(ComposeState newState) {
    composeStateNotifier.state = newState;
  }

  Future<void> saveDraft() async {
    final state = composeStateNotifier.state;
    if (state == null) return;

    if (state.isDraft == true && state.replyToId != null) {
      await emailService.updateDraft(state.replyToId!, state);
    } else {
      await emailService.saveDraft(state);
    }
  }

  Future<Email> sendEmail() async {
    final state = composeStateNotifier.state;
    if (state == null) throw Exception('No compose state');

    final email = await emailService.sendEmail(state);
    composeStateNotifier.state = null;
    ref.invalidate(emailsProvider);
    return email;
  }

  Future<Email> scheduleEmail(DateTime scheduledAt) async {
    final state = composeStateNotifier.state;
    if (state == null) throw Exception('No compose state');

    final email = await emailService.scheduleEmail(state, scheduledAt);
    composeStateNotifier.state = null;
    ref.invalidate(emailsProvider);
    return email;
  }

  void clearCompose() {
    composeStateNotifier.state = null;
  }

  String _getCurrentUserEmail() {
    // This should be retrieved from user preferences or settings
    return 'user@example.com';
  }

  String _createForwardBody(Email email) {
    return '''
---------- Forwarded message ---------
From: ${email.sender.displayName} <${email.sender.email}>
Date: ${email.timestamp}
Subject: ${email.subject}
To: ${email.recipients.map((c) => '${c.displayName} <${c.email}>').join(', ')}

${email.body}
''';
  }
}

class BulkOperations {
  final EmailService emailService;
  final Set<String> selectedEmailIds;
  final Ref ref;

  BulkOperations({
    required this.emailService,
    required this.selectedEmailIds,
    required this.ref,
  });

  Future<void> markAllAsRead({bool read = true}) async {
    for (final emailId in selectedEmailIds) {
      await emailService.markAsRead(emailId, read: read);
    }
    _refreshEmails();
  }

  Future<void> markAllAsStarred({bool starred = true}) async {
    for (final emailId in selectedEmailIds) {
      await emailService.markAsStarred(emailId, starred: starred);
    }
    _refreshEmails();
  }

  Future<void> markAllAsImportant({bool important = true}) async {
    for (final emailId in selectedEmailIds) {
      await emailService.markAsImportant(emailId, important: important);
    }
    _refreshEmails();
  }

  Future<void> moveAllToFolder(String folderId) async {
    for (final emailId in selectedEmailIds) {
      await emailService.moveToFolder(emailId, folderId);
    }
    _refreshEmails();
  }

  Future<void> deleteAll() async {
    await emailService.deleteEmails(selectedEmailIds.toList());
    _refreshEmails();
  }

  Future<void> addLabelToAll(String labelId) async {
    for (final emailId in selectedEmailIds) {
      await emailService.addLabel(emailId, labelId);
    }
    _refreshEmails();
  }

  Future<void> removeLabelFromAll(String labelId) async {
    for (final emailId in selectedEmailIds) {
      await emailService.removeLabel(emailId, labelId);
    }
    _refreshEmails();
  }

  void _refreshEmails() {
    ref.invalidate(emailsProvider);
    ref.invalidate(unreadCountProvider);
    ref.invalidate(importantEmailsProvider);
    ref.invalidate(starredEmailsProvider);
    
    // Clear selection after bulk operation
    ref.read(selectedEmailsProvider.notifier).state = {};
  }
}