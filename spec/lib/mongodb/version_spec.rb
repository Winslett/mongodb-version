require 'spec_helper'

describe MongoDB::Version do

  it "breaks a version into pieces" do
    v = MongoDB::Version['2.4.6']
    v.major.should eq(2)
    v.minor.should eq(4)
    v.patch.should eq(6)
    v.special.should eq(nil)
  end

  it "breaks a version into pieces" do
    v = MongoDB::Version['2.6.0-ssl']
    v.major.should eq(2)
    v.minor.should eq(6)
    v.patch.should eq(0)
    v.special.should eq("ssl")
  end

  it "compares versions and version strings" do
    (MongoDB::Version['2.4.6'] < '2.4.7').should eq(true)
    (MongoDB::Version['2.4.6'] < MongoDB::Version['2.4.5']).should eq(false)

    (MongoDB::Version['6.0.0'] > MongoDB::Version['1.9.9']).should eq(true)
    (MongoDB::Version['6.0.0'] < MongoDB::Version['1.9.9']).should eq(false)

    (MongoDB::Version['2.4.6'] > MongoDB::Version['2.4.5']).should eq(true)
    (MongoDB::Version['2.4.6'] > MongoDB::Version['2.4.7']).should eq(false)

    (MongoDB::Version['2.4.6'] >= MongoDB::Version['2.4.5-ssl']).should eq(true)
    (MongoDB::Version['2.4.6'] >= MongoDB::Version['2.4.6-ssl']).should eq(true)
    (MongoDB::Version['2.4.5'] >= MongoDB::Version['2.4.6-ssl']).should eq(false)

    (MongoDB::Version['2.4.5'] <= MongoDB::Version['2.4.6-ssl']).should eq(true)
    (MongoDB::Version['2.4.5'] <= MongoDB::Version['2.4.5-ssl']).should eq(true)
    (MongoDB::Version['2.4.7'] <= MongoDB::Version['2.4.5-ssl']).should eq(false)

    (MongoDB::Version['2.2.3'] == MongoDB::Version['2.6.0']).should eq(false)
    (MongoDB::Version['2.4.6'] == MongoDB::Version['2.4.6-ssl']).should eq(true)
    (MongoDB::Version['2.4.6'] === MongoDB::Version['2.4.6-ssl']).should eq(false)
  end

  it "manages TTL collections" do
    MongoDB::Version['2.4.6'].ttl_collections?.should eq(true)
    MongoDB::Version['2.0.6'].ttl_collections?.should eq(false)
  end

  it "manages TTL collections" do
    MongoDB::Version['2.6.0-rc0'].authentication_schemes.should eq([2])
    MongoDB::Version['2.4.0'].authentication_schemes.should eq([1,2])
    MongoDB::Version['2.2.4'].authentication_schemes.should eq([1])
  end

  it "manages text search" do
    MongoDB::Version['2.6.0-rc0'].text_search.should eq(:production)
    MongoDB::Version['2.4.0'].text_search.should eq(:beta)

    MongoDB::Version['2.6.0-rc0'].text_search?.should eq(true)
    MongoDB::Version['2.4.0'].text_search?.should eq(true)
    MongoDB::Version['2.2.0'].text_search?.should eq(false)
  end

end
