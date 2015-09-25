#' Get Proposition Progress
#'
#' @description Returns a data frame containing detailed information of the progress of the
#' requested proposition in the Brazilian Chamber of Deputies. sigla, numero and ano are required
#' parameters. Optionally, initial date (dataIni) and stance (codOrgao) can be specified. Proposition's
#' name is always combination of sigla (type of propostion), numero (number of proposition) and ano
#' (year of propostion).
#'
#' @param sigla string, the type of the proposition(s) (check listarSiglasTipoProposicao
#' function for help), which is part ot the name of the propostion(s).
#' @param numero integer, the number of the proposition(s) (check listarSiglasTipoProposicao function
#' for help), which is part ot the name of the propostion(s).
#' @param ano integer, the year of the proposition(s) (check listarSiglasTipoProposicao
#' function for help), which is part ot the name of the propostion(s) and represents the year
#' the proposition was written.
#' @param dataIni string of format dd/mm/yyyy, the date if the sessions. This is a optional parameter
#' and it's default is empty.
#' @param codOrgao integer, the Camara dos Deputados stance id code where the proposition is
#' located (check listarTiposOrgaos function for help). This is a optional parameter and it's default
#' is empty.
#'
#' @return A data frame containing detailed information on the progess of the requested proposition.
#'
#' @author Leonardo Sangali Barone; Alexia Aslan
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
