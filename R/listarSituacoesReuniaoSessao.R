#' List Status of Sessions
#'
#' @description Returns a data frame containing all the possible status of sessions in
#' the Brazilian Chamber of Deputies. This function does not require any parameter.
#'
#' @return A data frame containing all the possible status of sessions
#'
#' @author Leonardo Sangali Barone; Alexia Aslan
#'
#' @note The output of this function can be used as a parameter in functions that require
#' the type of status of session.
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
