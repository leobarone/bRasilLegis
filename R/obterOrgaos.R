#' Get Camara dos Deputados Organizations
#'
#' @description Returns a data frame that lists internal Camara dos Deputados organizations
#' (committees for example) and respective identification codes from the web
#' service. This function does not require any parameters.
#'
#' @return A data frame with information on Camara dos Deputados organizations.
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
#' obterOrgaos()
#'
#' @rdname obterOrgaos
#' @export

obterOrgaos <- function(){
  parsedOutput <- xmlParse(GET('http://www.camara.gov.br/SitCamaraWS/Orgaos.asmx/ObterOrgaos?'))
  tempdf <- (xmlAttributesToDataFrame(parsedOutput, "//orgao"))
  tempdf[["sigla"]] <- str_trim(tempdf[["sigla"]]) # remove unnecessary spaces in SIGLA column
}
