# このアプリケーションについて
## 概要
ユーザー登録後、レシピの投稿やクリップができるレシピアプリ「PITARI cook」です。<br>
味の好みやアレルギー食材といったプロフィール情報を登録しておくことで、ユーザーの好みに合いそうなレシピや似たユーザーを表示したり、検索結果にアレルギー食材を含まない様にしたりと、今日の献立に悩んだユーザーが何も考えずとも必要としている情報を得られるアプリケーションになっています。

## 制作背景
世の中に多くリリースされているレシピアプリですが、多くは料理が「日常」であるユーザー向けであり、多忙なため休日だけ自炊する人や趣味として手の込んだ料理をする人など、料理が「特別」であるユーザーにとっては、「冷蔵庫に余っている食材を使うレシピを探そう」「子どもが喜ぶ！特集からレシピを探そう」といったアクションは起こしづらいと考えていました。<br>
そうであれば、プロフィール情報を登録しておけばおすすめが表示されたり検索が便利になるレシピアプリがあれば、「今日の気分も決まっていないからレシピを探せない」「自分のライフスタイルや嗜好に合わない余計な情報はいらない」といった要望が満たせるのではないかと考え、このアプリを制作しました。

また、投稿者ありきのアプリであるため、閲覧者にとって良い機能だけでなく、レシピを投稿することで恩恵（プレゼント）を得られたり、コメントやユーザーフォロー機能によって他ユーザーからの評価や賞賛が目に見えるようなど、投稿者にとって良い機能も実装しました。

## 開発環境
- OS：macOS Big Sur 11.2.2
- Ruby：2.6.5
- Ruby on Rails：6.0.0
- MySQL：5.6
- テキストエディタ：Visual Studio Code

## 実装要件
### ユーザー登録
- 新規登録画面でニックネーム、メールアドレス、パスワードを入力するとユーザー登録できる
- 入力内容を間違えるとエラーメッセージを表示し、同じページに戻る

### ユーザーログイン
- ログイン画面でメールアドレス、パスワードを入力するとログインできる
- 入力内容を間違えるとエラーメッセージを表示し、同じページに戻る
- ログアウトボタンを押下するとログアウトできる

### ユーザーマイページ
- ログイン状態でユーザーニックネームをクリックすると自分のマイページに遷移する
- 自分のマイページではフォロー/フォロワー数、ログイン情報、登録しているプロフィール情報、プレゼント申し込み情報、投稿したレシピ一覧、クリップしたレシピ一覧が確認できる
- ログイン状態に関わらず別のユーザーのニックネームをクリックするとそのユーザーのマイページに遷移する
- 別のユーザーのマイページではフォロワー数、投稿したレシピ一覧を確認できる

### ユーザープロフィール登録
- マイページでプロフィール編集ボタンを押下すると編集ページへ遷移できる
- プロフィール編集画面では性別、家族構成、味の好み、アレルギーなどのプロフィールを登録できる
- 入力内容を間違えるとエラーメッセージを表示し、同じページに戻る

### レシピ投稿
- レシピ投稿画面で必要項目を入力すると投稿できる
- 入力内容を間違えるとエラーメッセージを出力し、同じページへ遷移する

### レシピ詳細表示
- レシピの写真またはタイトルをクリックすると、材料や作り方など詳細情報を表示する

### レシピ検索
- トップページでカテゴリーと検索ワードを入力すると、該当するカテゴリが同じかつ検索ワードを材料に含むレシピを一覧表示する
- 検索結果がない場合、「検索結果はありません」と出力する
- ログイン状態でかつアレルギー食品を登録しているユーザーが検索を行なった場合は、その食品を材料に含むレシピは検索結果から除いて表示する。

### レシピクリップ
- ログイン状態で、レシピ詳細画面でクリップボタンを押下するとレシピをクリップできる
- 自分のマイページでクリップしたレシピを確認することができる
- ログアウト状態では、クリップできない
- 自分が投稿したレシピは、クリップできない
- クリップ済のレシピはクリップ済マークが表示される

### おすすめレシピ表示
- ログイン状態では、トップページに味の好みが同じユーザーが投稿したレシピを表示する
- ログイン状態でも、プロフィール登録がない/味の好みが同じユーザーの投稿レシピがない場合はおすすめを表示しない
- ログアウト状態では、味の好みが同じユーザーのレシピは表示しない

