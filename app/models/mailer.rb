require 'dedent'

module Brisk
  module Models
    module Mailer extend self
      def user_invite!(invite)
        Mail.deliver do
          from    'Biotech Pulse <pulse@harlembiospace.com>'
          to      invite.email
          subject "An invitation to join Monocle from #{invite.user_name}."
          body    <<-EOF.dedent
            Hi there,

            #{invite.user_name} has invited you to join Biotech Pulse, a site dedicated to realtime sharing and discussion of articles, events, and resources of interest to biotech entrepreurs.

            To learn more, and claim your invitation, visit:

            thttp://example.com/claim/#{invite.code}

            Regards,
            
            Harlem Biospace Team

        end
      end

      def create_and_deliver_password_change!(user, password)
        Mail.deliver do
          from    'Monocle <alex@example.com>'
          to      user.email
          subject 'Reset your password'
          body    <<-EOF.dedent
            Hi there,

            A password change was requested on your behalf. You can login with the password below.

            New Password: #{password}

            Please change the password after logging in.

            Thanks,
            Admin
          EOF
        end
      end

      def user_activate!(user)
        Mail.deliver do
          from    'Monocle <alex@example.com>'
          to      user.email
          subject 'Welcome to Monocle!'
          body    <<-EOF.dedent
            Hi there,

            Good news! #{user.parent_name || 'Admin'} has activated your Biotech Pulse account.

            Thanks,
            Admin
          EOF
        end
      end

      def feedback!(text, email = nil)
        Mail.deliver do
          from    'Biotech Pulse <director@harlembiospace.com>'
          to      'alex@example.com'
          subject 'Monocle Feedback'
          reply_to email if email.present?
          body     text

          charset = 'UTF-8'
          content_transfer_encoding = '8bit'
        end
      end
    end
  end
end