"""config URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/2.2/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from django.contrib import admin
from django.urls import path, include
from django.conf import settings
from django.conf.urls.static import static
from shealth import views

urlpatterns = [
    path("", views.Index.as_view(), name="index"),
    path("admin/", admin.site.urls),
    path("register/d/", views.DoctorRegisterView.as_view(), name="doctor_register"),
    path("register/p/", views.PatientRegisterView.as_view(), name="patient_register"),
    path("auth/", include("dj_rest_auth.urls")),
    path("doctor/qrcode/", views.DoctorQRCode.as_view(), name="give_qrcode"),
    path("doctor/doc_id/", views.DoctorDocIdView.as_view(), name="give_doc_id"),
    path("patient/upload/", views.UploadDocs.as_view(), name="upload_docs"),
    path("patient/access/doc_id/", views.GiveAccessPatient.as_view(), name="give_doc_id"),
    path("detail/", views.UserDetailView.as_view(), name="user_detail"),
]

urlpatterns += static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)
