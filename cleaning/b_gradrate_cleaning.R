install.packages("writexl")
library(readxl)
library(tidyverse)
library(writexl)

#とりあえず、脳筋方法で

# データの読み込み
X1991 <- read_excel("~/Desktop/RAブートキャンプ事前課題/outcome/1991.xlsx")
X1992 <- read_excel("~/Desktop/RAブートキャンプ事前課題/outcome/1992.xlsx")
X1993 <- read_excel("~/Desktop/RAブートキャンプ事前課題/outcome/1993.xlsx")

X1995 <- read_excel("~/Desktop/RAブートキャンプ事前課題/outcome/1995.xlsx")
X1996 <- read_excel("~/Desktop/RAブートキャンプ事前課題/outcome/1996.xlsx")
X1997 <- read_excel("~/Desktop/RAブートキャンプ事前課題/outcome/1997.xlsx")
X1998 <- read_excel("~/Desktop/RAブートキャンプ事前課題/outcome/1998.xlsx")
X1999 <- read_excel("~/Desktop/RAブートキャンプ事前課題/outcome/1999.xlsx")
X2000 <- read_excel("~/Desktop/RAブートキャンプ事前課題/outcome/2000.xlsx")
X2001 <- read_excel("~/Desktop/RAブートキャンプ事前課題/outcome/2001.xlsx")
X2002 <- read_excel("~/Desktop/RAブートキャンプ事前課題/outcome/2002.xlsx")
X2003 <- read_excel("~/Desktop/RAブートキャンプ事前課題/outcome/2003.xlsx")
X2004 <- read_excel("~/Desktop/RAブートキャンプ事前課題/outcome/2004.xlsx")
X2005 <- read_excel("~/Desktop/RAブートキャンプ事前課題/outcome/2005.xlsx")
X2006 <- read_excel("~/Desktop/RAブートキャンプ事前課題/outcome/2006.xlsx")
X2007 <- read_excel("~/Desktop/RAブートキャンプ事前課題/outcome/2007.xlsx")
X2008 <- read_excel("~/Desktop/RAブートキャンプ事前課題/outcome/2008.xlsx")
X2009 <- read_excel("~/Desktop/RAブートキャンプ事前課題/outcome/2009.xlsx")
X2010 <- read_excel("~/Desktop/RAブートキャンプ事前課題/outcome/2010.xlsx")
X2011 <- read_excel("~/Desktop/RAブートキャンプ事前課題/outcome/2011.xlsx")
X2012 <- read_excel("~/Desktop/RAブートキャンプ事前課題/outcome/2012.xlsx")
X2013 <- read_excel("~/Desktop/RAブートキャンプ事前課題/outcome/2013.xlsx")
X2014 <- read_excel("~/Desktop/RAブートキャンプ事前課題/outcome/2014.xlsx")
X2015 <- read_excel("~/Desktop/RAブートキャンプ事前課題/outcome/2015.xlsx")
X2016 <- read_excel("~/Desktop/RAブートキャンプ事前課題/outcome/2016.xlsx")

# データを読み込んで結合
combined_data <- bind_rows(X1991, 
                           X1992, 
                           X1993, 
                           X1995, 
                           X1996, 
                           X1997,
                           X1998,
                           X1999,
                           X2000,
                           X2001,
                           X2002,
                           X2003,
                           X2004,
                           X2005,
                           X2006,
                           X2007,
                           X2008,
                           X2009,
                           X2010,
                           X2011,
                           X2012,
                           X2013,
                           X2014,
                           X2015,
                           X2016,)
 #データの確認                         
 print(combined_data)                        

# 女子学生の卒業率をスケーリング
combined_data <- combined_data %>%
  mutate(women_gradrate_4yr = women_gradrate_4yr * 0.01)

#データの確認                         
print(combined_data) 

#データ型の確認
str(combined_data)

#データの型を変更
combined_data <- combined_data %>%
  mutate(
    totcohortsize = as.numeric(as.character(totcohortsize)),
    m_4yrgrads = as.numeric(as.character(m_4yrgrads))
  )

# 男女合計の4年卒業率と男子学生の4年卒業率を計算
combined_data <- combined_data %>%
  mutate(total_gradrate_4yr = (m_4yrgrads + w_4yrgrads) / totcohortsize,
         male_gradrate_4yr = m_4yrgrads / m_cohortsize)

#データ型の確認
str(combined_data)

# 有効数字3桁に調整
combined_data <- combined_data %>%
  mutate(across(c(women_gradrate_4yr, total_gradrate_4yr, male_gradrate_4yr),
                ~ round(.x, 3)))

#データ型の確認
str(combined_data)

# 年の列があると仮定し、1991年から2010年までに変形
combined_data <- combined_data %>%
  filter(year >= 1991 & year <= 2010)

#データ型の確認
str(combined_data)

#データの保存
write_xlsx(combined_data, "~/Desktop/RAブートキャンプ事前課題/yourfile.xlsx")

