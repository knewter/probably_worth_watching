require_relative '../spec_helper'

describe IrcLogLineTweetFaker do
  let(:log_line) do
    %Q{02:10 < nmz787> Title: "Low Cost UV Laser Direct Write Photolithography System for Rapid Prototyping of Microsystems"  Author: John Waynelovich, Abtin Sepehri, Beejal Mehta, Sam Kassegne, and A. Khosla.}
  end

  subject { IrcLogLineTweetFaker.new(log_line) }

  it "outputs a tweet from a given irc log line" do
    subject.make_tweet.must_be_instance_of ProbablyWorthWatching::Tweet
  end

  it "extracts author correctly" do
    subject.make_tweet.author.must_equal "nmz787"
  end

  it "extracts content correctly" do
    subject.make_tweet.content.must_equal %Q{Title: "Low Cost UV Laser Direct Write Photolithography System for Rapid Prototyping of Microsystems"  Author: John Waynelovich, Abtin Sepehri, Beejal Mehta, Sam Kassegne, and A. Khosla.}
  end
end
