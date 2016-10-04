#' Get Proposal Progress
#'
#' @description Returns a data frame containing detailed information of the progress of the
#' requested proposal in the Brazilian Chamber of Deputies. sigla, numero and ano are required
#' parameters. Optionally, initial date (dataIni) and stance (codOrgao) can be specified. The proposal
#' name is always a combination of sigla (type of proposal), numero (number of proposal) and ano
#' (year of proposal).
#'
#' @param sigla string, the type of the proposal(s) (check listarSiglasTipoProposicao
#' function for help), which is part of the name of the proposal(s).
#' @param numero integer, the number of the proposal(s) (check listarSiglasTipoProposicao function
#' for help), which is part of the name of the proposal(s).
#' @param ano integer, the year of the proposal(s) (check listarSiglasTipoProposicao
#' function for help), which is part of the name of the proposal(s) and represents the year
#' the proposal was written.
#' @param dataIni string of format dd/mm/yyyy, the date of the sessions. This is an optional parameter
#' and its default is empty.
#' @param codOrgao integer, the Camara dos Deputados organ id code where the proposal is
#' located (check listarTiposOrgaos function for help). This is an optional parameter and its default
#' is empty.
#'
#' @return A data frame containing detailed information on the progress of the requested proposal.
#'
#' @author Leonardo Sangali Barone; Alexia Aslan
#'
#' @import httr XML dplyr
#'
#' @examples
#'
#' andamento <- obterAndamento("PL", 404, 2015)
#' head(andamento)
#'
#' @rdname obterAndamento
#'
#' @export

obterAndamento <- function(sigla,
                           numero,
                           ano,
                           dataIni = "",
                           codOrgao = ""){
  parsedOutput <- xmlParse(GET('http://www.camara.gov.br/SitCamaraWS/Orgaos.asmx/ObterAndamento?',
                                      query = list(sigla = sigla,
                                                   numero = numero,
                                                   ano = ano,
                                                   dataIni = dataIni,
                                                   codOrgao = codOrgao)))
  proposicao <- xmlToDataFrame(getNodeSet(parsedOutput, "//proposicao"), stringsAsFactors = F)[,1:3]
  proposicao <- data.frame(sigla, numero, ano, proposicao)
  tramitacao <- xmlToDataFrame(getNodeSet(parsedOutput, "//tramitacao"), stringsAsFactors = F)
  tramitacao$ultima.acao = 0; tramitacao$ultima.acao[1] = 1
  tramitacao <- merge(proposicao, tramitacao)
  return(tramitacao)
}
