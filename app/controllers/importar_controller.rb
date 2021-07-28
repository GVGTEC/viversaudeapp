class ImportarController < ApplicationController
    def clientes
    end

    def produtos
    end

    def fornecedores
    end

    def estoques
    end
    
    def importar
        begin
          if params[:arquivo].blank?
            flash[:error] = "Selecione um arquivo .CSV"
            redirect_to "/importar/importar"
            return
          end
      
          if File.basename(params[:arquivo].tempfile).include?(".CSV")
            importar_csv
          else
            flash[:error] = "Formato de arquivo não suportado. Selecione um arquivo com a extenção .CSV"
            redirect_to "/importar"
            return
          end
      
          flash[:sucesso] = "Produtos importados com sucesso"
          redirect_to "/importar"
        rescue => exception
          flash[:error] = exception
          redirect_to "/importar"
          return
        end
      end
    
      def importar_csv
        File.foreach(params[:arquivo].tempfile) do |line|
          d = CharlockHolmes::EncodingDetector.detect(line)
          line = line.to_s.encode("UTF-8", d[:encoding], invalid: :replace, replace: "")
          if line.present?
            importar_linha(line.split(";"))
          end
        end
      end
    
      def importar_linha(linha)
        codprd_sac = 0
        situacao = 1 #se branco ele esta ativo
        codigo_fabricante = 2
        codigo_barras = 3
        descricao = 4
        descricao_nfe = 5
        fornecedor_id = 6 
        situacao_tributaria = 10 
        ncm = 12
        unidade = 14
        preco_custo_medio = 15 # duas casas decimais
        preco_custo = 16 # duas casas decimais
        margem_lucro = 17 #4 casas decimais
        preco_venda = 18
        margem_lucro_oferta = 19
        preco_oferta = 20
        data_inicial_oferta = 21
        data_final_oferta = 22
        controlar_estoque = 23
        estoque_atual = 24
        estoque_minimo = 25
        data_ultimo_reajuste = 28
        comissao_pc = 31
        bloquear_preco = 32
        localizacao_estoque_id = 33
    
        begin
          produto = Produto.new
          produto.codprd_sac = linha[codprd_sac]
          produto.situacao = linha[situacao].present?? false : true
          produto.codigo_fabricante = linha[codigo_fabricante]
          produto.codigo_barras = linha[codigo_barras]
          produto.descricao = linha[descricao]
          produto.descricao_nfe = linha[descricao_nfe]
    
          begin
            produto.fornecedor_id = Fornecedor.find(linha[fornecedor_id].to_i).id
          rescue 
            produto.fornecedor_id = Fornecedor.create(id: linha[fornecedor_id].to_i).id
          end
    
          produto.situacao_tributaria = linha[situacao_tributaria]
          produto.ncm = linha[ncm]
          produto.unidade = linha[unidade]
          produto.preco_custo_medio = separate_comma(linha[preco_custo_medio].to_i)
          produto.preco_custo = separate_comma(linha[preco_custo].to_i) 
          produto.margem_lucro = separate_margem(linha[margem_lucro].to_i) 
          produto.preco_venda = separate_comma(linha[preco_venda].to_i)
          produto.margem_lucro_oferta = separate_margem(linha[margem_lucro_oferta].to_i)
          produto.preco_oferta = separate_comma(linha[preco_oferta].to_i)
          produto.data_inicial_oferta = linha[data_inicial_oferta]
          produto.controlar_estoque = linha[controlar_estoque]
          produto.estoque_atual = linha[estoque_atual]
          produto.estoque_minimo = linha[estoque_minimo]
          produto.data_ultimo_reajuste = linha[data_ultimo_reajuste]
          produto.comissao_pc = linha[comissao_pc]
          produto.bloquear_preco = linha[bloquear_preco]
    
          begin
            produto.localizacao_estoque_id = LocalizacaoEstoque.find(linha[localizacao_estoque_id].to_i).id
          rescue 
            produto.localizacao_estoque_id = LocalizacaoEstoque.create(id: linha[localizacao_estoque_id].to_i).id
          end
    
          produto.save
        rescue Exception => err
          raise err
          Rails.logger.error err.message
        end
      end

end
