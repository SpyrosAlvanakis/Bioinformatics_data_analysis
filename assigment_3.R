pdf("R Graphics Output.pdf", width=10)
library("readxl")

dataage=as.data.frame(read_excel("/home/spyros/metaptyxiako/bioinformatics/3rd_assignment_in_Bioinformatics/EurostatCensus2011.xlsx",sheet=1))
dataoc=as.data.frame(read_excel("/home/spyros/metaptyxiako/bioinformatics/3rd_assignment_in_Bioinformatics/EurostatCensus2011.xlsx",sheet=2))
datanonl=as.data.frame(read_excel("/home/spyros/metaptyxiako/bioinformatics/3rd_assignment_in_Bioinformatics/EurostatCensus2011.xlsx",sheet=3))

total<-apply(dataage[,2:ncol(dataage)],1,sum)

#for the total population of each country
dataf_total=data.frame(total, row.names =c(dataage$Country))


#for the total population of EU
total_pop<-sum(dataf_total$total)


#spliting the age groups
age_group<-c(colnames(dataage[2:ncol(dataage)]))

total<-apply(dataage[,2:ncol(dataage)],2,sum)

#to store the total population of each age group
dataf_agegroups<-data.frame(total, row.names=age_group)


#for the pie chart represent the total age distribution of the EU population
label_age<-age_group

library('RColorBrewer')
color <- brewer.pal(length(total), "Set2") 

pie(dataf_agegroups$total,labels=label_age,border = "black",col = color)

#for the barplot
total<-apply(dataoc[,2:ncol(dataoc)],2,sum)


#set tha dataframe
names<-c(colnames(dataoc[2:ncol(dataoc)]))
dataf_oc<-data.frame(total,row.names=names)

#for the barplot with the absolute number

barplot(dataf_oc$total,border=F, names.arg = dataf_oc$row.names,
        col=rainbow(length(total)), ylab="total number",xlab="occupations",
        main = "Absolute Barplot")

#for percentage barplot
library(ggplot2)
library(scales)
ggplot(dataf_oc,aes(y=names))+
  geom_bar(aes(x=..total../sum(..total..)))+
           xlab("Percentage")+
            ylab("Occupations")+
           scale_x_continuous(labels=scales::percent)

# i put with ggplot(dataf_oc,aes(y=names) the occupations in the y column 
# with geom_bar(aes(x=..total../sum(..total..))) i put the regulate value of each occupation 
# with scale_x_continuous(labels=scales::percent) i made the fractions percentages

#for pie chart

df<-datanonl
str(df)
df<-as.data.frame(sapply(datanonl,as.numeric))

df$`GEOGRAPHICAL AREA/COUNTRY OF CITIZENSHIP`<-datanonl$`GEOGRAPHICAL AREA/COUNTRY OF CITIZENSHIP`

for (i in 1:ncol(df)){
  for (j in 1:nrow(datanonl)){
    if (is.na(df[j,i])){
      df[j,i]<-0
    }
  }
}

total<-apply(df[,2:ncol(datanonl)],2,sum)

origin<-c(colnames(datanonl[2:ncol(datanonl)]))
dataf_nonl<-data.frame(total,row.names=origin)


library(RColorBrewer)
myPalette <- brewer.pal(length(origin), "Set2") 
pie(dataf_nonl$total,labels=origin,border='white',col=myPalette)

dev.off()
















