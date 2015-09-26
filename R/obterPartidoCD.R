#' Get Parties
#'
#' @description Returns a data frame containing details of the parties with representation in
#' the Brazilian Chamber of Deputies. There are no required parameters.
#'
#' @return A data frame containing information of all the parties with representation.
#'
#' @author Alexia Aslan <alexia.aslan[at]gmail.com>; Leonardo Sangali Barone <leobarone[at]gmail.com>;
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
