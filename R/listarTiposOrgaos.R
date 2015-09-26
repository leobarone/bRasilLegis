#' List Camara dos Deputados Organizations
#'
#' @description Returns a data frame that lists internal Camara dos Deputados organizations
#' (for example, "Comissao", "Bancada") and respectives identification codes at the web
#' service. This function does not require any parameter.
#'
#' @return A data frame with information on Camara dos Deputados organizations.
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
#' listarTiposOrgaos()
#'
#' @rdname listarTiposOrgaos
#' @export

listarTiposOrgaos <- function(){
  parsedOutput <- xmlParse(GET('http://www.camara.gov.br/SitCamaraWS/Orgaos.asmx/ListarTiposOrgaos?'))
  return(xmlAttributesToDataFrame(parsedOutput, "//tipoOrgao"))
}
