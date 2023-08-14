from django.urls import path, include
from rest_framework.routers import DefaultRouter
from api_challenge.api import views

router = DefaultRouter()
router.register("database", views.DatabaseViewSet)
router.register("information_type", views.InformationTypeViewSet)
router.register("columns", views.ColumnViewSet)
router.register("v1/database/scan", views.ScanHistoryViewSet)

app_name = "api_challenge"

urlpatterns = [
    path("", include(router.urls)),
    path(
        "v1/database/scan/<int:id>/",
        views.DatabaseScanView.as_view(),
        name="scan",
    ),
]
