#' Get Legislator Details
#'
#' @description Returns a data frame containing detailed information of the legislator (for
#' example, political parties, leaderships, committee positions, etc) at Camara dos Deputados.
#' The parameter atuacao helps to define what type of information is going to be
#' returned.
#'
#' @param ideCadastro integer, the legislator id number at the web service (check obterDeputados
#' function for help).
#' @param numLegislatura integer, is the number of a Legislature. This is an optional parameter
#' and it's default is empty.
#' @param atuacao string, if "bio" (default), return the basic bio information of the legislator;
#' if "comissoes", return the committee information of the legislator; if "cargos", return the
#' information on the positions occupied by the the legilator, if "exercicios" return the time
#' intervals in which the legislator were at Camara dos Deputados; if "filiacoes" return the
#' political parties in which the legislators belonged; and if "lideranca", returns leadership
#' information of the legislators.
#'
#' @return A data frame containing detailed information of the legislator.
#'
#' @author Alexia Aslan; Leonardo Sangali Barone;
#'
#' @import httr XML
#'
#' @examples
#'
#' obterDetalhesDeputado(74784)
#' obterDetalhesDeputado(74784, atuacao = "cargos")
#'
#' @rdname obterDetalhesDeputado
#' @export

obterDetalhesDeputado <- function (ideCadastro,
                                   numLegislatura = "",
                                   atuacao = "bio"){
  parsedOutput <- xmlParse(GET('http://www.camara.gov.br/SitCamaraWS/Deputados.asmx/ObterDetalhesDeputado?',
                               query = list(ideCadastro = ideCadastro,
                                            numLegislatura = numLegislatura)))
  infoBasica <- xmlToDataFrame(parsedOutput)[,1:12]

  if (atuacao == "bio") {
    partidoAtual <- xmlToDataFrame(getNodeSet(parsedOutput, "//partidoAtual"))
    gabinete <- xmlToDataFrame(getNodeSet(parsedOutput, "//gabinete"))
    output <- cbind(infoBasica, partidoAtual, gabinete)
  }

  if (atuacao == "comissoes") {
    infoBasica <- infoBasica[,c(1, 8, 10)]
    output <- data.frame()
    for (i in nrow(infoBasica)) {
      comissoes <- xmlToDataFrame(getNodeSet(parsedOutput,
                                             paste("//Deputado[.//numLegislatura/text() = '",
                                                   infoBasica$numLegislatura[i],
                                                   "']//comissao",
                                                   sep = "")), stringsAsFactors = F)
      output <- rbind(output, merge(infoBasica, comissoes))
    }
  }

  if (atuacao == "cargos") {
    infoBasica <- infoBasica[,c(1, 8, 10)]
    output <- data.frame()
    for (i in nrow(infoBasica)) {
      cargos <- xmlToDataFrame(getNodeSet(parsedOutput,
                                          paste("//Deputado[.//numLegislatura/text() = '",
                                                infoBasica$numLegislatura[i],
                                                "']//cargosComissoes",
                                                sep = "")), stringsAsFactors = F)
      output <- rbind(output, merge(infoBasica, cargos))
    }
  }

  if (atuacao == "exercicios") {
    infoBasica <- infoBasica[,c(1, 8, 10)]
    output <- data.frame()
    for (i in nrow(infoBasica)) {
      periodos <- xmlToDataFrame(getNodeSet(parsedOutput,
                                            paste("//Deputado[.//numLegislatura/text() = '",
                                                  infoBasica$numLegislatura[i],
                                                  "']//periodosExercicio",
                                                  sep = "")), stringsAsFactors = F)
      output <- rbind(output, merge(infoBasica, periodos))
    }
  }

  if (atuacao == "filiacoes") {
    infoBasica <- infoBasica[,c(1, 8, 10)]
    output <- data.frame()
    for (i in nrow(infoBasica)) {
      filiacoes <- xmlToDataFrame(getNodeSet(parsedOutput,
                                             paste("//Deputado[.//numLegislatura/text() = '",
                                                   infoBasica$numLegislatura[i],
                                                   "']//filiacoesPartidarias",
                                                   sep = "")), stringsAsFactors = F)
      output <- rbind(output, merge(infoBasica, filiacoes))
    }
  }

  if (atuacao == "lideranca") {
    infoBasica <- infoBasica[,c(1, 8, 10)]
    output <- data.frame()
    for (i in nrow(infoBasica)) {
      lideranca <- xmlToDataFrame(getNodeSet(parsedOutput,
                                             paste("//Deputado[.//numLegislatura/text() = '",
                                                   infoBasica$numLegislatura[i],
                                                   "']//historicoLider",
                                                   sep = "")), stringsAsFactors = F)
      output <- rbind(output, merge(infoBasica, lideranca))
    }
  }
  return(output)
}
