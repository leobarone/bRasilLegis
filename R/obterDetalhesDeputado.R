obterDetalhesDeputado <- function (ideCadastro.param,
                                   numLegislatura.param = "",
                                   atuacao = "bio"){
  ideCadastro.param = 141529
  parsedRequestOutput <- xmlParse(GET('http://www.camara.gov.br/SitCamaraWS/Deputados.asmx/ObterDetalhesDeputado?',
                                      query = list(ideCadastro = ideCadastro.param,
                                                   numLegislatura = numLegislatura.param)))
  infoBasica <- xmlToDataFrame(parsedRequestOutput)[,1:12]

  if (atuacao == "bio") {
    partidoAtual <- xmlToDataFrame(getNodeSet(parsedRequestOutput, "//partidoAtual"))
    gabinete <- xmlToDataFrame(getNodeSet(parsedRequestOutput, "//gabinete"))
    output <- cbind(infoBasica, partidoAtual, gabinete)
  }

  if (atuacao == "comissoes") {
    infoBasica <- infoBasica[,c(1, 8, 10)]
    output <- data.frame()
    for (i in nrow(infoBasica)) {
      comissoes <- xmlToDataFrame(getNodeSet(parsedRequestOutput,
                                             paste("//Deputado[.//numLegislatura/text() = '",
                                                   Deputado$numLegislatura[i],
                                                   "']//comissao",
                                                   sep = "")), stringsAsFactors = F)
      output <- rbind(output, merge(infoBasica, comissoes))
    }

    if (atuacao == "cargos") {
      infoBasica <- infoBasica[,c(1, 8, 10)]
      output <- data.frame()
      for (i in nrow(infoBasica)) {
        cargos <- xmlToDataFrame(getNodeSet(parsedRequestOutput,
                                               paste("//Deputado[.//numLegislatura/text() = '",
                                                     Deputado$numLegislatura[i],
                                                     "']//cargosComissoes",
                                                     sep = "")), stringsAsFactors = F)
        output <- rbind(output, merge(infoBasica, cargos))
      }
    }

    if (atuacao == "exercicios") {
      infoBasica <- infoBasica[,c(1, 8, 10)]
      output <- data.frame()
      for (i in nrow(infoBasica)) {
        periodos <- xmlToDataFrame(getNodeSet(parsedRequestOutput,
                                               paste("//Deputado[.//numLegislatura/text() = '",
                                                     Deputado$numLegislatura[i],
                                                     "']//periodosExercicio",
                                                     sep = "")), stringsAsFactors = F)
        output <- rbind(output, merge(infoBasica, periodos))
      }
    }

    if (atuacao == "filiacoes") {
      infoBasica <- infoBasica[,c(1, 8, 10)]
      output <- data.frame()
      for (i in nrow(infoBasica)) {
        filiacoes <- xmlToDataFrame(getNodeSet(parsedRequestOutput,
                                              paste("//Deputado[.//numLegislatura/text() = '",
                                                    Deputado$numLegislatura[i],
                                                    "']//filiacoesPartidarias",
                                                    sep = "")), stringsAsFactors = F)
        output <- rbind(output, merge(infoBasica, filiacoes))
      }
    }

    if (atuacao == "lideranca") {
      infoBasica <- infoBasica[,c(1, 8, 10)]
      output <- data.frame()
      for (i in nrow(infoBasica)) {
        lideranca <- xmlToDataFrame(getNodeSet(parsedRequestOutput,
                                               paste("//Deputado[.//numLegislatura/text() = '",
                                                     Deputado$numLegislatura[i],
                                                     "']//historicoLider",
                                                     sep = "")), stringsAsFactors = F)
        output <- rbind(output, merge(infoBasica, lideranca))
      }
    }
  }
  return(output)
}
