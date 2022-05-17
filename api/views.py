from django.shortcuts import render
from rest_framework.views import View 
from rest_framework.renderers import JSONRenderer
import io
from .models import Student
from .serializers import StudentCreateUpdateSerializer, StudentListSerializer
from rest_framework.parsers import JSONParser
from django.http import JsonResponse
from django.views.decorators.csrf import csrf_exempt
from django.utils.decorators import method_decorator
# Create your views here.

@method_decorator(csrf_exempt,name='dispatch')
class StudentAPI(View):

    # This is For Create Object
    def post(self, request, *args, **kwargs):

        json_data = request.body
        stream = io.BytesIO(json_data)
        data = JSONParser().parse(stream)

        serializer = StudentCreateUpdateSerializer(data=data)
        if serializer.is_valid():
            serializer.save()
            return JsonResponse(serializer.data) # You Can Write this for show data in response
        return JsonResponse(serializer.errors)


    def put(self, request, *args, **kwargs):

        # This is For Update Object
        pk = kwargs.get('pk')
        json_data= request.body
        stream = io.BytesIO(json_data)
        data= JSONParser().parse(stream)
        stu_obj = Student.objects.get(pk=pk)

        serializer = StudentCreateUpdateSerializer(data=data, instance=stu_obj) 

        if serializer.is_valid():
            serializer.save()

            return JsonResponse(serializer.data)

        return JsonResponse(serializer.errors)



    def patch(self, request, *args, **kwargs):

        # This is For Partial Update Object
        pk = kwargs.get('pk')
        json_data= request.body
        stream = io.BytesIO(json_data)
        data= JSONParser().parse(stream)
        stu_obj = Student.objects.get(pk=pk)

        serializer = StudentCreateUpdateSerializer(data=data, instance=stu_obj, partial=True) 

        if serializer.is_valid():
            serializer.save()

            return JsonResponse(serializer.data)
            
        return JsonResponse(serializer.errors)


    def get(self, request, *args, **kwargs):
        if kwargs.get('pk'):
            stu_obj = Student.objects.get(pk=kwargs.get('pk'))
            serializer = StudentListSerializer(stu_obj)
            return JsonResponse(serializer.data)
        else:
            stu = Student.objects.all()
            serializer = StudentListSerializer(stu, many=True)
            return JsonResponse({"result________modified_______________":serializer.data})


    def delete(self, request, *args, **kwargs):
        stu_obj= Student.objects.get(pk=kwargs.get('pk')).delete()
        return JsonResponse({"msg": "Data Deleted Successfully!!"})


############################# Thank You ###########################################
