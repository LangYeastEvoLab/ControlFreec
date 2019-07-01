Make.FREEC.plot <- function(input){
 
  ratio<-input
  
  #these will only be in ratio.txt if you use modifyRatio script, add name and ploidy to data frame otherwise
  name<- ratio[2,6]
  ploidy = ratio[2,7]
  
  #uncomment this for log graphs
  # png(filename = paste(name,".log2.png",sep = ""), width = 1180, height = 1180,
  #     units = "px", pointsize = 20, bg = "white", res = NA)
  # plot(1:10)
  # op <- par(mfrow = c(5,5))
  # 
  # for (i in c('I','II','III','IV','V','VI','VII','VIII','IX','X','XI','XII','XIII','XIV','XV','XVI','mt')) {
  #   tt <- which(ratio$Chromosome==i)
  #   if (length(tt)>0) {
  #     plot(ratio$Start[tt],log2(ratio$Ratio[tt]),xlab = paste ("position, chr",i),ylab = "normalized copy number profile (log2)",pch = ".",col = colors()[88])
  #     tt <- which(ratio$Chromosome==i  & ratio$CopyNumber>ploidy )
  #     points(ratio$Start[tt],log2(ratio$Ratio[tt]),pch = ".",col = colors()[136])
  #     
  #     
  #     tt <- which(ratio$Chromosome==i  & ratio$CopyNumber<ploidy & ratio$CopyNumber!= -1)
  #     points(ratio$Start[tt],log2(ratio$Ratio[tt]),pch = ".",col = colors()[461])
  #     tt <- which(ratio$Chromosome==i)
  #     
  #     #UNCOMMENT HERE TO SEE THE PREDICTED COPY NUMBER LEVEL:
  #     #points(ratio$Start[tt],log2(ratio$CopyNumber[tt]/ploidy), pch = ".", col = colors()[24],cex=4)
  #     
  #   }
  #   tt <- which(ratio$Chromosome==i)
  #   
  #   #UNCOMMENT HERE TO SEE THE EVALUATED MEDIAN LEVEL PER SEGMENT:
  #   #points(ratio$Start[tt],log2(ratio$MedianRatio[tt]), pch = ".", col = colors()[463],cex=4)
  #   
  # }
  # 
  # dev.off()
  
  
  png(filename = paste(name,".png",sep = ""), width = 1180, height = 1180,
      units = "px", pointsize = 20, bg = "white", res = NA)
  plot(1:10)
  op <- par(mfrow = c(5,5))
  
  maxLevelToPlot <- 4
  for (i in c(1:length(ratio$Ratio))) {
    if (ratio$Ratio[i]>maxLevelToPlot) {
      ratio$Ratio[i]=maxLevelToPlot;
    }
  }
  
  
  for (i in c('I','II','III','IV','V','VI','VII','VIII','IX','X','XI','XII','XIII','XIV','XV','XVI','mt')) {
    tt <- which(ratio$Chromosome==i)
    if (length(tt)>0) {
      plot(ratio$Start[tt],ratio$Ratio[tt]*ploidy,ylim = c(0,maxLevelToPlot*ploidy),xlab = paste ("position, chr",i),ylab = "normalized copy number profile",pch = ".",col = colors()[88])
      tt <- which(ratio$Chromosome==i  & ratio$CopyNumber>ploidy )
      points(ratio$Start[tt],ratio$Ratio[tt]*ploidy,pch = ".",col = colors()[136])
      
      tt <- which(ratio$Chromosome==i  & ratio$Ratio==maxLevelToPlot & ratio$CopyNumber>ploidy)	
      points(ratio$Start[tt],ratio$Ratio[tt]*ploidy,pch = ".",col = colors()[136],cex=4)
      
      tt <- which(ratio$Chromosome==i  & ratio$CopyNumber<ploidy & ratio$CopyNumber!= -1)
      points(ratio$Start[tt],ratio$Ratio[tt]*ploidy,pch = ".",col = colors()[461])
      tt <- which(ratio$Chromosome==i)
      
      #UNCOMMENT HERE TO SEE THE PREDICTED COPY NUMBER LEVEL:
      #points(ratio$Start[tt],ratio$CopyNumber[tt], pch = ".", col = colors()[24],cex=4)
      
    }
    tt <- which(ratio$Chromosome==i)
    
    #UNCOMMENT HERE TO SEE THE EVALUATED MEDIAN LEVEL PER SEGMENT:
    #points(ratio$Start[tt],ratio$MedianRatio[tt]*ploidy, pch = ".", col = colors()[463],cex=4)
    
  }
  mtext(text=name, side=3, line=-1, at = 300000)
  mtext(text=paste("Ploidy=",ploidy, sep=''), side=3, line= -2.5, at = 300000)
  dev.off()
}
