
# 1. SETUP
import numpy as np
import pandas as pd
from sklearn.preprocessing import OneHotEncoder

path = r"https://raw.githubusercontent.com/Smsantimaldonado/Data-Science-Portfolio/master/Roommates_tenants/dataset_tenants.csv"

df = pd.read_csv(path, index_col = 'id_tenant')

df.columns = ['time_of_the_day', 'biorhythm', 'education_level', 'read', 'animation', 
'cinema', 'pets', 'cook', 'sport', 'diet', 'smoker',
'visits', 'order', 'music_type', 'music_loud', 'perfect_plan', 'music_instrument']

# 2. ONE HOT ENCODING (OHE)
encoder = OneHotEncoder(sparse=False)
df_encoded = encoder.fit_transform(df)

# Obtainig coded features names after doing OHE
encoded_feature_names = encoder.get_feature_names_out()

# 3. SIMILARITY MATRIX
matrix_s = np.dot(df_encoded, df_encoded.T)

# Define el rango de destino
range_min = -100
range_max = 100

# Encontrar el mínimo y máximo valor en matrix_s
min_original = np.min(matrix_s)
max_original = np.max(matrix_s)

# Reescalar la matriz
matrix_s_reescaled = ((matrix_s - min_original) / (max_original - min_original)) * (range_max - range_min) + range_min

# Pasar a Pandas
df_similarity = pd.DataFrame(matrix_s_reescaled,
        index = df.index,
        columns = df.index)


# 4. LOOKING FOR MATCHING TENANTS (possible roommates)
'''
Inputs:
* id_tenants: the tenants MUST BE A LIST even though it's only one
* topn: amount of tenants we are looking for

Output:
List with 2 elements
Element 0: main characteristics of matching tenants
Element 1: similarity value
'''

def matching_tenants(id_tenants, topn):
    # Verify if every id_tenant existe in the similarity matrix
    for id_tenant in id_tenants:
        if id_tenant not in df_similarity.index:
            return 'At least 1 tenant was not found'

    # Obtaining corresponding rows of the tenants
    rows_tenants = df_similarity.loc[id_tenants]

    # Calculate the similarity average value of the tenants
    average_similarity = rows_tenants.mean(axis=0)

    # Order tenants according average similarity
    similar_tenant = average_similarity.sort_values(ascending=False)

    # Exclude reference tenants
    similar_tenant = similar_tenant.drop(id_tenants)

    # Select topn similar tenants
    topn_tenants = similar_tenant.head(topn)

    # Obtaining information of similar tenants
    similar_registers = df.loc[topn_tenants.index]

    # Obtaining information of searched tenants
    registers_searched = df.loc[id_tenants]

    # Concatenate searched registers with similar registers in the columns
    result = pd.concat([registers_searched.T, similar_registers.T], axis=1)

    # Create a Series with the similar tenants found similarities
    similarity_series = pd.Series(data=topn_tenants.values, index=topn_tenants.index, name='Similarity')

    # Return result and Series object
    return(result, similarity_series)