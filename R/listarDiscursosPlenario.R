#' List Speeches
#'
#' @description Returns a data frame containing the list of, and information on, every
#' speech given between the initial and final date. Optionals can be used to specify
#' legislator, political party, state and session.
#'
#' @param dataIni string of format dd/mm/yyyy, the initial date.
#' @param dataFim string of format dd/mm/yyyy, the initial date.
#' @param codigoSessao integer, the number of a required legislative session. This is
#' an optional parameter and its default is empty.
#' @param parteNomeParlamentar string, a part of the name of the legislator.
#' This is a optional parameter and its default is empty.
#' @param siglaPartido string, the political party of the author of the proposal. This is an optional
#' parameter and its default is empty.
#' @param siglaUF string, the state (Unidade da Federacao) of the author of the proposal. This is
#' an optional parameter and its default is empty.
#'
#' @return A data frame containing the list of speeches and information on the same.
#'
#' @author Leonardo Sangali Barone; Alexia Aslan
#'
#' @note The output of this function can be used as a parameter in functions that speeches ids.
#'
#' @import httr XML
#'
#' @examples
#'
#' dataInicial = "01/04/2014"; dataFinal = "02/04/2014"
#' discursos <- listarDiscursosPlenario(dataInicial, dataFinal)
#' head(discursos)
#'
#' @rdname listarDiscursosPlenario
#' @export

listarDiscursosPlenario <- function(dataIni,
                                    dataFim,
                                    codigoSessao = "",
                                    parteNomeParlamentar = "",
                                    siglaPartido = "",
                                    siglaUF = ""){

  parsedOutput <- xmlParse(GET('http://www.camara.gov.br/sitcamaraws/SessoesReunioes.asmx/ListarDiscursosPlenario?',
                                      query = list(dataIni = dataIni,
                                                   dataFim = dataFim,
                                                   codigoSessao = codigoSessao,
                                                   parteNomeParlamentar= parteNomeParlamentar,
                                                   siglaPartido = siglaPartido,
                                                   siglaUF = siglaUF)))

  sessao <- xmlToDataFrame(getNodeSet(parsedOutput, "//sessao"), stringsAsFactors = F)[,1:4]

  output.parcial <- data.frame()

  for (i in 1:nrow(sessao)){
    faseSessao <- xmlToDataFrame(getNodeSet(parsedOutput,
                                            paste("//sessao[.//codigo/text() = '",
                                                  sessao$codigo[i],
                                                  "']//faseSessao",
                                                  sep = "")), stringsAsFactors = F)[,1:2]
    names(faseSessao) <- c("codigo.fase.sessao", "descricao.fase.sessao")
    output.parcial <- rbind(output.parcial, merge(sessao[i,], faseSessao))
  }

  output <- data.frame()

  for (j in 1:nrow(sessao)){
    orador <- xmlToDataFrame(getNodeSet(parsedOutput,
                                        paste("//sessao[.//codigo/text() = '",
                                              output.parcial$codigo[j],
                                              "']//faseSessao[.//codigo/text() = '",
                                              output.parcial$codigo.fase.sessao[j],
                                              "']//orador",
                                              sep = "")), stringsAsFactors = F)
    discurso <- xmlToDataFrame(getNodeSet(parsedOutput,
                                          paste("//sessao[.//codigo/text() = '",
                                                output.parcial$codigo[j],
                                                "']//faseSessao[.//codigo/text() = '",
                                                output.parcial$codigo.fase.sessao[j],
                                                "']//discurso",
                                                sep = "")), stringsAsFactors = F)
    discurso <- cbind(orador, discurso[2:length(discurso)])
    names(discurso)[1] <- "numero.discurso"
    output <- rbind(output, merge(output.parcial[i,], discurso))
  }
  return(output)
}
