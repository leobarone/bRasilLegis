#' Get Proposal Amendments, Substitutions and Final Draft
#'
#' @description Returns a data frame containing detailed information on the amendments, substitute
#' drafts and final drafts of the requested proposal at Camara dos Deputados.
#' sigla, numero and ano are required parameters. Proposal name is always a combination of tipo
#' (type of proposal), numero (number of proposal) and ano (year of proposal).
#'
#' @param tipo string, the type of the proposal(s) (check listarSiglasTipoProposicao
#' function for help), which is part of the name of the proposal(s).
#' @param numero integer, the number of the proposal(s) (check listarSiglasTipoProposicao function
#' for help), which is part o the name of the proposal(s).
#' @param ano integer, the year of the proposal(s) (check listarSiglasTipoProposicao
#' function for help), which is part of the name of the proposal(s) and represents the year
#' the proposal was written.
#'
#' @return A a data frame containing detailed information on the amendments, substitute
#' drafts and final drafts of the requested proposal.
#'
#' @author Leonardo Sangali Barone; Alexia Aslan
#'
#' @import httr XML dplyr
#'
#' @examples
#'
#' # Proposition with amendments, substitutive and final draft
#' emendas <- obterEmendasSubstitutivoRedacaoFinal("PL", 3962, 2008)
#' head(emendas)
#'
#' # Proposition without any amendments, substitutive and final draft
#' emendas <- obterEmendasSubstitutivoRedacaoFinal("PL", 404, 2015)
#' print(emendas)
#'
#' @rdname obterEmendasSubstitutivoRedacaoFinal
#'
#' @export

obterEmendasSubstitutivoRedacaoFinal <- function(tipo,
                                                 numero,
                                                 ano){

  parsedOutput <- xmlParse(GET('http://www.camara.gov.br/SitCamaraWS/Orgaos.asmx/ObterEmendasSubstitutivoRedacaoFinal?',
                               query = list(tipo = tipo,
                                            numero = numero,
                                            ano = ano)))
  nProposicoes <- xmlSize(getNodeSet(parsedOutput, "//Emendas/*")) +
    xmlSize(getNodeSet(parsedOutput, "//RedacoesFinais/*")) +
    xmlSize(getNodeSet(parsedOutput, "//Substitutivos/*"))
  if (nProposicoes > 0){
    output <- data.frame(tipo = tipo, numero = numero, ano = ano,
                         xpathSApply(parsedOutput, "//Proposicao/*/*", xmlName),
                        xmlAttributesToDataFrame(parsedOutput, "//Proposicao/*/*"))
    return(output)
  }
  else {
    return(NULL)
  }
}
