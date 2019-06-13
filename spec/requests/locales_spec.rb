# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Locales', type: :request do
  let!(:author) { create(:author) }

  describe 'i18n' do
    context 'set_locale' do
      it 'set the locale' do
        get '/en'
        expect(I18n.locale).to eq :en
      end

      it 'set default locale when param is invalid' do
        get '/in'
        expect(I18n.locale).to eq :ja
      end
    end

    context 'default locale' do
      it 'use the defaul locale' do
        get '/'
        expect(I18n.locale).to eq :ja
      end
    end
  end
end
