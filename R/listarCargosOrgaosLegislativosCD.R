#' List Legislatives Positions at Câmara dos Deputdaos
#'
#' @description Returns a data frame that lists positions (for example, "Presidente", "Relator",
#' etc) that can be occupied by legislators at an internal Câmara dos Deputados organization
#' (comittes, floor, etc) and respectives identification codes at the web service. This function
#' does not require any parameter.
#'
#' @return A data frame with information on positions at Câmara dos Deputados
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
#' listarCargosOrgaosLegislativosCD()
#'
#' @rdname listarCargosOrgaosLegislativosCD
#' @export

listarCargosOrgaosLegislativosCD <- function(){
  parsedOutput <- xmlParse(GET('http://www.camara.gov.br/SitCamaraWS/Orgaos.asmx/ListarCargosOrgaosLegislativosCD?'))
  return(xmlAttributesToDataFrame(parsedOutput, "//cargo"))
}
