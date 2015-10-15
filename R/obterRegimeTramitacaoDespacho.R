#' Get Proposal Processing Status
#'
#' @description Returns a data frame containing detailed information on the processing status
#' of the requested proposal at Camara dos Deputados. sigla, numero and ano
#' are required parameters. Proposal name is always a combination of tipo (type of proposal),
#' numero (number of proposal) and ano (year of proposal).
#'
#' @param tipo string, the type of the proposal(s) (check listarSiglasTipoProposicao
#' function for help), which is part of the name of the proposal(s).
#' @param numero integer, the number of the proposal(s) (check listarSiglasTipoProposicao function
#' for help), which is part of the name of the proposal(s).
#' @param ano integer, the year of the proposal(s) (check listarSiglasTipoProposicao
#' function for help), which is part of the name of the proposal(s) and represents the year
#' the proposal was written.
#'
#' @return A data frame containing detailed information on the processing status
#' of the requested proposal.
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
