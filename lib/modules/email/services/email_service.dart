import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:http_parser/http_parser.dart' as http_parser;
import '../../../core/services/api_service.dart';
import '../models/email_models.dart';

class EmailService {
  final ApiService _apiService;
  
  EmailService(this._apiService);

  // Email CRUD Operations
  Future<List<Email>> getEmails({
    String? folderId,
    int page = 1,
    int limit = 50,
    EmailSearchFilter? filter,
  }) async {
    try {
      final response = await _apiService.get(
        path: '/api/email/emails',
        queryParameters: {
          if (folderId != null) 'folder': folderId,
          'page': page,
          'limit': limit,
          if (filter != null) ...filter.toJson(),
        },
      );
      
      final List<dynamic> emailsJson = response.data['emails'];
      return emailsJson.map((json) => Email.fromJson(json)).toList();
    } catch (e) {
      debugPrint('Error fetching emails: $e');
      rethrow;
    }
  }

  Future<Email> getEmail(String emailId) async {
    try {
      final response = await _apiService.get(path: '/api/email/emails/$emailId');
      return Email.fromJson(response.data);
    } catch (e) {
      debugPrint('Error fetching email: $e');
      rethrow;
    }
  }

  Future<EmailThread> getEmailThread(String threadId) async {
    try {
      final response = await _apiService.get(path: '/api/email/threads/$threadId');
      return EmailThread.fromJson(response.data);
    } catch (e) {
      debugPrint('Error fetching thread: $e');
      rethrow;
    }
  }

  Future<Email> sendEmail(ComposeState composeState) async {
    try {
      final response = await _apiService.post(
        path: '/api/email/send',
        data: composeState.toJson(),
      );
      return Email.fromJson(response.data);
    } catch (e) {
      debugPrint('Error sending email: $e');
      rethrow;
    }
  }

  Future<Email> saveDraft(ComposeState composeState) async {
    try {
      final response = await _apiService.post(
        path: '/api/email/drafts',
        data: composeState.toJson(),
      );
      return Email.fromJson(response.data);
    } catch (e) {
      debugPrint('Error saving draft: $e');
      rethrow;
    }
  }

  Future<Email> updateDraft(String draftId, ComposeState composeState) async {
    try {
      final response = await _apiService.put(
        path: '/api/email/drafts/$draftId',
        data: composeState.toJson(),
      );
      return Email.fromJson(response.data);
    } catch (e) {
      debugPrint('Error updating draft: $e');
      rethrow;
    }
  }

  Future<Email> scheduleEmail(ComposeState composeState, DateTime scheduledAt) async {
    try {
      final data = composeState.toJson();
      data['scheduledAt'] = scheduledAt.toIso8601String();
      
      final response = await _apiService.post(
        path: '/api/email/schedule',
        data: data,
      );
      return Email.fromJson(response.data);
    } catch (e) {
      debugPrint('Error scheduling email: $e');
      rethrow;
    }
  }

  Future<void> deleteEmail(String emailId) async {
    try {
      await _apiService.delete(path: '/api/email/emails/$emailId');
    } catch (e) {
      debugPrint('Error deleting email: $e');
      rethrow;
    }
  }

  Future<void> deleteEmails(List<String> emailIds) async {
    try {
      await _apiService.delete(
        path: '/api/email/emails/bulk',
        data: {'emailIds': emailIds},
      );
    } catch (e) {
      debugPrint('Error bulk deleting emails: $e');
      rethrow;
    }
  }

  // Email Actions
  Future<void> markAsRead(String emailId, {bool read = true}) async {
    try {
      await _apiService.patch(
        path: '/api/email/emails/$emailId/read',
        data: {'read': read},
      );
    } catch (e) {
      debugPrint('Error marking email as read: $e');
      rethrow;
    }
  }

  Future<void> markAsStarred(String emailId, {bool starred = true}) async {
    try {
      await _apiService.patch(
        path: '/api/email/emails/$emailId/star',
        data: {'starred': starred},
      );
    } catch (e) {
      debugPrint('Error starring email: $e');
      rethrow;
    }
  }

