plot.acc.timecourse <- function(dat){
	## Plots the average accuracy.
	library(ggplot2)

	plt <- ggplot(dat, aes(stimIndex, y=acc,ymin=0,ymax=1))
	plt <- plt + facet_grid(~crit_0.625)
	plt <- plt + scale_fill_manual(values = c("black","grey"))
	plt <- plt + stat_smooth(method="glm", family="binomial")
	plt <- plt + stat_summary(fun.y = "mean",geom="line")
	plt <- plt + theme_bw()
	plt <- plt + opts(strip.text.y = theme_text(),
					  panel.grid.major = theme_blank(), 
					  panel.grid.minor =  theme_blank())
	plt <- plt + geom_hline(aes(yintercept=0.625),colour="grey")
	print(plt)
}
