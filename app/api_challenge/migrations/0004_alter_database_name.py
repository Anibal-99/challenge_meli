# Generated by Django 4.2.4 on 2023-08-13 22:19

from django.db import migrations, models


class Migration(migrations.Migration):
    dependencies = [
        ("api_challenge", "0003_database_name"),
    ]

    operations = [
        migrations.AlterField(
            model_name="database",
            name="name",
            field=models.CharField(max_length=255),
        ),
    ]
