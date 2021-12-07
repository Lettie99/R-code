## 1. Describing Distribution by Group   按组描述分布(数据)

#by(quantitative_variable, factor, function)  
#by(数值变量,因子,函数):按factor里的不同组

by(chickwts$weight, chickwts$feed, mean)

by(chickwts$weight, chickwts$feed, sd)


by(chickwts$weight, chickwts$feed, summary)   #统计值（分位数等）


by(chickwts$weight, chickwts$feed, fivenum)


#aggregate(quantitative_variable, list(“Group Heading” = grouping_elements), function)
#aggregate函数可以按照要求把数据打组聚合，然后对聚合以后的数据进行加和、求平均等各种操作。
#一组人的性别，年龄，身高，用aggregate求不同性别的平均年龄和身高。
#根据quantitative_variable,grouping_elements相同的是一组
aggregate(chickwts$weight, list("Type of Feed" = chickwts$feed), median)


aggregate(chickwts$weight, list("Type of Feed" = chickwts$feed), var)


aggregate(chickwts$weight, list("Type of Feed" = chickwts$feed), summary)


aggregate(chickwts$weight, list("Type of Feed" = chickwts$feed), fivenum)


# 2. subsetting 子集
#data中某列的特定某类型组成子集(subset)
sunflower <- subset(chickwts, chickwts$feed == "sunflower")
sunflower # Lists elements in the subset 列出子集元素

# 3. outliers 离群值
boxplot(sunflower$weight)  #根据某变量画箱型图


boxplot.stats(sunflower$weight)$out  #列举出boxplot中的离群值,用boxplot.stats函数

fivenum(sunflower$weight)

# Calculating lower inner fence 下限
fivenum(sunflower$weight)[2] - 1.5*IQR(sunflower$weight, type = 2) 
#1/4位数-1.5*IQR

# Calculating upper inner fence 上限
fivenum(sunflower$weight)[4] + 1.5*IQR(sunflower$weight, type = 2) 
#3/4位数+1.5*IQR


sunflower_lower <- subset(sunflower, sunflower$weight < 258)
sunflower_lower #Lists all elements below lower inner fence列出低于下限的所有元素


sunflower_upper <- subset(sunflower, sunflower$weight > 390)
sunflower_upper #Lists all elements above upper inner fence列出大于上限的所有元素

#<下限 或 >上限：outliers
#把outliers提取成一个subsets


###  summary of descriptive statistics  #描述性统计量概要

View(cars)

# (1)Measures of central tendency  中心趋势

# mean 
sumofspeed <- sum(cars$speed)
sumofspeed / 50


sum(cars$speed) / length(cars$speed)
#length():某列的数量

mean(cars$speed)

mean(cars$speed, na.rm=TRUE)  #na.rm:移除na(缺失值)

# median
sort(cars$speed)  #数字排序

median(cars$speed)

# mode

table(cars$speed)   #频数表频率

modeforcars <- table(as.vector(cars$speed))
modeforcars
#is.vector(A):判断A是否为向量
#as.vector(A):如A是矩阵(数组),as.vector就是将矩阵转化为向量。
names(modeforcars)[modeforcars == max(modeforcars)]
#查找众数

# trimmed mean 修整平均值
myvector_outlier<- c(-100, 2, 4, 6, 8, 10, 12, 14, 16)
mean(myvector_outlier[2:9])   #人工剔除某个outliers,求均值

mean(myvector_outlier,trim = 0.1)
#trim：修剪掉排在首尾的部分数据，就是去除异常值以后再进行求均值
#trim=0.1对于一个包含20个数的向量，就是按顺序排列以后，砍掉首尾的各2个数，对剩下的16个数进行求均值
#trim:会在首尾分别去除N个异常值，其中N=样本数量*要去除的百分比(即是trim的值)

myvector_trim<- c(-15, 2, 3, 4, 5, 6, 7, 8, 9, 12)
mean(myvector_trim)

mean(myvector_trim, trim=.1)


## measures of variability 衡量变异性

min(cars$speed)

max(cars$speed)

range(cars$speed)
#range→min max

IQR(cars$speed)
#IQR=Q3-Q1

quantile(cars$speed)
#各个四分位数

quantile(cars$speed, probs=c(.25, .75))
#指定概率的四分位数

var(cars$speed)
#方差

sqrt(var(cars$speed))
#标准差

sd(cars$speed)
#标准差

## Skew and kurtosis 偏态和峰度

install.packages("psych")
library(psych)
skew(cars$speed)  #偏态


kurtosi(cars$speed)  #峰度


summary(cars$speed)

summary(cars)



library(psych)
describe(cars)   #描述某个变量:describe


#?describeBy
describeBy(cars, group=cars$speed)
#分组描述数据集


### correlation 相关性

# calculating correlations in R for Pearson’s correlation coefficient 相关系数的相关性

cor(cars$speed, cars$dist)  #相关系数

cor(cars)   #相关系数矩阵

cor.test(cars$speed,cars$dist,method="spearman")
#相关性测试

