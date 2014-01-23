# -*- encoding: utf-8 -*-
require File.expand_path("../../../spec_helper", __FILE__)

ruby_version_is "2.1" do
  describe "String#scrub with a default replacement" do
    it "returns self for valid strings" do
      input = "foo"

      input.scrub.should == input
    end

    it "replaces invalid byte sequences" do
      "abc\u3042\x81".scrub.should == "abc\u3042\uFFFD"
    end
  end

  describe "String#scrub with a custom replacement" do
    it "returns self for valid strings" do
      input = "foo"

      input.scrub("*").should == input
    end

    it "replaces invalid byte sequences" do
      "abc\u3042\x81".scrub("*").should == "abc\u3042*"
    end

    it "replaces groups of sequences together with a single replacement" do
      "\xE3\x80".scrub("*").should == "*"
    end
  end

  describe "String#scrub with a block" do
    it "returns self for valid strings" do
      input = "foo"

      input.scrub { |b| "*" }.should == input
    end

    it "replaces invalid byte sequences" do
      replaced = "abc\u3042\xE3\x80".scrub { |b| "<#{b.unpack("H*")[0]}>" }

      replaced.should == "abc\u3042<e380>"
    end
  end
end
