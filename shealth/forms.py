from django import forms
from rest_framework.authtoken.models import Token
from shealth.models import User, Doctor, Patient
from django.db import transaction


class DoctorCreationForm(forms.ModelForm):
    speciality = forms.CharField(max_length=100)

    class Meta:
        model = User
        fields = ("email", "phone", "name", "password")

    @transaction.atomic
    def save(self, commit=True):
        user = super(DoctorCreationForm, self).save(commit=False)
        user.is_doctor = True
        user.set_password(self.cleaned_data["password"])
        user.save()
        Token.objects.create(user=user)
        doctor = Doctor(user=user, speciality=self.cleaned_data["speciality"])
        doctor.save()
        return user


class PatientCreationForm(forms.ModelForm):
    age = forms.IntegerField()
    sex = forms.CharField(max_length=1)

    class Meta:
        model = User
        fields = ("email", "phone", "name", "password")

    @transaction.atomic
    def save(self, commit=True):
        user = super(PatientCreationForm, self).save(commit=False)
        user.is_patient = True
        user.set_password(self.cleaned_data["password"])
        user.save()
        Token.objects.create(user=user)
        patient = Patient(
            user=user, age=self.cleaned_data["age"], sex=self.cleaned_data["sex"]
        )
        patient.save()
        return user
