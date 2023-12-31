from rest_framework import viewsets, permissions, authentication, generics
from api_challenge.api import serializers
from rest_framework.response import Response
from user.models import User
from api_challenge.models import (
    Database,
    ScanHistory,
    Classification,
    TableDatabase,
    ColumnDatabase,
    InformationType,
)
from .dbconnection import get_cursor, close_cursor
import re


class DatabaseViewSet(viewsets.ModelViewSet):
    serializer_class = serializers.SerializerDatabaseConnection
    authentication_classes = [authentication.TokenAuthentication]
    permission_classes = [permissions.IsAuthenticatedOrReadOnly]
    queryset = (
        serializers.SerializerDatabaseConnection.Meta.model.objects.all()
    )


class InformationTypeViewSet(viewsets.ModelViewSet):
    serializer_class = serializers.SerializerInformationType
    authentication_classes = [authentication.TokenAuthentication]
    permission_classes = [permissions.IsAuthenticatedOrReadOnly]
    queryset = serializers.SerializerInformationType.Meta.model.objects.all()


class ColumnViewSet(viewsets.ModelViewSet):
    serializer_class = serializers.SerializerColumnDatabase
    authentication_classes = [authentication.TokenAuthentication]
    permission_classes = [permissions.IsAuthenticatedOrReadOnly]
    queryset = serializers.SerializerColumnDatabase.Meta.model.objects.all()


class ScanHistoryViewSet(viewsets.ReadOnlyModelViewSet):
    serializer_class = serializers.ScanHistorySerializer
    authentication_classes = [authentication.TokenAuthentication]
    permission_classes = [permissions.IsAuthenticatedOrReadOnly]
    queryset = serializers.ScanHistorySerializer.Meta.model.objects.all()


class DatabaseScanView(generics.CreateAPIView):
    authentication_classes = [authentication.TokenAuthentication]
    permission_classes = [permissions.IsAuthenticated]

    def post(self, request, *args, **kwargs):
        database_id = self.kwargs.get("id")

        try:
            database = Database.objects.get(id=database_id)
        except Database.DoesNotExist:
            return Response({"detail": "Database not found"}, status=404)

        con, cursor = get_cursor(
            database.name,
            database.host,
            database.port,
            database.username,
            database.password,
        )

        # Obtiene la lista de tablas en la base de datos
        cursor.execute("SHOW TABLES;")
        tables = cursor.fetchall()
        user = User.objects.get(email=request.user.email)

        scan_history = ScanHistory.objects.create(database=database, user=user)
        clasification = Classification.objects.create(
            scan_history=scan_history
        )
        clasification.save()

        # itera por cada tabla existente en la base de datos a la que nos conectamos
        for table in tables:
            table_name = table[0]

            table_instance = TableDatabase.objects.create(
                name=table_name, clasification=clasification
            )

            # Obtener la lista de columnas para la tabla actual
            cursor.execute(f"DESCRIBE {table_name};")
            columns = cursor.fetchall()

            """
             Obtengo todas las columnas y para cada columna, comparo si
              corresponde a laguna regex,
              si es asi se le asigna un tipo de informacion
            """

            for column in columns:
                column_name = column[0]

                # Crear una instancia de la columna en la base de datos
                column_instance = ColumnDatabase.objects.create(
                    name=column_name,
                    table=table_instance,
                )

                for info_type in InformationType.objects.all():
                    if re.match(info_type.regex, column_name):
                        column_instance.information_type = info_type
                        column_instance.save()
                        break

        close_cursor(con, cursor)
        return Response(
            {
                "Scan history": scan_history.id,
                "detail": "Scan started successfully",
            },
            status=201,
        )


class ScanView(generics.RetrieveAPIView):
    queryset = Database.objects.all()
    serializer_class = serializers.ScanHistorySerializer
    lookup_url_kwarg = "id"
