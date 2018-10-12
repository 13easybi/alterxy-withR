getScriptPath <- function(){
  cmd.args <- commandArgs()
  m <- regexpr("(?<=^--file=).+", cmd.args, perl=TRUE)
  script.dir <- dirname(regmatches(cmd.args, m))
  if(length(script.dir) == 0) stop("can't determine script dir: please call the script with Rscript")
  if(length(script.dir) > 1) stop("can't determine script dir: more than one '--file' argument detected")
  return(script.dir)
}
#path <- data.frame(pat = unlist(strsplit(c("C:/Users/user/teste_2"),"/")))
path <- data.frame(pat = unlist(strsplit(c(getScriptPath()),"/")))
path$pat <- as.character(path$pat)

fim <- nrow(path)

for (i in 1:fim ) {
  
  if (i==1){
    passando <- path[i,1]
    montando <- path[i,1]
    
  } else 
  {
    passando <- path[i,1]
    montando <- paste0(montando,"/",passando)  
  }
}

montando <- paste0(montando,"/")

setwd(montando)

mainDir <-(montando)
Param_dir  <- tolower("parametros")
resul_dir  <- tolower("resultados")

ifelse(!dir.exists(file.path(paste0(mainDir,Param_dir))), dir.create(file.path( paste0(mainDir,Param_dir))), FALSE)
ifelse(!dir.exists(file.path(paste0(mainDir,resul_dir))), dir.create(file.path( paste0(mainDir,resul_dir))), FALSE)

fnames <- dir(paste0(montando,Param_dir,"/"), pattern = "csv")
alt_nm <- dir(paste0(montando), pattern = "yxmd")

if ( length(fnames)<=0 & length( alt_nm)<=0 ){
  ###Primeira execução do programa 
  #####Gera diretorios necessarios
  #####Gera Log solicitando inclusao de lista de parametro
  #####Gera Log solicitando inclusao arquivo .yxmd
  log_texto <- as.character(paste( "
                        ",Sys.time()," 
                     ##### Arquivo Log #####

Muito bem, estamos quase la! 
Copie o arquivo .yxmd na pasta raiz da aplicacao, na mesma pasta do arquivo Gera_arq_Alterxy.R
Insira o arquivo de parametros na pasta ~/parametros
 obs: Nao esqueca que o primeiro parametro da lista sera o procurado para substituir pelo restante da lista
                     ") )
  write.csv(log_texto,paste0(montando,"/Primeira_execucao.log"))
  
} else if ( length(fnames)>0 & length( alt_nm)>0 )
  
  {
  lista <- data.frame(param =  read.csv2(paste0(montando,Param_dir,"/",fnames)))
  
  
  for (x in 2:nrow(lista)) {
    txt <- readLines(file(alt_nm))
    txt <- gsub(lista[1,1],lista[x,1], txt)
    writeLines(txt, file(paste0(montando,resul_dir,"/",x,"_",lista[x,1],"_",alt_nm)))
    print(paste(x,lista[x,1]))  
  }
  
  
  
  log_texto <- paste("Executou com sucesso",Sys.time(),lista[2:nrow(lista),1]) 
  write.csv(log_texto,paste0(montando,"/Execucao_sucesso.log"))
  if (file.exists(paste0(montando,"/Primeira_execucao.log"))) file.remove(paste0(montando,"/Primeira_execucao.log"))
  if (file.exists(paste0(montando,"/Segunda_execucao.log"))) file.remove(paste0(montando,"/Segunda_execucao.log"))
  if (file.exists(paste0(montando,"/Terceira_execucao.log"))) file.remove(paste0(montando,"/Terceira_execucao.log"))
  
  
} else if ( length(fnames)>0 & length( alt_nm)<=0 )
  
  {
  ###Execução do programa com arquivo parametro sem arquivo alterxy
  #####Gera Log solicitando inclusao arquivo .yxmd
  log_texto <- as.character(paste( "
                                   ",Sys.time()," 
                                   ##### Arquivo Log #####
                                   
Muito bem, voce colocou o arquivo de parametro.  
Agora copie o arquivo .yxmd na pasta raiz da aplicacao, na mesma pasta do arquivo Gera_arq_Alterxy.R
                                   ") )
  if (file.exists(paste0(montando,"/Primeira_execucao.log"))) file.remove(paste0(montando,"/Primeira_execucao.log"))
  if (file.exists(paste0(montando,"/Terceira_execucao.log"))) file.remove(paste0(montando,"/Terceira_execucao.log"))
  
  
  write.csv(log_texto,paste0(montando,"/Segunda_execucao.log"))
  
  if (file.exists(paste0(montando,"/Execucao_sucesso.log"))) file.remove(paste0(montando,"/Execucao_sucesso.log"))
  
  
    
} else if ( length(fnames)<=0 & length( alt_nm)>0 )
  
  {
    
  ###Execução do programa com  arquivo alterxy sem arquivo parametro 
  #####Gera Log solicitando inclusao arquivo .yxmd
  log_texto <- as.character(paste( "
                                   ",Sys.time()," 
                                   ##### Arquivo Log #####
                                   
Muito bem, voce colocou o arquivo Alterxy.
Insira o arquivo de parametros na pasta ~/parametros
obs: Nao esqueca que o primeiro parametro da lista sera o procurado para substituir pelo restante da lista
                                   ") )
  if (file.exists(paste0(montando,"/Primeira_execucao.log"))) file.remove(paste0(montando,"/Primeira_execucao.log"))
  if (file.exists(paste0(montando,"/Segunda_execucao.log"))) file.remove(paste0(montando,"/Segunda_execucao.log"))
  if (file.exists(paste0(montando,"/Execucao_sucesso.log"))) file.remove(paste0(montando,"/Execucao_sucesso.log"))
  
  
  write.csv(log_texto,paste0(montando,"/Terceira_execucao.log"))
  
  
  
  }
