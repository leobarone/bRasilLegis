#' Get Proposal Committee Report
#'
#' @description Returns a data frame containing detailed information on the committee
#' reports of the requested proposal at Camara dos Deputados. sigla,
#' numero and ano are required parameters. Proposal name is always a combination of tipo
#' (type of proposal), numero (number of proposal) and ano (year of proposal).
#'
#' @param tipo string, the type of the proposal(s) (check listarSiglasTipoProposicao
#' function for help), which is part of the name of the proposal(s).
#' @param numero integer, the number of the proposal(s) (check listarSiglasTipoProposicao function
#' for help), which is part of the name of the proposal(s).
#' @param ano integer, the year of the proposal(s) (check listarSiglasTipoProposicao
#' function for help), which is part of the name of the proposal(s) and represents the year
#' the proposal was written.
#'
#' @return A data frame containing detailed information on the committee reports of the
#' requested proposal.
#'
#' @author Leonardo Sangali Barone; Alexia Aslan
#'
#' @import httr XML dplyr
#'
#' @examples
#'
#' # Proposition without any amendments, substitutive and final draft
#' emendas <- obterIntegraComissoesRelator("PL", 404, 2015)
#' print(emendas)
#'
#' @rdname obterIntegraComissoesRelator
#'
#' @export

obterIntegraComissoesRelator <- function(tipo,
                                         numero,
                                         ano){
  parsedOutput <- xmlParse(GET('http://www.camara.gov.br/SitCamaraWS/Orgaos.asmx/ObterIntegraComissoesRelator?',
                                      query = list(tipo = tipo,
                                                   numero = numero,
                                                   ano = ano)))
  comissao <- data.frame(tipo = tipo, numero = numero, ano = ano,
                         cbind(xmlAttributesToDataFrame(parsedOutput, "//comissao")),
                               xmlToDataFrame(getNodeSet(parsedOutput,"//comissao"), stringsAsFactors = F))
  return(comissao)
}
