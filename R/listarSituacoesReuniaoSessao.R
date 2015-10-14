#' List Status of Sessions
#'
#' @description Returns a data frame containing all the status possibilities of sessions at
#' Camara dos Deputados. This function does not require any parameters.
#'
#' @return A data frame containing all the status possibilities of sessions
#'
#' @author Leonardo Sangali Barone; Alexia Aslan
#'
#' @note The output of this function can be used as a parameter in functions that require
#' the type of status of sessions.
#'
#' @import httr XML
#'
#' @examples
#'
#' status  <- listarSituacoesReuniaoSessao()
#' head(status)
#'
#' @rdname listarSituacoesReuniaoSessao
#' @export

listarSituacoesReuniaoSessao <- function(){
  parsedOutput <- xmlParse(GET('http://www.camara.gov.br/SitCamaraWS/Sessoesreunioes.asmx/ListarSituacoesReuniaoSessao?'))
  return(xmlAttributesToDataFrame(parsedOutput, "//situacaoReuniao"))
}
