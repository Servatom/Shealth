from rest_framework.views import APIView
from rest_framework.response import Response

from shealth.models import Doctor, Patient, Appointment
from shealth.forms import DoctorForm, PatientForm


class DoctorRegisterView(APIView):
    def post(self, request):
        form = DoctorForm(request.data)
        if form.is_valid():
            obj = form.save(commit=False)
            password = form.cleaned_data.get('password')
            obj.set_password(password)
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
            obj.set_password(password)
            obj.save()

            return Response({'detail': 'Patient registered successfully'})
        else:
            return Response({'detail': 'Patient registration failed', 'errors': form.errors})
            
