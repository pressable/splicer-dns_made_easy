module Splicer
  module DnsMadeEasy

    class Time < ::Time
      DAYS = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat']
      MONTHS = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec']

      def to_date_header
        self.utc.strftime("#{DAYS[self.utc.wday]}, %d #{MONTHS[self.utc.month - 1]} %Y %H:%M:%S GMT")
      end
    end

  end
end
