import random
import string
import uuid

from django.db import models
from django.contrib.auth.models import AbstractBaseUser

def user_directory_path(instance, filename):
        return 'records/{0}/{1}'.format(instance.patient.uuid, filename)

def generateCode(length=6):
    random_str = ''.join(random.choices(string.ascii_letters + string.digits, k=length))
    if Doctor.objects.filter(code=random_str).exists():
        return generateCode()
    return random_str

class Doctor(AbstractBaseUser):
    uuid = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
    doc_id = models.CharField(max_length=6, unique=True)
    name = models.CharField(max_length=100)
    email = models.EmailField(max_length=100)
    phone = models.CharField(max_length=100)
    speciality = models.CharField(max_length=100)
    city = models.CharField(max_length=100)
    state = models.CharField(max_length=100)
    country = models.CharField(max_length=100)
    created_at = models.DateTimeField(auto_now_add=True)
    password = models.CharField(max_length=100)

    def __str__(self):
        return self.name

    def save(self, *args, **kwargs):
        self.doc_id = generateCode()
        super(Doctor, self).save(*args, **kwargs)


class Patient(AbstractBaseUser):
    GENDER_CHOICES = (
        ('M', 'Male'),
        ('F', 'Female'),
        ('O', 'Others'),
    )
    uuid = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
    name = models.CharField(max_length=100)
    email = models.EmailField(max_length=100)
    phone = models.CharField(max_length=100)
    city = models.CharField(max_length=100)
    state = models.CharField(max_length=100)
    country = models.CharField(max_length=100)
    age = models.IntegerField()
    sex = models.CharField(max_length=1, choices=GENDER_CHOICES)
    created_at = models.DateTimeField(auto_now_add=True)
    password = models.CharField(max_length=100)

    def __str__(self):
        return self.name


class Record(models.Model):
    patient = models.ForeignKey(Patient, on_delete=models.CASCADE)
    file = models.FileField(upload_to=user_directory_path)
    created_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return self.patient.name


class Appointment(models.Model):
    """
    This model object is created everytime a patient gives access to record
    """
    patient = models.ForeignKey(Patient, on_delete=models.CASCADE)
    doctor = models.ForeignKey(Doctor, on_delete=models.CASCADE)
    date = models.DateField(auto_now_add=True)
    time = models.TimeField(auto_now_add=True)
    created_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return self.patient.name