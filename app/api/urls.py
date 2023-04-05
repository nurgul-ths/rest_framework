from django.urls import path, include 
from app.api.views import movie_details, movie_list

urlpatterns = [
    path('list/', movie_list, name = 'movie-list'),
    path('<int:pk>', movie_details, name = 'movie-detail')
]