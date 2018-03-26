require_dependency 'issue'

module SendNotification
  module IssuePatch


    def self.included(base)
      base.class_eval do

        safe_attributes 'recipient_email'

        after_save :check_before_send_recipient_email

        def check_before_send_recipient_email
          unless recipient_email.blank?
            # Task confirmed
            if issue_status_confirmed?
              TechMailer.send_issue_confirmed(self).deliver_now
            # Task Completed
            elsif issue_status_completed?
              TechMailer.send_issue_completed(self).deliver_now
            # Task due date change
            elsif issue_change_dates?
              TechMailer.send_issue_change(self).deliver_now
            end
          end
        end

        def issue_status_confirmed?
          issue_status_confirmed_id = Setting.plugin_send_notification["issue_status_confirmed_id"].to_i
          notify? && status_id_changed? && status_id == issue_status_confirmed_id
        end

        def issue_status_completed?
          issue_status_completed_id = Setting.plugin_send_notification["issue_status_completed_id"].to_i
          notify? && status_id_changed? && status_id == issue_status_completed_id
        end

        def issue_change_dates?
          issue_status_confirmed_id = Setting.plugin_send_notification["issue_status_confirmed_id"].to_i
          issue_status_in_work_id = Setting.plugin_send_notification["issue_status_in_work_id"].to_i
          issue_status_in_stop_id = Setting.plugin_send_notification["issue_status_in_stop_id"].to_i
          notify? && (start_date_changed? || due_date_changed?) &&
              status_id.in?([issue_status_confirmed_id, issue_status_in_work_id, issue_status_in_stop_id])
        end
      end
    end
  end
end
