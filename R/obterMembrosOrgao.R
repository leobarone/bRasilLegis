#' Get Members of a Camara dos Deputados Organization
#'
#' @description Returns a data frame containing all the legislators that are part of a
#' Camara dos Deputados Organization.
#'
#' @param idOrgao integer, the Camara dos Deputados organization id code where the proposal is
#' located (check listarTiposOrgaos function for help).
#'
#' @return A data frame containing detailed information on the progress of the requested proposal.
#'
#' @author Leonardo Sangali Barone; Alexia Aslan
#'
#' @import httr XML dplyr
#'
#' @examples
#'
#' # Members of Comissao de Agricultura, Pecuaria, Abastecimento e Desenvolvimento Rural
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
