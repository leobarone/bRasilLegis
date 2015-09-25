#' List Câmara dos Deputados Organizations
#'
#' @description Returns a data frame that lists internal Câmara dos Deputados organizations
#' (for example, "Comissão", "Bancada") and respectives identification codes at the web
#' service. This function does not require any parameter.
#'
#' @return A data frame with information on Câmara dos Deputados organizations.
#'
#' @author Leonardo Sangali Barone; Alexia Aslan
#'
#' @note The output of this function can be used as a parameter in functions that require
#' the type of propositions.
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
