Empresa.create(
  nome: "Viver Saúde",
  nome_fantasia: "Viver Saúde",
  cnpj: "15652029000125",
  inscricao_estadual: "145341536113",
  inscricao_municipal: "",
  endereco: "Av Tomaz Rabelo e Silva",
  numero: "310",
  complemento: nil,
  bairro: "Jardim Monte Alegre",
  cidade: "São Paulo",
  cep: "02811000",
  uf: "SP",
  telefone: "1125748367",
  email: "",
  codigo_uf_emitente: "35",
  codcid_ibge: "3550308",
  aliquota_pis: "3",
  aliquota_cofins: "0.65",
  serie_nfe: "001",
  cnae: "",
  ambiente: "1",
  versao_layout: "2.1.1",
  regime_tributario: "3",
  emissor_nfe: "P",
  permite_credito_icms: "N",
  credito_icms_pc: "",
  empresa_uninfe: nil,
  pasta_envio: "",
  pasta_retorno: "",
  senha: "")

Administrador.create(nome: 'Thiago', email: 'malaquiastech@gmail.com', senha: '123456', empresa_id: Empresa.first.id)
Administrador.create(nome: 'Gilberto', email: 'gvgtec@terra.com.br', senha: '123456', empresa_id: Empresa.first.id)

Icms.create(estado: 'AC', aliquota_icms: 0o7, aliquota_icms_st: 0, mva_icms_st: 0, fcp_sn: 'N', fcp_pc: 0)
Icms.create(estado: 'AL', aliquota_icms: 0o7, aliquota_icms_st: 0, mva_icms_st: 0, fcp_sn: 'N', fcp_pc: 0)
Icms.create(estado: 'AP', aliquota_icms: 0o7, aliquota_icms_st: 0, mva_icms_st: 0, fcp_sn: 'N', fcp_pc: 0)
Icms.create(estado: 'AM', aliquota_icms: 0o7, aliquota_icms_st: 0, mva_icms_st: 0, fcp_sn: 'N', fcp_pc: 0)
Icms.create(estado: 'BA', aliquota_icms: 0o7, aliquota_icms_st: 0, mva_icms_st: 0, fcp_sn: 'N', fcp_pc: 0)
Icms.create(estado: 'CE', aliquota_icms: 0o7, aliquota_icms_st: 0, mva_icms_st: 0, fcp_sn: 'N', fcp_pc: 0)
Icms.create(estado: 'DF', aliquota_icms: 0o7, aliquota_icms_st: 0, mva_icms_st: 0, fcp_sn: 'N', fcp_pc: 0)
Icms.create(estado: 'ES', aliquota_icms: 0o7, aliquota_icms_st: 0, mva_icms_st: 0, fcp_sn: 'N', fcp_pc: 0)
Icms.create(estado: 'GO', aliquota_icms: 0o7, aliquota_icms_st: 0, mva_icms_st: 0, fcp_sn: 'N', fcp_pc: 0)
Icms.create(estado: 'MA', aliquota_icms: 0o7, aliquota_icms_st: 0, mva_icms_st: 0, fcp_sn: 'N', fcp_pc: 0)
Icms.create(estado: 'MT', aliquota_icms: 0o7, aliquota_icms_st: 0, mva_icms_st: 0, fcp_sn: 'N', fcp_pc: 0)
Icms.create(estado: 'MS', aliquota_icms: 0o7, aliquota_icms_st: 0, mva_icms_st: 0, fcp_sn: 'N', fcp_pc: 0)
Icms.create(estado: 'MG', aliquota_icms: 12, aliquota_icms_st: 0, mva_icms_st: 0, fcp_sn: 'N', fcp_pc: 0)
Icms.create(estado: 'PA', aliquota_icms: 0o7, aliquota_icms_st: 0, mva_icms_st: 0, fcp_sn: 'N', fcp_pc: 0)
Icms.create(estado: 'PB', aliquota_icms: 0o7, aliquota_icms_st: 0, mva_icms_st: 0, fcp_sn: 'N', fcp_pc: 0)
Icms.create(estado: 'PR', aliquota_icms: 12, aliquota_icms_st: 0, mva_icms_st: 0, fcp_sn: 'N', fcp_pc: 0)
Icms.create(estado: 'PE', aliquota_icms: 0o7, aliquota_icms_st: 0, mva_icms_st: 0, fcp_sn: 'N', fcp_pc: 0)
Icms.create(estado: 'PI', aliquota_icms: 0o7, aliquota_icms_st: 0, mva_icms_st: 0, fcp_sn: 'N', fcp_pc: 0)
Icms.create(estado: 'RN', aliquota_icms: 0o7, aliquota_icms_st: 0, mva_icms_st: 0, fcp_sn: 'N', fcp_pc: 0)
Icms.create(estado: 'RS', aliquota_icms: 12, aliquota_icms_st: 0, mva_icms_st: 0, fcp_sn: 'N', fcp_pc: 0)
Icms.create(estado: 'RJ', aliquota_icms: 12, aliquota_icms_st: 0, mva_icms_st: 0, fcp_sn: 'N', fcp_pc: 0)
Icms.create(estado: 'RO', aliquota_icms: 0o7, aliquota_icms_st: 0, mva_icms_st: 0, fcp_sn: 'N', fcp_pc: 0)
Icms.create(estado: 'RR', aliquota_icms: 0o7, aliquota_icms_st: 0, mva_icms_st: 0, fcp_sn: 'N', fcp_pc: 0)
Icms.create(estado: 'SC', aliquota_icms: 12, aliquota_icms_st: 0, mva_icms_st: 0, fcp_sn: 'N', fcp_pc: 0)
Icms.create(estado: 'SP', aliquota_icms: 18, aliquota_icms_st: 0, mva_icms_st: 0, fcp_sn: 'N', fcp_pc: 0)
Icms.create(estado: 'SE', aliquota_icms: 0o7, aliquota_icms_st: 0, mva_icms_st: 0, fcp_sn: 'N', fcp_pc: 0)
Icms.create(estado: 'TO', aliquota_icms: 0o7, aliquota_icms_st: 0, mva_icms_st: 0, fcp_sn: 'N', fcp_pc: 0)
