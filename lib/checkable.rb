require "checkable/version"

module Checkable
  @@checks = Hash.new { |h,k| h[k] = [] }

  def self.register type, check
    @@checks[type] << check
  end

  def self.checks_for type
    @@checks[type]
  end

  class FocusOnCheckClass
    def initialize check_class
      @check_class = check_class
    end

    def enabled? check
      check.class == @check_class
    end
  end

  class NoFocus
    def self.enabled? _
      true
    end
  end

  class Report
    attr_accessor :object, :passing, :failing

    def initialize object
      @object = object
      @passing = []
      @failing = []
    end

    def run check
      (check.check(object) ? passing : failing) << check
    end

    def ok?
      (passing.size > 0) && (failing.size == 0)
    end
  end

  class Checker
    attr_accessor :reports, :focus

    def initialize focus=NoFocus
      @focus = focus
      @reports = []
    end

    def check object
      report = Report.new object
      checks = Checkable.checks_for object.class.name
      checks.each { |check|
        report.run check if @focus.enabled?(check)
      }
      @reports << report
    end
  end
end
