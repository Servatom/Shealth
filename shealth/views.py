from rest_framework.views import APIView
from rest_framework.response import Response
from django.contrib.auth.hashers import make_password, check_password

from shealth.models import Doctor, Patient, Appointment
from shealth.forms import DoctorForm, PatientForm


class DoctorRegisterView(APIView):
    def post(self, request):
        print(request.data)
        form = DoctorForm(request.data)
        if form.is_valid():
            obj = form.save(commit=False)
            password = form.cleaned_data.get('password')
            obj.password = make_password(password)
            obj.save()

            return Response({'detail': 'Doctor registered successfully'})
        else:
            return Response({'detail': 'Doctor registration failed', 'errors': form.errors})


class PatientRegisterView(APIView):
    def post(self, request):
        form = PatientForm(request.data)
        if form.is_valid():
            obj = form.save(commit=False)
            password = form.cleaned_data.get('password')
            obj.password = make_password(password)
            obj.save()

            return Response({'detail': 'Patient registered successfully'})
        else:
            return Response({'detail': 'Patient registration failed', 'errors': form.errors})

class DoctorLoginView(APIView):
    def post(self, request):
        print(request.data["email"])
        # check if the email is in the Doctor model
        try:
            doctor = Doctor.objects.get(email=request.data["email"])
            if doctor:
                # check if the password is correct
                if check_password(request.data["password"], doctor.password):
                    return Response({'detail': 'Doctor logged in successfully'})
                else:
                    # response code unauthorized
                    return Response({'detail': 'Doctor login failed'}, status=401)
            else:
                return Response({'detail': 'Doctor login failed'}, status=401)
        except:
            return Response({'detail': 'Doctor login failed'}, status=401)

class PatientLoginView(APIView):
    def post(self, request):
        print(request.data["email"])
        # check if the email is in the patient model
        try:
            patient = Patient.objects.get(email=request.data["email"])
            if patient:
                # check if the password is correct
                if check_password(request.data["password"], patient.password):
                    return Response({'detail': 'Patient logged in successfully'}, status=200)
                else:
                    # response code unauthorized
                    return Response({'detail': 'Patient login failed'}, status=401)
            else:
                return Response({'detail': 'Patient login failed'}, status=401)
        except:
            return Response({'detail': 'Patient login failed'}, status=401)


class Index(APIView):
    def get(self, request):
        return Response({'detail': 'Shealth'})