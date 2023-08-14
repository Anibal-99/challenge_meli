from rest_framework import serializers
from api_challenge.models import (
    Database,
    InformationType,
    ColumnDatabase,
    ScanHistory,
    TableDatabase,
    Classification,
)

from django.contrib.auth.hashers import make_password


class SerializerDatabaseConnection(serializers.ModelSerializer):
    class Meta:
        model = Database
        fields = ["id", "name", "host", "port", "username", "password"]
        read_only_fields = ["id"]

    def create(self, validated_data):
        """created and return a database with encrypted password"""

        password = validated_data.pop("password")
        encrypted_password = make_password(password)
        database = Database.objects.create(
            **validated_data, password=encrypted_password
        )
        return database

    def to_representation(self, instance):
        """Acomoda como queremos que se muestre el response"""
        return {"id": instance.id}


class SerializerInformationType(serializers.ModelSerializer):
    class Meta:
        model = InformationType
        fields = ["id", "title", "regex"]
        read_only_fields = ["id"]


class SerializerColumnDatabase(serializers.ModelSerializer):
    information_type = SerializerInformationType()
    table = serializers.StringRelatedField()

    class Meta:
        model = ColumnDatabase
        fields = ["id", "table", "information_type"]
        read_only_fields = ["id"]


class ColumnSerializer(serializers.ModelSerializer):
    information_type = serializers.StringRelatedField()

    class Meta:
        model = ColumnDatabase
        fields = ["name", "information_type"]


class TableSerializer(serializers.ModelSerializer):
    column_database = ColumnSerializer(many=True, read_only=True)

    class Meta:
        model = TableDatabase
        fields = ["name", "column_database"]


class ClassificationSerializer(serializers.ModelSerializer):
    table_database = TableSerializer(many=True)

    class Meta:
        model = Classification
        fields = ["table_database"]


class ScanHistorySerializer(serializers.ModelSerializer):
    database = serializers.StringRelatedField()
    classification = ClassificationSerializer()

    class Meta:
        model = ScanHistory
        fields = ["id", "date", "database", "classification"]
