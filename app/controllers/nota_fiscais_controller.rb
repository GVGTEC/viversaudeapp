class NotaFiscaisController < ApplicationController
  before_action :set_nota_fiscal, only: %i[show edit update destroy gerar_nota]

  # GET /nota_fiscais or /nota_fiscais.json
  def index
    @nota_fiscais = NotaFiscal.where(empresa_id: @adm.empresa.id)

    # paginação na view index (lista)
    options = {page: params[:page] || 1, per_page: 50}
    @nota_fiscais = @nota_fiscais.paginate(options)
  end

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

      cProd = "#{item.produto.codprd_sac}"
      cEAN = ""
      xProd = "#{item.produto.descricao_nfe.strip}"
      nCM = "#{item.produto.ncm.strip}"
      nVE = ""
      cEST = ""
      indEscala = ""
      cNPJFab = ""
      cBenef = ""
      eXTIPI = ""
      cFOP = "#{item.cfop}"
      uCom = "#{item.produto.unidade}"
      qCom = "#{item.quantidade}"
      vUnCom = "#{item.preco_unitario}"
      vProd = "#{item.preco_total}"
      cEANTrib = ""
      uTrib = "#{item.produto.unidade}"
      qTrib = "#{item.quantidade}"
      vUnTrib = "#{item.preco_unitario}"
      vFrete = "#{@nota_fiscal.valor_frete}"
      vSeg = ""
      vDesc = "#{@nota_fiscal.valor_desconto}"
      vOutro = "#{@nota_fiscal.valor_outras_despesas}"
      indTot = "1"
      out_file.puts("I|#{cProd}|#{cEAN}|#{xProd}|#{nCM}|#{nVE}|#{cEST}|#{indEscala}|#{cNPJFab}|#{cBenef}|#{eXTIPI}|#{cFOP}|#{uCom}|#{qCom}|#{vUnCom}|#{vProd}|#{cEANTrib}|#{uTrib}|#{qTrib}|#{vUnTrib}|#{vFrete}|#{vSeg}|#{vDesc}|#{vOutro}|#{indTot}|")

      vTotTrib = "218.31"
      out_file.puts("M|#{vTotTrib}|")
      
      orig = "0"
      cSOSN = "102"
      out_file.puts("N|")
      out_file.puts("N10d|#{orig}|#{cSOSN}|")

      cST = "01"
      vBC = "#{item.preco_total}"
      pPIS = "#{item.aliquota_pis}"
      vPIS = "#{item.valor_pis}"
      out_file.puts("Q|")
      out_file.puts("Q02|#{cST}|#{vBC}|#{pPIS}|#{vPIS}|")
      
      cST = "01"
      vBC = "#{item.preco_total}"
      pCOFINS = "#{item.aliquota_cofins}"
      vCOFINS = "#{item.valor_cofins}"
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
    vProd = "#{@nota_fiscal.valor_produtos}"
    vFrete = "#{@nota_fiscal.valor_frete}"
    vSeg = "0.00"
    vDesc = "#{@nota_fiscal.valor_desconto}"
    vII = "0.00"
    vIPI = "0.00"
    vPIS = "2.73"
    vCOFINS = "12.60"
    vOutro = "#{@nota_fiscal.valor_outras_despesas}"
    vNF =  "#{@nota_fiscal.valor_total_nota}"
    vTotTrib = "218.31"
    out_file.puts("W02|#{vBC}|#{vICMS}|#{vICMSDeson}|#{vFCPUFDest}|#{vICMSUFDest}|#{vICMSUFRemet}|#{vBCST}|#{vST}|#{vProd}|#{vFrete}|#{vSeg}|#{vDesc}|#{vII}|#{vIPI}|#{vPIS}|#{vCOFINS}|#{vOutro}|#{vNF}|#{vTotTrib}|")
    
    # Bloco X
    modFrete = "1"
    out_file.puts("X|#{modFrete}|")

    xNome = "#{@nota_fiscal.transportadora.nome}"
    iE = "#{@nota_fiscal.transportadora.ie}"
    xEnder = "#{@nota_fiscal.transportadora.endereco}"
    xMun = "#{@nota_fiscal.transportadora.cidade}"
    uF = "#{@nota_fiscal.transportadora.uf}"
    out_file.puts("X03|#{xNome}|#{iE}|#{xEnder}|#{xMun}|#{uF}|")

    cpf = ""
    out_file.puts("X05|#{cpf}|")

    qVol = "#{@nota_fiscal.qtd_volume}"
    esp = "#{@nota_fiscal.especie}"
    marca = "#{@nota_fiscal.marca}"
    nVol = ""
    pesoL = "#{@nota_fiscal.peso_liquido}"
    pesoB = "#{@nota_fiscal.peso_bruto}"
    out_file.puts("X26|#{qVol}|#{esp}|#{marca}|#{nVol}|#{pesoL}|#{pesoB}|")

    # Bloco Y
    out_file.puts("Y|")

    nFat = "#{@nota_fiscal.numero_nota}"
    vOrig = "#{@nota_fiscal.valor_total_nota}"
    vDesc = "0.00"
    vLiq = "#{@nota_fiscal.valor_total_nota}"
    out_file.puts("Y02|#{nFat}|#{vOrig}|#{vDesc}|#{vLiq}|")

    @nota_fiscal.nota_fiscal_faturamento_parcelas.each_with_index do |faturamento_parcela, i|
      nDup = "#{faturamento_parcela.duplicata}"
      cVenc = "#{faturamento_parcela.data_vencimento}"
      vDup = "#{faturamento_parcela.valor_parcela}"
      out_file.puts("Y07|#{nDup}|#{cVenc}|#{vDup}|")
    end

    tPag = "01" 
    vPag = "#{@nota_fiscal.valor_total_nota}" 
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

  # GET /nota_fiscais/1 or /nota_fiscais/1.json
  def show
  end

  # GET /nota_fiscais/new
  def new
    @nota_fiscal = NotaFiscal.new

    params[:data_emissao] ||= Time.zone.now.strftime("%Y-%m-%d")
    @nota_fiscal.data_emissao = params[:data_emissao]

    @transportadora = Transportadora.all
    @cfop = Cfop.all
  end

  # GET /nota_fiscais/1/edit
  def edit
  end

  # POST /nota_fiscais or /nota_fiscais.json
  def create
    @nota_fiscal = NotaFiscal.new(nota_fiscal_params)
    
    respond_to do |format|
      if @nota_fiscal.save
