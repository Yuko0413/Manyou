require 'rails_helper'

RSpec.describe 'ラベルモデル機能', type: :model do
  describe 'バリデーションのテスト' do
    let(:user) { FactoryBot.create(:user) }

    context 'ラベルの名前が空文字の場合' do
      let(:label) { Label.new(name: '', user: user) }

      it 'バリデーションに失敗する' do
        expect(label).not_to be_valid
        expect(label.errors[:name]).to include("を入力してください")
      end
    end

    context 'ラベルの名前に値があった場合' do
      let(:label) { Label.new(name: 'テストラベル', user: user) }

      it 'バリデーションに成功する' do
        expect(label).to be_valid
      end
    end
  end
end
