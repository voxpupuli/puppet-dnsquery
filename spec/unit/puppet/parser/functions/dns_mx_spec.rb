#! /usr/bin/env ruby -S rspec

require 'spec_helper'

describe 'the dns_mx function' do
  let(:scope) { PuppetlabsSpec::PuppetInternals.scope }

  it 'should exist' do
    expect(Puppet::Parser::Functions.function('dns_mx')).to eq('function_dns_mx')
  end

  it 'should raise a ArgumentError if there is less than 1 arguments' do
    expect { scope.function_dns_mx([]) }.to raise_error(ArgumentError)
  end

  it 'should raise a ArgumentError if there is more than 2 arguments' do
    expect { scope.function_dns_mx(['foo', 'bar', 'baz']) }.to raise_error(ArgumentError)
  end

  it 'should return a list of MX records when doing a lookup' do
    results = scope.function_dns_mx(['google.com'])
    expect(results).to be_a Array
    expect(results).to all( be_a Array )
    results.each do |res|
      expect(res.length).to eq(2)
      expect(res[0]).to be_a Integer
      expect(res[1]).to be_a String
    end
  end

  it 'should return a list of MX preferences when doing a lookup specifying that' do
    results = scope.function_dns_mx(['google.com', 'preference'])
    expect(results).to be_a Array
    expect(results).to all( be_a Integer )
  end

  it 'should return a list of MX exchanges when doing a lookup specifying that' do
    results = scope.function_dns_mx(['google.com', 'exchange'])
    expect(results).to be_a Array
    expect(results).to all( be_a String )
  end

  it 'should raise a ArgumentError for invalid values to second argument' do
    expect { scope.function_dns_mx(['google.com', 'foo']) }.to raise_error(ArgumentError)
  end
end
