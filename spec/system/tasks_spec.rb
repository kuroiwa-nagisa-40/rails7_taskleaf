require 'rails_helper'

describe "タスク管理機能", type: :system do
    let(:user_a) {FactoryBot.create(:user, name: "A", email: "a@a")}
    let(:user_b) {FactoryBot.create(:user, name: "B", email: "b@b")}
    let!(:task_a) {FactoryBot.create(:task, title: "最初のタスク", user: user_a)}

    before do
      #ログインする
      visit login_path
      fill_in "メールアドレス", with: login_user.email
      fill_in "パスワード", with: login_user.password
      click_button "ログインする"
    end

    shared_examples_for "ユーザAが作成したタスクを表示する" do
      it {expect(page).to have_content "最初のタスク"}
    end

    describe "一覧機能表示" do
      context "ユーザAがログインしている時" do
        let(:login_user) {user_a}

        it_behaves_like "ユーザAが作成したタスクを表示する"
      end

      context "ユーザBがログインしている時" do
        let(:login_user) {user_b}
        
        it "ユーザAが作成したタスクが表示されない" do
          # ユーザAが作成したタスクの名称が画面上に表示されていないことを確認
          expect(page).to have_no_content "最初のタスク"
        end
      end
    end

    describe "詳細表示機能" do
      context "ユーザAがログインしている時" do
        let(:login_user) { user_a }
    
        before do
          puts "Current Path: #{current_path}"
          # 親の before でログインしているはずなので、ここでタスクページに移動
          visit task_path(task_a)
          puts "Current Path: #{current_path}"
        end
    
        it_behaves_like "ユーザAが作成したタスクを表示する"
      end
    end

    describe "タスク新規作成機能" do
      let(:login_user) {user_a}

      before do
        puts "Current Path: #{current_path}"
        visit new_task_path
        fill_in "task_name", with: task_name
        click_button "登録する"
      end

      context "新規作成画面で名称を入力した時" do
        let(:task_name) {"新規作成のテストを書く"}

        it "正常に登録される" do
          expect(page).to have_selector '.alert-success', text: "新規作成のテストを書く"  
        end
      end

      context "新規作成画面で名称を入力しなかった時" do
        let(:task_name) {""}

        it "エラーになる" do
          within '#error_explaination' do
            expect(page).to have_content "名称を入力してください"  
          end
        end
      end
      
      
    end
    
  
end
