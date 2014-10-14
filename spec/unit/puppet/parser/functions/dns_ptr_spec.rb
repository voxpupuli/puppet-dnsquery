#! /usr/bin/env ruby -S rspec

require 'spec_helper'

describe 'the dns_ptr function' do
  let(:scope) { PuppetlabsSpec::PuppetInternals.scope }

  it 'should exist' do
    expect(Puppet::Parser::Functions.function('dns_ptr')).to eq('function_dns_ptr')
  end

  it 'should raise a ArgumentError if there is less than 1 arguments' do
    expect { scope.function_dns_ptr([]) }.to raise_error(ArgumentError)
  end

  it 'should return a list of PTR results when doing a lookup' do
    results = scope.function_dns_ptr(['google.com'])
    expect(results).to be_a Array
    expect(results).to all( be_a String)
  end
end
