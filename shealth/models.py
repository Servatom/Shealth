import random
import string
import uuid
from django.contrib.auth.models import AbstractBaseUser
from shealth.managers import UserManager
from django.db import models
from django.contrib.auth.models import AbstractBaseUser

def user_directory_path(instance, filename):
        return 'records/{0}/{1}'.format(instance.patient.user.uuid, filename)

def generateCode(length=6):
    random_str = ''.join(random.choices(string.ascii_letters + string.digits, k=length))
    if Doctor.objects.filter(doc_id=random_str).exists():
        return generateCode()
    return random_str

class User(AbstractBaseUser):
    """
    Custom User model
    """
    uuid = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
    email = models.EmailField(
        max_length=255, unique=True, verbose_name="email address"
    )
    phone = models.CharField(max_length=100, unique=True)
    name = models.CharField("Name", max_length=20)
    is_doctor = models.BooleanField(default=False)
    is_staff = models.BooleanField(default=False)
    created_at = models.DateTimeField(auto_now_add=True)
    
    USERNAME_FIELD = "email"
    REQUIRED_FIELDS = ["name",]
    

    objects = UserManager()

    def __str__(self):
        return f"{self.name}"
    def get_short_name(self):
        # The user is identified by their email address
        return self.email

    def has_perm(self, perm, obj=None):
        "Does the user have a specific permission?"
        # Simplest possible answer: Yes, always
        return True

    def has_module_perms(self, app_label):
        "Does the user have permissions to view the app `app_label`?"
        # Simplest possible answer: Yes, always
        return True

class Doctor(models.Model):
    user = models.OneToOneField(User, on_delete=models.CASCADE, primary_key=True)
    speciality = models.CharField(max_length=20)
    doc_id = models.CharField(max_length=6, unique=True)

    def __str__(self):
        return self.user.name

    def save(self, *args, **kwargs):
        self.doc_id = generateCode()
        super(Doctor, self).save(*args, **kwargs)


class Patient(models.Model):
    GENDER_CHOICES = (
        ('M', 'Male'),
        ('F', 'Female'),
        ('O', 'Others'),
    )
    user = models.OneToOneField(User, on_delete=models.CASCADE, primary_key=True)
    age = models.IntegerField()
    sex = models.CharField(max_length=1, choices=GENDER_CHOICES)

    def __str__(self):
        return self.user.name


class Record(models.Model):
    patient = models.ForeignKey(Patient, on_delete=models.CASCADE)
    file = models.FileField(upload_to=user_directory_path)
    created_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return self.patient.user.name


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
        return self.patient.user.name