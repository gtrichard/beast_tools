# BEAST Markov Matrices Maker
# Description: generates a XML file next to this script with Markov Jumps and Rewards matrices formatted properly to be copy pasted to the BEAST XML.
# Author: Gautier RICHARD
# email: gautier.richard@anses.fr
# date: 09/10/2023


##########  PARAMETERS ############
outputFile = "regions_markov.xml"                      # File the matrices will be written to
state = "regions"                           # Name of the state used in BEAUTi
compartments = c("22","27","28","29","35","37","44","49","50","53","56","72","76","79","81","05")  # State codes used in BEAUTi


######### SCRIPT #########
#Sets wordking directory to the script file
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

#useful variables
comLen = as.numeric(length(compartments))
row1 = rep(1,comLen)

#text file init
write(paste(sep='',''), file = outputFile, append=T, sep="\n") 
write(paste(sep='','	<!-- Likelihood for tree given discrete trait data                           -->'), file = outputFile, append=F, sep="\n") 
write(paste(sep='','	<markovJumpsTreeLikelihood id="',state,'.treeLikelihood" stateTagName="',state,'.states" useUniformization="true" numberOfSimulants="1" saveCompleteHistory="true">'), file = outputFile, append=T, sep="\n") 
write(paste(sep='','		<attributePatterns idref="',state,'.pattern"/>'), file = outputFile, append=T, sep="\n") 
write(paste(sep='','		<treeModel idref="treeModel"/>'), file = outputFile, append=T, sep="\n") 
write(paste(sep='','		<siteModel idref="',state,'.siteModel"/>'), file = outputFile, append=T, sep="\n") 
write(paste(sep='','		<generalSubstitutionModel idref="',state,'.model"/>'), file = outputFile, append=T, sep="\n") 
write(paste(sep='','		<generalSubstitutionModel idref="',state,'.model"/>'), file = outputFile, append=T, sep="\n") # duplicated but apparently it's how it should be
write(paste(sep='','		<strictClockBranchRates idref="',state,'.branchRates"/>'), file = outputFile, append=T, sep="\n") 
write(paste(''), file = outputFile, append=T, sep="\n") 
write(paste(sep='','		<!-- The root state frequencies                                              -->'), file = outputFile, append=T, sep="\n") 
write(paste(sep='','		<frequencyModel id="',state,'.root.frequencyModel" normalize="true">'), file = outputFile, append=T, sep="\n") 
write(paste(sep='','			<generalDataType idref="',state,'.dataType"/>'), file = outputFile, append=T, sep="\n") 
write(paste(sep='','			<frequencies>'), file = outputFile, append=T, sep="\n") 
write(paste(sep='','				<parameter id="',state,'.root.frequencies" dimension="',comLen,'"/>'), file = outputFile, append=T, sep="\n") 
write(paste(sep='','			</frequencies>'), file = outputFile, append=T, sep="\n") 
write(paste(sep='','		</frequencyModel>'), file = outputFile, append=T, sep="\n") 
write(paste(''), file = outputFile, append=T, sep="\n") 

write(paste("		<!-- START Ancestral state reconstruction                                    -->"), file = outputFile, append=T, sep="\n") 

#count matrix to export (as.vector to flatten)
m = matrix(1,comLen,comLen)
diag(m) = 0
count_matrix = as.vector(format(round(m, 2), nsmall = 1))
write(paste(sep='', '		<parameter id="',state,'.count','" value=" ',paste(as.vector(format(round(m, 2), nsmall = 1)), collapse = " "),'"/>'), file = outputFile, append = T, sep="\n")


#from Matrices to export
fromMatrices = list()
for(i in 1:comLen){
  m = matrix(0,comLen,comLen)
  m[,i] = row1
  name=paste(state,".from",compartments[i],sep = "")
  #fromMatrices[[name]] = as.matrix(format(round(m, 2), nsmall = 1))
  write(paste(sep='', '		<parameter id="',name,'" value=" ',paste(as.vector(format(round(m, 2), nsmall = 1)), collapse = " "),'"/>'), file = outputFile, append = T, sep="\n")
}


#fromto Matrices to export
fromtoMatrices = list()
for(i in 1:comLen){
  for(j in 1:comLen){
    if (i == j) {
      next
    }
    m = matrix(0,comLen,comLen)
    m[j,i] = 1
    name = paste(state,".",compartments[i],"to",compartments[j],sep = "")
#    fromtoMatrices[[name]] = as.matrix(format(round(m, 2), nsmall = 1))
    write(paste(sep='', '		<parameter id="',name,'" value=" ',paste(as.vector(format(round(m, 2), nsmall = 1)), collapse = " "),'"/>'), file = outputFile, append = T, sep="\n")
  }
}


#to Matrices to export
toMatrices = list()
for(i in 1:comLen){
  m = matrix(0,comLen,comLen)
  m[i,] = row1
  name = paste(state,".to",compartments[i],sep = "")
  #toMatrices[[name]] = as.matrix(format(round(m, 2), nsmall = 1))
  write(paste(sep='', '		<parameter id="',name,'" value=" ',paste(as.vector(format(round(m, 2), nsmall = 1)), collapse = " "),'"/>'), file = outputFile, append = T, sep="\n")
}


#Markov rewards
write(paste(sep='',''), file = outputFile, append = T, sep="\n")
write(paste(sep='','	<rewards>'), file = outputFile, append = T, sep="\n")
write(paste(sep='',''), file = outputFile, append = T, sep="\n")

for(i in 1:comLen){
  v = rep(0,comLen)
  v[i] = 1
  write(paste(sep='','		<parameter id="',compartments[i],'_reward" value="',paste(as.vector(format(round(v, 2), nsmall = 1)), collapse = " "),'"/>'), file = outputFile, append = T, sep="\n")
}
write(paste(sep='',''), file = outputFile, append = T, sep="\n")
write(paste(sep='','	</rewards>'), file = outputFile, append = T, sep="\n")
write(paste(sep='',''), file = outputFile, append = T, sep="\n")
write(paste(sep='','		<!-- END Ancestral state reconstruction                                      -->'), file = outputFile, append = T, sep="\n")
write(paste(sep='',''), file = outputFile, append = T, sep="\n")
write(paste(sep='','	</markovJumpsTreeLikelihood>'), file = outputFile, append = T, sep="\n")
write(paste(sep='',''), file = outputFile, append = T, sep="\n")
write(paste(sep='','	<!-- END Discrete Traits Model                                               -->'), file = outputFile, append = T, sep="\n")