### コメント投稿
- ログイン状態では、レシピ詳細画面にコメント入力欄が表示されコメントを投稿できる
- ログアウト状態ではコメント投稿できない
- 投稿されたコメントはレシピ詳細画面の下部に一覧表示される

### 特典プレゼント申し込み
- ログイン状態では、自分のマイページからプレゼント申し込みページへ遷移できる
- プレゼント交換ページで欲しい商品を選び、必要事項を入力するとプレゼント配送の申し込みができる
- 入力内容に誤りがあるとエラーメッセージを表示し、同じページに遷移する

### ユーザーフォロー
- ログイン状態で、ユーザー詳細画面でフォローボタンを押下すると、ユーザーをフォローできる
- 自分のマイページでフォロー中ユーザーの人数、フォロワー人数を確認することができる
- マイページのフォロー中ユーザーの人数を押下するとページ遷移し、フォロー中ユーザーの投稿レシピとおすすめユーザーのレシピを表示する
- プロフィール登録がない場合、おすすめユーザーのレシピは表示されずプロフィール登録を促すメッセージが表示される
- 登録情報に基づくおすすめユーザーがない場合、おすすめユーザーのレシピは表示されない
- ログアウト状態ではユーザーフォローできない
- フォロー中のユーザー済はフォロー済マークが表示される

## 今後実装予定の機能について
- ユーザープロフィール登録機能について、登録済みのプロフィールを編集可能とする
- ユーザープロフィール登録機能について、アレルギー食品を複数登録可能とする
- レシピクリップ機能について、クリップ解除を可能とする
- ユーザーフォロー機能について、フォローの解除を可能とする

## 工夫した点
レシピの食材について、検索時にかな/カナの表記ゆれを許容するためにローマ字での読みをテーブルに持つようにしています。またローマ字読みで一意であることにより、「タマゴ」「たまご」といった同じ食材で複数のレコードを持つこともなくしています。<br>
_※本番環境ではJavaオープンソース日本語形態素解析エンジンのgemである、「kuromoji」を導入することが困難であったため、かな/カナの入力のみを許容しています。ローカル環境ではしかるべき手順により「kuromoji」を導入すると漢字入力された単語をローマ字に変換しDB登録できることを動作確認済みです。詳細は「ローカルでの操作方法」をご確認ください。_

レシピ投稿画面やプレゼント申し込み画面など入力すべき内容が多い画面があったため、各入力フォームのエラーメッセージを日本語で出力することにより、一目で「どこがダメだったのか」がわかりやすくなるようにしました。

レシピについては投稿ユーザーによる編集・削除機能を実装する予定はありません。クリップ機能を実装したことにより、「好みの味付けだったのに前と同じ味にならなくなってしまった」「とても気に入っていたレシピがなくなっている」といった不都合を防ぐためです。その代わりにコメント機能を実装したことで、投稿ユーザーと実際にレシピを作ってみた別のユーザーとの間で意見交換によりレシピを育てていけるような環境を用意しています。


# 本番環境での操作方法
- URL：http://35.76.158.220/
- Basic認証情報： アカウント「admin」 PASS「7777」

## 注意事項
- WebブラウザGoogle Chromeの最新版を利用してアクセスしてください。
- デプロイ等で接続できないタイミングもございますが、その際は少し時間をおいてから接続してください。
- 各種投稿機能機能がございますが、不特定多数の方の目に触れる可能性があるため、個人情報や公序良俗に反する内容の投稿はご遠慮ください。
- 終了時はログアウト処理をお願いします。

## テストアカウント

| ニックネーム | メールアドレス | パスワード | 性別 | 家族構成 | 味の好み | アレルギー |
| ---------- | ------------ | -------- | ---- | ------ | ------- | --------- |
| testuser1 | user1@test.com | testuser1 | 女性 | 1人暮らし | 濃い目が好み | エビ |
| testuser2 | user2@test.com | testuser2 | 男性 | 3~4人暮らし | 甘めの味が好き |       |
| testuser3 | user3@test.com | testuser3 | 女性 | 2人暮らし | 薄味が好き |       |
| testuser4 | user4@test.com | testuser4 | その他 | その他 | 辛いもの大好き |       |
| testuser5 | user5@test.com | testuser5 | 女性 | 1人暮らし | 濃い目が好み |     |

