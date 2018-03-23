if (Rails.env == 'development')
  ActiveSupport::Dependencies.autoload_once_paths.reject!{|x| x =~ /^#{Regexp.escape(File.dirname(__FILE__))}/}
end

IssueQuery.send(:include, SendNotification::IssueQueryPatch)
Issue.send(:include, SendNotification::IssuePatch)

require_dependency 'send_notification/send_hooks'

Redmine::Plugin.register :send_notification do
  name 'Send Notification plugin'
  author 'Sergey Vershinin'
  description 'This is a plugin for Redmine'
  version '0.0.2'
  url 'http://example.com/path/to/plugin'
  author_url 'https://github.com/Yarroo'
  requires_redmine version_or_higher: '3.4'

  settings partial: 'settings/send_notification',
           default: { ldap_use: 0 }
end

