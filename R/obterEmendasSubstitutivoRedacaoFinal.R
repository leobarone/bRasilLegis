#' Get Proposition Amemndments, Substitutives and Final Draft
#'
#' @description Returns a data frame containing detailed information on the ammendments, substitutive
#' draft and final draft of the requested proposition in the Brazilian Chamber of Deputies.
#' sigla, numero and ano are required parameters. Proposition's name is always combination of tipo
#' (type of propostion), numero (number of proposition) and ano (year of propostion).
#'
#' @param tipo string, the type of the proposition(s) (check listarSiglasTipoProposicao
#' function for help), which is part ot the name of the propostion(s).
#' @param numero integer, the number of the proposition(s) (check listarSiglasTipoProposicao function
#' for help), which is part ot the name of the propostion(s).
#' @param ano integer, the year of the proposition(s) (check listarSiglasTipoProposicao
#' function for help), which is part ot the name of the propostion(s) and represents the year
#' the proposition was written.
#'
#' @return A a data frame containing detailed information on the ammendments, substitutive
#' draft and final draft of the requested proposition.
#'
#' @author Leonardo Sangali Barone; Alexia Aslan
#'
#' @import httr XML
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
