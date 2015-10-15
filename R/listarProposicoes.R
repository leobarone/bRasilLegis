#' List Proposals
#'
#' @description Returns a data frame containing detailed information on the requested proposals
#' from the Camara dos Deputados. sigla (type of proposal) and ano (year of the
#' proposal) are required parameters, unless parteNomeAutor (partial name of proposal author)
#' is filled in. Proposal name is always a combination of sigla (type of proposal),
#' numero (number of proposal) and ano (year of proposal).
#'
#' @param sigla string, the type of the proposal(s) (check listarSiglasTipoProposicao
#' function for help), which is part of the name of the proposal(s).
#' @param ano integer, the year of the proposal(s) (check listarSiglasTipoProposicao
#' function for help), which is part of the name of the proposal(s) and represents the year
#' the proposal was written.
#' @param numero integer, the number of the proposal(s) (check listarSiglasTipoProposicao function
#' for help), which is part of the name of the proposal(s). This is an optional parameter and
#' its default is empty.
#' @param datApresentacaoIni string of format dd/mm/yyyy, the initial date of the requested
#' proposals. This is an optional parameter and its default is empty.
#' @param datApresentacaoFim string of format dd/mm/yyyy, the initial date of for the requested
#' proposals. This is an optional parameter and its default is empty.
#' @param idTipoAutor character, the id code of the type of author of proposal (for example, "Bancada",
#' "Deputado Federal", "Senador", "Comissao Diretora", "Orgao do Poder Executivo", etc - check
#' listarTiposAutores function for help). This is an optional parameter and its default is empty.
#' @param parteNomeAutor string, a part of the name of the proposal author. This is an optional
#' parameter and its default is empty.
#' @param siglaPartidoAutor string, the political party of the author of the proposal. This is an
#' optional parameter and its default is empty.
#' @param siglaUfAutor string, the state (Unidade da Federacao) of the proposal author. This is an
#'optional parameter and its default is empty.
#' @param generoAutor string, the gender ("F" for female, "M" for male) of the proposal author. This
#' is an optional parameter and its default is empty.
#' @param idSituacaoProposicao string, the situation (stage of the legislative process) of the proposal
#' (check listarSituacoesProposicao for help). This is an optional parameter and its default is empty.
#' @param idOrgaoSituacaoProposicao string, the organ of the Camara dos Deputados where the proposition is
#' located (check listarTiposOrgaos function for help). This is an optional parameter and its default
#' is empty.
#' @param emTramitacao integer, indicates if the proposition (1) is still in the legislative process, or
#' (2) has reached an end. This is an optional parameter and its default is empty (both conditions return).
#'
#' @return A data frame containing detailed information on the requested proposals.
#'
#' @author Leonardo Sangali Barone; Alexia Aslan
#'
#' @import httr XML
#'
#' @examples
#'
#' # Return a data frame containing all of the propositions written in 2015
#' proposicoes2015 <- listarProposicoes(sigla = "PL", ano = 2015)
#' str(proposicoes2015)
#'
#' # Return a data frame containing the details of proposition PL-404/2015
#' proposicaoPL4042015 <- listarProposicoes(sigla = "PL", ano = 2015, numero = 404)
#' print(proposicaoPL4042015)
#'
#' # Return a data frame containing all of the propositions written by legislator Luiza Erundina
#' proposicoesDepErundina <- listarProposicoes(parteNomeAutor = "Erundina")
#' str(proposicoesDepErundina)
#'
#' # Return a data frame containing all of the propositions written in 2003 that are still in
#' # the legislative process
#' proposicoes2015EmTramitaco <- listarProposicoes(sigla = "PL", ano = 2015, emTramitacao = 1)
#' str(proposicoes2015EmTramitaco)
#'
#' @rdname listarProposicoes
#'
#' @export

