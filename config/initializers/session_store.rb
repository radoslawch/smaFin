# Be sure to restart your server when you modify this file.

if Rails.env.test?
  Rails.application.config.session_store :cookie_store, key: '_smaFin_session', secure: false
else
  Rails.application.config.session_store :cookie_store, key: '_smaFin_session', secure: true
end
