from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework.permissions import IsAuthenticated
from rest_framework.parsers import MultiPartParser, FormParser, FileUploadParser
from shealth.models import Doctor, Patient, Appointment
from shealth.forms import DoctorCreationForm, PatientCreationForm
from shealth.serializers import RecordSerializer, UserSerializer
from shealth.qrcodeGenerate import *
from wsgiref.util import FileWrapper
from django.http import HttpResponse
import os


class DoctorRegisterView(APIView):
    def post(self, request):
        form = DoctorCreationForm(request.data)
        if form.is_valid():
            form.save()
            return Response({"detail": "Doctor registered successfully"})
        else:
            return Response(
                {"detail": "Doctor registration failed", "errors": form.errors}
            )


class PatientRegisterView(APIView):
    def post(self, request):
        form = PatientCreationForm(request.data)
        if form.is_valid():
            form.save()
            return Response({"detail": "Patient registered successfully"})
        else:
            return Response(
                {"detail": "Patient registration failed", "errors": form.errors}
            )


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

    def put(self, request, format=None):
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

    def get(self, request):
        serializer = UserSerializer(request.user)
        return Response(serializer.data)
        


class Index(APIView):
    def get(self, request):
        return Response({"detail": "Welcome to Shealth"})
