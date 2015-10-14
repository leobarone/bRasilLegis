#' List Status of Proposals
#'
#' @description Returns a data frame containing all status possibilities of proposals in
#' the legislative process at Camara dos Deputados (for example, "Vetado
#' totalmente" (entirely vetoed), Aguardando Parecer ("waiting for review"), etc) and
#' respective identification codes from the web Service. This function does not require any
#' parameters.
#'
#' @return A data frame containing all the possible status types.
#'
#' @author Leonardo Sangali Barone; Alexia Aslan
#'
#' @note The output of this function can be used as a parameter in functions that require
#' the type of status of a proposal.
#'
#' @import httr XML
#'
#' @examples
#'
#' status  <- listarSituacoesProposicao()
#' head(status)
#'
#' @rdname listarSituacoesProposicao
#' @export

listarSituacoesProposicao <- function() {
  parsedOutput <- xmlParse(GET('http://www.camara.gov.br/SitCamaraWS/Proposicoes.asmx/ListarSituacoesProposicao?'))
  return(xmlAttributesToDataFrame(parsedOutput, "//situacaoProposicao/situacaoProposicao"))
}
