class ApplicationMailbox < ActionMailbox::Base
  # routing /something/i => :somewhere
  routing /\Acomment\+[0-9]+/i => :comment
end
