"""Test for the user API"""

from django.test import TestCase
from django.contrib.auth import get_user_model
from django.urls import reverse
from rest_framework.test import APIClient
from rest_framework import status

CREATE_USER_URL = reverse("user:create_user")
TOKEN_URL = reverse("user:login")
ME_URL = reverse("user:me")


def create_user(**params):
    """create and return a new user"""
    return get_user_model().objects.create_user(**params)


class PublicUserApiTests(TestCase):
    """Test the public features of the user API"""

    def setUp(self):
        self.client = APIClient()

    def test_create_user_success(self):
        """Test para corroborar que se crea correctamente un usuario"""

        payload = {
            "email": "anibal@example.com",
            "password": "anibal1234",
            "name": "Test name",
        }

        response = self.client.post(CREATE_USER_URL, payload)

        # usuario se creo correctamente en la base de datos, con el estado 201
        self.assertEquals(response.status_code, status.HTTP_201_CREATED)
        user = get_user_model().objects.get(email=payload["email"])

        # comprueba la password cifrada
        self.assertTrue(user.check_password(payload["password"]))
        # verifica que se seteo una password valida
        self.assertTrue(user.has_usable_password())
        # varifica la data enviada en la respuesta, y que no esta la password
        self.assertNotIn("password", response.data)

    def test_user_with_email_exists_errors(self):
        """test que prueba la devolucion de un error si el email ya existe"""
        payload = {
            "email": "test@example.com",
            "password": "test1234",
            "name": "Test name",
        }

        create_user(**payload)

        response = self.client.post(CREATE_USER_URL, payload)
        self.assertEqual(response.status_code, status.HTTP_400_BAD_REQUEST)

    def test_password_too_short_error(self):
        """Test que devuelve si el password es menor que 5 caracteres"""

        payload = {
            "email": "test@example.com",
            "password": "te",
            "name": "Test name",
        }

        response = self.client.post(CREATE_USER_URL, payload)
        self.assertEqual(response.status_code, status.HTTP_400_BAD_REQUEST)

        """
        con esta parte lo que hacemos es verificar que el
        usaurio que esta intentando registrarse con una password corta,
        tampoco se esta registrando en la db
        """
        user_exists = (
            get_user_model().objects.filter(email=payload["email"]).exists()
        )

        self.assertFalse(user_exists)

    def test_create_token_for_user(self):
        """test para verificar que crea el token con las credenciales"""

        # primero testea la creacion de un nuevo usuario
        user_detail = {
            "name": "Test name",
            "email": "test@gmail.com",
            "password": "testpass1234",
        }

        create_user(**user_detail)

        # con el usuario creado intenta iniciar session
        payload = {
            "email": user_detail["email"],
            "password": user_detail["password"],
        }

        # verifica la respuesta
        response = self.client.post(TOKEN_URL, payload)

        # para saber si el token viaja en el response
        self.assertIn("token", response.data)

        # verfica que la respuesta sea un 200
        self.assertEqual(response.status_code, status.HTTP_200_OK)

    def test_create_token_bad_credentials(self):
        """test que devuelve error si las credenciales son erroneas"""

        create_user(email="test@example.com", password="goodpass")

        # crea una carga util con una password incorrecta
        payload = {"email": "test@example.com", "password": "badpass"}

        # realiza el post al endpoint
        response = self.client.post(TOKEN_URL, payload)

        self.assertNotIn("token", response.data)
        # verifica que status code sea un 400
        self.assertEqual(response.status_code, status.HTTP_400_BAD_REQUEST)

    def test_create_token_blank_password(self):
        """test para ver que devuelve un error si el password llega vacia"""

        # crea una carga util sin password
        payload = {"email": "test@gmail.com", "password": ""}

        response = self.client.post(TOKEN_URL, payload)

        # verifica que no viaje el token en el response
        self.assertNotIn("token", response.data)
        # verifica el estado del response
        self.assertEqual(response.status_code, status.HTTP_400_BAD_REQUEST)

    def test_retrieve_user_unauthorized(self):
        """
        test para verificar que el usaurio necesita autorizacion
        para acceder a un enpoint
        """
        response = self.client.get(ME_URL)
        self.assertEqual(response.status_code, status.HTTP_401_UNAUTHORIZED)


class PrivateUserApiTest(TestCase):
    def setUp(self):
        self.user = create_user(
            email="test@example.com", password="testpass1234", name="testname"
        )
        self.client = APIClient()
        self.client.force_authenticate(user=self.user)

    def test_retrieve_profile_succes(self):
        """develve el detalle del usuario autenticado actualmente"""
        response = self.client.get(ME_URL)
        self.assertEqual(response.status_code, status.HTTP_200_OK)
        self.assertEqual(
            response.data, {"name": self.user.name, "email": self.user.email}
        )

    def test_post_me_not_allowed(self):
        """
        test para probar que no esta disponible el metodo post
        en el enpoint me
        """
        response = self.client.post(ME_URL, {})

        self.assertEqual(
            response.status_code, status.HTTP_405_METHOD_NOT_ALLOWED
        )

    def test_update_user_profile(self):
        """
        Test que prueba si funciona la funcionalidad de actualizar los datos
        de un usuario
        """
        payload = {"name": "Update name", "password": "newpass123"}
        response = self.client.patch(ME_URL, payload)

        self.user.refresh_from_db()
        self.assertEqual(self.user.name, payload["name"])
        self.assertTrue(self.user.check_password(payload["password"]))
        self.assertEqual(response.status_code, status.HTTP_200_OK)
