#' Get Legislative Agenda
#'
#' @description Returns a data frame with information on the legislative agenda of a Camara
#' dos Deputados organ between an initial and a final date. The maximum difference between
#' initial and final date allowed by the web service is 7 days. The inputs for this
#' function are of class character and in the format dd/mm/yyyy. All the three parameters
#' are required.
#'
#' @param idOrgao integer, the Camara dos Deputados organ id code where the proposal is
#' located (check listarTiposOrgaos function for help).
#' @param datIni string of format dd/mm/yyyy, the initial date.
#' @param datFim string of format dd/mm/yyyy, the initial date.
#'
#' @return A data frame with information on a specific legislator attendance to sessions.
#'
#' @author Leonardo Sangali Barone; Alexia Aslan
#'
#' @import httr XML dplyr
#'
#' @examples
#'
#' # Members of Comissao de Agricultura, Pecuaria, Abastecimento e Desenvolvimento Rural
#' # between "10/04/2012" and "17/04/2012".
#' IDOrgao = 2004; dataInicial = "10/04/2012"; dataFinal = "17/04/2012"
#' pauta <- obterPauta(IDOrgao, dataInicial, dataFinal)
#' head(pauta)
#'
#' @rdname obterPauta
#' @export

obterPauta <- function(idOrgao,
                       datIni,
                       datFim){

  parsedOutput <- xmlParse(GET('http://www.camara.gov.br/SitCamaraWS/Orgaos.asmx/ObterPauta?',
                               query = list(IDOrgao = idOrgao,
                                            datIni = datIni,
                                            datFim = datFim)))

  reuniao <- xmlToDataFrame(getNodeSet(parsedOutput, "//reuniao"), stringsAsFactors = F)[,1:9]
  output <- data.frame()
  for (i in 1:nrow(reuniao)){
    proposicao <- xmlToDataFrame(getNodeSet(parsedOutput,
                                            paste("//reuniao[.//codReuniao/text() = '",
                                                  reuniao$codReuniao[i],
                                                  "']//proposicao",
                                                  sep = "")), stringsAsFactors = F)
    if (length(proposicao) == 0){
      proposicao = data.frame(sigla = NA, idProposicao = NA, numOrdemApreciacao = NA,
                              ementa = NA, resultado = NA, relator = NA, textoParecerRelator = NA)
    }
    output <- bind_rows(output, merge(reuniao[i,], proposicao))
  }
  return(output)
}
