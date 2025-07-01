// Email Module - Complete Email Client Implementation
//
// This module provides a comprehensive email client with the following features:
// - Email composition with rich text editor and attachments
// - Email viewing with thread support
// - Contact management with groups and search
// - Email templates for quick composition
// - Advanced email rules and filters
// - Comprehensive settings and security options
// - Responsive design for mobile and desktop

// Main Email Page
export 'email_page.dart';

// Models
export 'models/email_models.dart';

// Services
export 'services/email_service.dart';

// Providers
export 'providers/email_providers.dart';

// Views
export 'views/inbox_view.dart';
export 'views/compose_view.dart';
export 'views/email_detail_view.dart';
export 'views/contacts_view.dart';
export 'views/email_settings_view.dart';
export 'views/templates_view.dart';

// Widgets
export 'widgets/email_list_item.dart';
export 'widgets/email_composer.dart';
export 'widgets/email_viewer.dart';
export 'widgets/attachment_widget.dart';
export 'widgets/contact_card.dart';

import 'package:flutter/material.dart';

// Email Module Features Summary:
//
// 📧 EMAIL MANAGEMENT
// - Inbox view with categories (inbox, sent, drafts, spam, trash)
// - Email threading and conversation view
// - Smart folders (starred, important, attachments, unread)
// - Advanced search and filtering
// - Bulk operations (mark as read, archive, delete, etc.)
// - Email labels and organization
//
// ✍️ EMAIL COMPOSITION
// - Rich text editor with formatting options
// - File and image attachments with upload progress
// - Email scheduling and draft auto-save
// - Email templates for quick composition
// - Reply, reply-all, and forward functionality
// - Email priority and read receipt settings
//
// 👥 CONTACT MANAGEMENT
// - Complete address book with contact cards
// - Contact groups and categorization
// - Contact search and filtering
// - Contact import/export capabilities
// - Integration with email composition
//
// 📋 EMAIL TEMPLATES
// - Template creation and management
// - Template categories (personal, business, marketing, support)
// - Template preview and usage tracking
// - Template sharing and duplication
//
// ⚙️ ADVANCED FEATURES
// - Email rules and filters for automation
// - Security settings and spam protection
// - Notification preferences
// - Two-factor authentication support
// - Storage management and quotas
//
// 📱 RESPONSIVE DESIGN
// - Mobile-optimized layouts
// - Adaptive navigation (sidebar/drawer)
// - Touch-friendly interactions
// - Cross-platform compatibility
//
// 🔒 SECURITY & PRIVACY
// - Email encryption support
// - Phishing protection
// - Blocked senders management
// - External image blocking
// - Sender authentication

/// Email module configuration and constants
class EmailModuleConfig {
  static const String moduleName = 'Email';
  static const String moduleVersion = '1.0.0';
  static const String moduleDescription = 'Complete email client with rich features';
  
  // Default settings
  static const int defaultRefreshInterval = 5; // minutes
  static const int defaultPreviewLines = 3;
  static const bool defaultShowPreview = true;
  static const bool defaultMarkAsReadOnPreview = false;
  
  // Limits
  static const int maxAttachmentSize = 25 * 1024 * 1024; // 25MB
  static const int maxAttachmentsPerEmail = 10;
  static const int maxEmailsPerPage = 50;
  static const int maxContactsPerPage = 50;
  static const int maxTemplatesPerPage = 50;
  
  // File types
  static const List<String> supportedImageTypes = [
    'image/jpeg',
    'image/png',
    'image/gif',
    'image/webp',
  ];
  
  static const List<String> supportedDocumentTypes = [
    'application/pdf',
    'application/msword',
    'application/vnd.openxmlformats-officedocument.wordprocessingml.document',
    'application/vnd.ms-excel',
    'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet',
    'text/plain',
    'text/csv',
  ];
}

/// Email module utilities and helpers
class EmailModuleUtils {
  /// Validates email address format
  static bool isValidEmail(String email) {
    return RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
        .hasMatch(email);
  }
  
  /// Formats file size for display
  static String formatFileSize(int bytes) {
    if (bytes < 1024) return '${bytes}B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)}KB';
    if (bytes < 1024 * 1024 * 1024) {
      return '${(bytes / (1024 * 1024)).toStringAsFixed(1)}MB';
    }
    return '${(bytes / (1024 * 1024 * 1024)).toStringAsFixed(1)}GB';
  }
  
  /// Extracts domain from email address
  static String getDomain(String email) {
    final parts = email.split('@');
    return parts.length > 1 ? parts.last : '';
  }
  
  /// Generates initials from name
  static String getInitials(String name) {
    if (name.isEmpty) return '';
    final parts = name.split(' ');
    if (parts.length == 1) return name[0].toUpperCase();
    return '${parts.first[0]}${parts.last[0]}'.toUpperCase();
  }
  
  /// Validates attachment file type
  static bool isValidAttachmentType(String mimeType) {
    return EmailModuleConfig.supportedImageTypes.contains(mimeType) ||
           EmailModuleConfig.supportedDocumentTypes.contains(mimeType);
  }
  
  /// Checks if file size is within limits
  static bool isValidAttachmentSize(int bytes) {
    return bytes <= EmailModuleConfig.maxAttachmentSize;
  }
}

/// Email module constants
class EmailConstants {
  // Folder IDs
  static const String inboxFolderId = 'inbox';
  static const String sentFolderId = 'sent';
  static const String draftsFolderId = 'drafts';
  static const String trashFolderId = 'trash';
  static const String spamFolderId = 'spam';
  static const String archiveFolderId = 'archive';
  
  // System label IDs
  static const String starredLabelId = 'starred';
  static const String importantLabelId = 'important';
  static const String unreadLabelId = 'unread';
  static const String attachmentsLabelId = 'attachments';
  
  // Default values
  static const String defaultSignature = '''

Best regards,
[Your Name]''';
  
  static const String defaultAutoReplyMessage = '''
Thank you for your email. I am currently out of office and will respond to your message as soon as possible.

Best regards,
[Your Name]''';
}

/// Email module themes and styling
class EmailTheme {
  // Priority colors
  static const Map<String, Color> priorityColors = {
    'low': Color(0xFF4CAF50),      // Green
    'normal': Color(0xFF9E9E9E),   // Grey
    'high': Color(0xFFFF9800),     // Orange
    'urgent': Color(0xFFF44336),   // Red
  };
  
  // Label colors
  static const List<Color> labelColors = [
    Color(0xFF2196F3), // Blue
    Color(0xFF4CAF50), // Green
    Color(0xFFFF9800), // Orange
    Color(0xFFF44336), // Red
    Color(0xFF9C27B0), // Purple
    Color(0xFF00BCD4), // Cyan
    Color(0xFFFFEB3B), // Yellow
    Color(0xFF795548), // Brown
  ];
  
  // Template type colors
  static const Map<String, Color> templateTypeColors = {
    'personal': Color(0xFF2196F3),   // Blue
    'business': Color(0xFF4CAF50),   // Green
    'marketing': Color(0xFFFF9800),  // Orange
    'support': Color(0xFF9C27B0),    // Purple
    'newsletter': Color(0xFFF44336), // Red
  };
}