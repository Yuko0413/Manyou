require 'rails_helper'

RSpec.describe '対応者モデル機能', type: :model do
  describe 'バリデーションのテスト' do
    let(:user) { FactoryBot.create(:user) }

    context '対応者の名前が空文字の場合' do
      let(:label) { Label.new(name: '', user: user) }

      it 'バリデーションに失敗する' do
        expect(label).not_to be_valid
        expect(label.errors[:name]).to include("を入力してください")
      end
    end

    context '対応者の名前に値があった場合' do
      let(:label) { Label.new(name: 'テスト対応者', user: user) }

      it 'バリデーションに成功する' do
        expect(label).to be_valid
      end
    end
  end
end
