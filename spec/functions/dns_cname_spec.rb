#! /usr/bin/env ruby -S rspec

require 'spec_helper'

describe 'dns_cname' do
  it 'should return a CNAME destination when doing a lookup' do
    result = subject.execute('mail.google.com')
    expect(result).to be_a String
  end

  it 'should raise an error on empty reply' do
    is_expected.to run
      .with_params('foo.example.com')
      .and_raise_error(Resolv::ResolvError)
  end
end
