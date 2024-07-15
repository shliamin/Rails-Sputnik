import pandas as pd
import psycopg2
import os
from dotenv import load_dotenv

# Load environment variables from a .env file if you have one
load_dotenv()

# Database connection URL
DATABASE_URL = os.getenv("DATABASE_URL")

def get_recommendations(visitor_id):
    # Connect to the Supabase PostgreSQL database
    conn = psycopg2.connect(DATABASE_URL)

    # Load the activity_views table
    query = "SELECT * FROM activity_views"
    activity_views = pd.read_sql_query(query, conn)

    # Assuming activity_views has columns: id, visitor_id, activity_id, created_at, updated_at

    # Calculate the most viewed activities
    if activity_views.empty:
        top_activity_ids = [1, 2, 3, 4, 5]  # Default activity IDs if no data is present
    else:
        activity_counts = activity_views['activity_id'].value_counts().reset_index()
        activity_counts.columns = ['activity_id', 'view_count']

        # Get the top 5 most viewed activities
        top_activities = activity_counts.head(5)
        top_activity_ids = top_activities['activity_id'].tolist()

        # Ensure we have 5 recommendations
        while len(top_activity_ids) < 5:
            top_activity_ids.append(activity_counts['activity_id'].max() + len(top_activity_ids) + 1)

    # Close the database connection
    conn.close()

    return top_activity_ids
