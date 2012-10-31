module ApplicationHelper
  # Strip all whitespace between the HTML tags in the passed block, and
  # on its start and end.
  #  http://stackoverflow.com/a/6925495
  def spaceless(&block)
    contents = capture(&block)

    # Note that string returned by +capture+ is implicitly HTML-safe,
    # and this mangling does not introduce unsafe changes, so I'm just
    # resetting the flag.
    contents = contents.strip.gsub(/>\s+</, '><').html_safe if Rails.env.production?
    contents
  end
  
end