  Future<void> markAsImportant(String emailId, {bool important = true}) async {
    try {
      await _apiService.patch(
        path: '/api/email/emails/$emailId/important',
        data: {'important': important},
      );
    } catch (e) {
      debugPrint('Error marking email as important: $e');
      rethrow;
    }
  }

  Future<void> moveToFolder(String emailId, String folderId) async {
    try {
      await _apiService.patch(
        path: '/api/email/emails/$emailId/folder',
        data: {'folderId': folderId},
      );
    } catch (e) {
      debugPrint('Error moving email to folder: $e');
      rethrow;
    }
  }

  Future<void> addLabel(String emailId, String labelId) async {
    try {
      await _apiService.post(
        path: '/api/email/emails/$emailId/labels',
        data: {'labelId': labelId},
      );
    } catch (e) {
      debugPrint('Error adding label to email: $e');
      rethrow;
    }
  }

  Future<void> removeLabel(String emailId, String labelId) async {
    try {
      await _apiService.delete(path: '/api/email/emails/$emailId/labels/$labelId');
    } catch (e) {
      debugPrint('Error removing label from email: $e');
      rethrow;
    }
  }

  // Folders Management
  Future<List<EmailFolder>> getFolders() async {
    try {
      final response = await _apiService.get(path: '/api/email/folders');
      final List<dynamic> foldersJson = response.data['folders'];
      return foldersJson.map((json) => EmailFolder.fromJson(json)).toList();
    } catch (e) {
      debugPrint('Error fetching folders: $e');
      rethrow;
    }
  }

  Future<EmailFolder> createFolder(String name, {String? parentId}) async {
    try {
      final response = await _apiService.post(
        path: '/api/email/folders',
        data: {
          'name': name,
          if (parentId != null) 'parentId': parentId,
        },
      );
      return EmailFolder.fromJson(response.data);
    } catch (e) {
      debugPrint('Error creating folder: $e');
      rethrow;
    }
  }

  Future<EmailFolder> updateFolder(String folderId, String name) async {
    try {
      final response = await _apiService.put(
        path: '/api/email/folders/$folderId',
        data: {'name': name},
      );
      return EmailFolder.fromJson(response.data);
    } catch (e) {
      debugPrint('Error updating folder: $e');
      rethrow;
    }
  }

  Future<void> deleteFolder(String folderId) async {
    try {
      await _apiService.delete(path: '/api/email/folders/$folderId');
    } catch (e) {
      debugPrint('Error deleting folder: $e');
      rethrow;
    }
  }

  // Labels Management
  Future<List<EmailLabel>> getLabels() async {
    try {
      final response = await _apiService.get(path: '/api/email/labels');
      final List<dynamic> labelsJson = response.data['labels'];
      return labelsJson.map((json) => EmailLabel.fromJson(json)).toList();
    } catch (e) {
      debugPrint('Error fetching labels: $e');
      rethrow;
    }
  }

  Future<EmailLabel> createLabel(String name, String colorHex) async {
    try {
      final response = await _apiService.post(
        path: '/api/email/labels',
        data: {
          'name': name,
          'color': colorHex,
        },
      );
      return EmailLabel.fromJson(response.data);
    } catch (e) {
      debugPrint('Error creating label: $e');
      rethrow;
    }
  }

  Future<EmailLabel> updateLabel(String labelId, String name, String colorHex) async {
    try {
      final response = await _apiService.put(
        path: '/api/email/labels/$labelId',
        data: {
          'name': name,
          'color': colorHex,
        },
      );
      return EmailLabel.fromJson(response.data);
    } catch (e) {
      debugPrint('Error updating label: $e');
      rethrow;
    }
  }

  Future<void> deleteLabel(String labelId) async {
    try {
      await _apiService.delete(path: '/api/email/labels/$labelId');
    } catch (e) {
      debugPrint('Error deleting label: $e');
      rethrow;
    }
  }

  // Contacts Management
  Future<List<Contact>> getContacts({
    String? query,
    String? groupId,
    int page = 1,
    int limit = 50,
  }) async {
    try {
      final response = await _apiService.get(
        path: '/api/email/contacts',
        queryParameters: {
          if (query != null) 'query': query,
          if (groupId != null) 'groupId': groupId,
          'page': page,
          'limit': limit,
        },
      );
      
      final List<dynamic> contactsJson = response.data['contacts'];
      return contactsJson.map((json) => Contact.fromJson(json)).toList();
    } catch (e) {
      debugPrint('Error fetching contacts: $e');
      rethrow;
    }
  }

