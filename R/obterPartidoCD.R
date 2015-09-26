#' Get Parties
#'
#' @description Returns a data frame containing details of the parties with representation at
#' Camara dos deputados. There are no required parameters.
#'
#' @return A data frame containing information of all the parties with representation.
#'
#' @author Alexia Aslan; Leonardo Sangali Barone;
#'
#' @import httr XML
#'
#' @examples
#'
#' # Return a data frame containing the parties with representation
#' partidos <- obterPartidosCD()
#' print(partidos)
#'
#' @rdname obterPartidosCD
#'
#' @export

obterPartidosCD <- function() {
  parsedOutput <- xmlParse(GET('http://www.camara.gov.br/SitCamaraWS/Deputados.asmx/ObterPartidosCD'))
  return(xmlToDataFrame(parsedOutput, stringsAsFactors = F))
}
