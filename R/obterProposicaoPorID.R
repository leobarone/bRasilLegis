#' Get Proposition Info by Id
#'
#' @description Returns a data frame containing detailed information the requested proposition
#' in the Brazilian Chamber of Deputies and respectives attached propositions ("proposições
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
  proposicao <- xmlToDataFrame(getNodeSet(parsedOutput, "/proposicao"), stringsAsFactors = F)[1:19]
  names(proposicao)
  apensadas <- xmlToDataFrame(getNodeSet(parsedOutput, "//apensadas/proposicao"), stringsAsFactors = F)
  names(apensadas) <- c("nomeProposicaoApensada", "codProposicaoApensada")
  output <- merge(proposicao, apensadas)
  return(output)
}
