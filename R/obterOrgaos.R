#' Get Câmara dos Deputados Organizations
#'
#' @description Returns a data frame that lists internal Câmara dos Deputados organizations
#' (comittees for example) and respectives identification codes at the web
#' service. This function does not require any parameter.
#'
#' @return A data frame with information on Câmara dos Deputados organizations.
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
#' obterOrgaos()
#'
#' @rdname obterOrgaos
#' @export

obterOrgaos <- function(){
  parsedOutput <- xmlParse(GET('http://www.camara.gov.br/SitCamaraWS/Orgaos.asmx/ObterOrgaos?'))
  return(xmlAttributesToDataFrame(parsedOutput, "//orgao"))
}
