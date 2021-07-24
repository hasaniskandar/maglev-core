# frozen_string_literal: true

require 'rails_helper'

describe Maglev::EditorHelper do
  let(:title) { nil }
  let(:primary_color) { '#7E6EDB' }
  let(:logo) { nil }
  let(:config) do
    Maglev::Config.new.tap do |config|
      config.title = title
      config.primary_color = primary_color
      config.logo = logo
    end
  end

  helper do
    def maglev_config; end
  end

  before(:each) do
    allow(helper).to receive(:maglev_config).and_return(config)
  end

  describe '#editor_window_title' do
    subject { helper.editor_window_title }
    it 'returns the default title' do
      is_expected.to eq 'Maglev - EDITOR'
    end
    context 'the developer has set a custom title' do
      let(:title) { 'My awesome CMS' }
      it 'returns the new title' do
        is_expected.to eq 'My awesome CMS'
      end
    end
  end

  describe '#editor_primary_hex_color' do
    subject { helper.editor_primary_hex_color }
    it 'returns the primary color in a hexadecimal format' do
      is_expected.to eq '#7E6EDB'
    end
  end

  describe '#editor_primary_rgb_color' do
    subject { helper.editor_primary_rgb_color }
    it 'returns the primary color in RGB (array)' do
      is_expected.to eq [126, 110, 219]
    end
    context 'short version of the primary color' do
      let(:primary_color) { '#345' }
      it 'returns the primary color in RGB (array)' do
        is_expected.to eq [51, 68, 85]
      end
    end
  end

  describe '#editor_logo_url' do
    subject { helper.editor_logo_url }
    it 'returns the default logo url' do
      is_expected.to include('/assets/maglev/logo-')
    end
    context 'the developer has replaced the logo' do
      let(:logo) { 'new-logo.png' }
      it 'returns the new logo' do
        is_expected.to include '/assets/new-logo-'
      end
    end
  end
end