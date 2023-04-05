from app.models import Movie
from rest_framework.response import Response
from app.api.serializers import MovieSerializer
from rest_framework.decorators import api_view
from django.http import JsonResponse



@api_view(['GET'])
def movie_list(request): 
    movies = Movie.objects.all()
    serializer = MovieSerializer(movies, many=True)
    return Response(serializer.data)

@api_view(['GET'])
def movie_details(request, pk):
    movie = Movie.objects.get(pk = pk)
    serializer = MovieSerializer(movie)
    return Response(serializer.data)

