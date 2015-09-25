#' Get Members of a Câmara dos Deputados Organization
#'
#' @description Returns a data frame containing all the legislators that are part of a
#' Câmara dos Deputados Organization.
#'
#' @param idOrgao integer, the Camara dos Deputados stance id code where the proposition is
#' located (check listarTiposOrgaos function for help).
#'
#' @return A data frame containing detailed information on the progess of the requested proposition.
#'
#' @author Leonardo Sangali Barone; Alexia Aslan
#'
#' @examples
#'
#' # Members of Comissão de Agricultura, Pecuária, Abastecimento e Desenvolvimento Rural
#' obterMembrosOrgao(2001)
#'
#' @rdname obterMembrosOrgao
#'
#' @export

obterMembrosOrgao <- function(idOrgao){
  parsedOutput <- xmlParse(GET('http://www.camara.gov.br/SitCamaraWS/Orgaos.asmx/ObterMembrosOrgao?',
                                  query = list(IDOrgao = idOrgao)))
  membros <- xmlToDataFrame(getNodeSet(parsedOutput, "//membros/*"), stringsAsFactors = F)
  membros <- data.frame(comissao = xmlAttributesToDataFrame(parsedOutput, "//orgao"), membros)
  return(membros)
}
