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

ActiveRecord::Schema.define(version: 2022_02_01_000113) do

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
    t.bigint "empresa_id"
    t.string "codigo"
    t.string "informativo"
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
    t.index ["empresa_id"], name: "index_cfop_on_empresa_id"
  end

  create_table "cliente_contatos", force: :cascade do |t|
    t.bigint "cliente_id"
    t.string "nome"
    t.string "telefone"
    t.string "email"
    t.string "cargo"
    t.string "departamento"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cliente_id"], name: "index_cliente_contatos_on_cliente_id"
  end

  create_table "clientes", force: :cascade do |t|
    t.bigint "empresa_id"
    t.bigint "vendedor_id"
    t.bigint "terceiro_id"
    t.integer "codcli_sac"
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
    t.string "telefone_alternativo"
    t.string "telefone_nf"
    t.string "email"
    t.string "codcidade_ibge"
    t.boolean "empresa_governo", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "consumidor_final"
    t.index ["empresa_id"], name: "index_clientes_on_empresa_id"
    t.index ["terceiro_id"], name: "index_clientes_on_terceiro_id"
    t.index ["vendedor_id"], name: "index_clientes_on_vendedor_id"
  end

  create_table "contas_pag", force: :cascade do |t|
    t.bigint "empresa_id"
    t.bigint "fornecedor_id"
    t.bigint "plano_conta_id"
    t.string "documento"
    t.string "historico"
    t.datetime "data_emissao"
    t.float "valor_total"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["empresa_id"], name: "index_contas_pag_on_empresa_id"
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

  create_table "contas_rec", force: :cascade do |t|
    t.bigint "empresa_id"
    t.bigint "cliente_id"
    t.bigint "plano_conta_id"
    t.string "documento"
    t.string "historico"
    t.datetime "data_emissao"
    t.float "valor_total"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cliente_id"], name: "index_contas_rec_on_cliente_id"
    t.index ["empresa_id"], name: "index_contas_rec_on_empresa_id"
    t.index ["plano_conta_id"], name: "index_contas_rec_on_plano_conta_id"
  end

  create_table "contas_rec_parcelas", force: :cascade do |t|
    t.bigint "contas_rec_id"
    t.datetime "data_vencimento"
    t.datetime "data_recebimento"
    t.float "valor_parcela"
    t.float "valor_juros_desconto"
    t.string "documento"
    t.string "descricao"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["contas_rec_id"], name: "index_contas_rec_parcelas_on_contas_rec_id"
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
    t.bigint "empresa_id"
    t.bigint "produto_id"
    t.bigint "fornecedor_id"
    t.string "codprd_sac"
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
    t.index ["empresa_id"], name: "index_estoques_on_empresa_id"
    t.index ["fornecedor_id"], name: "index_estoques_on_fornecedor_id"
    t.index ["produto_id"], name: "index_estoques_on_produto_id"
  end

  create_table "fornecedor_contatos", force: :cascade do |t|
    t.bigint "fornecedor_id"
    t.string "nome"
    t.string "telefone"
    t.string "email"
    t.string "cargo"
    t.string "departamento"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["fornecedor_id"], name: "index_fornecedor_contatos_on_fornecedor_id"
  end

  create_table "fornecedores", force: :cascade do |t|
    t.bigint "empresa_id"
    t.integer "codfor_sac"
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
    t.string "telefone_alternativo"
    t.string "telefone_nf"
    t.string "email"
    t.string "codcidade_ibge"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["empresa_id"], name: "index_fornecedores_on_empresa_id"
  end

  create_table "icms", force: :cascade do |t|
    t.string "estado"
    t.float "aliquota_icms"
    t.float "aliquota_icms_st"
    t.float "mva_icms_st"
    t.string "fcp_sn"
    t.float "fcp_pc"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "localizacao_estoques", force: :cascade do |t|
    t.bigint "empresa_id"
    t.string "local"
    t.string "observacao"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["empresa_id"], name: "index_localizacao_estoques_on_empresa_id"
  end

  create_table "movimento_estoques", force: :cascade do |t|
    t.bigint "produto_id"
    t.bigint "estoque_id"
    t.string "origem"
    t.date "data"
    t.float "qtd"
    t.float "estoque_inicial"
    t.float "estoque_final"
    t.float "preco_custo"
    t.string "motivo_operacao"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "nota_fiscal_id"
    t.bigint "empresa_id"
    t.index ["empresa_id"], name: "index_movimento_estoques_on_empresa_id"
    t.index ["estoque_id"], name: "index_movimento_estoques_on_estoque_id"
    t.index ["produto_id"], name: "index_movimento_estoques_on_produto_id"
  end

