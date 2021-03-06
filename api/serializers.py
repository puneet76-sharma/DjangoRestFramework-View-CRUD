from rest_framework import serializers
from .models import Student

class StudentListSerializer(serializers.ModelSerializer):
    class Meta:
        model = Student
        fields = '__all__'

class StudentCreateUpdateSerializer(serializers.ModelSerializer):
    class Meta:
        model = Student
        fields = ('id', 'name', 'roll', 'city')