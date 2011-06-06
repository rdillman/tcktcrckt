Gem::Specification.new do |s|
  s.name              = 'chronic'
  s.version           = '0.4.1'
  s.rubyforge_project = 'chronic'

  s.summary     = "Natural language date/time parsing."
  s.description = "Chronic is a natural language date/time parser written in pure Ruby."

  s.authors  = ["Tom Preston-Werner", "Lee Jarvis"]
  s.email    = ['tom@mojombo.com', 'lee@jarvis.co']
  s.homepage = 'http://github.com/mojombo/chronic'

  s.rdoc_options = ["--charset=UTF-8"]
  s.extra_rdoc_files = %w[README.md HISTORY.md LICENSE]

  # = MANIFEST =
  s.files = %w[
    HISTORY.md
    LICENSE
    Manifest.txt
    README.md
    Rakefile
    benchmark/benchmark.rb
    chronic.gemspec
    lib/chronic.rb
    lib/chronic/chronic.rb
    lib/chronic/grabber.rb
    lib/chronic/handlers.rb
    lib/chronic/mini_date.rb
    lib/chronic/numerizer.rb
    lib/chronic/ordinal.rb
    lib/chronic/pointer.rb
    lib/chronic/repeater.rb
    lib/chronic/repeaters/repeater_day.rb
    lib/chronic/repeaters/repeater_day_name.rb
    lib/chronic/repeaters/repeater_day_portion.rb
    lib/chronic/repeaters/repeater_fortnight.rb
    lib/chronic/repeaters/repeater_hour.rb
    lib/chronic/repeaters/repeater_minute.rb
    lib/chronic/repeaters/repeater_month.rb
    lib/chronic/repeaters/repeater_month_name.rb
    lib/chronic/repeaters/repeater_season.rb
    lib/chronic/repeaters/repeater_season_name.rb
    lib/chronic/repeaters/repeater_second.rb
    lib/chronic/repeaters/repeater_time.rb
    lib/chronic/repeaters/repeater_week.rb
    lib/chronic/repeaters/repeater_weekday.rb
    lib/chronic/repeaters/repeater_weekend.rb
    lib/chronic/repeaters/repeater_year.rb
    lib/chronic/scalar.rb
    lib/chronic/separator.rb
    lib/chronic/span.rb
    lib/chronic/tag.rb
    lib/chronic/time_zone.rb
    lib/chronic/token.rb
    test/helper.rb
    test/test_Chronic.rb
    test/test_DaylightSavings.rb
    test/test_Handler.rb
    test/test_MiniDate.rb
    test/test_Numerizer.rb
    test/test_RepeaterDayName.rb
    test/test_RepeaterFortnight.rb
    test/test_RepeaterHour.rb
    test/test_RepeaterMinute.rb
    test/test_RepeaterMonth.rb
    test/test_RepeaterMonthName.rb
    test/test_RepeaterTime.rb
    test/test_RepeaterWeek.rb
    test/test_RepeaterWeekday.rb
    test/test_RepeaterWeekend.rb
    test/test_RepeaterYear.rb
    test/test_Span.rb
    test/test_Time.rb
    test/test_Token.rb
    test/test_parsing.rb
  ]
  # = MANIFEST =

  ## Test files will be grabbed from the file list. Make sure the path glob
  ## matches what you actually use.
  s.test_files = s.files.select { |path| path =~ /^test\/test_.*\.rb/ }
end
