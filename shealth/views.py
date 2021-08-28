from rest_framework.views import APIView
from rest_framework.response import Response
import os
from shealth.models import Doctor, Patient, Appointment
from shealth.forms import DoctorCreationForm, PatientCreationForm
from shealth.qrcodeGenerate import *
from wsgiref.util import FileWrapper
from django.http import HttpResponse


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

class DoctorLoginView(APIView):
    def get(self, request):
        # print(request.data["email"])
        # # check if the email is in the Doctor model
        # try:
        #     doctor = Doctor.objects.get(email=request.data["email"])
        #     if doctor:
        #         # check if the password is correct
        #         if check_password(request.data["password"], doctor.password):
        #             token = create_access_token(request.data["email"])
        #             return Response({'token': token})
        #         else:
        #             # response code unauthorized
        #             return Response({'detail': 'Doctor login failed'}, status=401)
        #     else:
        #         return Response({'detail': 'Doctor login failed'}, status=401)
        # except:
        #     return Response({'detail': 'Doctor login failed'}, status=401)
        return Response({'detail': 'Doctor login failed'}, status=401)

class PatientLoginView(APIView):
    def get(self, request):
        # print(request.data["email"])
        # # check if the email is in the patient model
        # try:
        #     patient = Patient.objects.get(email=request.data["email"])
        #     if patient:
        #         # check if the password is correct
        #         if check_password(request.data["password"], patient.password):
        #             token = create_access_token(request.data["email"])
        #             return Response({'token': token})
        #         else:
        #             # response code unauthorized
        #             return Response({'detail': 'Patient login failed'}, status=401)
        #     else:
        #         return Response({'detail': 'Patient login failed'}, status=401)
        # except:
        #     return Response({'detail': 'Patient login failed'}, status=401)
        return Response({'detail': 'Patient login failed'}, status=401)

class DoctorQRCode(APIView):
    def get(self, request):
        # try: 
        #     if getUser(request.headers['Authorization']):
        #         # get doctor id
        #         doctor_id = Doctor.objects.filter(email=getUser(request.headers['Authorization']))[0].doc_id
        #         # get all the patients
        #         qrcode = createQR(doctor_id, getUser(request.headers['Authorization']))
        #         qr = open(qrcode, 'rb')
        #         response = HttpResponse(FileWrapper(qr), content_type='image/png')

        #         # Remove qr code from the server
        #         os.system(f"rm {qrcode}")

        #         return response
        #     else:
        #         return Response({'detail': 'Unauthorized'}, status=401)
        # except:
        #     return Response({'detail': 'Unauthorized'}, status=401)
        return Response({'detail': 'Unauthorized'}, status=401)

class Index(APIView):
    def get(self, request):
        return Response({'detail': 'Welcome to Shealth'})