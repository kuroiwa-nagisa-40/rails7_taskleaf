FactoryBot.define do
  factory :task do
    title {"テストを書く"}
    description {"テストテストテスト"}
    user
  end
end