#' List Propositions
#'
#' @description Returns a data frame containing detailed information the requested propositions
#' at Camara dos Deputados. sigla (type of propostion) and ano (year of the
#' proposition) are required parameters, unless parteNomeAutor (author's proposition partial
#' name) is filled in. Proposition's name is always a combination of sigla (type of propostion),
#' numero (number of proposition) and ano (year of propostion).
#'
#' @param sigla string, the type of the proposition(s) (check listarSiglasTipoProposicao
#' function for help), which is part ot the name of the propostion(s).
#' @param ano integer, the year of the proposition(s) (check listarSiglasTipoProposicao
#' function for help), which is part ot the name of the propostion(s) and represents the year
#' the proposition was written.
#' @param numero integer, the number of the proposition(s) (check listarSiglasTipoProposicao function
#' for help), which is part ot the name of the propostion(s). This is an optional parameter and
#' it's default is empty.
#' @param datApresentacaoIni string of format dd/mm/yyyy, the initial date of for the requested
#' propositions. This is a optional parameter and it's default is empty.
#' @param datApresentacaoFim string of format dd/mm/yyyy, the initial date of for the requested
#' propositions. This is a optional parameter and it's default is empty.
#' @param idTipoAutor character, the id code of the type of author of propositon (for example, "Bancada",
#' "Deputado Federal", "Senador", "Comissao Diretora", "Orgao do Poder Executivo", etc - check
#' listarTiposAutores function for help). This is a optional parameter and it's default is empty.
#' @param parteNomeAutor string, a part of the name of the propostion's author. This is a optional
#' parameter and it's default is empty.
#' @param siglaPartidoAutor string, the political part of the proposition's author. This is a optional
#' parameter and it's default is empty.
#' @param siglaUfAutor string, the state (Unidade da Federacao) of the proposition's author. This is
#' a optional parameter and it's default is empty.
#' @param generoAutor string, the gender ("F" for female "M" for male) of the proposition's author. This is
#' a optional parameter and it's default is empty.
#' @param idSituacaoProposicao string, the situation (stage of the legislative process) of the propostion
#' (check listarSituacoesProposicao for hel). This is a optional parameter and it's default is empty.
#' @param idOrgaoSituacaoProposicao string, the Camara dos Deputados stance where the proposition is
#' located (check listarTiposOrgaos function for help). This is a optional parameter and it's default
#' is empty.
#' @param emTramitacao integer, indicates if the proposition (1) is still in the legislative process, or
#' (2) has reached an end. This is a optional parameter and it's default is empty (both conditions return).
#'
#' @return A data frame containing detailed information the requested propositions.
#'
#' @author Leonardo Sangali Barone; Alexia Aslan
#'
#' @import httr XML
#'
#' @examples
#'
#' # Return a data frame containing all of the propositions written in 2015
#' proposicoes2015 <- listarProposicoes(sigla = "PL", ano = 2015)
#' str(proposicoes2015)
#'
#' # Return a data frame containing the details of proposition PL-404/2015
#' proposicaoPL4042015 <- listarProposicoes(sigla = "PL", ano = 2015, numero = 404)
#' print(proposicaoPL4042015)
#'
#' # Return a data frame containing all of the propositions written by legislator Luiza Erundina
#' proposicoesDepErundina <- listarProposicoes(parteNomeAutor = "Erundina")
#' str(proposicoesDepErundina)
#'
#' # Return a data frame containing all of the propositions written in 2003 that are still in
#' # the legislative process
#' proposicoes2015EmTramitaco <- listarProposicoes(sigla = "PL", ano = 2015, emTramitacao = 1)
#' str(proposicoes2015EmTramitaco)
#'
#' @rdname listarProposicoes
#'
#' @export

listarProposicoes <- function(sigla = "",
                              ano = "",
                              numero = "",
                              datApresentacaoIni = "",
                              datApresentacaoFim = "",
                              idTipoAutor = "",
                              parteNomeAutor = "",
                              siglaPartidoAutor = "",
                              siglaUfAutor = "",
                              generoAutor = "",
                              idSituacaoProposicao = "",
                              idOrgaoSituacaoProposicao = "",
                              emTramitacao = "") {
  parsedOutput <- xmlParse(GET('http://www.camara.gov.br/SitCamaraWS/Proposicoes.asmx/ListarProposicoes?',
                               query = list(Sigla = sigla,
                                            Numero = numero,
                                            Ano = ano,
                                            datApresentacaoIni = datApresentacaoIni,
                                            datApresentacaoFim = datApresentacaoFim,
                                            IdTipoAutor = idTipoAutor,
                                            ParteNomeAutor = parteNomeAutor,
                                            SiglaPartidoAutor = siglaPartidoAutor,
                                            SiglaUfAutor = siglaUfAutor,
                                            GeneroAutor = generoAutor,
                                            IdSituacaoProposicao = idSituacaoProposicao,
                                            IdOrgaoSituacaoProposicao = idOrgaoSituacaoProposicao,
                                            EmTramitacao = emTramitacao,
                                            codEstado = "",
                                            codOrgaoEstado = "")))
  proposicao <- xmlToDataFrame(getNodeSet( parsedOutput, "//proposicao"), stringsAsFactors = F)[,c(1,2,4,5,8,9,13,16,17)]
  tipoProposicao <- xmlToDataFrame(getNodeSet( parsedOutput, "//proposicao/tipoProposicao"), stringsAsFactors = F)
  orgaoNumerador <- xmlToDataFrame(getNodeSet( parsedOutput, "//proposicao/orgaoNumerador"), stringsAsFactors = F)
  regime <- xmlToDataFrame(getNodeSet( parsedOutput, "//proposicao/regime"), stringsAsFactors = F)
  apreciacao <- xmlToDataFrame(getNodeSet( parsedOutput, "//proposicao/apreciacao"), stringsAsFactors = F)
  autor1 <- xmlToDataFrame(getNodeSet( parsedOutput, "//proposicao/autor1"), stringsAsFactors = F)
  ultimoDespacho <- xmlToDataFrame(getNodeSet( parsedOutput, "//proposicao/ultimoDespacho"), stringsAsFactors = F)
  situacao <- xmlToDataFrame(getNodeSet( parsedOutput, "//proposicao/situacao"), stringsAsFactors = F)[,1:2]
  situacao.orgao <- xmlToDataFrame(getNodeSet( parsedOutput, "//proposicao/situacao/orgao"), stringsAsFactors = F)
  situacao.principal <- xmlToDataFrame(getNodeSet( parsedOutput, "//proposicao/situacao/principal"), stringsAsFactors = F)
  proposicao <- cbind(proposicao, tipoProposicao, orgaoNumerador, regime, apreciacao, autor1, ultimoDespacho, situacao, situacao.orgao, situacao.principal)
  return(proposicao)
}
