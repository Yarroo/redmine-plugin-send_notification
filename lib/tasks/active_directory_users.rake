require 'net/ldap'

namespace :redmine do
  task active_directory_users: :environment do
    ldap = Net::LDAP.new host: Setting.plugin_send_notification['ldap_host'].strip,
                         port: Setting.plugin_send_notification['ldap_port'].strip,
                         base: Setting.plugin_send_notification['ldap_basedn'].strip,
                         :auth => {
                             method:  :simple,
                             username: Setting.plugin_send_notification['ldap_account'].strip,
                             password: Setting.plugin_send_notification['ldap_password'].strip
                         }


    result_attrs = %w[employeeNumber sAMAccountName displayName mail department]
    search_filter = Net::LDAP::Filter.construct(Setting.plugin_send_notification['ldap_filter'])
    users = []
    ldap.search(filter: search_filter, attributes: result_attrs) do |item|
      user = { user_id: item.employeeNumber.first,
               sam_account_name: item.sAMAccountName.first,
               display_name: item.displayName.first.to_s.force_encoding('UTF-8'),
               mail: item.mail.first,
               department: item.department.first.to_s.force_encoding('UTF-8') }
      users << user
    end

    users.each do |user|
      ActiveDirectoryUser.create(user)
    end

  end
end