require "test_helper"

describe Vote do
  describe 'relations' do
    it "has a work" do
      vote = votes(:one)
      vote.work.must_equal works(:jane)
    end

    it "can set the work" do
      vote = Vote.new
      vote.work = works(:harry)
      vote.work_id.must_equal works(:harry).id
    end
  end
end