## 利用方法
### ユーザー登録
ログアウト状態で、ヘッダー上部の「新規会員登録」リンクから新規会員登録画面を開いてください。<br>
ニックネーム、メールアドレス。パスワード(半角英数字混合・6文字以上)、確認用パスワードを入力し「会員登録」ボタンを押下すると会員登録できます。<br>
入力内容に問題がある場合はエラーメッセージが出力されます。

### ユーザーログイン
ログアウト状態で、ヘッダー上部の「ログイン」リンクからログイン画面を開いてください。<br>
ご自身が登録したユーザー、もしくはテストアカウントのメールアドレスとパスワードを入力し、「ログイン」ボタンを押下するとログインできます。
入力内容に問題がある場合はエラーメッセージが出力されます。<br>
ヘッダー上部の「ログアウト」リンクを押下するとログアウトできます。

### ユーザープロフィール登録
ご自身が登録したユーザーでログインし、トップページの自分のユーザー名のリンクを押下してマイページを開いてください。<br>
初期状態のマイページは以下のような表示になっています。
[![Image from Gyazo](https://i.gyazo.com/2f7285525fb2e6ee589ee69ac9da5532.jpg)](https://gyazo.com/2f7285525fb2e6ee589ee69ac9da5532)

プロフィール欄の「こちら」というリンクを押下してプロフィール登録画面を開いてください。<br>
性別、家族構成、味の好み、アレルギー(全角カナかな)を入力し、「登録」ボタンを押下するとプロフィールを登録できます。アレルギーは入力しなくても登録できます。<br>

プロフィールを登録すると、トップページに同じ味の好みのユーザーが投稿したレシピが表示されます(おすすめ表示機能)。「濃い目が好み」と登録すると、テストアカウント「testuser1」と同じですのでtestuser1のレシピが表示されます。
[![Image from Gyazo](https://i.gyazo.com/2aed58cf072b532d7ecb794a065a4070.jpg)](https://gyazo.com/2aed58cf072b532d7ecb794a065a4070)


### レシピ投稿
ご自身が登録したユーザーでログインし、ヘッダー上部の「レシピ投稿」リンクからレシピ投稿画面を開いてください。<br>
タイトル、写真、カテゴリー、材料・分量(全角カナかな)、作り方を入力し、「投稿」ボタンを押下すると投稿できます。
材料が3つでは足らない場合は「材料を追加」ボタンを押下すると入力フォームが追加されます。
[![Image from Gyazo](https://i.gyazo.com/55f4b5783dc88d7a9580a49f70c261b4.gif)](https://gyazo.com/55f4b5783dc88d7a9580a49f70c261b4)

入力内容に問題がある場合はエラーメッセージが出力されます。<br>
投稿したレシピはトップページ「新着レシピ」欄に表示されます。

### レシピ詳細表示
レシピはトップページやマイページなどに、カード形式で表示されています。<br>
レシピの画像もしくはタイトルのリンクを押下してレシピ詳細画面を開いてください。レシピ詳細画面へはログイン状態に関わらず遷移することができます。

ログイン状態ではレシピのクリップとコメント投稿ができます。ご自身が登録したユーザーでログインしてください。<br>
自分以外のユーザーが投稿したレシピはクリップマークを押下することでクリップすることができ、クリップしたレシピはマイページで確認できます。
[![Image from Gyazo](https://i.gyazo.com/c938793d58d0d970a76f1841cf7b71c6.gif)](https://gyazo.com/c938793d58d0d970a76f1841cf7b71c6)

コメント入力フォームにコメントを入力し、「投稿」ボタンを押下するとコメント投稿できます。

### レシピ検索
ログイン状態に関わらず、トップページの検索フォームにカテゴリー、食材名(全角カナかな、1つまで)を入力し「検索」ボタンを押下するとレシピ検索結果が出力されます。カテゴリーのみ、食材名どちらかのみの入力も可能です。<br>
検索結果がない場合は「検索結果はありません」と出力されます。

テストアカウント「testuser1」でログインしてください。<br>
「testuser1」はエビをアレルギー食品として登録していますので、「洋食」カテゴリで検索しても、食材にエビを含むtestuser2のレシピ8は検索結果に出力されません。
[![Image from Gyazo](https://i.gyazo.com/6e8390ae7e3aeb08d7700ffe753746e2.gif)](https://gyazo.com/6e8390ae7e3aeb08d7700ffe753746e2)

### 特典プレゼント申し込み
ご自身が登録したユーザーでログインし、5つ以上レシピを投稿してください。
マイページ、プレゼント申込履歴欄の「こちら」というリンクを押下してプレゼント申し込み画面を開いてください。<br>
プレゼント、姓・名(全角)、姓(カナ)・名(カナ)(全角カナ)、郵便番号、都道府県、市区町村、番地、電話番号を入力して「登録」ボタンを押下してください。建物名はなくても登録できます。<br>
プレゼントは、ページ上部にある必要投稿数を満たしていないと申し込みできませんので、「国産フルーツジャム」を選択してください。また、１つにつきもらえるのは１回までです。(申込履歴はマイページで確認できます。)

入力内容に問題がある場合はエラーメッセージが出力されます。<br>

### ユーザーフォロー
ご自身が登録したユーザーでログインし、レシピ詳細画面などのユーザー名リンクから他ユーザーのマイページを開いてください。<br>
フォローマークを押下することで他ユーザーをフォローすることができ、フォロー中ユーザーのレシピは自分のマイページを経由して確認することができます。
[![Image from Gyazo](https://i.gyazo.com/4ef11eabfe746e21babba53ece6411bc.gif)](https://gyazo.com/4ef11eabfe746e21babba53ece6411bc)

プロフィールを登録していると、同ページにプロフィール情報(性別、家族構成、味の好み)が同じユーザーのレシピがおすすめとして表示されます。<br>
テストアカウント「testuser1」と「testuser5」はプロフィール情報が同じですので、いずれかでログインしていただくとお互いのレシピがおすすめとして表示されます。
[![Image from Gyazo](https://i.gyazo.com/3bd27e2fed3f0e7d4397bb1c0ebdc525.gif)](https://gyazo.com/3bd27e2fed3f0e7d4397bb1c0ebdc525)


# ローカル環境での操作方法
## git clone後の実行コマンド
プロジェクトのディレクトリで、下記コマンドを順に実行してください。
```
% bundle install
% yarn install
% rails db:create
% rails db:migrate
```

## 食材の漢字入力を実行する場合
### 前提
ご自身のローカル環境にJDEの導入、環境変数「JAVA_HOME」の設定が必要です。

### ソース修正箇所
下記ファイルの該当箇所を修正してください。

- gemfile

``` ruby
# ローカル環境でkuromojiを利用できる場合は追加
gem 'rjb'
gem 'kuromoji'
gem 'zipang'
```

- assets/models/profiles_form.rb

``` ruby
# ローカル環境でkuromojiを導入する場合
# materialのname 全角入力チェック
with_options format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/ }, if: :name_check do
  validates :name
end
# romajiのみを利用する場合
# materialのname 全角かなカナ入力チェック
# with_options format: { with: /\A[ぁ-んァ-ヶー]+\z/ }, if: :name_check do
#  validates :name
# end
~
# 食材のローマ字読みを取得
# ローカル環境でkuromojiを導入する場合
roman_name = (Zipang.to_slug name.romaji).gsub(/\-/, '')
# romajiのみを利用する場合
# roman_name = name.romaji
```

- assets/models/recipes_form.rb

``` ruby
# ローカル環境でkuromojiを導入する場合 全角以外は登録できない
if name.match(/\A[ぁ-んァ-ヶ一-龥々ー]+\z/).nil?
# romajiのみを利用する場合 全角かなカナ以外は登録できない
# if name.match(/\A[ぁ-んァ-ヶー]+\z/).nil?
  errors.add(:names, 'は不正な値です')
end
 ~
# 食材のローマ字読みを取得
# ローカル環境でkuromojiを導入する場合
roman_name = (Zipang.to_slug names[i].romaji).gsub(/\-/, '')
# romajiのみを利用する場合
# roman_name = names[i].romaji
```

### 実行コマンド
`bundle install`を実行し、gemの導入を行なってください。<br>
サーバーを再起動後、漢字入力が可能となります。

# DB設計
## ER図
[![Image from Gyazo](https://i.gyazo.com/e6f135b4fa6794de78d2db14b160791b.png)](https://gyazo.com/e6f135b4fa6794de78d2db14b160791b)

## users テーブル
| Column                 | Type     | Options                         |
| -----------------------|----------|-------------------------------- |
| nickname               | string   | null:false                      |
| email                  | string   | null:false, unique:true         |
| encrypted_password     | string   | null:false                      |

### association
- has_many :recipes
- has_one :profile
- has_many :clips
- has_many :comments
- has_many :present_orders

- has_many :follows
- has_many :followings, through: :follows, source: :follower
- has_many :reverse_of_follows, class_name: 'Follow', foreign_key: 'follower_id'
- has_many :reverse_of_followings, through: :reverse_of_follows, source: :followee_id

## recipes テーブル
| Column                 | Type       | Options                       |
| -----------------------|------------|------------------------------ |
| title                  | string     | null:false                    |
| category_id            | integer    | null:false                    |
| text                   | text       | null:false                    |
| user                   | references | null: false,foreign_key: true |

### association
- belongs_to :user
- has_many :comments
- has_many :recipe_materials
- has_many :materials, through: :recipe_materials
- has_many :clips

### Other
- using ActiveStorage and ActiveHash(category)

## recipe_materials テーブル
| Column                 | Type       | Options                       |
| -----------------------|------------|------------------------------ |
| amount                 | string     | null: false                   |
| recipe                 | references | null: false,foreign_key: true |
| material               | references | null: false,foreign_key: true |

### association
- belongs_to :recipe
- belongs_to :material

## materials テーブル
| Column                 | Type       | Options                       |
| -----------------------|------------|------------------------------ |
| name                   | string     | null: false                   |
| roman_name             | string     | null: false                   |

### association
- has_many :recipe_materials
- has_many :recipes, through: :recipe_materials
- has_many :allergy_materials
- has_many :allergies, through: :allergy_materials

## clips テーブル
| Column                 | Type       | Options                       |
| -----------------------|------------|------------------------------ |
| user                   | references | null: false,foreign_key: true |
| recipe                 | references | null: false,foreign_key: true |

### association 
- belongs_to :user
- belongs_to :recipe

## profiles テーブル
| Column                 | Type       | Options                       |
| -----------------------|------------|------------------------------ |
| gender_id              | integer    | null:false                    |
| family_structure_id    | integer    | null:false                    |
| taste_id               | integer    | null:false                    | 
| user                   | references | null: false,foreign_key: true |

### association
- belongs_to :user
- has_one :allergy

### Other
- using ActiveHash(gender,family_structure,taste)

## allergy テーブル
| Column                 | Type       | Options                       |
| -----------------------|------------|------------------------------ |
| profile                | references | null: false,foreign_key: true |

### association 
- belongs_to :profile
- has_many :allergy_materials
- has_many :materials, through: :allergy_materials

## allergy_materials テーブル
| Column                 | Type       | Options                       |
| -----------------------|------------|------------------------------ |
| allergy                | references | null: false,foreign_key: true |
| material               | references | null: false,foreign_key: true |

### association
- belongs_to :allergy
- belongs_to :material

## comments テーブル
| Column                 | Type       | Options                       |
| -----------------------|------------|------------------------------ |
| text                   | text       | null:false                    |
| user                   | references | null: false,foreign_key: true |
| recipe                 | references | null: false,foreign_key: true |

### association
- belongs_to :user
- belongs_to :recipe

## present_orders　テーブル
| Column                 | Type       | Options                       |
| -----------------------|------------|------------------------------ |
| present_id             | integer    | null:false                    |
| user                   | references | null: false,foreign_key: true |

### association
- belongs_to :user
- has_one :delivery_address

### Other
- using ActiveHash(present)

## delivery_addresses　テーブル
| Column                 | Type       | Options                       |
| -----------------------|------------|------------------------------ |
| last_name              | string     | null:false                    |
| first_name             | string     | null:false                    |
| last_name_kana         | string     | null:false                    |
| first_name_kana        | string     | null:false                    |
| postal_code            | string     | null:false                    |
| prefecture_id          | integer    | null:false                    |
| city                   | string     | null:false                    |
| address                | string     | null:false                    |
| building_name          | string     |                               |
| phone_number           | string     | null:false                    |
| present_order          | references | null: false,foreign_key: true |

### association
- belongs_to :present_order

### Other
- using ActiveHash(prefecture)

## followテーブル
| Column                 | Type       | Options                           |
| -----------------------|------------|---------------------------------- |
| followee               | references | foreign_key: { to_table: :users } |
| follower               | references | foreign_key: { to_table: :users } |

### association
- belongs_to :followee, class_name: "User"
- belongs_to :follower, class_name: "User"