# Could not dump table "nota_fiscais" because of following StandardError
#   Unknown type 'contas_rec' for column 'references'

  create_table "nota_fiscal_chave_acessos", force: :cascade do |t|
    t.bigint "nota_fiscal_id"
    t.string "chave_acesso"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["nota_fiscal_id"], name: "index_nota_fiscal_chave_acessos_on_nota_fiscal_id"
  end

  create_table "nota_fiscal_faturamento_parcelas", force: :cascade do |t|
    t.bigint "nota_fiscal_id"
    t.string "duplicata"
    t.integer "prazo_pagamento"
    t.datetime "data_vencimento"
    t.float "valor_parcela"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["nota_fiscal_id"], name: "index_nota_fiscal_faturamento_parcelas_on_nota_fiscal_id"
  end

  create_table "nota_fiscal_impostos", force: :cascade do |t|
    t.bigint "nota_fiscal_id"
    t.float "valor_bc_icms"
    t.float "valor_icms"
    t.float "valor_bc_icms_st"
    t.float "valor_icms_st"
    t.float "valor_pis"
    t.float "valor_cofins"
    t.float "valor_ipi"
    t.float "valor_difal"
    t.float "valor_fcp"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["nota_fiscal_id"], name: "index_nota_fiscal_impostos_on_nota_fiscal_id"
  end

  create_table "nota_fiscal_item_lotes", force: :cascade do |t|
    t.bigint "nota_fiscal_item_id"
    t.float "estoque_inicial"
    t.float "estoque_final"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "qtd"
    t.bigint "estoque_id"
    t.index ["estoque_id"], name: "index_nota_fiscal_item_lotes_on_estoque_id"
    t.index ["nota_fiscal_item_id"], name: "index_nota_fiscal_item_lotes_on_nota_fiscal_item_id"
  end

  create_table "nota_fiscal_itens", force: :cascade do |t|
    t.bigint "nota_fiscal_id"
    t.bigint "produto_id"
    t.text "descricao"
    t.string "cfop"
    t.string "st"
    t.string "ncm"
    t.string "cst"
    t.string "unidade"
    t.float "quantidade"
    t.float "preco_unitario"
    t.float "preco_total"
    t.float "aliquota_icms", default: 0.0
    t.float "valor_bc_icms", default: 0.0
    t.float "valor_icms", default: 0.0
    t.float "aliquota_icms_st", default: 0.0
    t.float "valor_bc_icms_st", default: 0.0
    t.float "valor_icms_st", default: 0.0
    t.float "aliquota_ipi", default: 0.0
    t.float "valor_ipi", default: 0.0
    t.float "aliquota_pis", default: 0.0
    t.float "valor_pis", default: 0.0
    t.float "aliquota_cofins", default: 0.0
    t.float "valor_cofins", default: 0.0
    t.float "aliquota_difal", default: 0.0
    t.float "valor_difal", default: 0.0
    t.float "valor_fcp", default: 0.0
    t.float "aliquota_fcp", default: 0.0
    t.string "local_estoque"
    t.boolean "baixou_estoque"
    t.string "pagar_comissao_sn"
    t.float "comissao_ven_pc"
    t.float "comissao_ven_vr"
    t.float "comissao_ter_pc"
    t.float "comissao_ter_vr"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["nota_fiscal_id"], name: "index_nota_fiscal_itens_on_nota_fiscal_id"
    t.index ["produto_id"], name: "index_nota_fiscal_itens_on_produto_id"
  end

  create_table "nota_fiscal_transportas", force: :cascade do |t|
    t.bigint "nota_fiscal_id"
    t.bigint "transportadora_id"
    t.integer "paga_frete"
    t.string "numero_coleta"
    t.datetime "data_coleta"
    t.string "hora_coleta"
    t.string "quantidade"
    t.string "especie"
    t.string "marca"
    t.string "numero"
    t.string "peso_liquido"
    t.string "peso_bruto"
    t.string "placa_veiculo"
    t.string "estado_veiculo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["nota_fiscal_id"], name: "index_nota_fiscal_transportas_on_nota_fiscal_id"
    t.index ["transportadora_id"], name: "index_nota_fiscal_transportas_on_transportadora_id"
  end

  create_table "orcamento_itens", force: :cascade do |t|
    t.bigint "orcamento_id"
    t.bigint "produto_id"
    #t.string "unidade"
    t.float "quantidade"
    t.float "preco_unitario"
    t.float "preco_total"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["orcamento_id"], name: "index_orcamento_itens_on_orcamento_id"
    t.index ["produto_id"], name: "index_orcamento_itens_on_produto_id"
  end

  create_table "orcamentos", force: :cascade do |t|
    t.bigint "cliente_id"
    t.bigint "vendedor_id"
    t.datetime "data_emissao"
    t.float "valor_total"
    t.text "observacao"
    t.string "flag"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "valor_sub_total"
    t.float "valor_desconto"
    t.index ["cliente_id"], name: "index_orcamentos_on_cliente_id"
    t.index ["vendedor_id"], name: "index_orcamentos_on_vendedor_id"
  end

  create_table "plano_contas", force: :cascade do |t|
    t.bigint "empresa_id"
    t.string "conta"
    t.string "descricao"
    t.string "grau"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["empresa_id"], name: "index_plano_contas_on_empresa_id"
  end

  create_table "produtos", force: :cascade do |t|
    t.bigint "empresa_id"
    t.bigint "localizacao_estoque_id"
    t.bigint "fornecedor_id"
    t.string "codprd_sac"
    t.string "situacao"
    t.datetime "data_inativo"
    t.string "descricao"
    t.string "descricao_nfe"
    t.string "codigo_fabricante"
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
    t.string "origem"
    t.index ["empresa_id"], name: "index_produtos_on_empresa_id"
    t.index ["fornecedor_id"], name: "index_produtos_on_fornecedor_id"
    t.index ["localizacao_estoque_id"], name: "index_produtos_on_localizacao_estoque_id"
  end

  create_table "terceiros", force: :cascade do |t|
    t.bigint "empresa_id"
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
    t.index ["empresa_id"], name: "index_terceiros_on_empresa_id"
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
    t.bigint "empresa_id"
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
    t.index ["empresa_id"], name: "index_transportadoras_on_empresa_id"
  end

  create_table "vendedores", force: :cascade do |t|
    t.bigint "empresa_id"
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
    t.index ["empresa_id"], name: "index_vendedores_on_empresa_id"
  end

  add_foreign_key "administradores", "empresas"
  add_foreign_key "cfop", "empresas"
  add_foreign_key "cliente_contatos", "clientes"
  add_foreign_key "clientes", "empresas"
  add_foreign_key "clientes", "terceiros"
  add_foreign_key "clientes", "vendedores"
  add_foreign_key "contas_pag", "empresas"
  add_foreign_key "contas_pag", "fornecedores"
  add_foreign_key "contas_pag", "plano_contas"
  add_foreign_key "contas_pagar_parcelas", "contas_pag"
  add_foreign_key "contas_rec", "clientes"
  add_foreign_key "contas_rec", "empresas"
  add_foreign_key "contas_rec", "plano_contas"
  add_foreign_key "contas_rec_parcelas", "contas_rec"
  add_foreign_key "estoques", "empresas"
  add_foreign_key "estoques", "fornecedores"
  add_foreign_key "estoques", "produtos"
  add_foreign_key "fornecedor_contatos", "fornecedores"
  add_foreign_key "fornecedores", "empresas"
  add_foreign_key "localizacao_estoques", "empresas"
  add_foreign_key "movimento_estoques", "empresas"
  add_foreign_key "movimento_estoques", "estoques"
  add_foreign_key "movimento_estoques", "produtos"
  add_foreign_key "nota_fiscais", "cfop"
  add_foreign_key "nota_fiscais", "clientes"
  add_foreign_key "nota_fiscais", "contas_rec"
  add_foreign_key "nota_fiscais", "empresas"
  add_foreign_key "nota_fiscais", "fornecedores"
  add_foreign_key "nota_fiscais", "transportadoras"
  add_foreign_key "nota_fiscais", "vendedores"
  add_foreign_key "nota_fiscal_chave_acessos", "nota_fiscais"
  add_foreign_key "nota_fiscal_faturamento_parcelas", "nota_fiscais"
  add_foreign_key "nota_fiscal_impostos", "nota_fiscais"
  add_foreign_key "nota_fiscal_item_lotes", "estoques"
  add_foreign_key "nota_fiscal_item_lotes", "nota_fiscal_itens"
  add_foreign_key "nota_fiscal_itens", "nota_fiscais"
  add_foreign_key "nota_fiscal_itens", "produtos"
  add_foreign_key "nota_fiscal_transportas", "nota_fiscais"
  add_foreign_key "nota_fiscal_transportas", "transportadoras"
  add_foreign_key "orcamento_itens", "orcamentos"
  add_foreign_key "orcamento_itens", "produtos"
  add_foreign_key "orcamentos", "clientes"
  add_foreign_key "orcamentos", "vendedores"
  add_foreign_key "plano_contas", "empresas"
  add_foreign_key "produtos", "empresas"
  add_foreign_key "produtos", "fornecedores"
  add_foreign_key "produtos", "localizacao_estoques"
  add_foreign_key "terceiros", "empresas"
  add_foreign_key "transportadora_contatos", "transportadoras"
  add_foreign_key "transportadoras", "empresas"
  add_foreign_key "vendedores", "empresas"
end
