from django import forms
from shealth.models import Doctor, Patient, Appointment, Record


class DoctorForm(forms.ModelForm):
    class Meta:
        model = Doctor
        fields = (
            "name",
            "email",
            "phone",
            "speciality",
            "city",
            "state",
            "country",
            "password",
        )

class PatientForm(forms.ModelForm):
    class Meta:
        model = Patient
        fields = (
            "name",
            "email",
            "phone",
            "city",
            "state",
            "country",
            "age",
            "sex",
            "password",
        )