<<<<<<< HEAD
        format.html { redirect_to new_nota_fiscal_nota_fiscal_item_path(@nota_fiscal), notice: "Nota Fiscal Cadastrada" }
=======
        salvar_nota_fiscal_transportadora
        format.html { redirect_to new_nota_fiscal_nota_fiscal_item_path(@nota_fiscal), notice: "Nota fiscal criado com sucesso." }
>>>>>>> 42141527517154d9ef483fb2aa8ad831f8d3e24e
        format.json { render :show, status: :created, location: @nota_fiscal }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @nota_fiscal.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /nota_fiscais/1 or /nota_fiscais/1.json
  def update
    respond_to do |format|
      if @nota_fiscal.update(nota_fiscal_params)
<<<<<<< HEAD
        format.html { redirect_to @nota_fiscal, notice: "Nota Fiscal Alterada" }
=======
        salvar_nota_fiscal_transportadora
        format.html { redirect_to @nota_fiscal, notice: "Nota fiscal atualizado com sucesso." }
>>>>>>> 42141527517154d9ef483fb2aa8ad831f8d3e24e
        format.json { render :show, status: :ok, location: @nota_fiscal }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @nota_fiscal.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /nota_fiscais/1 or /nota_fiscais/1.json
  def destroy
    @nota_fiscal.destroy
    respond_to do |format|
<<<<<<< HEAD
      format.html { redirect_to nota_fiscais_url, notice: "Nota Fiscal Excluída" }
=======
      format.html { redirect_to nota_fiscais_url, notice: "Nota fiscal excluído com sucesso.." }
>>>>>>> 42141527517154d9ef483fb2aa8ad831f8d3e24e
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_nota_fiscal
    @nota_fiscal = NotaFiscal.find(params[:id] || params[:nota_fiscal_id])
  end
  
  def salvar_nota_fiscal_transportadora
    NotaFiscalTransporta.where(nota_fiscal: @nota_fiscal.id).destroy_all
    if params[:nota_fiscal].has_key?(:transportadora_id)
      nota_fiscal_transporta = NotaFiscalTransporta.new
      nota_fiscal_transporta.nota_fiscal_id = @nota_fiscal.id
      nota_fiscal_transporta.transportadora_id = params[:nota_fiscal][:transportadora_id]
      nota_fiscal_transporta.quantidade = params[:quantidade]
      nota_fiscal_transporta.especie = params[:especie]
      nota_fiscal_transporta.marca = params[:marca]
      nota_fiscal_transporta.peso_liquido = params[:peso_liquido]
      nota_fiscal_transporta.peso_bruto = params[:peso_bruto]
      nota_fiscal_transporta.save
    end
  end

  # Only allow a list of trusted parameters through.
  def nota_fiscal_params
    params.require(:nota_fiscal).permit(:numero_nota, :numero_pedido, :cfop_id, :entsai, :cliente_id, :fornecedor_id, :vendedor_id, :transportadora_id, :data_emissao, :data_saida, :hora_saida, :valor_desconto, :valor_produtos, :valor_total_nota, :valor_frete, :valor_outras_despesas, :numero_pedido_compra, :tipo_pagamento, :meio_pagamento, :numero_parcelas_pagamento, :observacao, :chave_acesso_nfe, :nota_cancelada_sn)
  end
end