library(readxl)
library(tidyverse)
library(writexl)
install.packages("stringr")
library(stringr)
install.packages("dplyr")
library(dplyr)
install.packages("tidyr")
library(tidyr)

# データの読み込み
df <- read_excel("~/Desktop/RAブートキャンプ事前課題/covariates/covariates.xlsx")

#データ型の確認
str(df)

# 一行目を削除し、列名を変更
df <- df %>%
  rename( unitid = university_id )

#データ型の確認
str(df)    

# "aaaa" を削除する
df1 <- df %>%
  mutate(unitid = str_replace_all(unitid, "aaaa", ""))

#データ型の確認
str(df1)    

# データを wide 型に変換
wide_data <- df1 %>%
  pivot_wider(
    names_from = category,
    values_from = value, # ここで values_from に実際の値が含まれる列を指定します
    values_fill = list(value = NA) # これにより、欠損値は NA で埋められます
  )
#データ型の確認
str(wide_data)

#データの保存
write_xlsx(wide_data, "~/Desktop/RAブートキャンプ事前課題/c_data.xlsx")




