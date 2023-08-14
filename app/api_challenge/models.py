from django.db import models
from user.models import User
from django.core.validators import RegexValidator


class Database(models.Model):
    name = models.CharField(max_length=255, null=False, blank=False)
    host = models.CharField(max_length=255, blank=False, null=False)
    port = models.IntegerField()
    username = models.CharField(max_length=100, blank=False, null=False)
    password = models.CharField(max_length=255, blank=False, null=False)

    class Meta:
        verbose_name = "Database Connection"
        verbose_name_plural = "Database Connections"

    def __str__(self) -> str:
        return self.name


class ScanHistory(models.Model):
    date = models.DateTimeField(auto_now_add=True)
    database = models.ForeignKey(
        Database,
        on_delete=models.SET_DEFAULT,
        default="",
        related_name="scan_history",
    )
    user = models.ForeignKey(
        User,
        on_delete=models.SET_DEFAULT,
        default="",
        related_name="scan_history",
    )

    class Meta:
        verbose_name = "Scan History"
        verbose_name_plural = "Scans Historys"

    def __str__(self) -> str:
        return f"escaneo de {self.database.host} por {self.user.name}"


class Classification(models.Model):
    date = models.DateTimeField(auto_now_add=True)
    scan_history = models.OneToOneField(
        ScanHistory,
        on_delete=models.SET_DEFAULT,
        default="",
        related_name="classification",
    )

    class Meta:
        verbose_name = "Classification"
        verbose_name_plural = "Classificacions"

    def __str__(self) -> str:
        return f"{self.date}"


class TableDatabase(models.Model):
    name = models.CharField(max_length=255, null=False, blank=False)
    clasification = models.ForeignKey(
        Classification,
        on_delete=models.SET_DEFAULT,
        default="",
        related_name="table_database",
    )

    class Meta:
        verbose_name = "Table database"
        verbose_name_plural = "Tables database"

    def __str__(self) -> str:
        return f"{self.name}"


class InformationType(models.Model):
    title = models.CharField(max_length=100)
    regex = models.CharField(max_length=200)

    class Meta:
        verbose_name = "Information type"
        verbose_name_plural = "Information types"

    def __str__(self):
        return self.title


class ColumnDatabase(models.Model):
    name = models.CharField(max_length=255, null=False, blank=False)
    table = models.ForeignKey(
        TableDatabase,
        on_delete=models.CASCADE,
        related_name="column_database",
        blank=True,
        null=True,
    )

    information_type = models.ForeignKey(
        InformationType,
        on_delete=models.SET_DEFAULT,
        default="",
        related_name="column_database",
        null=True,
        blank=True,
    )

    class Meta:
        verbose_name = "Column Database"
        verbose_name_plural = "Columns Databases"

    def __str__(self) -> str:
        return f"Tabla: {self.table.name} - column: {self.name}"
