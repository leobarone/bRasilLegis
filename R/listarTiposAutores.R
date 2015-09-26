#' List types of Authors
#'
#' @description Returns a data frame containing all the possible types of authors of propositions
#' at Camara dos Deputados (for example, "Bancada", "Deputado Federal", "Senador",
#' "Comissao Diretora", "Orgao do Poder Executivo", etc) and respectives identification
#' codes at the web service. This function does not require any parameter.
#'
#' @return A data frame containing all the possible types of authors of propositions.
#'
#' @author Leonardo Sangali Barone; Alexia Aslan
#'
#' @note The output of this function can be used as a parameter in functions that require
#' the type of authors.
#'
#' @import httr XML
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
