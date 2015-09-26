#' Get Legislator Info
#'
#' @description Returns a data frame containing detailed information of the active legislators
#' in the Brazilian Chamber of Deputies and their respective basic information. There are none required parameters.
#'
#' @return A data frame containing basic information of all the active legislators in the Brazilian Chamber of Deputies.
#'
#' @author Alexia Aslan <alexia.aslan[at]gmail.com>; Leonardo Sangali Barone <leobarone[at]gmail.com>;
#'
#' @import httr XML
#'
#' @examples
#'
#' # Return a data frame containing all of the active legislators
#' deputados <- obterDeputados()
#' print(deputados)
#'
#' @rdname obterDeputados
#'
#' @export

obterDeputados <- function() {
  parsedOutput <- xmlParse(GET('http://www.camara.gov.br/SitCamaraWS/Deputados.asmx/ObterDeputados?'))
  return(xmlToDataFrame(parsedOutput, stringsAsFactors = F))
}
