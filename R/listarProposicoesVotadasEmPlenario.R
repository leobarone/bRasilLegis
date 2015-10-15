#' List Proposals Voted On
#'
#' @description Returns a data frame containing all the of proposals that were submitted to
#' the floor for voting at Camara dos Deputados in a specific year (ano) and
#' of a type (tipo). tipo is an optional parameter and if not specified the function will return
#' all types of proposals.
#'
#' @param ano integer, the year in which the proposals were submitted to the floor.
#' @param tipo character, the type of the proposal(s) (check listarSiglasTipoProposicao
#' function for help). If not specified the function will return all types of proposals.
#'
#' @return A data frame containing all the of proposals that were submitted to
#' the floor for voting.
#'
#' @author Leonardo Sangali Barone; Alexia Aslan
#'
#' @note The output of this function can be used as a parameter in functions that require
#' proposals already voted on.
#'
#' @import httr XML
#'
#' @examples
#'
#' # All the propositions voted in 2015
#' proposicoesVotadas2015 <- listarProposicoesVotadasEmPlenario(2015)
#' head(proposicoesVotadas2015)
#'
#' # All the propositions of type "Proposta de Emenda a Constituicao" (PEC, which
#' # are constitutional amendments) voted in 2015
#' pecsVotadas2015 <- listarProposicoesVotadasEmPlenario(2015, "PEC")
#' head(pecsVotadas2015)
#'
#' @rdname listarProposicoesVotadasEmPlenario
#' @export

listarProposicoesVotadasEmPlenario <- function(ano, tipo = "") {
  parsedOutput <- xmlParse(GET('http://www.camara.gov.br/SitCamaraWS/Proposicoes.asmx/ListarProposicoesVotadasEmPlenario?',
                                     query = list(ano = ano,
                                                  tipo = tipo)))
  return(xmlToDataFrame(parsedOutput, stringsAsFactors = F))
}
