#' Get Votes on a Proposal
#'
#' @description Returns a data frame containing all the roll call votes for the requested
#' proposal and individual votes at Camara dos Deputados. bancada is an
#' optional parameter and if bancada = TRUE, leadership votes will be returned instead of
#' individual legislators' votes. Note that when a proposal goes to the floor every
#' amendment, substitute proposal etc, will be submitted for voting, not only the
#' main proposal (for example, one data frame may contain several different votes regarding
#' the requested proposal).
#'
#' @param tipo character, the type of the proposal(s) (check listarSiglasTipoProposicao
#' function for help), which is part of the name of the proposal(s).
#' @param numero integer, the number of the proposal(s) (check listarSiglasTipoProposicao function
#' for help), which is part of the name of the proposal(s).
#' @param ano integer, the year of the proposal(s) (check listarSiglasTipoProposicao
#' function for help), which is part of the name of the proposal(s) and represents the year
#' the proposal was written.
#' @param bancada logic, if TRUE, leadership votes will be returned instead of
#' individual legislators' votes.
#'
#' @return A data frame containing all the roll call votes for the requested
#' proposal and individual votes.
#'
#' @author Leonardo Sangali Barone; Alexia Aslan
#'
#' @import httr XML dplyr
#'
#' @examples
#'
#' # Return the roll call votes for the Proposta de Emenda a Constituicao 358 de 2013 (constitutional
#' # amendment 358 of 2013) voted in 2015
#' votesPec358.2013 <- obterVotacaoProposicao(tipo = "PEC", numero = 358,ano = 2013)
#' head(votesPec358.2013)
#'
#' # Return the leadership votes for the Proposta de Emenda a Constituicao 358 de 2013 (constitutional
#' # amendment 358 of 2013) voted in 2015
#' bancadaPec358.2013 <- obterVotacaoProposicao(tipo = "PEC", numero = 358,ano = 2013, bancada = TRUE)
#' head(bancadaPec358.2013)
#'
#' @rdname obterVotacaoProposicao
#'
#' @export

obterVotacaoProposicao <- function(tipo, numero, ano, bancada = F) {
  parsedOutput <- xmlParse(GET('http://www.camara.gov.br/SitCamaraWS/Proposicoes.asmx/ObterVotacaoProposicao?',
                               query = list(Tipo = tipo,
                                            Numero = numero,
                                            Ano = ano)))

  votacoes <- as.data.frame(t(xpathSApply(parsedOutput,"//Votacao", xmlAttrs)), stringsAsFactors = F)

  output <- data.frame()

  if (bancada == F){
    for (i in 1:nrow(votacoes)){
      voto <- as.data.frame(t(xpathSApply(parsedOutput, paste("//Votacao[@ObjVotacao = '", votacoes$ObjVotacao[i], "']//Deputado", sep = ''),
                                          xmlAttrs)), stringsAsFactors = F)
      if (nrow(voto) > 1){
        output <- bind_rows(output, merge(votacoes[i,], voto))
      }
    }
  }

  if (bancada == T){
    for (i in 1:nrow(votacoes)){
      bancada <- as.data.frame(t(xpathSApply(parsedOutput, paste("//Votacao[@ObjVotacao = '", votacoes$ObjVotacao[i], "']//bancada", sep = ''),
                                             xmlAttrs)), stringsAsFactors = F)
      if (nrow(bancada) > 1){
        output <- bind_rows(output, merge(votacoes[i,], bancada))
      }
    }
  }

  if (nrow(output) > 1) {
    return(data.frame(Ano = ano, Tipo = tipo, Numero = numero, output))
  }
}
