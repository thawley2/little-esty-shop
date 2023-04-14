module FormatHelper
  def format_date
    created_at.strftime("%A, %B %d, %Y")
  end
end
