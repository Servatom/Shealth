from rest_framework import serializers
from shealth.models import Record, User


class UserSerializer(serializers.ModelSerializer):
    class Meta:
        model = User
        fields = ("name", "email", "phone", "is_doctor", "avatar")


class RecordSerializer(serializers.ModelSerializer):
    file = serializers.FileField(required=False)

    class Meta:
        model = Record
        fields = ("patient", "file")
