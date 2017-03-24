#! /usr/bin/env ruby -S rspec

require 'spec_helper'

describe 'dns_txt' do
  it 'should return a list of lists of strings when doing a lookup' do
    results = subject.execute('google.com')
    expect(results).to be_a Array
    expect(results).to all(be_a(Array))
    expect(results).to all(all(be_a(String)))
  end
end
