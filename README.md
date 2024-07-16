# Sputnik Activity Recommendation System

### Efim Shliamin

## Overview

The Sputnik Activity Recommendation System is a Ruby on Rails application that integrates a machine learning-based recommendation engine to suggest activities to users based on their previous interactions and the content features of the activities. This project leverages a hybrid recommendation approach combining collaborative filtering and content-based filtering.

## Features

- **User Authentication**: Users can sign up, log in, and log out.
- **Activity Views**: Users can view detailed information about various activities.
- **Rating System**: Users can rate activities.
- **Recommendation System**: Provides personalized activity recommendations to users.

## Machine Learning

The recommendation system is built using a combination of collaborative filtering and content-based filtering. The key steps include:

1. **Data Loading**: 
   - Data is loaded from a PostgreSQL database hosted on Supabase.
   - The tables `activity_views` and `activities` are loaded into pandas DataFrames.

2. **Data Processing**:
   - The `activity_views` table is merged with the `activities` table to obtain detailed activity information.
   - Vector representations for activities are created based on features like price, rating, place, theme, and duration.

3. **Model Training**:
   - A k-NN model is used to find similar activities.
   - A linear regression model is trained to predict user ratings based on activity features.

4. **Hybrid Recommendation**:
   - The system recommends activities by combining the collaborative score (how many times an activity is viewed) and the content score (predicted rating) using a weighted average.


## Usage

- Sign up and log in to the application.
- View and rate various activities.
- Receive personalized recommendations based on your activity interactions.

## Contributing

Contributions are welcome! Please create a pull request or submit an issue to discuss any changes.


