require 'rails_helper'

RSpec.describe "チャットルームの削除機能", type: :system do
  before do
    @room_user = FactoryBot.create(:room_user)
  end

  it 'チャットルームを削除すると、関連するメッセージがすべて削除されていること' do
    # サインインする
    sign_in(@room_user.user)

    # 作成されたチャットルームへ遷移する
    click_on(@room_user.room.name)

    # メッセージ情報を5つDBに追加する
    message1 = Message.create(content: "test1")
    message2 = Message.create(content: "test2")
    message3 = Message.create(content: "test3")
    message4 = Message.create(content: "test4")
    message5 = Message.create(content: "test5")
    # 「チャットを終了する」ボタンをクリックすることで、作成した5つのメッセージが削除されていることを確認する
    expect{ click_on("チャットを終了する") }.to change { Message.count }.by(-5)
    # トップページに遷移していることを確認する
    expect(current_path).to eq root_path
  end
end