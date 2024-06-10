module ApplicationHelper
    def float_to_percentage(float_value)
        percentage = (float_value * 100).round
        "#{percentage}%"
    end
end
