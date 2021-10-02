from re import search
import re
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework.permissions import IsAuthenticated
from rest_framework.parsers import MultiPartParser, FormParser, FileUploadParser
from shealth import serializers
from shealth.forms import DoctorCreationForm, PatientCreationForm
from shealth.models import Doctor, Patient, Appointment, User, Record
from shealth.serializers import RecordSerializer, UserSerializer
from shealth.qrcodeGenerate import *
from wsgiref.util import FileWrapper
from django.http import HttpResponse
from django.db.models import Q
from shealth.generateAvatar import *
import os


def has_access(self, request, email):
    if request.user.email == email:
        return True
    elif Appointment.objects.filter(
        Q(doctor__user__email=request.user.email) & Q(patient__user__email=email) |
        Q(patient__user__email=request.user.email) & Q(doctor__user__email=email)
    ).exists():
        return True
    else:
        return False


class DoctorRegisterView(APIView):
    def post(self, request):
        form = DoctorCreationForm(request.data)
        if form.is_valid():
            form.save()
            return Response({"detail": "Doctor registered successfully"})
        else:
            return Response(
                {"detail": "Doctor registration failed", "errors": form.errors}, status=400)


class PatientRegisterView(APIView):
    def post(self, request):
        form = PatientCreationForm(request.data)
        if form.is_valid():
            form.save()
            return Response({"detail": "Patient registered successfully"})
        else:
            return Response(
                {"detail": "Patient registration failed", "errors": form.errors}, status=400)


class DoctorQRCode(APIView):
    permission_classes = (IsAuthenticated,)

    def get(self, request):
        # get doctor id
        doctor_id = Doctor.objects.get(user=request.user).doc_id
        print(doctor_id)
        qrcode = createQR(doctor_id)
        qr = open(qrcode, "rb")
        response = HttpResponse(FileWrapper(qr), content_type="image/png")

        # Remove qr code from the server
        os.system(f"rm {qrcode}")

        return response


class UploadDocs(APIView):
    permission_classes = (IsAuthenticated,)
    parser_classes = (FileUploadParser, FormParser, MultiPartParser)

    def post(self, request, format=None):
        data = request.data
        print(data)
        data.update({"patient": self.request.user.uuid})
        print(data)
        serializer = RecordSerializer(data=data)
        if serializer.is_valid():
            serializer.save()
            return Response({"detail": "File uploaded successfully"})
        else:
            return Response(
                {"detail": "File upload failed", "errors": serializer.errors}
            )


class UserDetailView(APIView):
    permission_classes = (IsAuthenticated,)

    def post(self, request):
        email = request.data["email"]
        if not has_access(self, request, email):
            return Response({"detail": "You don't have access to this user"})
        user = User.objects.get(email=email)
        serializer = UserSerializer(user)
        result = serializer.data
        print(serializer.data)
        if not serializer.data["is_doctor"]:
            result["gender"] = user.patient.sex
            print(result)
        return Response(result)


class DoctorDocIdView(APIView):
    permission_classes = (IsAuthenticated,)

    def get(self, request):
        doctor_id = Doctor.objects.get(user=request.user).doc_id
        print(doctor_id)
        return Response({"doc_id": doctor_id})


class GiveAccessPatient(APIView):
    permission_classes = (IsAuthenticated,)

    def post(self, request):
        doc_id = request.data["doc_id"]
        print(doc_id)
        patient = request.user.patient
        doctor = None
        try:
            doctor = Doctor.objects.get(doc_id=doc_id)
        except:
            return Response({"detail": "Doctor not found"}, status=404)

        # check if the doctor and patient are already connected
        Appointment.objects.get_or_create(
            doctor=Doctor.objects.get(doc_id=doc_id), patient=patient
        )
        return Response({"message": "Access given to {}".format(doctor.user.email)})


class ListRecords(APIView):
    permission_classes = (IsAuthenticated,)

    def post(self, request):
        email = request.data["email"]
        if not has_access(self, request, email):
            return Response(
                {"detail": "You do not have access to this patient"}, status=404
            )
        records = Record.objects.filter(patient__user__email=email)
        serializer = RecordSerializer(records, many=True)
        return Response(serializer.data)


class ListDoctors(APIView):
    permission_classes = (IsAuthenticated,)
    
    def get(self, request):
        doctors = Appointment.objects.filter(patient=request.user.patient)
        users = [doctor.doctor.user for doctor in doctors]
        serializer = UserSerializer(users, many=True)
        return Response(serializer.data)
    
class ListPatients(APIView):
    permission_classes = (IsAuthenticated,)

    def get(self, request):
        patients = Appointment.objects.filter(doctor=request.user.doctor)
        users = [patient.patient.user for patient in patients]
        serializer = UserSerializer(users, many=True)
        return Response(serializer.data)

class Index(APIView):
    def get(self, request):
        return Response({"detail": "Welcome to Shealth"})

class AvatarChange(APIView):
    permission_classes = (IsAuthenticated,)

    def post(self, request):
        email = request.user.email
        user = User.objects.get(email=email)
        prev_img = user.avatar
        new_avatar = selectImage()
        while(new_avatar == prev_img):
            new_avatar = selectImage()
        user.avatar = new_avatar
        user.save()
        return Response({"detail": "Avatar changed successfully"})

class DoctorDetails(APIView):
    def post(self, request):
        doc_id = request.data["doc_id"]
        doctor = Doctor.objects.get(doc_id=doc_id)
        # get doctor details
        response = {}
        response["doctor_name"] = doctor.user.name
        response["doctor_email"] = doctor.user.email
        response["doctor_speciality"] = doctor.speciality
        return Response(response)

class ResetPasswordView(APIView):
    permission_classes = (IsAuthenticated,)
    def post(self, request):

        # check old password
        email = request.user.email
        user = User.objects.get(email=email)

        if not user.check_password(request.data['old_password']):
            return Response({"detail": "Old password is incorrect"}, status=400)
        # change new password
        user.set_password(request.data['new_password'])
        user.save()
        return Response({"detail": "password changed"})