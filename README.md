# redmine-plugin-send_notification
## Description
This is [Redmine](https://www.redmine.org) plugin. Plugin adds the recipient email field to the issue form and allows you to send notifications about changes in the issue status to the addresses specified in this field. Emails are sent if the issue is confirmed, the issue is completed, or the start date or due date has changed during the issue execution. Plugin may work with LDAP.

## Installation

1. Plugin with on option "Use LDAP" use jQuery plugin [Select2](https://select2.org/). To add Select2 library you should install plugin [A common libs](http://www.redmine.org/plugins/a_common_libs) or another that add Select2 libary to redmine.       
2. Create directory your_redmine_base/plugins/send_notification.
3. Copy the content of this repository to the created directory. If you are cloning from this repository, please make sure to rename the root folder from "redmine-plugin-send_notification" to "send_notification" to match the described folder structure above.
4. Plugin requires a migration, run the following command in your_redmine_base directory to upgrade your database (make a db backup before):
    ```ruby
        bundle exec rake redmine:plugins:migrate RAILS_ENV=production
    ```

5. Restart Redmine.

## Settings

### Global settings

- The send_notification plugin needs to know which issue status is considered as "confirmed", "complited", "in progress" and "suspended"(own status which means that performance on the issue is suspended, but still execute) in your redmine installation. This behaviour must be configured in your redmine installation: Administration --> Plugins --> Send notification plugin --> Configure.
 

### LDAP settings

- To use LDAP you should press check box "Use LDAP" in Administration --> Plugins --> Send notification plugin --> Configure..
- In LDAP settings you should set:  
    - LDAP host(example: ldap-server)
    - port(example: 389)
    - user name with read LDAP right
    - user password
    - BaseDN(CN=Users,DC=company,DC=com)
    - LDAP field name that will be use as unique identifier in database table
    
- You may add some filter to search in LDAP in "ldap filter" field. Search filters enable you to define search criteria and provide more efficient and effective searches. Field supports the LDAP search filters as defined in RFC2254. Syntax and example you may look [Here](https://social.technet.microsoft.com/wiki/contents/articles/5392.active-directory-ldap-syntax-filters.aspx).          
- To load data from LDAP you should run rake task:
    ```ruby
        bundle exec rake redmine:active_directory_users RAILS_ENV=production
    ```
    For synchronization you may set up a Cron job.


## Usage

### Without LDAP

- E-mail addresses can be separated by characters ",", ":", ";" or space. 

### With LDAP

- Just begin enter the name :).


## Developer
[Vershinin Sergey](https://github.com/Yarroo)