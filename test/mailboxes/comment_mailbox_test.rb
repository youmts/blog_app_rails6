# frozen_string_literal: true

require "test_helper"

class CommentMailboxTest < ActionMailbox::TestCase
  # test "receive mail" do
  #   receive_inbound_email_from_mail \
  #     to: '"someone" <someone@example.com>',
  #     from: '"else" <else@example.com>',
  #     subject: "Hello world!",
  #     body: "Hello?"
  # end

  test "register comment from reply" do
    id = Comment.last.id

    assert_difference("Comment.count") do
      receive_inbound_email_from_mail \
        charset: "UTF-8",
        to: "'blog_app' <comment+#{id}@example.com>",
        from: '"someone" <someone@example.com>',
        subject: "Re: notification",
        body: "コメントへの返信です"
    end

    assert_equal "コメントへの返信です", Comment.last.body
  end

  test "don't register comment with not-exists-id" do
    id = Comment.last.id + 1 # not exists

    assert_no_changes( "Comment.count") do
      receive_inbound_email_from_mail \
        charset: "UTF-8",
        to: "'blog_app' <comment+#{id}@example.com>",
        from: '"someone" <someone@example.com>',
        subject: "Re: notification",
        body: "コメントへの返信です"
    end
 end
end
