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

ActiveRecord::Schema.define(version: 2021_06_16_041348) do

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

  create_table "contas_pag", force: :cascade do |t|
    t.bigint "fornecedor_id"
    t.bigint "plano_conta_id"
    t.string "documento"
    t.string "historico"
    t.datetime "data_emissao"
    t.decimal "valor_total"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["fornecedor_id"], name: "index_contas_pag_on_fornecedor_id"
    t.index ["plano_conta_id"], name: "index_contas_pag_on_plano_conta_id"
  end

  create_table "contas_pagar_parcelas", force: :cascade do |t|
    t.bigint "contas_pag_id"
    t.datetime "data_vencimento"
    t.datetime "data_pagamento"
    t.decimal "valor_parcela"
    t.decimal "valor_juros_desconto"
    t.string "documento"
    t.string "descricao"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["contas_pag_id"], name: "index_contas_pagar_parcelas_on_contas_pag_id"
  end

  create_table "contatos", force: :cascade do |t|
    t.string "nome"
    t.string "email"
    t.string "telefone"
    t.string "natureza"
    t.bigint "natureza_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "empresas", force: :cascade do |t|
    t.string "nome"
    t.string "nome_fantasia"
    t.string "cnpj"
    t.string "inscricao_estadual"
    t.string "inscricao_municipal"
    t.string "endereco"
    t.string "numero"
    t.string "complemento"
    t.string "bairro"
    t.string "cidade"
    t.string "cep"
    t.string "uf"
    t.string "telefone"
    t.string "email"
    t.string "codigo_uf_emitente"
    t.string "codcid_ibge"
    t.string "aliquota_pis"
    t.string "aliquota_cofins"
    t.string "serie_nfe"
    t.string "cnae"
    t.string "ambiente"
    t.string "versao_layout"
    t.string "regime_tributario"
    t.string "emissor_nfe"
    t.string "permite_credito_icms"
    t.string "credito_icms_pc"
    t.string "empresa_uninfe"
    t.string "pasta_envio"
    t.string "pasta_retorno"
    t.string "senha"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "estoques", force: :cascade do |t|
    t.bigint "produto_id"
    t.bigint "fornecedor_id"
    t.string "lote"
    t.string "documento"
    t.integer "qtd"
    t.date "data_reposicao"
    t.date "data_validade"
    t.decimal "estoque_atual"
    t.decimal "estoque_minimo"
    t.decimal "estoque_reservado"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["fornecedor_id"], name: "index_estoques_on_fornecedor_id"
    t.index ["produto_id"], name: "index_estoques_on_produto_id"
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

  create_table "plano_contas", force: :cascade do |t|
    t.string "conta"
    t.string "descricao"
    t.string "grau"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "produtos", force: :cascade do |t|
    t.bigint "localizacao_estoque_id"
    t.boolean "situacao"
    t.datetime "data_inativo"
    t.string "descricao"
    t.string "descricao_nfe"
    t.string "codigo_barras"
    t.string "ncm"
    t.string "situacao_tributaria"
    t.string "unidade"
    t.decimal "embalagem"
    t.boolean "controlar_estoque"
    t.boolean "por_lote"
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

  create_table "transportadora_contatos", force: :cascade do |t|
    t.bigint "transportadora_id"
    t.string "nome"
    t.string "telefone"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["transportadora_id"], name: "index_transportadora_contatos_on_transportadora_id"
  end

  create_table "transportadoras", force: :cascade do |t|
    t.string "nome"
    t.string "cnpj"
    t.string "ie"
    t.string "endereco"
    t.string "bairro"
    t.string "cidade"
    t.string "cep"
    t.string "uf"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "vendedores", force: :cascade do |t|
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
    t.string "telefone"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "cliente_contatos", "clientes"
  add_foreign_key "contas_pag", "fornecedores"
  add_foreign_key "contas_pag", "plano_contas"
  add_foreign_key "contas_pagar_parcelas", "contas_pag"
  add_foreign_key "estoques", "fornecedores"
  add_foreign_key "estoques", "produtos"
  add_foreign_key "fornecedor_contatos", "fornecedores"
  add_foreign_key "produtos", "localizacao_estoques"
  add_foreign_key "transportadora_contatos", "transportadoras"
end
