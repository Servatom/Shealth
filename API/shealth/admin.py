from django.contrib import admin
from shealth.models import Appointment, Record, User, Doctor, Patient


class UserAdmin(admin.ModelAdmin):
    list_display = ('name', 'email', 'name', 'is_doctor')
    list_display_links = ('name', 'email', 'name')

class DoctorAdmin(admin.ModelAdmin):
    list_display = ('user', 'doc_id')
    list_display_links = ('user',)

class PatientAdmin(admin.ModelAdmin):
    list_display = ('user',)
    list_display_links = ('user',)

admin.site.register(User, UserAdmin)
admin.site.register(Doctor, DoctorAdmin)
admin.site.register(Patient, PatientAdmin)
admin.site.register(Record)
admin.site.register(Appointment)
