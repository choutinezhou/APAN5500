library(readr)
FinalData <- read_csv("FinalData.csv")
SortFrom <- FinalData$Exp...From.Field..
SortTo <- FinalData$Carrer.Plan...To.Field..
SortTo[35] <- "IT"
SortTo[36] <- "Business Analyst"
CareerPlan <- list(SortFrom,SortTo)
names(CareerPlan) <- c("SortFrom","SortTo")
CareerPlan <- as.data.frame(CareerPlan)
CareerPlan <- na.omit(CareerPlan)
CareerPlan$SortFrom <- as.factor(CareerPlan$SortFrom)
levels(CareerPlan$SortFrom)[levels(CareerPlan$SortFrom)=="Public offering fund"] <- "Finance"
levels(CareerPlan$SortFrom)[levels(CareerPlan$SortFrom)=="Fianance"] <- "Finance"
levels(CareerPlan$SortFrom)[levels(CareerPlan$SortFrom)=="Investment, Technology"] <- "Finance"
levels(CareerPlan$SortFrom)[levels(CareerPlan$SortFrom)=="Airline Company"] <- "Coorporation Management"
levels(CareerPlan$SortFrom)[levels(CareerPlan$SortFrom)=="Data Analytics"] <- "Data Analyst"
levels(CareerPlan$SortFrom)[levels(CareerPlan$SortFrom)=="Data"] <- "Data Analyst"
levels(CareerPlan$SortFrom)[levels(CareerPlan$SortFrom)=="Analyst"] <- "Data Analyst"
levels(CareerPlan$SortFrom)[levels(CareerPlan$SortFrom)=="Trading/ Insurance"] <- "Economics"
levels(CareerPlan$SortFrom)[levels(CareerPlan$SortFrom)=="Technology, Retail"] <- "IT"
levels(CareerPlan$SortFrom)[levels(CareerPlan$SortFrom)=="Technical"] <- "IT"
levels(CareerPlan$SortFrom)[levels(CareerPlan$SortFrom)=="Programmer"] <- "IT"
levels(CareerPlan$SortFrom)[levels(CareerPlan$SortFrom)=="Investment, Technology"] <- "Finance"
levels(CareerPlan$SortFrom)[levels(CareerPlan$SortFrom)=="Financial Advisor"] <- "Consulting"
levels(CareerPlan$SortFrom)[levels(CareerPlan$SortFrom)=="Product Management"] <- "Coorporation Management"
levels(CareerPlan$SortFrom)[levels(CareerPlan$SortFrom)=="environmental"] <- "Coorporation Management"
levels(CareerPlan$SortFrom)[levels(CareerPlan$SortFrom)=="media"] <- "Coorporation Management"
levels(CareerPlan$SortFrom)[levels(CareerPlan$SortFrom)=="Banking"] <- "Business Analyst"
levels(CareerPlan$SortFrom)[levels(CareerPlan$SortFrom)=="Economics"] <- "Business Analyst"
CareerPlan$SortTo <- as.factor(CareerPlan$SortTo)
levels(CareerPlan$SortTo)[levels(CareerPlan$SortTo)=="Analyst"] <- "Data Analyst"
levels(CareerPlan$SortTo)[levels(CareerPlan$SortTo)=="Big Data"] <- "Data Analyst"
levels(CareerPlan$SortTo)[levels(CareerPlan$SortTo)=="Data"] <- "Data Analyst"
levels(CareerPlan$SortTo)[levels(CareerPlan$SortTo)=="Data Analytics"] <- "Data Analyst"
levels(CareerPlan$SortTo)[levels(CareerPlan$SortTo)=="Data Science"] <- "Data Analyst"
levels(CareerPlan$SortTo)[levels(CareerPlan$SortTo)=="Finance Analyst"] <- "Business Analyst"
levels(CareerPlan$SortTo)[levels(CareerPlan$SortTo)=="consulting"] <- "Consulting"
levels(CareerPlan$SortTo)[levels(CareerPlan$SortTo)=="Consulting/ Tech"] <- "Consulting"
levels(CareerPlan$SortTo)[levels(CareerPlan$SortTo)=="consulting"] <- "Consulting"
levels(CareerPlan$SortTo)[levels(CareerPlan$SortTo)=="IT/ Retailer"] <- "IT"
levels(CareerPlan$SortTo)[levels(CareerPlan$SortTo)=="Wealth Management"] <- "Finance"
levels(CareerPlan$SortTo)[levels(CareerPlan$SortTo)=="Entrepreneurship"] <- "Coorporation Management"
levels(CareerPlan$SortTo)[levels(CareerPlan$SortTo)=="Audit"] <- "Accounting"
#devtools::install_github("mattflor/chorddiag")
library(chorddiag)
m <- matrix(c(2,0,0,1,0,0,0,
              0,1,1,0,0,0,0,
              3,0,0,0,0,1,0,
              0,0,1,0,0,0,0,
              2,0,0,1,0,0,1,
              2,0,0,1,1,6,0,
              2,0,0,1,0,1,2),
            byrow = TRUE,
            nrow = 7, ncol = 7)
NameList <- c("Data Analyst","Accounting","Business Analyst","Consulting","Coorporation Management","Finance","IT")
dimnames(m) <- list(have = NameList,
                    prefer = NameList)
groupColors <- c("#d2f53c", "#fabebe","#008080","#e6beff","#aa6e28","#fffac8","#800000","#aaffc3")

save(m, groupColors, file = "Load_ext.RData")
chorddiag(m, groupColors = groupColors, groupnamePadding = 40)



