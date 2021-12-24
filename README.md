# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

pg_dump -Fc --no-acl --no-owne viversaude_development > /home/malaquias/Downloads/mydb.dump

heroku pg:backups:restore https://liveevents-adm.s3.sa-east-1.amazonaws.com/1639527672-mydb.dump --confirm viversaudeapp

ActiveRecord::Base.connection.exec_query(
  "SELECT setval(pg_get_serial_sequence('produtos', 'id'), max(id)) FROM produtos"
)