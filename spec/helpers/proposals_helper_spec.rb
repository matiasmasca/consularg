require 'rails_helper'

describe ProposalsHelper do

  describe "#progress_bar_percentage" do
    it "should be 0 if no votes" do
      proposal = create(:proposal)
      expect(progress_bar_percentage(proposal)).to eq 0
    end

    it "should be a between 1 and 100 if there are votes but less than needed" do
      proposal = create(:proposal, cached_votes_up: Proposal.votes_needed_for_success/2)
      expect(progress_bar_percentage(proposal)).to eq 50
    end

    it "should take into account the physical votes" do
      proposal = create(:proposal, cached_votes_up: ((Proposal.votes_needed_for_success/2)-100), physical_votes: 100)
      expect(progress_bar_percentage(proposal)).to eq 50
    end

    it "should be 100 if there are more votes than needed" do
      proposal = create(:proposal, cached_votes_up: Proposal.votes_needed_for_success*2)
      expect(progress_bar_percentage(proposal)).to eq 100
    end
  end

  describe "#supports_percentage" do
    it "should be 0 if no votes" do
      proposal = create(:proposal)
      expect(supports_percentage(proposal)).to eq "0%"
    end

    it "should be a between 0.1 from 1 to 0.1% of needed votes" do
      proposal = create(:proposal, cached_votes_up: 1)
      expect(supports_percentage(proposal)).to eq "0.1%"
    end

    it "should be a between 1 and 100 if there are votes but less than needed" do
      proposal = create(:proposal, cached_votes_up: Proposal.votes_needed_for_success/2)
      expect(supports_percentage(proposal)).to eq "50%"
    end

    it "should be 100 if there are more votes than needed" do
      proposal = create(:proposal, cached_votes_up: Proposal.votes_needed_for_success*2)
      expect(supports_percentage(proposal)).to eq "100%"
    end

    it "should take into account the physical votes" do
      proposal = create(:proposal, physical_votes: Proposal.votes_needed_for_success/2)
      expect(supports_percentage(proposal)).to eq "50%"
    end
  end

  describe "#no_more_city_votes_css" do
    xit "should return minimal class when no votes left"
  end

end