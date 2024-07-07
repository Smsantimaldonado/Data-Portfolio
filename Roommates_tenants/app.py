import streamlit as st
import pandas as pd
from logic import matching_tenants
from accesories import generate_compatibily_chart, generate_compatibility_table, obtain_id_tenants

# Page configuration in order to use wider layout
st.set_page_config(layout="wide")

result = None

# Show a big picture in the superior area
st.image(r"Apps\Roommates_tenants\front_picture.png", use_column_width=True)

# Inserting a vertical area of 60px
st.markdown(f'<div style="margin-top: 60px;"></div>', unsafe_allow_html=True)

# Configurating sidebar with inputs and a button
with st.sidebar:
    st.header("Who is already living in the property?")
    tenant1 = st.text_input("Tenant 1")
    tenant2 = st.text_input("Tenant 2")
    tenant3 = st.text_input("Tenant 3")
    
    new_roommates_amount = st.text_input("How many new roommates are you looking for?")
    
    if st.button('SEARCH NEW ROOMMATES'):
        # Validating that the number of roommates is a valid number
        try:
            topn = int(new_roommates_amount)
        except ValueError:
            st.error("Please enter a valid number for the number of colleagues")
            topn = None
        
        # Get the tenant IDs using the function
        id_tenants = obtain_id_tenants(tenant1, tenant2, tenant3, topn)

        if id_tenants and topn is not None:
            # Call the matching_tenants function with the corresponding parameters
            result = matching_tenants(id_tenants, topn)

# Verify if 'result' contains an error message (string)
if isinstance(result, str):
    st.error(result)
# If not and if 'result' is not None, show the bar chart and the table
elif result is not None:
    cols = st.columns((1, 2))  # Split layout in 2 columns
    
    with cols[0]:  # Setting that the chart and its title appear both in the first column
        st.write("Compatibility level of each new suggested roommate:")
        fig_chart = generate_compatibily_chart(result[1])
        st.pyplot(fig_chart)
    
    with cols[1]:  # Setting that the table and its title appear both in the second column
        st.write("Suggested roommates comparison:")
        fig_table = generate_compatibility_table(result)
        st.plotly_chart(fig_table, use_container_width=True)