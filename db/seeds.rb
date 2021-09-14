# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Empresa.create(nome: 'Viver Saúde')
Administrador.create(nome: 'Thiago', email: "malaquiastech@gmail.com", senha: "123456", empresa_id: Empresa.first.id)
Administrador.create(nome: 'Gilberto', email: "gvgtec@terra.com.br", senha: "123456", empresa_id: Empresa.first.id)