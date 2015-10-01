#' Get Proposition Info by Id
#'
#' @description Returns a data frame containing detailed information the requested proposition
#' at Camara dos Deputados and respectives attached propositions ("proposicoes
#' apensadas"). The only parameter (idPorpo) is requires. This function is similar to the
#' obterProposicao function.
#'
#' @param idProp integer, the requested proposition identification number.
#'
#' @return A data frame containing detailed information the requested propositions and attached
#' propositions.
#'
#' @author Leonardo Sangali Barone; Alexia Aslan
#'
#' @examples
#'
#' # Return a data frame containing all of proposition PL 404/2015, whose id is 947717
#' proposicao <- obterProposicaoPorID(idProp = 947717)
#' print(proposicao)
#'
#' @rdname obterProposicaoPorID
#'
#' @export

obterProposicaoPorID <- function(idProp) {
  parsedOutput <- xmlParse(GET('http://www.camara.gov.br/SitCamaraWS/Proposicoes.asmx/ObterProposicaoPorID?',
                               query = list(idProp = idProp)))
  output <- xmlToDataFrame(getNodeSet(parsedOutput, "/proposicao"), stringsAsFactors = F)[1:19]
  names(output)
  apensadas <- xmlToDataFrame(getNodeSet(parsedOutput, "//apensadas/proposicao"), stringsAsFactors = F)
  if (nrow(apensadas) > 0){
    names(apensadas) <- c("nomeProposicaoApensada", "codProposicaoApensada")
    output <- merge(output, apensadas)
  }
  return(output)
}
