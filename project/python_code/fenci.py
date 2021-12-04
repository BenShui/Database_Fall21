import thulac
import pandas as pd

df = pd.read_csv('wuyan.csv', encoding = 'gb18030')
thul = thulac.thulac()

for i in range(len(df)):
    text = df['contents'][i]
    text_res = thul.cut(text, text = True)
    df.loc[i,'fenci'] = text_res
print(df['fenci'][0])
df.to_csv('wuyan_fenci.csv', encoding = 'gb18030')