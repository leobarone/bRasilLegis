#' List Propositions in Process
#'
#' @description Returns a data frame containing legislative actions taken
#' by proposition between and initial and a final date (parameters of the function) in the
#' Brazilian Chamber of Deputies. The maximum difference between  initial and final date
#' allowed by the web service allowed is 7 days. The inputs for this functions are of
#' class character and in the format dd/mm/yyyy.
#'
#' @param dtInicio string of format dd/mm/yyyy, the initial date of for the requested
#' propositions.
#' @param dtFim string of format dd/mm/yyyy, the initial date of for the requested
#' propositions.
#'
#' @return A data frame containing the legislative actions taken by propositions.
#'
#' @author Leonardo Sangali Barone; Alexia Aslan
#'
#' @note The output of this function can be used as a parameter in functions that require
#' a vector of propositions.
#'
#' @examples
#'
#' proposicoes <- listarProposicoesTramitadasNoPeriodo('01/08/2015', '08/08/2015')
#' head(proposicoes)
#'
#' @rdname listarProposicoesTramitadasNoPeriodo
#' @export

listarProposicoesTramitadasNoPeriodo <- function(dtInicio, dtFim) {
#   dtFim.param <- as.character(as.Date(dtInicio.param, '%d/%m/%Y') + 6)
#   dtFim.param <- paste(substr(dtFim.param, 9, 10), substr(dtFim.param, 6, 7), substr(dtFim.param, 1, 4), sep = "/")
  parsedOutput <- xmlParse(GET('http://www.camara.gov.br//SitCamaraWS/Proposicoes.asmx/ListarProposicoesTramitadasNoPeriodo?',
                                      query = list(dtInicio = dtInicio,
                                                   dtFim = dtFim)))
  return(xmlToDataFrame(parsedOutput, stringsAsFactors = F))
}
