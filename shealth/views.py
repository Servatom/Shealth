from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework.permissions import IsAuthenticated
from shealth.models import Doctor, Patient, Appointment
from shealth.forms import DoctorCreationForm, PatientCreationForm
from shealth.qrcodeGenerate import *
from wsgiref.util import FileWrapper
from django.http import HttpResponse
import os


class DoctorRegisterView(APIView):
    def post(self, request):
        form = DoctorCreationForm(request.data)
        if form.is_valid():
            form.save()
            return Response({'detail': 'Doctor registered successfully'})
        else:
            return Response({'detail': 'Doctor registration failed', 'errors': form.errors})


class PatientRegisterView(APIView):
    def post(self, request):
        form = PatientCreationForm(request.data)
        if form.is_valid():
            form.save()
            return Response({'detail': 'Patient registered successfully'})
        else:
            return Response({'detail': 'Patient registration failed', 'errors': form.errors})

class DoctorQRCode(APIView):
    permission_classes = (IsAuthenticated,)
    def get(self, request):
        # get doctor id
        doctor_id = Doctor.objects.get(user=request.user).doc_id
        print(doctor_id)
        qrcode = createQR(doctor_id)
        qr = open(qrcode, 'rb')
        response = HttpResponse(FileWrapper(qr), content_type='image/png')

        #Remove qr code from the server
        os.system(f"rm {qrcode}")

        return response

class Index(APIView):
    def get(self, request):
        return Response({'detail': 'Welcome to Shealth'})