class GerarNotaFiscaisController < ApplicationController
  before_action :set_nota_fiscal

  def gerar_nota
    require "fileutils"

    path_tmp_nota = "tmp/nota-#{Time.now.strftime("%Y%m%d%H%M%S")}.txt"
    FileUtils.rm_rf Dir.glob("tmp/nota*.txt")

    out_file = File.new(path_tmp_nota, "w")
    empresa = Empresa.first

    # Inicio
    out_file.puts("NOTA FISCAL|1|")

    # Bloco A
    out_file.puts("A|4.00|NFe|")

    # Bloco B
    cUF = empresa.codigo_uf_emitente
    cNF = ""
    natOp = @nota_fiscal.cfop.natureza_operacao
    mod = "55"
    serie = "1"
    nNF = @nota_fiscal.numero_nota
    dhEmi = @nota_fiscal.data_emissao
    dhSaiEnt = @nota_fiscal.data_saida
    tpNF = @nota_fiscal.entsai
    idDest = "1"
    cMunFG = empresa.codcid_ibge
    tpImp = "1"
    tpEmis = "1"
    cDV = "0"
    tpAmb = "1"
    finNFe = "1"
    indFinal = "0"
    indPres = "1"
    procEmi = "3"
    verProc = empresa.versao_layout
    dhCont = ""
    xJust = ""
    out_file.puts("B|#{cUF}|#{cNF}|#{natOp}|#{mod}|#{serie}|#{nNF}|#{dhEmi}|#{dhSaiEnt}|#{tpNF}|#{idDest}|#{cMunFG}|#{tpImp}|#{tpEmis}|#{cDV}|#{tpAmb}|#{finNFe}|#{indFinal}|#{indPres}|#{procEmi}|#{verProc}|#{dhCont}|#{xJust}|")

    # Bloco C
    xNome = empresa.nome
    xFant = ""
    iE = empresa.inscricao_estadual
    iEST = ""
    iM = empresa.inscricao_municipal
    cNAE = empresa.cnae
    cRT = empresa.regime_tributario
    out_file.puts("C|#{xNome}|#{xFant}|#{iE}|#{iEST}|#{iM}|#{cNAE}|#{cRT}|")

    cnpj = empresa.cnpj
    out_file.puts("C02|#{cnpj}|")

    xLgr = empresa.endereco
    nro = empresa.numero
    xCpl = empresa.complemento
    xBairro = empresa.bairro
    cMun = empresa.codcid_ibge
    xMun = empresa.cidade
    uf = empresa.uf
    cep = empresa.cep
    cPais = "1058"
    xPais = "BRASIL"
    fone = empresa.telefone
    out_file.puts("C05|#{xLgr}|#{nro}|#{xCpl}|#{xBairro}|#{cMun}|#{xMun}|#{uf}|#{cep}|#{cPais}|#{xPais}|#{fone}|")

    # Bloco E
    xNome = @nota_fiscal.cliente.nome.strip
    indIEDest = "1"
    ie = @nota_fiscal.cliente.ie
    isuf = ""
    im = ""
    email = @nota_fiscal.cliente.email.strip
    out_file.puts("E|#{xNome}|#{indIEDest}|#{ie}|#{isuf}|#{im}|#{email}|")

    cnpj = @nota_fiscal.cliente.cnpj.strip
    out_file.puts("E02|#{cnpj}|")

    xLgr = @nota_fiscal.cliente.endereco.strip
    nro = "00000"
    xCpl = ""
    xBairro = @nota_fiscal.cliente.bairro.strip
    cMun = @nota_fiscal.cliente.codcidade_ibge.strip
    xMun = @nota_fiscal.cliente.cidade.strip
    uf = @nota_fiscal.cliente.uf.strip
    cep = @nota_fiscal.cliente.cep.strip
    cPais = "1058"
    xPais = "BRASIL"
    fone = @nota_fiscal.cliente.telefone_nf.strip
    out_file.puts("E05|#{xLgr}|#{nro}|#{xCpl}|#{xBairro}|#{cMun}|#{xMun}|#{uf}|#{cep}|#{cPais}|#{xPais}|#{fone}|")

    @nota_fiscal.nota_fiscal_itens.each_with_index do |item, i|
      # Bloco Prod
      out_file.puts("H|#{i + 1}||")

      cProd = item.produto.codprd_sac.to_s
      cEAN = ""
      xProd = item.produto.descricao_nfe.strip.to_s
      nCM = item.produto.ncm.strip.to_s
      nVE = ""
      cEST = ""
      indEscala = ""
      cNPJFab = ""
      cBenef = ""
      eXTIPI = ""
      cFOP = item.cfop.to_s
      uCom = item.produto.unidade.to_s
      qCom = item.quantidade.to_s
      vUnCom = item.preco_unitario.to_s
      vProd = item.preco_total.to_s
      cEANTrib = ""
      uTrib = item.produto.unidade.to_s
      qTrib = item.quantidade.to_s
      vUnTrib = item.preco_unitario.to_s
      vFrete = @nota_fiscal.valor_frete.to_s
      vSeg = ""
      vDesc = @nota_fiscal.valor_desconto.to_s
      vOutro = @nota_fiscal.valor_outras_despesas.to_s
      indTot = "1"
      out_file.puts("I|#{cProd}|#{cEAN}|#{xProd}|#{nCM}|#{nVE}|#{cEST}|#{indEscala}|#{cNPJFab}|#{cBenef}|#{eXTIPI}|#{cFOP}|#{uCom}|#{qCom}|#{vUnCom}|#{vProd}|#{cEANTrib}|#{uTrib}|#{qTrib}|#{vUnTrib}|#{vFrete}|#{vSeg}|#{vDesc}|#{vOutro}|#{indTot}|")

      vTotTrib = "218.31"
      out_file.puts("M|#{vTotTrib}|")

      orig = "0"
      cSOSN = "102"
      out_file.puts("N|")
      out_file.puts("N10d|#{orig}|#{cSOSN}|")

      cST = "01"
      vBC = item.preco_total.to_s
      pPIS = item.aliquota_pis.to_s
      vPIS = item.valor_pis.to_s
      out_file.puts("Q|")
      out_file.puts("Q02|#{cST}|#{vBC}|#{pPIS}|#{vPIS}|")

      cST = "01"
      vBC = item.preco_total.to_s
      pCOFINS = item.aliquota_cofins.to_s
      vCOFINS = item.valor_cofins.to_s
      out_file.puts("S|")
      out_file.puts("S02|#{cST}|#{vBC}|#{pCOFINS}|#{vCOFINS}|")
    end

    # Bloco W
    out_file.puts("W|")

    vBC = "0.00"
    vICMS = "0.00"
    vICMSDeson = "0.00"
    vFCPUFDest = "0.00"
    vICMSUFDest = "0.00"
    vICMSUFRemet = "0.00"
    vBCST = "0.00"
    vST = "0.00"
    vProd = @nota_fiscal.valor_produtos.to_s
    vFrete = @nota_fiscal.valor_frete.to_s
    vSeg = "0.00"
    vDesc = @nota_fiscal.valor_desconto.to_s
    vII = "0.00"
    vIPI = "0.00"
    vPIS = "2.73"
    vCOFINS = "12.60"
    vOutro = @nota_fiscal.valor_outras_despesas.to_s
    vNF = @nota_fiscal.valor_total_nota.to_s
    vTotTrib = "218.31"
    out_file.puts("W02|#{vBC}|#{vICMS}|#{vICMSDeson}|#{vFCPUFDest}|#{vICMSUFDest}|#{vICMSUFRemet}|#{vBCST}|#{vST}|#{vProd}|#{vFrete}|#{vSeg}|#{vDesc}|#{vII}|#{vIPI}|#{vPIS}|#{vCOFINS}|#{vOutro}|#{vNF}|#{vTotTrib}|")

    # Bloco X
    modFrete = "1"
    out_file.puts("X|#{modFrete}|")

    xNome = @nota_fiscal.transportadora.nome.to_s
    iE = @nota_fiscal.transportadora.ie.to_s
    xEnder = @nota_fiscal.transportadora.endereco.to_s
    xMun = @nota_fiscal.transportadora.cidade.to_s
    uF = @nota_fiscal.transportadora.uf.to_s
    out_file.puts("X03|#{xNome}|#{iE}|#{xEnder}|#{xMun}|#{uF}|")

    cpf = ""
    out_file.puts("X05|#{cpf}|")

    qVol = @nota_fiscal.nota_fiscal_transporta.quantidade.to_s
    esp = @nota_fiscal.nota_fiscal_transporta.especie.to_s
    marca = @nota_fiscal.nota_fiscal_transporta.marca.to_s
    nVol = ""
    pesoL = @nota_fiscal.nota_fiscal_transporta.peso_liquido.to_s
    pesoB = @nota_fiscal.nota_fiscal_transporta.peso_bruto.to_s
    out_file.puts("X26|#{qVol}|#{esp}|#{marca}|#{nVol}|#{pesoL}|#{pesoB}|")

    # Bloco Y
    out_file.puts("Y|")

    nFat = @nota_fiscal.numero_nota.to_s
    vOrig = @nota_fiscal.valor_total_nota.to_s
    vDesc = "0.00"
    vLiq = @nota_fiscal.valor_total_nota.to_s
    out_file.puts("Y02|#{nFat}|#{vOrig}|#{vDesc}|#{vLiq}|")

    @nota_fiscal.nota_fiscal_faturamento_parcelas.each_with_index do |faturamento_parcela, i|
      nDup = faturamento_parcela.duplicata.to_s
      cVenc = faturamento_parcela.data_vencimento.to_s
      vDup = faturamento_parcela.valor_parcela.to_s
      out_file.puts("Y07|#{nDup}|#{cVenc}|#{vDup}|")
    end

    tPag = "01"
    vPag = @nota_fiscal.valor_total_nota.to_s
    cNPJ = ""
    tBand = ""
    cAut = ""
    out_file.puts("YA|#{tPag}|#{vPag}|#{cNPJ}|#{tBand}|#{cAut}|")

    out_file.puts("YA01||01|420.00|")

    # Bloco Z
    out_file.puts("Z|||")

    out_file.close

    send_file path_tmp_nota
  end

  private

  def set_nota_fiscal
    @nota_fiscal = NotaFiscal.find(params[:nota_fiscal_id])
  end
end
