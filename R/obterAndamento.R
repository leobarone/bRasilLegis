obterAndamento <- function(sigla.param,
                           numero.param,
                           ano.param,
                           dataIni.param = "",
                           codOrgao.param = ""){
  parsedRequestOutput <- xmlParse(GET('http://www.camara.gov.br/SitCamaraWS/Orgaos.asmx/ObterAndamento?',
                                      query = list(sigla = sigla.param,
                                                   numero = numero.param,
                                                   ano = ano.param,
                                                   dataIni = dataIni.param,
                                                   codOrgao = codOrgao.param)))
  proposicao <- xmlToDataFrame(getNodeSet(parsedRequestOutput, "//proposicao"), stringsAsFactors = F)[,1:3]
  proposicao <- data.frame(sigla.param, numero.param, ano.param, proposicao)
  tramitacao <- xmlToDataFrame(getNodeSet(parsedRequestOutput, "//tramitacao"), stringsAsFactors = F)
  tramitacao$ultima.acao = 0; tramitacao$ultima.acao[1] = 1
  tramitacao <- merge(proposicao, tramitacao)
  return(tramitacao)
}


# sigla.param="PL" ; numero.param=3962 ; ano.param=2008 ; dataIni.param= "01/01/2009";codOrgao.param = ""
# d<-obterAndamento(sigla.param, numero.param, ano.param, dataIni.param, codOrgao.param)
# View(d)
