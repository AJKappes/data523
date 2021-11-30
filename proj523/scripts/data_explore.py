import pandas as pd
import numpy as np
import glob

d_path = glob.glob('/home/alex/teaching/data523/proj523/data/*.csv')

for d in d_path:
    if 'few' in d:
        print('dataset found')
        df = pd.read_csv(d)

df.dtypes
df.shape
df.columns
df.info
df.head()
df.tail()
df['air_temp']
df['air_temp'].describe()
df['air_temp'].mean()
air_temp_mean = df['air_temp'].mean()
df['air_temp'].plot.hist()

# select by position
df.iloc[0, ]
df.iloc[10, 1:4]

# select by label
df.loc[0, 'air_temp']
df.at[10, 'rainf']

# boolean indexing
df[df['air_temp'] > air_temp_mean]
df[df['air_temp'] > air_temp_mean]['air_temp']
df[~(df['air_temp'] > air_temp_mean)]

# row obervation indexing
df['crop_or_cover'].unique()
df['crop_or_cover'].str.contains('colder')
df[df['crop_or_cover'].str.contains('colder')]
df[df['crop_or_cover'].str.contains('colder')==False]
# slightly different approach
df[df['crop_or_cover'].apply(lambda x: 'colder' not in x)]

# grouping
df_grouped = df.groupby('crop_or_cover')
df_grouped.mean()
df_grouped['yield_kg_m2'].mean()
df.groupby(['crop_or_cover', 'month'])['yield_kg_m2'].mean()

# building our sum stat table
df[df['month'].isin([6, 7, 8, 9])]
np.arange(6, 9, 1)
np.arange(6, 10, 1)
df[df['month'].isin(np.arange(6, 10, 1))]

df_warmcrop = df[(df['crop_or_cover'].apply(lambda x: 'colder' not in x)) &
                 (df['month'].isin([6, 7, 8, 9]))]

for c in df_warmcrop['crop_or_cover'].unique():
    print(c)
    
for c in df_warmcrop['crop_or_cover'].unique():
    print(df_warmcrop[df_warmcrop['crop_or_cover']==c]['yield_kg_m2'].mean())

means = []
sds = []

for c in df_warmcrop['crop_or_cover'].unique():
    means.append(df_warmcrop[df_warmcrop['crop_or_cover']==c]['yield_kg_m2'].mean())
    sds.append(df_warmcrop[df_warmcrop['crop_or_cover']==c]['yield_kg_m2'].std())

means
sds

warmcrop_ss = pd.DataFrame({'mean': means,
                           'st.dev': sds},
                          index = df_warmcrop['crop_or_cover'].unique())

warmcrop_ss.transpose()
