#' Get Legislator Info
#'
#' @description Returns a data frame containing detailed information on the active legislators
#' at Camara dos Deputados. There are no required parameters.
#'
#' @return A data frame containing basic information on all the active legislators in the Brazilian Chamber of Deputies.
#'
#' @author Alexia Aslan; Leonardo Sangali Barone;
#'
#' @import httr XML dplyr
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