  Future<Contact> getContact(String contactId) async {
    try {
      final response = await _apiService.get(path: '/api/email/contacts/$contactId');
      return Contact.fromJson(response.data);
    } catch (e) {
      debugPrint('Error fetching contact: $e');
      rethrow;
    }
  }

  Future<Contact> createContact(Contact contact) async {
    try {
      final response = await _apiService.post(
        path: '/api/email/contacts',
        data: contact.toJson(),
      );
      return Contact.fromJson(response.data);
    } catch (e) {
      debugPrint('Error creating contact: $e');
      rethrow;
    }
  }

  Future<Contact> updateContact(String contactId, Contact contact) async {
    try {
      final response = await _apiService.put(
        path: '/api/email/contacts/$contactId',
        data: contact.toJson(),
      );
      return Contact.fromJson(response.data);
    } catch (e) {
      debugPrint('Error updating contact: $e');
      rethrow;
    }
  }

  Future<void> deleteContact(String contactId) async {
    try {
      await _apiService.delete(path: '/api/email/contacts/$contactId');
    } catch (e) {
      debugPrint('Error deleting contact: $e');
      rethrow;
    }
  }

  // Templates Management
  Future<List<EmailTemplate>> getTemplates({
    TemplateType? type,
    String? query,
    int page = 1,
    int limit = 50,
  }) async {
    try {
      final response = await _apiService.get(
        path: '/api/email/templates',
        queryParameters: {
          if (type != null) 'type': type.name,
          if (query != null) 'query': query,
          'page': page,
          'limit': limit,
        },
      );
      
      final List<dynamic> templatesJson = response.data['templates'];
      return templatesJson.map((json) => EmailTemplate.fromJson(json)).toList();
    } catch (e) {
      debugPrint('Error fetching templates: $e');
      rethrow;
    }
  }

  Future<EmailTemplate> createTemplate(EmailTemplate template) async {
    try {
      final response = await _apiService.post(
        path: '/api/email/templates',
        data: template.toJson(),
      );
      return EmailTemplate.fromJson(response.data);
    } catch (e) {
      debugPrint('Error creating template: $e');
      rethrow;
    }
  }

  Future<EmailTemplate> updateTemplate(String templateId, EmailTemplate template) async {
    try {
      final response = await _apiService.put(
        path: '/api/email/templates/$templateId',
        data: template.toJson(),
      );
      return EmailTemplate.fromJson(response.data);
    } catch (e) {
      debugPrint('Error updating template: $e');
      rethrow;
    }
  }

  Future<void> deleteTemplate(String templateId) async {
    try {
      await _apiService.delete(path: '/api/email/templates/$templateId');
    } catch (e) {
      debugPrint('Error deleting template: $e');
      rethrow;
    }
  }

  // Rules Management
  Future<List<EmailRule>> getRules() async {
    try {
      final response = await _apiService.get(path: '/api/email/rules');
      final List<dynamic> rulesJson = response.data['rules'];
      return rulesJson.map((json) => EmailRule.fromJson(json)).toList();
    } catch (e) {
      debugPrint('Error fetching rules: $e');
      rethrow;
    }
  }

  Future<EmailRule> createRule(EmailRule rule) async {
    try {
      final response = await _apiService.post(
        path: '/api/email/rules',
        data: rule.toJson(),
      );
      return EmailRule.fromJson(response.data);
    } catch (e) {
      debugPrint('Error creating rule: $e');
      rethrow;
    }
  }

  Future<EmailRule> updateRule(String ruleId, EmailRule rule) async {
    try {
      final response = await _apiService.put(
        path: '/api/email/rules/$ruleId',
        data: rule.toJson(),
      );
      return EmailRule.fromJson(response.data);
    } catch (e) {
      debugPrint('Error updating rule: $e');
      rethrow;
    }
  }

