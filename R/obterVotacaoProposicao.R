#' Get Votes of a Proposition
#'
#' @description Returns a data frame containing all the roll call votes for the requested
#' proposition and individual votes in the Brazilian Chamber of Deputies. bancada is an
#' optional parameter and if bancada = TRUE, leadership votes will be returned instead of
#' individual legislators vote. Note that when a proposition goes to the floor every
#' amendment, substitutive propositions, etc, will be submitted to voting, not only the
#' main proposition (for example, one data frame may contain several different votings regarding
#' the requested proposition).
#'
#' @param tipo character, the type of the proposition(s) (check listarSiglasTipoProposicao
#' function for help), which is part ot the name of the propostion(s).
#' @param numero integer, the number of the proposition(s) (check listarSiglasTipoProposicao function
#' for help), which is part ot the name of the propostion(s).
#' @param ano integer, the year of the proposition(s) (check listarSiglasTipoProposicao
#' function for help), which is part ot the name of the propostion(s) and represents the year
#' the proposition was written.
#' @param logic, if TRUE, leadership votes will be returned instead of
#' individual legislators vote.
#'
#' @return A data frame containing all the roll call votes for the requested
#' proposition and individual votes.
#'
#' @author Leonardo Sangali Barone; Alexia Aslan
#'
#' @examples
#'
#' # Return the roll call votes for the Proposta de Emenda à Constituição 358 de 2013 (constitutional
#' amendment 358 of 2013) voted in 2015
#' votesPec358.2013 <- obterVotacaoProposicao(tipo = "PEC", numero = 358,ano = 2013)
#' head(votesPec358.2013)
#'
#' # Return the ledearship votes for the Proposta de Emenda à Constituição 358 de 2013 (constitutional
#' amendment 358 of 2013) voted in 2015
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
        output <- rbind(output, merge(votacoes[i,], voto))
      }
    }
  }

  if (bancada == T){
    for (i in 1:nrow(votacoes)){
      bancada <- as.data.frame(t(xpathSApply(parsedOutput, paste("//Votacao[@ObjVotacao = '", votacoes$ObjVotacao[i], "']//bancada", sep = ''),
                                             xmlAttrs)), stringsAsFactors = F)
      if (nrow(bancada) > 1){
        output <- rbind(output, merge(votacoes[i,], bancada))
      }
    }
  }

  if (nrow(output) > 1) {
    return(data.frame(Ano = ano, Tipo = tipo, Numero = numero, output))
  }
}
