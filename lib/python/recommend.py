import pandas as pd
import psycopg2
import os
from dotenv import load_dotenv
from sklearn.preprocessing import StandardScaler
from sklearn.neighbors import NearestNeighbors
from sklearn.linear_model import LinearRegression
import numpy as np

def load_data():
    # Load environment variables from a .env file
    load_dotenv()

    # Database connection URL
    DATABASE_URL = os.getenv("DATABASE_URL")

    # Connect to the Supabase PostgreSQL database
    conn = psycopg2.connect(DATABASE_URL)

    # Load the activity_views table
    activity_views_query = "SELECT * FROM activity_views"
    activity_views = pd.read_sql_query(activity_views_query, conn)

    # Load the activities table
    activities_query = "SELECT * FROM activities"
    activities = pd.read_sql_query(activities_query, conn)

    # Close the database connection
    conn.close()

    return activity_views, activities

def process_data(activity_views, activities):
    # Merge activity_views with activities to get activity details
    merged_df = activity_views.merge(activities, left_on='activity_id', right_on='id', suffixes=('', '_activity'))

    # Create vector representations for activities
    features = ['price', 'rating', 'place', 'theme', 'duration']
    activities_features = pd.get_dummies(activities[features])

    scaler = StandardScaler()
    activities_scaled = scaler.fit_transform(activities_features)

    return merged_df, activities_scaled, activities

def main():
    activity_views, activities = load_data()
    merged_df, activities_scaled, activities = process_data(activity_views, activities)

    # k-NN model for finding similar activities
    knn = NearestNeighbors(n_neighbors=5, metric='cosine')
    knn.fit(activities_scaled)

    # Function to find similar activities
    def find_similar_activities(activity_id, k=5):
        activity_index = activities[activities['id'] == activity_id].index[0]
        distances, indices = knn.kneighbors([activities_scaled[activity_index]], n_neighbors=k+1)
        similar_activities = activities.iloc[indices[0][1:]]
        return similar_activities['id'].tolist()

    # Machine learning model to predict user ratings
    X = merged_df[['price', 'rating', 'place', 'theme', 'duration']]
    X = pd.get_dummies(X)
    y = merged_df['user_rating']

    model = LinearRegression()
    model.fit(X, y)

    def predict_rating(activity_id, visitor_id):
        activity = activities[activities['id'] == activity_id]
        if activity.empty:
            return None

        activity_features = activity[['price', 'rating', 'place', 'theme', 'duration']]
        activity_features = pd.get_dummies(activity_features).reindex(columns=X.columns, fill_value=0)
        rating = model.predict(activity_features)
        return rating[0]

    # Hybrid recommendation function
    def recommend_activities(visitor_id):
        user_views = activity_views[activity_views['visitor_id'] == visitor_id]['activity_id']
        similar_activities = []

        for activity_id in user_views:
            similar_activities.extend(find_similar_activities(activity_id))

        similar_activities = list(set(similar_activities))
        recommendations = []

        for activity_id in similar_activities:
            collaborative_score = similar_activities.count(activity_id)
            content_score = predict_rating(activity_id, visitor_id)
            hybrid_score = 0.5 * collaborative_score + 0.5 * content_score
            recommendations.append((activity_id, hybrid_score))

        recommendations.sort(key=lambda x: x[1], reverse=True)
        top_recommendations = [rec[0] for rec in recommendations[:5]]

        return top_recommendations

    # Test the recommendation function with a sample visitor_id
    visitor_id = 1  # Replace with an actual visitor_id from your data
    print("Top 5 recommended activities for visitor_id {}: {}".format(visitor_id, recommend_activities(visitor_id)))

if __name__ == "__main__":
    main()