  Future<void> deleteRule(String ruleId) async {
    try {
      await _apiService.delete(path: '/api/email/rules/$ruleId');
    } catch (e) {
      debugPrint('Error deleting rule: $e');
      rethrow;
    }
  }

  // Attachments
  Future<Attachment> uploadAttachment(
    String fileName,
    String mimeType,
    Uint8List fileBytes,
    {Function(double)? onProgress}
  ) async {
    try {
      final formData = FormData.fromMap({
        'file': MultipartFile.fromBytes(
          fileBytes,
          filename: fileName,
          contentType: http_parser.MediaType.parse(mimeType),
        ),
      });

      final response = await _apiService.post(
        path: '/api/email/attachments',
        data: formData,
      );

      return Attachment.fromJson(response.data);
    } catch (e) {
      debugPrint('Error uploading attachment: $e');
      rethrow;
    }
  }

  Future<Uint8List> downloadAttachment(String attachmentId) async {
    try {
      final response = await _apiService.get(
        path: '/api/email/attachments/$attachmentId/download',
        options: Options(responseType: ResponseType.bytes),
      );
      return response.data;
    } catch (e) {
      debugPrint('Error downloading attachment: $e');
      rethrow;
    }
  }

  Future<void> deleteAttachment(String attachmentId) async {
    try {
      await _apiService.delete(path: '/api/email/attachments/$attachmentId');
    } catch (e) {
      debugPrint('Error deleting attachment: $e');
      rethrow;
    }
  }

  // Search
  Future<List<Email>> searchEmails(EmailSearchFilter filter) async {
    try {
      final response = await _apiService.post(
        path: '/api/email/search',
        data: filter.toJson(),
      );
      
      final List<dynamic> emailsJson = response.data['emails'];
      return emailsJson.map((json) => Email.fromJson(json)).toList();
    } catch (e) {
      debugPrint('Error searching emails: $e');
      rethrow;
    }
  }

  Future<List<Contact>> searchContacts(String query) async {
    try {
      final response = await _apiService.get(
        path: '/api/email/contacts/search',
        queryParameters: {'query': query},
      );
      
      final List<dynamic> contactsJson = response.data['contacts'];
      return contactsJson.map((json) => Contact.fromJson(json)).toList();
    } catch (e) {
      debugPrint('Error searching contacts: $e');
      rethrow;
    }
  }

  // Settings
  Future<EmailSettings> getSettings() async {
    try {
      final response = await _apiService.get(path: '/api/email/settings');
      return EmailSettings.fromJson(response.data);
    } catch (e) {
      debugPrint('Error fetching settings: $e');
      rethrow;
    }
  }

  Future<EmailSettings> updateSettings(EmailSettings settings) async {
    try {
      final response = await _apiService.put(
        path: '/api/email/settings',
        data: settings.toJson(),
      );
      return EmailSettings.fromJson(response.data);
    } catch (e) {
      debugPrint('Error updating settings: $e');
      rethrow;
    }
  }

  // Utility methods
  Future<List<Email>> getUnreadEmails() async {
    return getEmails(
      filter: const EmailSearchFilter(isUnread: true),
    );
  }

  Future<List<Email>> getStarredEmails() async {
    return getEmails(
      filter: const EmailSearchFilter(isStarred: true),
    );
  }

  Future<List<Email>> getImportantEmails() async {
    return getEmails(
      filter: const EmailSearchFilter(isImportant: true),
    );
  }

  Future<List<Email>> getEmailsWithAttachments() async {
    return getEmails(
      filter: const EmailSearchFilter(hasAttachments: true),
    );
  }

  Future<void> markAllAsRead(String folderId) async {
    try {
      await _apiService.patch(
        path: '/api/email/folders/$folderId/mark-all-read',
      );
    } catch (e) {
      debugPrint('Error marking all as read: $e');
      rethrow;
    }
  }

  Future<void> emptyTrash() async {
    try {
      await _apiService.delete(path: '/api/email/trash');
    } catch (e) {
      debugPrint('Error emptying trash: $e');
      rethrow;
    }
  }

  Future<void> emptySpam() async {
    try {
      await _apiService.delete(path: '/api/email/spam');
    } catch (e) {
      debugPrint('Error emptying spam: $e');
      rethrow;
    }
  }
}