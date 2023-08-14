# Generated by Django 4.2.4 on 2023-08-13 23:52

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):
    dependencies = [
        ("api_challenge", "0004_alter_database_name"),
    ]

    operations = [
        migrations.AlterField(
            model_name="columndatabase",
            name="table",
            field=models.ForeignKey(
                blank=True,
                null=True,
                on_delete=django.db.models.deletion.CASCADE,
                related_name="column_database",
                to="api_challenge.tabledatabase",
            ),
        ),
    ]
