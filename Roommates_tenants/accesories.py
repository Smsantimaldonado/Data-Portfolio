import matplotlib.pyplot as plt
import seaborn as sns
import plotly.graph_objs as go
import streamlit as st

# FUNCIÓN PARA GENERAR EL GRÁFICO DE compatibility
def generate_compatibily_chart(compatibility):
    compatibility = compatibility / 100  # Make sure it is scaled from 0 to 1 for percentages
    
    fig, ax = plt.subplots(figsize=(5, 4))  # Adjust the chart size according to your needs
    
    # Create the bar chart with the values ​​converted to percentages
    sns.barplot(x=compatibility.index, y=compatibility.values, ax=ax, color='lightblue', edgecolor=None)
    
    # Remove borders
    sns.despine(top=True, right=True, left=True, bottom=False)
    
    # Set axis labels and rotate x-axis labels
    ax.set_xlabel('Tenant identifier', fontsize=10)
    ax.set_ylabel('Similarity (%)', fontsize=10)
    ax.set_xticklabels(ax.get_xticklabels(), rotation=45)
    
    # Adjust y-axis labels to display percentages correctly
    ax.set_yticklabels(['{:.1f}%'.format(y * 100) for y in ax.get_yticks()], fontsize=8)

    # Add labels for each bar
    for p in ax.patches:
        height = p.get_height()
        ax.annotate('{:.1f}%'.format(height * 100), (p.get_x() + p.get_width() / 2., height),
                    ha='center', va='center', xytext=(0, 5),
                    textcoords='offset points', fontsize=8)

    return(fig)


# FUNCTION TO GENERATE THE POSSIBLE ROOMMATES TABLE
def generate_compatibility_table(result):
    # Change the name of the 'index' column and adjust the width of the columns
    result_0_with_index = result[0].reset_index()
    result_0_with_index.rename(columns={'index': 'ATRIBUTE'}, inplace=True)
    
    # Configure the Plotly table
    fig_table = go.Figure(data=[go.Table(
        columnwidth = [20] + [10] * (len(result_0_with_index.columns) - 1),  # Set the first value for the width of the 'ATTRIBUTE' column
        header=dict(values=list(result_0_with_index.columns),
                    fill_color='paleturquoise', align='left'),
        cells=dict(values=[result_0_with_index[col] for col in result_0_with_index.columns],
                   fill_color='lavender', align='left'))])
    
    # Configure the Plotly table layout
    fig_table.update_layout(width=700, height=320, margin=dict(l=0, r=0, t=0, b=0))

    return(fig_table)


# FUNCTION TO GENERATE THE LIST OF SEED TENANTS
def obtain_id_tenants(tenant1, tenant2, tenant3, topn):
    # Creates a list of the tenant IDs entered and converts them to integers
    id_tenants = []
    for tenant in [tenant1, tenant2, tenant3]:
        try:
            if tenant:  # If there is text in the input
                id_tenants.append(int(tenant))  # Convert to int and add to the list
        except ValueError:
            st.error(f"Tenant identifier '{tenant}' is not a valid number.")
            id_tenants = []  # Empty list if there is an error
            break

    return(id_tenants)