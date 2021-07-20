# deviseメモ

> Devise is a flexible authentication solution for Rails based on
>
> Warden

- is Rack based
- is a MVC solution based on Rails engines
- Allows you to have multiple models signed in at the same time
- use only what you really need

> It's composed of 10 modules

| module                   | describe                                                     |
| ------------------------ | ------------------------------------------------------------ |
| Database Authenticatable | ユーザの認証に使う。パスワードをハッシュ化してデータベースに保存する。認証にはPOSTリクエスト、HTTPベーシック認証が使用できる |
| Omniauthable             | githubやTwitterやFacebookなどのアカウントでサインアップできる |
| Confirmable              | メールを送信して、アカウントを有効化する                     |
| Recoverable              | サインアップ後のユーザを編集、破棄できる                     |
| Rememberable             | cookieを使って、ユーザを永続化できる                         |
| Trackable                | サインインのカウント、タイムスタンプ、IPアドレスを追跡できる |
| Timeoutable              | 指定した時間内にアクティブでないセッションを破棄する         |
| Validatable              | メール、パスワードのバリデーションを提供する。カスタマイズ可能 |
| Lockable                 | 指定した回数のサインインに失敗すると、アカウントをロックする。一定期間後にロックを解除可能 |

## routing

| Prefix                          | Verb      | URI                                    | Pattern                      |
| ------------------------------- | --------- | -------------------------------------- | ---------------------------- |
| new_user_session                | GET       | /users/sign_in(.:format)               | devise/sessions#new          |
| user_session                    | POST      | /users/sign_in(.:format)               | devise/sessions#create       |
| destroy_user_session            | DELETE    | /users/sign_out(.:format)              | devise/sessions#destroy      |
| user_twitter_omniauth_authorize | GET\|POST | /users/auth/twitter(.:format)          | omniauth_callbacks#passthr   |
| user_twitter_omniauth_callback  | GET\|POST | /users/auth/twitter/callback(.:format) | omniauth_callbacks#twitter   |
| new_user_password               | GET       | /users/password/new(.:format)          | devise/passwords#new         |
| edit_user_password              | GET       | /users/password/edit(.:format)         | devise/passwords#edit        |
| user_password                   | PATCH     | /users/password(.:format)              | devise/passwords#update      |
|                                 | PUT       | /users/password(.:format)              | devise/passwords#update      |
|                                 | POST      | /users/password(.:format)              | devise/passwords#create      |
| cancel_user_registration        | GET       | /users/cancel(.:format)                | devise/registrations#cancel  |
| new_user_registration           | GET       | /users/sign_up(.:format)               | devise/registrations#new     |
| edit_user_registration          | GET       | /users/edit(.:format)                  | devise/registrations#edit    |
| user_registration               | PATCH     | /users(.:format)                       | devise/registrations#update  |
|                                 | PUT       | /users(.:format)                       | devise/registrations#update  |
|                                 | DELETE    | /users(.:format)                       | devise/registrations#destroy |
|                                 | POST      | /users(.:format)                       | devise/registrations#create  |
| new_user_confirmation           | GET       | /users/confirmation/new(.:format)      | devise/confirmations#new     |
|                                 | POST      | /users/confirmation(.:format)          | devise/confirmations#create  |
| user_unlock                     | GET       | /users/unlock/new(.:format)            | devise/unlocks#new           |
| new_user_unlock                 | GET       | /users/unlock(.:format)                | devise/unlocks#show          |
|                                 | POST      | /users/unlock(.:format)                | devise/unlocks#create        |

- /
  - signup
  - login
  - forget_password
  - activate_user
  - unlock_user
  - password_reset
  - twitter
  - user_name
    - edit
