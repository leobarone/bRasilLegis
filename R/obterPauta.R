obterPauta <- function(IDOrgao.param,
                       datIni.param,
                       datFim.param){

  parsedRequestOutput <- xmlParse(GET('http://www.camara.gov.br/SitCamaraWS/Orgaos.asmx/ObterPauta?',
                                      query = list(IDOrgao = IDOrgao.param,
                                                   datIni = datIni.param,
                                                   datFim = datFim.param)))

  reuniao <- xmlToDataFrame(getNodeSet(parsedRequestOutput, "//reuniao"), stringsAsFactors = F)[,1:9]
  output <- data.frame()
  for (i in 1:nrow(reuniao)){
    proposicao <- xmlToDataFrame(getNodeSet(parsedRequestOutput,
                                            paste("//reuniao[.//codReuniao/text() = '",
                                                  reuniao$codReuniao[i],
                                                  "']//proposicao",
                                                  sep = "")), stringsAsFactors = F)
    if (length(proposicao) == 0){
      proposicao = data.frame(sigla = NA, idProposicao = NA, numOrdemApreciacao = NA,
                              ementa = NA, resultado = NA, relator = NA, textoParecerRelator = NA)
    }
    output <- rbind(output, merge(reuniao[i,], proposicao))
  }
  return(output)
}

# IDOrgao.param=2004 ; datIni.param= "01/01/2012" ; datFim.param= "30/04/2012"
# d <- obterPauta(IDOrgao.param, datIni.param, datFim.param)
# View(d)
