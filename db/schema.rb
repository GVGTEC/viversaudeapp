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

ActiveRecord::Schema.define(version: 2021_07_04_004002) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "administradores", force: :cascade do |t|
    t.bigint "empresa_id"
    t.string "nome"
    t.string "email"
    t.string "senha"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["empresa_id"], name: "index_administradores_on_empresa_id"
  end

  create_table "cfop", force: :cascade do |t|
    t.string "cfop_de"
    t.string "cfop_st_de"
    t.string "cfop_fe"
    t.string "cfop_st_fe"
    t.string "descricao"
    t.string "natureza_operacao"
    t.string "natureza_operacao_st"
    t.string "operacao"
    t.string "nota_complementar_impostos_sn"
    t.string "entrada_saida_es"
    t.string "cliente_fornecedor_cf"
    t.string "calcular_impostos_sn"
    t.string "faturamento_sn"
    t.string "arquivo_mensagem"
    t.text "observacao"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

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
    t.float "valor_total"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["fornecedor_id"], name: "index_contas_pag_on_fornecedor_id"
    t.index ["plano_conta_id"], name: "index_contas_pag_on_plano_conta_id"
  end

  create_table "contas_pagar_parcelas", force: :cascade do |t|
    t.bigint "contas_pag_id"
    t.datetime "data_vencimento"
    t.datetime "data_pagamento"
    t.float "valor_parcela"
    t.float "valor_juros_desconto"
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
    t.string "ultima_alteracao"
    t.date "data_reposicao"
    t.date "data_validade"
    t.float "estoque_atual_lote"
    t.float "estoque_reservado"
    t.float "preco_custo_reposicao"
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
    t.string "codcidade_ibge"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "localizacao_estoques", force: :cascade do |t|
    t.string "local"
    t.string "observacao"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "movimento_estoques", force: :cascade do |t|
    t.bigint "estoque_id"
    t.string "origem"
    t.date "data"
    t.float "qtd"
    t.float "estoque_inicial"
    t.float "estoque_final"
    t.float "preco_custo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["estoque_id"], name: "index_movimento_estoques_on_estoque_id"
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
    t.float "embalagem", default: 0.0
    t.boolean "controlar_estoque"
    t.boolean "por_lote"
    t.boolean "bloquear_preco"
    t.datetime "data_ultima_reposicao"
    t.datetime "data_ultimo_reajuste"
    t.float "preco_custo", default: 0.0
    t.float "preco_custo_medio", default: 0.0
    t.float "margem_lucro", default: 0.0
    t.float "preco_venda", default: 0.0
    t.float "preco_oferta", default: 0.0
    t.float "margem_lucro_oferta", default: 0.0
    t.datetime "data_inicial_oferta"
    t.datetime "data_final_oferta"
    t.float "comissao_pc", default: 0.0
    t.float "estoque_atual", default: 0.0
    t.float "estoque_minimo", default: 0.0
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

  add_foreign_key "administradores", "empresas"
  add_foreign_key "cliente_contatos", "clientes"
  add_foreign_key "contas_pag", "fornecedores"
  add_foreign_key "contas_pag", "plano_contas"
  add_foreign_key "contas_pagar_parcelas", "contas_pag"
  add_foreign_key "estoques", "fornecedores"
  add_foreign_key "estoques", "produtos"
  add_foreign_key "fornecedor_contatos", "fornecedores"
  add_foreign_key "movimento_estoques", "estoques"
  add_foreign_key "produtos", "localizacao_estoques"
  add_foreign_key "transportadora_contatos", "transportadoras"
end
