install.packages("tidyr")
library(tidyr)
library(dplyr)
library(readr)
library(tidyverse)

# データの読み込み
semester_dummy_1 <- read_csv("semester_data_1.csv", col_names = TRUE)  # 1行目を列名として読み込み
semester_dummy_2 <- read_csv("semester_data_2.csv", col_names = TRUE)

# 全ての列を文字型に変換
semester_dummy_2 <- semester_dummy_2 %>% mutate_all(as.character)

# 2つのデータを適切に結合（列名が同じであることを確認）
# bind_rowsを使って縦に結合
semester_data <- bind_rows(semester_dummy_1, semester_dummy_2)

print(head(semester_data))
# 'Y'列を削除
semester_data <- semester_data %>%
  select(-x6)
print(head(semester_data))
                                                  
# 結果を表示
print(semester_data)

print(semester_data)
# semester制導入後を示すダミー変数を作成
semester_data <- semester_data %>%
  mutate(semester_introduced_x5 = if_else(x5 >= 2001, 1, 0))

# 結果を確認
print(semester_data)

# 一行目を削除し、列名を変更
semester_data <- semester_data %>%
  slice(-1) %>%
  rename(
    unitid = x1,
    instnm = x2,
    semester = x3,
    quarter = x4,
    year = x5,
    dummy = semester_introduced_x5)

# データの確認
print(head(semester_data))

#データ型の確認
str(semester_data)

#データ保存
write_xlsx(semester_data, "~/Desktop/RAブートキャンプ事前課題/a_dataset.xlsx")
