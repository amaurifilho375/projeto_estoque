class MovimentationController < ApplicationController
  skip_before_action :verify_authenticity_token
      def index

      end
      
      def new 
        @movimentation = Movimentation.new

      end 
 
      def create_show
        @movimentation = Movimentation.new(movimentation_params)
        @movimentation.save(validate: false)
            
      end


      def importar
            #file = params["csv"].tempfile.path   
            #"COMECO DO IMPORTAR"
            if params["csv"].nil? 
                  render :index 
                    

            else 
                    erros = [] 
                      file = params["csv"].tempfile.path
                      File.open(file).each do |row|
                      begin 
                        row = row.split(",")
                        next if row[0] == "Movimentacoes" 
                        
                        nDeposito = row[0].strip rescue row[0]
                        data = row[1].strip rescue row[1]
                        tipo = row[2].strip rescue row[2]
                        nProduto = row[3].strip rescue row[3]
                        quantidade = row[4].strip rescue row[4]
                       
                      if tipo =="E"
                      
                          existeArm = Storage.find_by(name: nDeposito.strip)
                          existeProd = Product.find_by(name: nProduto.strip)
                           
                         if  existeProd.nil?
                              
                              @movimentacaoCadastro = Movimentation.new(type: tipo, quantities: quantidade, date: data )  
                              @movimentacaoCadastro.save
                              @movimentacaoCadastro = @movimentacaoCadastro.products.new(name: nProduto, movimentation_id: @movimentacaoCadastro.id)
                              @movimentacaoCadastro.save
                              
                        
                          else
                            @movimentacaoCadastro = Movimentation.new(type: tipo, quantities: quantidade, date: data )  
                            @movimentacaoCadastro.save
                            
                            @movimentacaoCadastro = @movimentacaoCadastro.products.new(name: nProduto, movimentation_id: @movimentacaoCadastro.id)
                            @movimentacaoCadastro.save
                          
                          end

                          if existeArm.nil?
                            puts "ENTROU NO IF DO ARMAZEM VAZIO "
                              puts "Nome do Armazenamento: #{existeArm} "
                              @movimentacaoCadastro = Movimentation.new(type: tipo, quantities: quantidade, date: data ) 
                              @movimentacaoCadastro.save
                              @movimentacaoCadastro = @movimentacaoCadastro.storages.new(name: nDeposito)
                              @movimentacaoCadastro.save
                              
                          
                          else
                            @movimentacaoCadastro = Movimentation.new(type: tipo, quantities: quantidade, date: data ) 
                            @movimentacaoCadastro.save
                            @movimentacaoCadastro = @movimentacaoCadastro.storages.new(name: nDeposito)
                            @movimentacaoCadastro.save

                          end      
                                               
                      elsif tipo =="S" 
                     
                          @stora = Storage.find_by(name: nProduto )
                          @prod = Product.find_by(name: nDeposito)
                          @moviment = Movimentation.find_by(id: @prod.movimentation_id)
                           cont = @moviment.quantities
                          if cont >=1
                              @moviment.quantities = @moviment.quantities -1
                              @moviment.save
                              
                           end
                      end
      
                      rescue Exception => err
                        erros << err.message
                      end
                    end
                
                  if erros.blank?
                    flash[:success] = "upado com sucesso" 

                  else
                    flash[:error] = erros.join(",")
                  end
                   
              end
               
            @produtos  = Product.all
            @estoques = Product.all
          end
            
          
private

    def movimentation_params
      params.require(:@movimentation).permit(:type, :quantities,  :date )
    end


            
end
   





