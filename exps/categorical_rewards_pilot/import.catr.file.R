import.catr.file <- function(fname=''){
## For bulk job try
#p1.data <- import.catr.file('data_1_trials.dat'); for(f in files){p1.data <- rbind(p1.data,import.catr.file(f))}

	## Get and name the data fields
	fdata <- read.table(fname,sep="\t")
	fdata <- fdata[,1:11] 
		# drop the last empy col
	fdata[[12]] <- as.factor(rep(fname,nrow(fdata)))
	colnames <- c("index","stim","correctResp","acc","rt",
				  "resp","rew_cond","par1","par2","par3",
				  "reward","sCode")
	colnames(fdata) <- colnames
	
	## Create a trial index for each category stim
	stimList <- unique(fdata[["stim"]])
	fdata[["stimIndex"]] <- rep(0,nrow(fdata))
	for(s in stimList){
		stimMask <- fdata[["stim"]] == s
		index = 1:length(fdata[["stim"]][stimMask])
		fdata[["stimIndex"]][stimMask] <- index
	}

	m.10 <- mean(fdata[["acc"]][(nrow(fdata)-10):nrow(fdata)])
	if (m.10 > .63){
		fdata[["crit_0.625"]] <- rep("learner",(dim(fdata))[1])
	} else{
		fdata[["crit_0.625"]] <- rep("non_learner",(dim(fdata))[1])
	}
	fdata[["crit_0.625"]] <- as.factor(fdata[["crit_0.625"]])
	fdata
}
