import pandas as pd
import psycopg2
import os
from dotenv import load_dotenv
from sklearn.cluster import KMeans
from sklearn.neighbors import NearestNeighbors

def get_recommendations_for_user(user_index):
    # Load environment variables from a .env file
    load_dotenv()

    # Database connection URL
    DATABASE_URL = os.getenv("DATABASE_URL")

    # Connect to the Supabase PostgreSQL database
    conn = psycopg2.connect(DATABASE_URL)

    # Load the activity_views table
    query = "SELECT * FROM activity_views"
    activity_views = pd.read_sql_query(query, conn)

    # Assuming activity_views has columns: id, visitor_id, activity_id, created_at, updated_at

    if activity_views.empty or len(activity_views['activity_id'].unique()) < 5:
        # Close the database connection
        conn.close()
        return []  # Return an empty list if there are not enough activities

    # Create interaction matrix: users (rows) x activities (columns)
    interaction_matrix = activity_views.pivot_table(index='visitor_id', columns='activity_id', aggfunc='size', fill_value=0)

    # Transpose the matrix for clustering activities
    transposed_matrix = interaction_matrix.T

    # Apply KMeans clustering to activities
    n_clusters = 3  # Define the number of clusters
    kmeans = KMeans(n_clusters=n_clusters, random_state=42)
    activity_clusters = kmeans.fit_predict(transposed_matrix)

    # Add cluster labels to the interaction matrix
    interaction_matrix['cluster'] = interaction_matrix.columns.map(dict(zip(transposed_matrix.index, activity_clusters)))

    # Train the Nearest Neighbors model
    model_knn = NearestNeighbors(metric='cosine', algorithm='brute')
    model_knn.fit(interaction_matrix.drop('cluster', axis=1))

    # Get recommendations for the specified user
    distances, indices = model_knn.kneighbors(interaction_matrix.iloc[user_index, :].values.reshape(1, -1), n_neighbors=5)

    # Get the recommended activities
    recommended_indices = indices.flatten()
    recommended_activities = interaction_matrix.columns[recommended_indices].tolist()

    # Close the database connection
    conn.close()

    # Return the recommended activities
    return recommended_activities

if __name__ == "__main__":
    user_index = int(input("Enter the user index: "))  # Prompt for user index
    recommendations = get_recommendations_for_user(user_index)
    print(f"Recommended activities for user {user_index}: {recommendations}")
