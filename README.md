## redmine-plugin-send_notification
This is [Redmine](https://www.redmine.org) plugin. Plugin adds the recipient email field to the issue form and allows you to send notifications about changes in the issue status to the addresses specified in this field. E-mail addresses can be separated by characters ",", ":", ";" or space. Emails are sent if the issue is confirmed, the issue is completed, or the start date or due date has changed during the issue execution. Add ldap support/

## Installation
1. Create directory your_redmine_base/plugins/send_notification.
2. Copy the content of this repository to the created directory. If you are cloning from this repository, please make sure to rename the root folder from "redmine-plugin-send_notification" to "send_notification" to match the described folder structure above.
3. Plugin requires a migration, run the following command in your_redmine_base directory to upgrade your database (make a db backup before):
    ```ruby
        bundle exec rake redmine:plugins:migrate RAILS_ENV=production
    ```

4. Restart Redmine.
5. The send_notification plugin needs to know which issue status is considered as "confirmed", "complited", "in progress" and "suspended"(own status which means that performance on the issue is suspended, but still execute) in your redmine installation. This behaviour must be configured in your redmine installation: Administration --> Plugins --> Send notification plugin --> Configure.

## Developer
[Vershinin Sergey](https://github.com/Yarroo)