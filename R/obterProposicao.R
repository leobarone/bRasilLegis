#' Get Proposal Info
#'
#' @description Returns a data frame containing detailed information the requested proposal
#' at Camara dos Deputados and respective related proposals ("proposicoes
#' apensadas"). All the parameters are required. Proposal name is always a combination of
#' tipo (type of proposal), numero (number of proposal) and ano (year of proposal). This
#' function is similar to the obterProposicaoPorID function.
#'
#' @param tipo string, the type of the proposal(s) (check listarSiglasTipoProposicao
#' function for help), which is part of the name of the proposal(s).
#' @param ano integer, the year of the proposal(s) (check listarSiglasTipoProposicao
#' function for help), which is part of the name of the proposal(s) and represents the year
#' the proposal was written.
#' @param numero integer, the number of the proposal(s) (check listarSiglasTipoProposicao function
#' for help), which is part of the name of the proposal(s).
#'
#' @return A data frame containing detailed information on the requested proposals and related
#' proposals.
#'
#' @author Leonardo Sangali Barone; Alexia Aslan
#'
#' @import httr XML dplyr
#'
#' @examples
#'
#' # Return a data frame containing all of proposition PL 404/2015
#' proposicao <- obterProposicao(tipo = "PL", numero = 404, ano = 2015)
#' print(proposicao)
#'
#' @rdname obterProposicao
#'
#' @export

obterProposicao <- function(tipo, numero, ano) {
  parsedOutput <- xmlParse(GET('http://www.camara.gov.br/SitCamaraWS/Proposicoes.asmx/ObterProposicao?',
                                                query = list(Tipo = tipo,
                                                             Numero = numero,
                                                             Ano = ano)))
  output <- xmlToDataFrame(getNodeSet(parsedOutput, "/proposicao"), stringsAsFactors = F)[1:19]
  names(output)
  apensadas <- xmlToDataFrame(getNodeSet(parsedOutput, "//apensadas/proposicao"), stringsAsFactors = F)
  if (nrow(apensadas) > 0){
    names(apensadas) <- c("nomeProposicaoApensada", "codProposicaoApensada")
    output <- merge(output, apensadas)
  }
  return(output)
}
