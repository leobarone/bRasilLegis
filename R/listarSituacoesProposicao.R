#' List Status of Propositions
#'
#' @description Returns a data frame containing all the possible status of propositions in
#' the legislative proccess of the Brazilian Chamber of Deputies (for example, "Vetado
#' totalmente" (entirely vetoed), Aguardando Parecer ("waiting for review"), etc) and
#' respectives identification codes at the web Service. This function does not require any
#' parameter.
#'
#' @return A data frame containing all the possible types of situations.
#'
#' @author Leonardo Sangali Barone; Alexia Aslan
#'
#' @note The output of this function can be used as a parameter in functions that require
#' the type of status of a proposition.
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
