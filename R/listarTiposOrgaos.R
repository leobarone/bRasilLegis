#' List Camara dos Deputados Organizations
#'
#' @description Returns a data frame that lists internal Camara dos Deputados organizations
#' (for example, "Comissao", "Bancada") and respective identification codes from the web
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
#' listarTiposOrgaos()
#'
#' @rdname listarTiposOrgaos
#' @export

listarTiposOrgaos <- function(){
  parsedOutput <- xmlParse(GET('http://www.camara.gov.br/SitCamaraWS/Orgaos.asmx/ListarTiposOrgaos?'))
  return(xmlAttributesToDataFrame(parsedOutput, "//tipoOrgao"))
}
