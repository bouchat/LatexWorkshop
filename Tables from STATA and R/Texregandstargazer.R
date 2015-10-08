#Sarah Bouchat
#Texreg Example
#Latex Workshop 2
#7 October 2015

#Some packages you might need depending on your model

library(foreign) 
library(xtable)  
library(MASS) 
library(boot)
library(arm)
library(texreg)
library(stargazer)

#We'll be using built-in data from R for this example, to keep things simple

#Let's start by saving some models to objects
attach(ToothGrowth)
length.dose.reg<-lm(len~dose)
length.supp.reg<-lm(len~supp)
length.int.reg<-lm(len~dose+supp+dose*supp)

########################
# 1: Texreg
########################

#Now use texreg to pull each of those saved objects into a LaTeX-friendly table
texreg(list(length.dose.reg, length.supp.reg, length.int.reg),
       caption="OLS Estimates",
	   custom.coef.names=c("Intercept","Dose", "Supplement", "Dose*Sup"),
       dcolumn=TRUE,
       custom.model.names=c("Dose Only","Supplement Only", "W/ Interact"))
	   
#Notice that I can reference LaTeX packages from within texreg as well
	   texreg(list(length.dose.reg, length.supp.reg, length.int.reg),
	          caption="OLS Estimates, this time with booktabs!",
	   	   custom.coef.names=c("Intercept","Dose", "Supplement", "Dose*Sup"),
	          dcolumn=TRUE,
	          custom.model.names=c("Dose Only","Supplement Only", "W/ Interact"), booktabs=TRUE)

#Also notice that I can choose to omit variables as I like
	   texreg(list(length.dose.reg, length.supp.reg, length.int.reg),
	          caption="OLS Estimates, but not the intercept!",
	   	   custom.coef.names=c("Intercept","Dose", "Supplement", "Dose*Sup"),
	          dcolumn=TRUE,
	          custom.model.names=c("Dose","Supplement", "Interact"),
			  omit.coef=c("Intercept"))
	   
########################
# 2: Stargazer
########################

#Even simpler, but with different arguments

stargazer(length.dose.reg, length.supp.reg, length.int.reg, align=TRUE, column.labels=c("Dose Only", "Supplement Only", "w/Interact"), covariate.labels=c("Dose","Supplement","Dose*Supplement", "Intercept"), dep.var.labels=c("Tooth Length"))

#######################
# Want more? See these other packages: #http://stackoverflow.com/questions/5465314/tools-for-making-latex-tables-in-r






