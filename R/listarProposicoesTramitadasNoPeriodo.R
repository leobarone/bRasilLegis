#' List Proposals in Process
#'
#' @description Returns a data frame containing legislative actions taken
#' regarding the proposal between an initial and a final date (parameters of the function) at
#' Camara dos Deputados. The maximum difference between the initial and final date
#' allowed by the web service is 7 days. The inputs for this function are of
#' class character and in the format dd/mm/yyyy.
#'
#' @param dtInicio string of format dd/mm/yyyy, the initial date of the requested
#' proposals.
#' @param dtFim string of format dd/mm/yyyy, the initial date of the requested
#' proposals.
#'
#' @return A data frame containing the legislative actions regarding the proposals.
#'
#' @author Leonardo Sangali Barone; Alexia Aslan
#'
#' @note The output of this function can be used as a parameter in functions that require
#' a vector of proposals.
#'
#' @import httr XML dplyr
#'
#' @examples
#'
#' proposicoes <- listarProposicoesTramitadasNoPeriodo('01/08/2015', '08/08/2015')
#' head(proposicoes)
#'
#' @rdname listarProposicoesTramitadasNoPeriodo
#' @export

listarProposicoesTramitadasNoPeriodo <- function(dtInicio, dtFim) {
  parsedOutput <- xmlParse(GET('http://www.camara.gov.br//SitCamaraWS/Proposicoes.asmx/ListarProposicoesTramitadasNoPeriodo?',
                                      query = list(dtInicio = dtInicio,
                                                   dtFim = dtFim)))
  return(xmlToDataFrame(parsedOutput, stringsAsFactors = F))
}
