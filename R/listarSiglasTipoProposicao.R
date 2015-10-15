#' List Types of Proposals
#'
#' @description Returns a data frame containing all the possible types of proposals (siglas)
#' at the Camara dos Deputados (for example, "PL" (Projeto de Lei), "MPV" (Medida
#' Provisoria, etc) and respective identification codes from the web service. This function
#' does not require any parameters.
#'
#' @return A data frame containing all the possible types of proposals.
#'
#' @author Leonardo Sangali Barone; Alexia Aslan
#'
#' @note The output of this function can be used as a parameter in functions that require
#' the type of proposals.
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
