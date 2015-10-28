require './test/test_helper'

class SunlightServiceTest < ActiveSupport::TestCase
attr_reader :service

  def setup
    @service ||= SunlightService.new
  end

  test '#legislators gender' do
    VCR.use_cassette("sunlight_service#legislators gender") do
      legislators = service.legislators(gender: 'F')
      legislator = legislators.first

      assert_equal 20, legislators.count
      assert_equal "Joni", legislator[:first_name]
      assert_equal "Ernst", legislator[:last_name]
    end
  end

  test '#legislators chamber' do
    VCR.use_cassette("sunlight_service#legislators chamber") do
      legislators = service.legislators(chamber: 'senate')
      legislator = legislators.first

      assert_equal 20, legislators.count
      assert_equal 'Benjamin', legislator[:first_name]
      assert_equal 'Sasse', legislator[:last_name]
    end
  end

  test '#committees chamber' do
    VCR.use_cassette("sunlight_service#committees chamber") do
      committees = service.committees(chamber: 'joint')
      committee = committees.first

      assert_equal 5, committees.count
      assert_equal 'Joint Committee on Taxation', committee[:name]
      assert_equal false, committee[:subcommittee]
    end
  end

  test '#committees query' do
    VCR.use_cassette("sunlight_service#committees query") do
      committees = service.committees(query: 'taxation')
      committee = committees.first

      assert_equal 2, committees.count
      assert_equal 'Taxation and IRS Oversight', committee[:name]
      assert_equal true, committee[:subcommittee]
    end
  end
end