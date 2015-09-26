#' List Types of Propositions
#'
#' @description Returns a data frame containing all the possible types of propositions (siglas)
#' in the Brazilian Chamber of Deputies (for example, "PL" (Projeto de Lei), "MPV" (Medida
#' Provisória, etc) and respectives identification codes at the web service. This function
#' does not require any parameter.
#'
#' @return A data frame containing all the possible types of propositions.
#'
#' @author Leonardo Sangali Barone; Alexia Aslan
#'
#' @note The output of this function can be used as a parameter in functions that require
#' the type of propositions.
#'
#' @import httr XML
#'
#' @examples
#'
#' siglas  <- listarSiglasTipoProposicao()
#' head(siglas)
#'
#' @rdname listarSiglasTipoProposicao
#' @export

listarSiglasTipoProposicao <- function() {
  parsedOutput <- xmlParse(GET('http://www.camara.gov.br/SitCamaraWS/Proposicoes.asmx/ListarSiglasTipoProposicao?'))
  return(xmlAttributesToDataFrame(parsedOutput, "//sigla"))
}
