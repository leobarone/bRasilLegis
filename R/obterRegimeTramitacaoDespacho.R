#' Get Proposition Processing Status
#'
#' @description Returns a data frame containing detailed information on the processing status
#' of the requested proposition in the Brazilian Chamber of Deputies. sigla, numero and ano
#' are required parameters. Proposition's name is always combination of tipo (type of propostion),
#' numero (number of proposition) and ano (year of propostion).
#'
#' @param tipo string, the type of the proposition(s) (check listarSiglasTipoProposicao
#' function for help), which is part ot the name of the propostion(s).
#' @param numero integer, the number of the proposition(s) (check listarSiglasTipoProposicao function
#' for help), which is part ot the name of the propostion(s).
#' @param ano integer, the year of the proposition(s) (check listarSiglasTipoProposicao
#' function for help), which is part ot the name of the propostion(s) and represents the year
#' the proposition was written.
#'
#' @return A data frame containing detailed information on the processing status
#' of the requested proposition.
#'
#' @author Leonardo Sangali Barone; Alexia Aslan
#'
#' @import httr XML
#'
#' @examples
#'
#' regime <- obterRegimeTramitacaoDespacho("PL", 404, 2015)
#' print(regime)
#'
#' @rdname obterRegimeTramitacaoDespacho
#'
#' @export

obterRegimeTramitacaoDespacho <- function(tipo,
                                          numero,
                                          ano){
  parsedOutput <- xmlParse(GET('http://www.camara.gov.br/SitCamaraWS/Orgaos.asmx/ObterRegimeTramitacaoDespacho?',
                               query = list(tipo = tipo,
                                            numero = numero,
                                            ano = ano)))
  proposicao <- data.frame(tipo = tipo, numero = numero, ano = ano,
                           xmlToDataFrame(getNodeSet(parsedOutput,"//proposicao"), stringsAsFactors = F))
  return(proposicao)
}
