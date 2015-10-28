require './test/test_helper'

class CommitteeTest < ActiveSupport::TestCase
  test '#find_by chamber' do
    VCR.use_cassette('committee#find_by chamber') do
      committees = Committee.find_by(chamber: 'joint')
      committee = committees.first

      assert_equal 5, committees.count
      assert_equal Committee, committee.class
      assert_equal "Joint Committee on Taxation", committee.name
      assert_equal false, committee.subcommittee
    end
  end

  test '#find_by query' do
    VCR.use_cassette('committee#find_by query') do
      committees = Committee.find_by(query: 'taxation')
      committee = committees.first

      assert_equal 2, committees.count
      assert_equal Committee, committee.class
      assert_equal "Taxation and IRS Oversight", committee.name
      assert_equal true, committee.subcommittee
    end
  end
end