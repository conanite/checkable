require 'spec_helper'

describe Checkable do
  let(:checker) { Checkable::Checker.new filter }

  def run_checks thing
    checker.check thing
    checker.reports.first
  end

  describe "using a filter to restrict the set of checks applied" do
    let(:filter) { Checkable::FocusOnCheckClass.new CheckWidgetIsFixed }

    it "should be ok if the widget is fixed" do
      expect(run_checks Widget.new(Battery.new, true)).to be_ok
    end

    it "should not be ok if the widget is not fixed" do
      expect(run_checks Widget.new(Battery.new, false)).not_to be_ok
    end
  end

  describe Widget do
    let(:filter) { Checkable::NoFocus }

    it "should not be ok if the widget is not fixed and has no battery" do
      report = run_checks Widget.new(nil, false)
      expect(report).not_to be_ok
      expect(report.passing.size).to eq 0
      expect(report.failing.size).to eq 2
    end

    it "should not be ok if the widget is is fixed but has no battery" do
      report = run_checks Widget.new(nil, true)
      expect(report.passing.size).to eq 1
      expect(report.failing.size).to eq 1
      expect(report).not_to be_ok
    end

    it "should not be ok if the widget is not fixed" do
      report = run_checks Widget.new(Battery.new, false)
      expect(report).not_to be_ok
      expect(report.passing.size).to eq 1
      expect(report.failing.size).to eq 1
    end

    it "should be ok if the widget is fixed and has a battery" do
      report = run_checks Widget.new(Battery.new, true)
      expect(report).to be_ok
      expect(report.passing.size).to eq 2
      expect(report.failing.size).to eq 0
    end
  end

  describe Battery do
    let(:filter) { Checkable::NoFocus }

    it "should be ok if the widget is fixed" do
      expect(run_checks Battery.new(true)).to be_ok
    end

    it "should not be ok if the widget is not fixed" do
      expect(run_checks Battery.new).not_to be_ok
    end
  end
end
