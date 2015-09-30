#' Get Proposition Info
#'
#' @description Returns a data frame containing detailed information the requested proposition
#' at Camara dos Deputados and respectives attached propositions ("proposicoes
#' apensadas"). All the parameters are requires. Proposition's name is always a combination of
#' tipo (type of propostion), numero (number of proposition) and ano (year of propostion). This
#' function is similar to the obterProposicaoPorID function.
#'
#' @param tipo string, the type of the proposition(s) (check listarSiglasTipoProposicao
#' function for help), which is part ot the name of the propostion(s).
#' @param ano integer, the year of the proposition(s) (check listarSiglasTipoProposicao
#' function for help), which is part ot the name of the propostion(s) and represents the year
#' the proposition was written.
#' @param numero integer, the number of the proposition(s) (check listarSiglasTipoProposicao function
#' for help), which is part ot the name of the propostion(s).
#'
#' @return A data frame containing detailed information the requested propositions and attached
#' propositions.
#'
#' @author Leonardo Sangali Barone; Alexia Aslan
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
