factoptd.default<-function(narys, Optcrit = "", desvect,...){
  if(!is.numeric(desvect)) stop("Design vectors 'desvect'  should be numeric")
  if(!is.numeric(narys)|!(round(narys)==abs(narys))) stop("The number of arrays 'narys' should be positive integer")
  if(!is.element(Optcrit,c("A","D","E"))){stop("The optimality criterion 'Optcrit' is not correctly specified")}
  ndv<-nrow(desvect)#Size of design vectors
  cdsp<-as.matrix(compositions(narys,ndv)) #list of candidate designs 
  ldp<-length(desvect[1,]) #length of design points 
  ncd<-ncol(cdsp) #number of all candidate designs 
  #generate each designs
  cdesigns<-{}
  scrval<-{}
  for(j in 1:ncd) {
    despnt1<-{};
    ndp<-nrow(desvect)
    for(i in 1:ndp) {
      vect2<-matrix(rep(desvect[i,],cdsp[,j][i]),ldp,cdsp[,j][i])
      despnt1<-cbind(despnt1,vect2)
      }
    #Check for the connectedness of the candidate design (if |X'X| = 0 or not)
    detcd<-det(despnt1%*%t(despnt1))
    if(abs(detcd)<0.0000001) next
    cdesigns<-rbind(cdesigns,despnt1)
    matinvprod<-ginv(despnt1%*%t(despnt1)) #Inverse(x'x)
    if(Optcrit=="A") {
      #A-optimal multifactorial design
      ascrval4<-sum(diag(matinvprod)) #A-score value
      ascrval2<-c(ascrval4,cdsp[,j])
      scrval<-rbind(scrval,ascrval2)
      } else if(Optcrit=="D") {
        #D-optimal multifactorial design
        dscrval4<-det(matinvprod) #|(x'x)^-1|, D-score value
        dscrval2<-c(dscrval4,cdsp[,j])
        scrval<-rbind(scrval,dscrval2)
        } else if(Optcrit=="E") {
          #E-optimal multifactorial design
          Eegvs<-eigen(matinvprod)$values 
          escrval4<-Eegvs[1] #E-score value
          escrval2<-c(escrval4,cdsp[,j])
          scrval<-rbind(scrval,escrval2)
          } else {
            stop('Optimality criteria is not specified')
          }
  }
  if(is.null(scrval)) stop(paste("Factorial ", Optcrit,"-optimal design does not exist. Please provide appropriate number of arrays, narys",sep=""))
  sortdscv<-scrval[order(scrval[,1]),]
  factdeso<-sortdscv[sortdscv[,1]<=sortdscv[1,1],]
  optscv<-as.numeric(if(is.null(dim(factdeso))) factdeso[1] else  factdeso[1,1])
  optfctd<-if(is.null(dim(factdeso))) factdeso[-1] else factdeso[,-1]
    cnames=paste0("fdpnt",1:ndv)
    cnamesdv=paste0("dpnt",1:ndv)
    if(is.null(dim(factdeso))) {
    optfctd<-as.matrix(t(optfctd))}
    tnfd<-nrow(optfctd)
    rnamesfd<-paste0("Optfd",1:tnfd)
    dimnames(optfctd)=list(rnamesfd,cnames)#} else {optfctd<-t(optfctd)}
    desvect0<-t(desvect)
    dimnames(desvect0) = list({},cnamesdv)
  factdes<-list("b" = narys, Optcrit = Optcrit, optscv = optscv,  optfctd = optfctd, desvect = desvect0, tnfd = tnfd)
  factdes$call<-match.call()

  titleoptbd<-list(c("      --------------------------------------- ",paste("Title: Factorial ",Optcrit,"-optimal  design(s)          Date:", format(Sys.time(), "%a %b %d %Y %H:%M:%S"),sep=""),
                     "      --------------------------------------- "))
  tempFiled <- tempfile(pattern = paste("Fact",Optcrit,"opt_summary",sep = ""), tempdir(), ".csv")
  write.table(titleoptbd, file = tempFiled,append=T ,sep = ",", row.names=FALSE, col.names=FALSE)
  
  parcomb<-list(c("Number of arrays:", " ", paste("No. of ",  Optcrit, "-optimal factorial design(s):" ,sep=""), " ", "Design vectors:"),
                c(narys, " ",tnfd ," "," "))
  write.table(parcomb, file = tempFiled,append=T ,sep = ",", row.names=FALSE, col.names=FALSE)
  write.table(cbind("",rbind(cnamesdv,desvect0)), file = tempFiled,append=T ,sep = ",", row.names=FALSE, col.names=FALSE)
  write.table(rbind("",list(paste("Resultant ",Optcrit,"-optimal factorial design(s) are:",sep="")),""), file = tempFiled,append=T ,sep = ",", row.names=FALSE, col.names=FALSE)
  stitle<-list("","","Design vectors      ","","","   Optimal factorial design(s)")
  write.table(stitle, file = tempFiled,append=T ,sep = ",", row.names=FALSE, col.names=FALSE)
  
  soptfctdd<-cbind(c("",cnamesdv),rbind(c(paste0("x",1:ldp),paste0("Optfd",1:tnfd)),cbind(t(desvect0),t(optfctd))))
  write.table(cbind("",soptfctdd), file = tempFiled,append=T ,sep = ",", row.names=FALSE, col.names=FALSE)
  write.table(list(c("",paste(Optcrit,"-score value:")),c("",optscv)), file = tempFiled,append=T ,sep = ",", row.names=FALSE, col.names=FALSE)
  
  class(factdes)<-"factoptd"
  factdes
}

