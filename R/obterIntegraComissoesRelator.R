#' Get Proposition Committees Report
#'
#' @description Returns a data frame containing detailed information on the committees
#' reports of the requested proposition at Camara dos Deputados. sigla,
#' numero and ano are required parameters. Proposition's name is always combination of tipo
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
#' @return A data frame containing detailed information on the committees reports of the
#' requested propostion.
#'
#' @author Leonardo Sangali Barone; Alexia Aslan
#'
#' @import httr XML
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
