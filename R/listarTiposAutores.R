#' List types of Authors
#'
#' @description Returns a data frame containing all the possible types of authors of proposals
#' at the Camara dos Deputados (for example, "Bancada", "Deputado Federal", "Senador",
#' "Comissao Diretora", "Orgao do Poder Executivo", etc) and respective identification
#' codes from the web service. This function does not require any parameters.
#'
#' @return A data frame containing all the possible types of authors of proposals.
#'
#' @author Leonardo Sangali Barone; Alexia Aslan
#'
#' @note The output of this function can be used as a parameter in functions that require
#' the type of authors.
#'
#' @import httr XML dplyr
#'
#' @examples
#'
#' autores <- listarTiposAutores()
#' head(autores)
#'
#' @rdname listarTiposAutores
#' @export

listarTiposAutores <- function() {
  parsedOutput <- xmlParse(GET('http://www.camara.gov.br/SitCamaraWS/Proposicoes.asmx/ListarTiposAutores?'))
  return(xmlAttributesToDataFrame(parsedOutput, "//TipoAutor"))
}
