# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_05_20_010744) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cliente_contatos", force: :cascade do |t|
    t.bigint "cliente_id"
    t.string "nome"
    t.string "telefone"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cliente_id"], name: "index_cliente_contatos_on_cliente_id"
  end

  create_table "clientes", force: :cascade do |t|
    t.string "nome"
    t.string "pessoa"
    t.string "cpf"
    t.string "rg"
    t.string "cnpj"
    t.string "ie"
    t.string "endereco"
    t.string "bairro"
    t.string "cidade"
    t.string "cep"
    t.string "uf"
    t.string "email"
    t.string "codcidade_ibge"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "fornecedor_contatos", force: :cascade do |t|
    t.bigint "fornecedor_id"
    t.string "nome"
    t.string "telefone"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["fornecedor_id"], name: "index_fornecedor_contatos_on_fornecedor_id"
  end

  create_table "fornecedores", force: :cascade do |t|
    t.string "nome"
    t.string "pessoa"
    t.string "cpf"
    t.string "rg"
    t.string "cnpj"
    t.string "ie"
    t.string "endereco"
    t.string "bairro"
    t.string "cidade"
    t.string "cep"
    t.string "uf"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "localizacao_estoques", force: :cascade do |t|
    t.string "nome"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "produtos", force: :cascade do |t|
    t.bigint "localizacao_estoque_id"
    t.string "descricao"
    t.string "descricao_nfe"
    t.string "codigo_barras"
    t.string "ncm"
    t.boolean "bloquear_preco"
    t.datetime "data_ultima_reposicao"
    t.datetime "data_ultimo_reajuste"
    t.decimal "preco_custo"
    t.decimal "preco_custo_medio"
    t.decimal "margem_lucro"
    t.decimal "preco_venda"
    t.decimal "preco_oferta"
    t.decimal "margem_lucro_oferta"
    t.datetime "data_inicial_oferta"
    t.datetime "data_final_oferta"
    t.decimal "comissao_pc"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["localizacao_estoque_id"], name: "index_produtos_on_localizacao_estoque_id"
  end

  add_foreign_key "cliente_contatos", "clientes"
  add_foreign_key "fornecedor_contatos", "fornecedores"
  add_foreign_key "produtos", "localizacao_estoques"
end
